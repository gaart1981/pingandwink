// lib/controllers/ping_wink_controller.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/emotion_data.dart';
import '../models/ping_data.dart';
import '../models/spark_session.dart';
import '../models/user_data.dart';
import '../services/ping_wink_service.dart';
import '../services/vibe_state_manager.dart';
import '../services/storage_service.dart';
import '../widgets/wink_banner.dart';
import '../l10n/app_localizations.dart';

/// Controller for managing all Ping&Wink functionality
/// Extracted from map_screen.dart for better separation of concerns
class PingWinkController extends ChangeNotifier {
  // ============================================
  // STATE MANAGEMENT
  // ============================================

  // Track active outgoing pings (key: mood_id, value: is_active)
  final Map<String, bool> _processingPings = {};
  Map<String, bool> get processingPings => Map.unmodifiable(_processingPings);

  // Timers for ping expiration (60 seconds)
  final Map<String, Timer?> _pingTimers = {};

  // Start times for calculating remaining time
  final Map<String, DateTime> _pingStartTimes = {};
  Map<String, DateTime> get pingStartTimes => Map.unmodifiable(_pingStartTimes);

  // Track which pings have been shown to user
  final Set<String> _shownPings = {};

  // Track currently active Spark sessions (true = chat is open in UI)
  final Map<String, bool> _activeSparkSessions = {};

  // Track processed ping IDs from push notifications
  final Set<String> _processedPingIds = {};

  // Timer for checking incoming pings
  Timer? _pingCheckTimer;

  // Current wink banner overlay
  OverlayEntry? _winkBannerOverlay;

  // Reference to VibeStateManager
  late final VibeStateManager _vibeManager;

  // User data reference
  UserData? _userData;

  // Flag for active emotion status
  bool _hasActiveEmotion = false;

  // ============================================
  // CALLBACKS TO MAP SCREEN
  // ============================================

  // Called when ping animation needs to be added to map
  Function(EmotionData emotion, String pingId)? onAddPingAnimation;

  // Called when ping animation needs to be removed from map
  Function(String pingId)? onRemovePingAnimation;

  // Called when wink animation needs to be shown on map
  Function(IncomingPing ping)? onAnimatePingSource;

  // Called when marker color needs update
  Function(String moodId, Color? color)? onUpdateMarkerColor;

  // Called to navigate to Spark chat
  Function(SparkSession session)? onNavigateToSpark;

  // Called to show Spark animation
  Function()? onShowSparkAnimation;

  // Called to show toast messages
  Function(String message)? onShowToast;

  // Called to show error messages
  Function(String message)? onShowError;

  // Called to reload emotions from API
  Function()? onReloadEmotions;

  // Called to get current BuildContext for overlays
  BuildContext Function()? getContext;

  // ============================================
  // INITIALIZATION & LIFECYCLE
  // ============================================

  PingWinkController() {
    _vibeManager = VibeStateManager();
  }

  /// Initialize the controller with user data and start monitoring
  void initialize(UserData userData, bool hasActiveEmotion) {
    _userData = userData;
    _hasActiveEmotion = hasActiveEmotion;

    // Check immediately on init
    _checkIncomingPings();
    _checkActiveSparks();
    _checkPendingPingFromPush();

    // Start periodic checking (13 seconds for battery optimization)
    _pingCheckTimer?.cancel();
  
    // Delay to avoid peak load with map polling
    Future.delayed(Duration(seconds: AppConfig.pingPollingDelayOffset), () {
      _pingCheckTimer =
          Timer.periodic(Duration(seconds: AppConfig.pingPollingInterval), (_) {
        if (_hasActiveEmotion) {
          _checkIncomingPings();
          debugPrint('[PingWink] Checking pings - emotion is active');
        } else {
          debugPrint('[PingWink] Skipping ping check - no active emotion');
        }
        _checkActiveSparks();
      });
    });
  }

  /// Update user data
  void updateUserData(UserData userData) {
    _userData = userData;
  }

  /// Update active emotion status
  void updateActiveEmotionStatus(bool hasActive) {
    _hasActiveEmotion = hasActive;
  }

  /// Clean up resources
  @override
  void dispose() {
    // Cancel all timers
    _pingCheckTimer?.cancel();
    for (var timer in _pingTimers.values) {
      timer?.cancel();
    }
    _pingTimers.clear();

    // Remove overlay if exists
    _winkBannerOverlay?.remove();
    _winkBannerOverlay = null;

    // Clear sets
    _shownPings.clear();
    _activeSparkSessions.clear();
    _processedPingIds.clear();

    super.dispose();
  }

  // ============================================
  // CHECK PENDING PINGS FROM PUSH
  // ============================================

  Future<void> _checkPendingPingFromPush() async {
    // Give time for initialization
    await Future.delayed(const Duration(milliseconds: 500));

    final pendingPingId = await StorageService.getPendingPing();
    if (pendingPingId != null && _userData?.deviceId != null) {
      debugPrint('[PingWink] Found pending ping from push: $pendingPingId');

      try {
        // Load ping data from database
        final url = '${AppConfig.supabaseUrl}/rest/v1/pings';
        final queryParams = {
          'id': 'eq.$pendingPingId',
          'to_device_id': 'eq.${_userData!.deviceId}',
          'status': 'eq.pending',
          'select': '*',
        };

        final uri = Uri.parse(url).replace(queryParameters: queryParams);
        final response = await http.get(
          uri,
          headers: {
            'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
            'apikey': AppConfig.supabaseAnonKey,
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            final pingData = data.first;
            final expiresAt = DateTime.parse(pingData['expires_at']);

            if (DateTime.now().isBefore(expiresAt)) {
              final ping = IncomingPing.fromJson(pingData);

              if (!_shownPings.contains(ping.pingId)) {
                _shownPings.add(ping.pingId);
                _processedPingIds.add(ping.pingId);
                _showWinkBanner(ping);
                HapticFeedback.heavyImpact();
                debugPrint('[PingWink] Showing wink banner from saved ping');
              }
            } else {
              debugPrint('[PingWink] Saved ping expired');
            }
          }
        }

        // Clear saved ping
        await StorageService.clearPendingPing();
      } catch (e) {
        debugPrint('[PingWink] Error loading pending ping: $e');
        await StorageService.clearPendingPing();
      }
    }
  }

  // ============================================
  // CHECK INCOMING PINGS
  // ============================================

  // Throttle tracking
  DateTime? _lastPingCheck;

  Future<void> _checkIncomingPings() async {
    if (_userData?.deviceId == null) return;

    // Throttle protection for frequent calls
    if (_lastPingCheck != null &&
        DateTime.now().difference(_lastPingCheck!).inSeconds < 3) {
      debugPrint('[PingWink] Skipping ping check - too frequent');
      return;
    }
    _lastPingCheck = DateTime.now();

    debugPrint('[PingWink] Checking pings at ${DateTime.now()}');

    try {
      // Query pings directly from Supabase
      final url = '${AppConfig.supabaseUrl}/rest/v1/pings';
      final queryParams = {
        'to_device_id': 'eq.${_userData!.deviceId}',
        'status': 'eq.pending',
        'expires_at': 'gt.${DateTime.now().toUtc().toIso8601String()}',
        'select': '*',
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        debugPrint('[PingWink] Found ${data.length} incoming pings');

        for (final pingData in data) {
          // Check if ping is not expired
          final expiresAt = DateTime.parse(pingData['expires_at']);
          final isExpired = DateTime.now().isAfter(expiresAt);

          if (!isExpired && !_shownPings.contains(pingData['id'])) {
            // Check if already processed via Realtime
            if (_processedPingIds.contains(pingData['id'])) {
              debugPrint(
                  '[PingWink] Ping already processed: ${pingData['id']}');
              continue;
            }

            debugPrint('[PingWink] Processing ping: ${pingData['id']}');
            final ping = IncomingPing.fromJson(pingData);

            _shownPings.add(ping.pingId);
            _processedPingIds.add(pingData['id']);
            _showWinkBanner(ping);
            debugPrint(
                '[PingWink] Showing wink banner for ping: ${ping.pingId}');
            HapticFeedback.heavyImpact();
            break; // Show only one at a time
          }
        }
      }
    } catch (e) {
      debugPrint('[PingWink] Error checking pings: $e');
    }
  }

  // ============================================
  // CHECK ACTIVE SPARKS
  // ============================================

  Future<void> _checkActiveSparks() async {
    if (_userData?.deviceId == null) return;

    try {
      // Check for active spark sessions
      final url = '${AppConfig.supabaseUrl}/rest/v1/spark_sessions';
      final queryParams = {
        'or':
            '(device_1.eq.${_userData!.deviceId},device_2.eq.${_userData!.deviceId})',
        'is_active': 'eq.true',
        'select': '*',
        'order': 'started_at.desc',
        'limit': '1'
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final sessionData = data.first;
          final sessionId = sessionData['id'];

          // Check if chat is currently open in UI
          if (_activeSparkSessions[sessionId] == true) {
            return; // Chat is currently open
          }

          // Check if this session involves us
          final device1 = sessionData['device_1'];
          final device2 = sessionData['device_2'];
          if (device1 != _userData!.deviceId &&
              device2 != _userData!.deviceId) {
            return; // Not our session
          }

          // Mark as opened PERMANENTLY for this app session
          _shownPings.add('spark_$sessionId'); // Keep for compatibility
          // Mark session as active in UI
          _activeSparkSessions[sessionId] = true;

          debugPrint('[PingWink] Found new spark session: $sessionId');

          // Cancel all our active outgoing pings
          for (var pingId in _processingPings.keys.toList()) {
            cancelPing(pingId);
          }

          // Dismiss all incoming ping banners
          _winkBannerOverlay?.remove();
          _winkBannerOverlay = null;
          await _dismissAllIncomingPings();

          // Update Spark statuses
          final session = SparkSession.fromJson(sessionData);

          _vibeManager.setLocalState(
              deviceId: session.device1,
              status: VibeStatus.inSpark,
              color: const Color(0xFF808080));
          _vibeManager.setLocalState(
              deviceId: session.device2,
              status: VibeStatus.inSpark,
              color: const Color(0xFF808080));

          // Notify MapScreen about new spark session
          onNavigateToSpark?.call(session);
        }
      }
    } catch (e) {
      debugPrint('[PingWink] Error checking sparks: $e');
    }
  }

  // ============================================
  // DISMISS ALL INCOMING PINGS
  // ============================================

  Future<void> _dismissAllIncomingPings({String? except}) async {
    if (_userData?.deviceId == null) return;

    // Remove any visible wink banner (unless it's the one we're accepting)
    if (_winkBannerOverlay != null && except == null) {
      _winkBannerOverlay?.remove();
      _winkBannerOverlay = null;
    }

    // Clear all shown pings except the one being accepted
    if (except != null) {
      _shownPings.removeWhere((id) => id != except);
    } else {
      _shownPings.clear();
    }

    // Reject all pending pings on server (except the one being accepted)
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/pings';
      Map<String, String> queryParams = {
        'to_device_id': 'eq.${_userData!.deviceId}',
        'status': 'eq.pending',
      };

      // Build query to exclude the accepted ping
      if (except != null) {
        queryParams['id'] = 'neq.$except'; // All except the one we're accepting
      }

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      await http.patch(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({'status': 'auto_rejected'}),
      );

      debugPrint('[PingWink] Auto-rejected all other incoming pings');
    } catch (e) {
      debugPrint('[PingWink] Error auto-rejecting pings: $e');
    }
  }

  // ============================================
  // SEND PING
  // ============================================

  /// Send a ping to another emotion
  /// Returns true if successful, false otherwise
  Future<bool> sendPing({
    required EmotionData targetEmotion,
    required EmotionData myEmotion,
    required List<EmotionData> activeEmotions,    
  }) async {
    if (_userData == null) return false;
    final context = getContext?.call();
    if (context == null) return false;
    final l10n = AppLocalizations.of(context)!;

    debugPrint('[PingWink] Sending ping to ${targetEmotion.id}');

    // Mark as processing
    _processingPings[targetEmotion.id] = true;
    _pingStartTimes[targetEmotion.id] = DateTime.now();
    notifyListeners();

    try {
      // Validate my emotion
      if (!myEmotion.isValid) {
        onShowError?.call(l10n.pingErrorYourVibeExpired);
        _cleanupFailedPing(targetEmotion.id);
        return false;
      }

      // Send ping via API
      final result = await PingWinkService.sendPing(
        fromDeviceId: _userData!.deviceId,
        toMoodId: targetEmotion.id,
        fromLat: myEmotion.lat,
        fromLon: myEmotion.lon,
      );

      if (result['success'] == true) {
        onShowToast?.call(l10n.pingSentSuccess);
        HapticFeedback.heavyImpact();

        // Save local state in VibeStateManager
        _vibeManager.setLocalState(
          moodId: targetEmotion.id,
          status: VibeStatus.sendingPing,
          color: Colors.white,
          duration: const Duration(seconds: 65),
        );

        // Mark receiver as busy
        _vibeManager.setLocalState(
            moodId: targetEmotion.id,
            status: VibeStatus.receivingPing,
            color: Colors.white);

        debugPrint('[PingWink] Ping sent successfully to ${targetEmotion.id}');

        // Notify MapScreen to add animation
        onAddPingAnimation?.call(targetEmotion, targetEmotion.id);

        // Start expiration timer (65 seconds to account for network delay)
        _pingTimers[targetEmotion.id]?.cancel();
        _pingTimers[targetEmotion.id] = Timer(const Duration(seconds: 65), () {
          cancelPing(targetEmotion.id);
          _vibeManager.clearLocalState(moodId: targetEmotion.id);
        });

        return true;
      } else {
        _cleanupFailedPing(targetEmotion.id);

        // Handle error messages
        final errorMsg = result['error']?.toString() ?? '';
        if (errorMsg.contains('already has an active ping') ||
            errorMsg.contains('already have an active ping')) {
          _vibeManager.setLocalState(
              moodId: targetEmotion.id,
              status: VibeStatus.receivingPing,
              color: Colors.white);
          onShowToast?.call(l10n.pingSomeoneAlreadySent);
        } else if (errorMsg.contains('Spark chat')) {
          _vibeManager.setLocalState(
              deviceId: targetEmotion.deviceId,
              status: VibeStatus.inSpark,
              color: const Color(0xFF808080));
          onShowToast?.call(l10n.pingPersonInSpark);
        } else if (errorMsg.contains('expired')) {
          onShowToast?.call(l10n.pingThisVibeExpired);
          onReloadEmotions?.call();
        } else {
          onShowError
              ?.call(errorMsg.isNotEmpty ? errorMsg : l10n.pingFailedToSend);
        }

        return false;
      }
    } catch (e) {
      debugPrint('[PingWink] Error sending ping: $e');
      _cleanupFailedPing(targetEmotion.id);
      onShowError?.call(l10n.pingSendingError);
      return false;
    }
  }

  // ============================================
  // CANCEL PING
  // ============================================

  /// Cancel an active ping
  void cancelPing(String emotionId) async {    
    final context = getContext?.call();
    if (context != null) {
      final l10n = AppLocalizations.of(context)!;
      onShowToast?.call(l10n.pingCancelled);
    }

    debugPrint('[PingWink] Starting ping cancellation for $emotionId');

    // 1. Local cleanup first
    _pingTimers[emotionId]?.cancel();
    _pingTimers.remove(emotionId);
    _pingStartTimes.remove(emotionId);
    _processingPings.remove(emotionId);
    _vibeManager.clearLocalState(moodId: emotionId);
    notifyListeners();

    // 2. Notify MapScreen to remove animation
    onRemovePingAnimation?.call(emotionId);

    debugPrint('[PingWink] Local cleanup completed for $emotionId');

    // 3. Cancel on server via Edge Function
    if (_userData?.deviceId != null) {
      try {
        debugPrint('[PingWink] Calling cancel-ping Edge Function...');

        final response = await http.post(
          Uri.parse('${AppConfig.supabaseUrl}/functions/v1/cancel-ping'),
          headers: {
            'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'device_id': _userData!.deviceId,
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          debugPrint('[PingWink] Server cancellation successful');
          debugPrint('[PingWink] Cancelled count: ${data['cancelled_count']}');
        } else {
          final error = json.decode(response.body);
          debugPrint('[PingWink] Server error: ${error['error']}');
        }
      } catch (e) {
        debugPrint('[PingWink] Network error cancelling ping: $e');
      }
    }

    // 4. Restore original color
    onUpdateMarkerColor?.call(emotionId, null);

    debugPrint('[PingWink] Ping cancellation completed for $emotionId');
  }

  /// Helper method to cleanup failed ping
  void _cleanupFailedPing(String emotionId) {
    _processingPings.remove(emotionId);
    _pingStartTimes.remove(emotionId);
    notifyListeners();
  }

  // ============================================
  // WINK BANNER MANAGEMENT
  // ============================================

  /// Show wink banner for incoming ping
  void _showWinkBanner(IncomingPing ping) {
    final context = getContext?.call();
    if (context == null || !context.mounted) return;

    // Remove existing banner if any
    _winkBannerOverlay?.remove();
    _winkBannerOverlay = null;

    debugPrint('[PingWink] Showing wink banner for ping: ${ping.pingId}');

    // Mark our vibe as busy if we have one
    // Note: This is handled by MapScreen since it needs access to activeEmotions

    // Animate ping source on map
    onAnimatePingSource?.call(ping);

    // Create and show banner overlay
    _winkBannerOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: WinkBanner(
            ping: ping,
            onWink: () => _handleWink(ping),
            onDismiss: () => _dismissPing(ping),
            onExpired: () {
              _winkBannerOverlay?.remove();
              _winkBannerOverlay = null;
              _shownPings.remove(ping.pingId);
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_winkBannerOverlay!);

    // Auto-remove after expiration
    Timer(Duration(seconds: ping.remainingSeconds), () {
      if (_winkBannerOverlay != null) {
        _winkBannerOverlay?.remove();
        _winkBannerOverlay = null;
        _shownPings.remove(ping.pingId);
      }
    });
  }

  // ============================================
  // HANDLE WINK (ACCEPT PING)
  // ============================================

  Future<void> _handleWink(IncomingPing ping) async {
    final context = getContext?.call();
    if (context == null || _userData?.deviceId == null) return;

    final l10n = AppLocalizations.of(context)!;

    // Remove banner
    _winkBannerOverlay?.remove();
    _winkBannerOverlay = null;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4FF)),
        ),
      ),
    );

    try {
      // Send wink via API
      final result = await PingWinkService.sendWink(
        pingId: ping.pingId,
        winkDeviceId: _userData!.deviceId,
      );

      // Close loading dialog
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      if (result['success'] == true && result['spark_session'] != null) {
        try {
          final session = result['spark_session'] as SparkSession;
          _activeSparkSessions[session.id] = true;

          // Cancel ALL active outgoing pings when Spark created
          for (var pingId in _processingPings.keys.toList()) {
            cancelPing(pingId);
          }

          // Dismiss ALL other incoming pings
          await _dismissAllIncomingPings(except: ping.pingId);

          // Update Spark statuses for BOTH participants
          _vibeManager.setLocalState(
              deviceId: session.device1,
              status: VibeStatus.inSpark,
              color: const Color(0xFF808080));
          _vibeManager.setLocalState(
              deviceId: session.device2,
              status: VibeStatus.inSpark,
              color: const Color(0xFF808080));

          // Show spark animation and navigate to chat
          if (onShowSparkAnimation != null) {
            await onShowSparkAnimation!();
          }

          // Navigate immediately after animation (without Future.delayed)
          if (onNavigateToSpark != null) {
            onNavigateToSpark!(session);
          }
        } catch (sessionError) {
          debugPrint('[PingWink] Error parsing spark session: $sessionError');
          onShowError?.call(l10n.pingErrorStartingChat);
        }
      } else {
        onShowError?.call(result['error'] ?? l10n.pingFailedToSend);
      }
    } catch (e) {
      debugPrint('[PingWink] Error handling wink: $e');
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      onShowError?.call(l10n.pingErrorConnecting);
    }
  }

  // ============================================
  // DISMISS PING (REJECT)
  // ============================================

  void _dismissPing(IncomingPing ping) {
    // Remove banner
    _winkBannerOverlay?.remove();
    _winkBannerOverlay = null;
    _shownPings.remove(ping.pingId);
    _processedPingIds.add(ping.pingId);

    // Reject ping on server
    PingWinkService.rejectPing(ping.pingId);

    HapticFeedback.selectionClick();
    debugPrint('[PingWink] Ping dismissed: ${ping.pingId}');
  }

  // ============================================
  // PUBLIC METHODS FOR UI INTERACTION
  // ============================================

  /// Check if user can send a ping
  bool canSendPing(EmotionData targetEmotion) {
    // Check if already sending to this emotion
    if (_processingPings[targetEmotion.id] == true) {
      return false;
    }

    // Check if already have an active ping
    if (_processingPings.values.any((processing) => processing == true)) {
      return false;
    }

    // Check availability through VibeStateManager
    if (!_vibeManager.isAvailableForPing(
        targetEmotion.id, targetEmotion.deviceId)) {
      return false;
    }

    return true;
  }

  /// Get remaining seconds for a ping
  int getRemainingSeconds(String emotionId) {
    final startTime = _pingStartTimes[emotionId];
    if (startTime == null) return 0;

    final elapsed = DateTime.now().difference(startTime).inSeconds;
    return (60 - elapsed).clamp(0, 60);
  }

  /// Check if any pings are active
  bool get hasActivePings => _processingPings.values.any((v) => v == true);

  /// Get first active ping ID
  String? get firstActivePingId {
    try {
      return _processingPings.entries
          .firstWhere((entry) => entry.value == true)
          .key;
    } catch (_) {
      return null;
    }
  }

  /// Handle push notification for ping
  void handlePingPushNotification(Map<String, dynamic> data) {
    if (data['type'] == 'ping') {
      debugPrint(
          '[PingWink] Push received: ping from ${data['from_device_id']}');
      _checkIncomingPings();
      HapticFeedback.heavyImpact();
    }
  }

  /// Handle push notification for spark
  void handleSparkPushNotification(Map<String, dynamic> data) {
    if (data['type'] == 'spark') {
      debugPrint(
          '[PingWink] Push received: spark session ${data['session_id']}');
      _checkActiveSparks();
      HapticFeedback.heavyImpact();
    }
  }

  /// Handle ping cancellation push notification
  void handlePingCancellationPush(Map<String, dynamic> data) {
    if (data['type'] == 'ping_cancelled') {
      debugPrint('[PingWink] Received ping cancellation notification');

      final cancelledPings = data['cancelled_pings'] as List<dynamic>?;

      // Remove banner if currently showing
      if (_winkBannerOverlay != null) {
        _winkBannerOverlay?.remove();
        _winkBannerOverlay = null;

        // Mark pings as processed
        if (cancelledPings != null) {
          for (var pingId in cancelledPings) {
            _processedPingIds.add(pingId.toString());
            _shownPings.add(pingId.toString());
          }
        }

        // Show notification to user - получаем context и l10n здесь
        final context = getContext?.call();
        if (context != null) {
          final l10n = AppLocalizations.of(context)!;
          onShowToast?.call(l10n.pingCancelledBySender);
        }
      }
    }
  }

  /// Mark Spark chat as closed in UI
  void onSparkChatClosed(String sessionId) {
    _activeSparkSessions[sessionId] = false;
    debugPrint('[PingWink] Spark chat closed: $sessionId');
  }

  /// Mark user's mood as busy when receiving ping
  void markMyMoodAsBusy(String moodId) {
    _vibeManager.setLocalState(
        moodId: moodId, status: VibeStatus.receivingPing, color: Colors.white);
  }

  /// Clear user's mood busy status
  void clearMyMoodBusyStatus(String moodId) {
    _vibeManager.clearLocalState(moodId: moodId);
  }
}
