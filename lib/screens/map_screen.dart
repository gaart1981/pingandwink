// lib/screens/map_screen.dart
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart'
    show OnCircleAnnotationClickListener;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutter/foundation.dart' show mapEquals;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../config/emotions.dart';
import '../models/emotion_data.dart';
import '../models/user_data.dart';
import '../models/ping_data.dart';
import '../services/api_service.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../widgets/emotion_selector.dart';
import '../widgets/map_widget.dart';
import '../widgets/ping_bottom_sheet.dart';
import 'spark_chat_screen.dart';
import '../services/moderation_service.dart';
import '../widgets/ban_overlay.dart';
import '../widgets/community_guidelines_dialog.dart';
import '../widgets/viral_share_card.dart';
import 'birth_year_selection_screen.dart';
import '../services/vibe_state_manager.dart';
import '../controllers/ping_wink_controller.dart';
import '../l10n/app_localizations.dart';
import '../controllers/empty_state_controller.dart';
import '../widgets/empty_state_widget.dart';
import '../services/notification_service.dart';
import '../widgets/vibe_confirmation_animation.dart';

/// Map screen with Ping&Wink - Adapted for Mapbox 2.3.0
class MapScreen extends StatefulWidget {
  final bool isInContainer;

  const MapScreen({
    super.key,
    this.isInContainer = false,
  });

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // Mapbox
  mapbox.MapboxMap? _mapboxMap;
  mapbox.CircleAnnotationManager? _circleAnnotationManager;
  mapbox.CircleAnnotationManager?
      _tapCircleManager; // Separate manager for tap areas

  final Map<String, mapbox.CircleAnnotation> _emotionMarkers = {};
  final Map<String, mapbox.CircleAnnotation> _tapAreas = {};
  final Map<String, EmotionData> _annotationToEmotion = {};

  List<EmotionData> _activeEmotions = [];
  bool _mapReady = false;

  // UI State
  bool _showEmotionSelector = false;
  bool _isSubmitting = false;
  bool _hasActiveEmotion = false;

  // User Data
  UserData? _userData;
  geo.Position? _currentPosition;

  Timer? _refreshTimer;
  Timer? _viewportDebounce;
  bool _userHasPostedEmotion = false;

  // Controllers - FIXED: Make non-nullable and initialize early
  late final VibeStateManager _vibeManager = VibeStateManager();
  late final PingWinkController _pingWinkController = PingWinkController();
  late final EmptyStateController _emptyStateController;

  // Moderation state
  Timer? _statusUpdateTimer;
  BanStatus? _banStatus;

  // Mapbox visual elements (must stay in MapScreen)
  final Map<String, mapbox.CircleAnnotation> _emotionRings = {};
  final Map<String, mapbox.CircleAnnotation> _emotionCenters = {};

  // Mapbox animations (must stay in MapScreen)
  final Map<String, List<mapbox.CircleAnnotation>> _pingAnimations = {};
  final Map<String, Timer?> _pingAnimationTimers = {};
  final Map<String, List<mapbox.CircleAnnotation>> _winkAnimations = {};
  Timer? _winkAnimationTimer;

  // Tutorial state
  bool _showingTutorial = false;
  Timer? _tutorialBlinkTimer;
  bool _tutorialBlinking = true;
  EmotionData? _tutorialTargetVibe;

  // Animation controllers
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupControllerCallbacks(); // FIXED: Setup callbacks early

    // Initialize Empty State controller
    _emptyStateController = EmptyStateController(
      onRequestPushPermission: () async {
        final granted =
            await NotificationService.requestNotificationPermissions();
        if (granted && mounted) {
          _showToast(
              'Notifications enabled! You\'ll know when vibes appear 🔔');
        }
      },
      onNavigateToSettings: () {
        if (mounted) {
          Navigator.pushNamed(context, '/settings');
        }
      },
    );
    _initializeApp().then((_) {
      _checkBirthYear();
    });

    // Push instant handling
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      if (mounted) {
        final data = event.notification.additionalData;
        if (data != null) {
          _pingWinkController.handlePingPushNotification(data);
          _pingWinkController.handleSparkPushNotification(data);
        }
      }
    });

    OneSignal.Notifications.addClickListener((event) {
      if (mounted) {
        final data = event.notification.additionalData;

        // Save ping_id for later processing when app opens from background
        if (data != null && data['ping_id'] != null) {
          final pingId = data['ping_id'] as String;
          debugPrint('📱 Push clicked: saving ping $pingId');
          StorageService.savePendingPing(pingId);
        }
      }
    });

    // Handle ping cancellation via push notification
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      if (mounted) {
        final data = event.notification.additionalData;
        if (data != null && data['type'] == 'ping_cancelled') {
          _pingWinkController.handlePingCancellationPush(data);
        }
      }
    });

    StorageService.getCachedBanStatus().then((cachedBan) {
      if (cachedBan != null && cachedBan.isBanned && mounted) {
        setState(() {
          _banStatus = cachedBan;
        });
      }
    });

    _checkBanStatus();
    CommunityGuidelinesDialog.showIfNeeded(context);

    // Check ban status every 10 seconds
    Timer.periodic(const Duration(seconds: 10), (_) {
      if (_userData != null) {
        _checkBanStatus();
      }
    });

    WidgetsBinding.instance.addObserver(this);
    _checkStreakStatus();

    // Status update timer - check every 5 seconds
    _statusUpdateTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_mapReady && _activeEmotions.isNotEmpty) {
        _updateOnlyStatuses();
      }
    });
  }

  // FIXED: Setup all callbacks for controller
  void _setupControllerCallbacks() {
    _pingWinkController.getContext = () => context;
    _pingWinkController.onShowToast = _showToast;
    _pingWinkController.onShowError = _showError;
    _pingWinkController.onReloadEmotions = _loadEmotionsForViewport;
    _pingWinkController.onUpdateMarkerColor = _updateSingleCenterColor;
    _pingWinkController.onShowSparkAnimation = _showSparkAnimation;

    // Animation callbacks
    _pingWinkController.onAddPingAnimation = (emotion, pingId) {
      _addPingAnimation(emotion);
    };
    _pingWinkController.onRemovePingAnimation = (pingId) {
      _stopPingAnimation(pingId);
    };
    _pingWinkController.onAnimatePingSource = _animatePingSource;

    // Navigation callback
    _pingWinkController.onNavigateToSpark = (session) async {
      if (!mounted) return;

      // Show spark animation
      await _showSparkAnimation();

      if (!mounted) return;

      // Open chat and wait for result
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SparkChatScreen(session: session),
        ),
      );

      // Mark chat as closed after user returns
      _pingWinkController.onSparkChatClosed(session.id);

      // Clear vibe states
      setState(() {
        _vibeManager.clearLocalState(deviceId: session.device1);
        _vibeManager.clearLocalState(deviceId: session.device2);
      });

      // Update map
      _updateCenterColors();
      _loadEmotionsForViewport();
    };
  }

  // Access to controller state - FIXED: Now guaranteed non-null
  Map<String, bool> get _processingPings => _pingWinkController.processingPings;
  Map<String, DateTime> get _pingStartTimes =>
      _pingWinkController.pingStartTimes;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Track user return for Empty State
      _emptyStateController.onUserReturned();

      // Recheck map state
      if (_activeEmotions.length < 3 && mounted) {
        _emptyStateController.checkAndShowMessage(
          context,
          _activeEmotions.length,
        );
      }

      StorageService.getCachedBanStatus().then((cachedBan) {
        if (cachedBan != null && cachedBan.isBanned && mounted) {
          setState(() {
            _banStatus = cachedBan;
          });
        }
      });

      if (_userData != null) {
        _checkBanStatus();
      }

      if (_showEmotionSelector && (_banStatus?.isBanned ?? false)) {
        setState(() {
          _showEmotionSelector = false;
        });
      }
    }
  }

  Future<void> _checkBanStatus() async {
    if (_userData == null) return;
    if (!mounted) return;

    final banStatus =
        await ModerationService.checkBanStatus(_userData!.deviceId);
    if (!mounted) return;

    await StorageService.saveBanStatus(
      banStatus.isBanned,
      banStatus.bannedUntil,
    );

    if (!mounted) return;

    final bool wasBanned = _banStatus?.isBanned ?? false;
    final bool isNowBanned = banStatus.isBanned;

    if (wasBanned != isNowBanned) {
      setState(() {
        _banStatus = banStatus.isBanned ? banStatus : null;

        if (banStatus.isBanned && !_hasActiveEmotion) {
          _showEmotionSelector = true;
        } else if (!banStatus.isBanned && !_hasActiveEmotion) {
          _showEmotionSelector = false;
        }
      });

      if (isNowBanned && mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                l10n.mapBanRestrictionMessage(banStatus.remainingTimeText)),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      } else if (!isNowBanned && wasBanned && mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.mapBanRestrictionLifted),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      _banStatus = banStatus.isBanned ? banStatus : null;
    }
  }

  // Delegate method for ping cancellation
  void _cancelPing(String id) => _pingWinkController.cancelPing(id);

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  Future<void> _initializeApp() async {
    await _loadUserData();
    // Initialize Ping&Wink controller after user data is loaded
    if (_userData != null) {
      _pingWinkController.initialize(_userData!, _hasActiveEmotion);
    }
    await _getCurrentLocation();
    _startRefreshTimer();
  }

  Future<void> _checkBirthYear() async {
    if (_userData == null || _userData!.hasBirthYear) {
      if (_userData!.hasBirthYear && _mapReady) {
        await _loadEmotionsForViewport();
      }
      return;
    }

    // If no birth year set, show selection screen
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BirthYearSelectionScreen(
            onComplete: () async {
              _userData = await StorageService.loadUserData();

              // Save to server
              if (_userData!.birthYear != null) {
                await ApiService.saveBirthYear(
                  deviceId: _userData!.deviceId,
                  birthYear: _userData!.birthYear!,
                );
              }

              // Close screen
              if (context.mounted) {
                Navigator.pop(context);
              }

              if (_mapReady) {
                await _loadEmotionsForViewport();
              } else {
                await _loadEmotionsFromAPI();
              }

              // Reload emotions with filtering
              await _loadEmotionsFromAPI();
            },
          ),
        ),
      );
    }
  }

  Future<void> _checkStreakStatus() async {
    await Future.delayed(const Duration(seconds: 1));

    final wasLost = await StorageService.checkStreakLost();
    if (wasLost && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Text('😔', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                _userData?.isFrench ?? true
                    ? 'Streak perdu! Commence une nouvelle série'
                    : 'Streak lost! Start a new one today',
              ),
            ],
          ),
          backgroundColor: Colors.orange.shade700,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _loadUserData() async {
    _userData = await StorageService.loadUserData();
    debugPrint('👤 User data loaded: ${_userData?.deviceId}');
    // Update controller with new user data
    if (_userData != null) {
      _pingWinkController.updateUserData(_userData!);
    }
  }

  Future<void> _getCurrentLocation() async {
    _currentPosition = await LocationService.getCurrentLocation();
    if (_mapboxMap != null && _mapReady && _currentPosition != null) {
      await _centerMapOnLocation();
    }
  }

  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_userData?.birthYear == null) {
        debugPrint('⏳ Skipping refresh - no birth year set');
        return;
      }

      if (_mapReady && _mapboxMap != null) {
        _loadEmotionsForViewport();
      } else {
        _loadEmotionsFromAPI();
      }

      // Check if emotion expired (after 2 hours)
      if (_userHasPostedEmotion && !_hasActiveEmotion) {
        setState(() {
          _userHasPostedEmotion = false;
        });
        debugPrint('User emotion expired');
      }
    });
  }

  Future<void> _loadEmotionsFromAPI() async {
    if (_userData == null) return;

    try {
      final data = await ApiService.getMapData(
        deviceId: _userData!.deviceId,
        lat: _currentPosition?.latitude,
        lon: _currentPosition?.longitude,
        birthYear: _userData!.birthYear,
      );

      _activeEmotions = ApiService.parseEmotions(data, _userData!.deviceId);
      _hasActiveEmotion = data['stats']?['has_active_mood'] ?? false;

      // Update controller with active emotion status
      _pingWinkController.updateActiveEmotionStatus(_hasActiveEmotion);

      // Sync global states from server
      _vibeManager.syncGlobalStates(
        activeSparks: data['active_sparks'] ?? [],
        activePings: data['active_pings'] ?? [],
        myDeviceId: _userData!.deviceId,
      );

      _vibeManager.printDebugInfo();

      if (_userData!.birthYear != null &&
          data['stats']?['age_filtered'] == true) {
        debugPrint(
            '🎂 Age filtering active for birth year ${_userData!.birthYear}');
      }

      await _smartUpdateMapMarkers();

      // Restore busy vibes for still active pings
      for (var entry in _processingPings.entries) {
        if (entry.value == true) {
          final moodId = entry.key;
          if (_activeEmotions.any((e) => e.id == moodId)) {
            _vibeManager.setLocalState(
                moodId: moodId,
                status: VibeStatus.receivingPing,
                color: Colors.white);
            debugPrint('FORCE WHITE: Restored white center for ping $moodId');
          }
        }
      }

      if (!_hasActiveEmotion && !_showEmotionSelector && mounted) {
        final cachedBan = await StorageService.getCachedBanStatus();
        if (cachedBan != null && cachedBan.isBanned) {
          setState(() {
            _banStatus = cachedBan;
            _showEmotionSelector = true;
          });
        } else {
          setState(() {
            _showEmotionSelector = true;
          });
        }
      }

      // Check empty state after loading
      if (mounted) {
        _emptyStateController.checkAndShowMessage(
          context,
          _activeEmotions.length,
        );
      }
    } catch (e) {
      debugPrint('Error loading emotions: $e');
    }
  }

  Future<void> _loadEmotionsForViewport() async {
    if (_mapboxMap == null || !_mapReady || _userData == null) return;

    try {
      mapbox.CoordinateBounds? bounds;
      double? zoom;

      try {
        final currentCamera = await _mapboxMap!.getCameraState();
        final cameraOptions = mapbox.CameraOptions(
          center: currentCamera.center,
          zoom: currentCamera.zoom,
          bearing: currentCamera.bearing,
          pitch: currentCamera.pitch,
        );
        bounds = await _mapboxMap!.coordinateBoundsForCamera(cameraOptions);
        zoom = currentCamera.zoom;
      } catch (e) {
        debugPrint(
            'Could not get viewport bounds, using location-based loading: $e');
      }

      final Map<String, dynamic> data;

      if (bounds != null) {
        data = await ApiService.getMapData(
          deviceId: _userData!.deviceId,
          lat: _currentPosition?.latitude,
          lon: _currentPosition?.longitude,
          birthYear: _userData!.birthYear,
          north: bounds.northeast.coordinates.lat.toDouble(),
          south: bounds.southwest.coordinates.lat.toDouble(),
          east: bounds.northeast.coordinates.lng.toDouble(),
          west: bounds.southwest.coordinates.lng.toDouble(),
          zoom: zoom,
        );
      } else {
        data = await ApiService.getMapData(
          deviceId: _userData!.deviceId,
          lat: _currentPosition?.latitude,
          lon: _currentPosition?.longitude,
          birthYear: _userData!.birthYear,
        );
      }

      _activeEmotions = ApiService.parseEmotions(data, _userData!.deviceId);
      _hasActiveEmotion = data['stats']?['has_active_mood'] ?? false;

      // Update controller with active emotion status
      _pingWinkController.updateActiveEmotionStatus(_hasActiveEmotion);

      _vibeManager.clearAll();
      _vibeManager.syncGlobalStates(
        activeSparks: data['active_sparks'] ?? [],
        activePings: data['active_pings'] ?? [],
        myDeviceId: _userData!.deviceId,
      );

      // Restore my active pings to VibeStateManager
      for (var entry in _processingPings.entries) {
        if (entry.value == true) {
          _vibeManager.setLocalState(
            moodId: entry.key,
            status: VibeStatus.sendingPing,
            color: Colors.white,
            duration: const Duration(seconds: 60),
          );
        }
      }

      _vibeManager.printDebugInfo();

      await _smartUpdateMapMarkers();

      // Check tutorial after 2 seconds
      if (_hasActiveEmotion && !_showEmotionSelector) {
        Timer(const Duration(seconds: 2), () {
          _checkAndShowTutorial();
        });
      }

      // Restore busy vibes for still active pings
      for (var entry in _processingPings.entries) {
        if (entry.value == true) {
          final moodId = entry.key;
          if (_activeEmotions.any((e) => e.id == moodId)) {
            _vibeManager.setLocalState(
                moodId: moodId,
                status: VibeStatus.receivingPing,
                color: Colors.white);
            debugPrint('FORCE WHITE: Restored white center for ping $moodId');
          }
        }
      }

      if (!_hasActiveEmotion && !_showEmotionSelector && mounted) {
        setState(() {
          _showEmotionSelector = true;
        });
      }

      // Check empty state after loading
      if (mounted && _mapReady) {
        Timer(const Duration(milliseconds: 500), () {
          if (mounted) {
            _emptyStateController.checkAndShowMessage(
              context,
              _activeEmotions.length,
            );
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading viewport emotions: $e');
      await _loadEmotionsFromAPI();
    }
  }

  // Smart update that only adds/removes changed emotions
  Future<void> _smartUpdateMapMarkers() async {
    if (_circleAnnotationManager == null || _tapCircleManager == null) return;

    // Save active ping states before any changes
    final activePingMoodIds = <String>{};
    for (var entry in _processingPings.entries) {
      if (entry.value == true) {
        activePingMoodIds.add(entry.key);
      }
    }

    // Build map of device_id -> emotion_id for NEW data
    final Map<String, String> newDeviceToId = {};
    for (var emotion in _activeEmotions) {
      newDeviceToId[emotion.deviceId] = emotion.id;
    }

    // Build map of device_id -> emotion_id for CURRENT map
    final Map<String, String> currentDeviceToId = {};
    for (var emotion in _annotationToEmotion.values) {
      currentDeviceToId[emotion.deviceId] = emotion.id;
    }

    // If device maps are identical, skip full update (no flicker!)
    if (mapEquals(newDeviceToId, currentDeviceToId)) {
      // Only update colors for status changes
      await _updateCenterColors();
      return;
    }

    // Maps differ - do full refresh
    debugPrint('Device map changed, performing full refresh');

    // Stop ping animations temporarily
    for (var timer in _pingAnimationTimers.values) {
      timer?.cancel();
    }
    _pingAnimationTimers.clear();

    for (var animations in _pingAnimations.values) {
      for (var annotation in animations) {
        try {
          await _circleAnnotationManager!.delete(annotation);
        } catch (e) {
          // Ignore
        }
      }
    }
    _pingAnimations.clear();

    // Clear all markers
    await _circleAnnotationManager!.deleteAll();
    await _tapCircleManager!.deleteAll();
    _emotionMarkers.clear();
    _tapAreas.clear();
    _emotionRings.clear();
    _emotionCenters.clear();
    _annotationToEmotion.clear();

    // Recreate all markers
    for (var emotion in _activeEmotions) {
      await _addEmotionToMap(emotion);
    }

    // Restore ping animations
    for (var moodId in activePingMoodIds) {
      EmotionData? emotion;
      try {
        emotion = _activeEmotions.firstWhere((e) => e.id == moodId);
      } catch (e) {
        emotion = null;
      }

      if (emotion != null) {
        await _restorePingAnimation(emotion);
        _vibeManager.setLocalState(
          moodId: moodId,
          status: VibeStatus.sendingPing,
          color: Colors.white,
        );
      }
    }

    // Update colors
    await _updateCenterColors();
  }

  Future<void> _restorePingAnimation(EmotionData emotion) async {
    if (_circleAnnotationManager == null) return;
    if (!_processingPings.containsKey(emotion.id)) return;

    try {
      final startTime = _pingStartTimes[emotion.id];
      if (startTime == null) return;

      final elapsedSeconds = DateTime.now().difference(startTime).inSeconds;
      final remainingSeconds = 65 - elapsedSeconds;

      if (remainingSeconds <= 0) {
        _cancelPing(emotion.id);
        return;
      }

      final List<mapbox.CircleAnnotation> pulseAnnotations = [];

      for (int i = 0; i < 3; i++) {
        final pulseOption = mapbox.CircleAnnotationOptions(
          geometry: mapbox.Point(
              coordinates: mapbox.Position(emotion.lon, emotion.lat)),
          circleRadius: 15.0 + (i * 8),
          circleColor: Colors.transparent.toARGB32(),
          circleOpacity: 0,
          circleStrokeWidth: 1.5,
          circleStrokeColor: const Color(0xFF00D4FF).toARGB32(),
          circleStrokeOpacity: 0.6 - (i * 0.15),
        );

        final pulse = await _circleAnnotationManager!.create(pulseOption);
        pulseAnnotations.add(pulse);
      }

      _pingAnimations[emotion.id] = pulseAnnotations;

      int animationCount = (elapsedSeconds / 2).floor();

      _pingAnimationTimers[emotion.id] = Timer.periodic(
        const Duration(seconds: 2),
        (timer) async {
          animationCount++;

          final currentElapsed = DateTime.now().difference(startTime).inSeconds;
          if (!_processingPings.containsKey(emotion.id) ||
              !mounted ||
              currentElapsed >= 65) {
            timer.cancel();
            for (var annotation in pulseAnnotations) {
              try {
                await _circleAnnotationManager?.delete(annotation);
              } catch (e) {
                // Ignore
              }
            }
            _pingAnimations.remove(emotion.id);
            _pingAnimationTimers.remove(emotion.id);

            if (currentElapsed >= 65) {
              _cancelPing(emotion.id);
            }
            return;
          }

          try {
            if (_circleAnnotationManager != null) {
              for (int i = 0; i < pulseAnnotations.length; i++) {
                await _circleAnnotationManager!.update(pulseAnnotations[i]
                  ..circleStrokeOpacity =
                      (0.6 - (i * 0.15)) * (1 - (animationCount % 3) * 0.3)
                  ..circleRadius = 15.0 + (i * 8) + ((animationCount % 3) * 5));
              }
            }
          } catch (e) {
            debugPrint('Animation update skipped (annotation deleted)');
          }
        },
      );

      debugPrint(
          'Restored ping animation for ${emotion.id}, remaining: ${remainingSeconds}s');
    } catch (e) {
      debugPrint('Error restoring ping animation: $e');
    }
  }

  Future<void> _addEmotionToMap(EmotionData emotionData) async {
    if (_circleAnnotationManager == null || _tapCircleManager == null) return;

    final emotionConfig = Emotions.getEmotion(emotionData.emotion);
    final emotionColor = emotionConfig.color;

    Color centerColor;
    if (emotionData.isOwn) {
      centerColor = emotionColor;
    } else {
      centerColor = _vibeManager.getVibeColor(
        emotionData.id,
        emotionData.deviceId,
        emotionData.emotion,
      );
    }

    try {
      // Create ring FIRST (transparent center, colored stroke)
      final ringOption = mapbox.CircleAnnotationOptions(
        geometry: mapbox.Point(
            coordinates: mapbox.Position(emotionData.lon, emotionData.lat)),
        circleRadius: 5.0,
        circleColor: Colors.transparent.toARGB32(),
        circleStrokeWidth: 4.0,
        circleStrokeColor: emotionData.isOwn
            ? Colors.white.toARGB32()
            : emotionColor.toARGB32(),
        circleStrokeOpacity: 1.0,
      );

      // Create center dot SECOND (on top)
      final centerOption = mapbox.CircleAnnotationOptions(
        geometry: mapbox.Point(
            coordinates: mapbox.Position(emotionData.lon, emotionData.lat)),
        circleRadius: 5.0,
        circleColor: centerColor.toARGB32(),
        circleStrokeWidth: 0,
        circleOpacity: 1.0,
      );

      final ring = await _circleAnnotationManager!.create(ringOption);
      final center = await _circleAnnotationManager!.create(centerOption);

      _emotionRings[emotionData.id] = ring;
      _emotionCenters[emotionData.id] = center;
      _emotionMarkers[emotionData.id] = ring;

      // Tap area for all non-own vibes
      if (!emotionData.isOwn) {
        final tapAreaOption = mapbox.CircleAnnotationOptions(
          geometry: mapbox.Point(
              coordinates: mapbox.Position(emotionData.lon, emotionData.lat)),
          circleRadius: 13.0,
          circleColor: Colors.transparent.toARGB32(),
          circleOpacity: 0.01,
          circleStrokeWidth: 0,
        );

        final tapArea = await _tapCircleManager!.create(tapAreaOption);
        _tapAreas[emotionData.id] = tapArea;
        _annotationToEmotion[tapArea.id] = emotionData;
      }
    } catch (e) {
      debugPrint('Error adding emotion to map: $e');
    }
  }

  // Update only statuses without reloading map
  Future<void> _updateOnlyStatuses() async {
    if (_activeEmotions.isEmpty) return;

    debugPrint('STATUS CHECK: Current processingPings = $_processingPings');

    // Collect all IDs
    final moodIds = _activeEmotions.map((e) => e.id).toList();
    final deviceIds = _activeEmotions.map((e) => e.deviceId).toSet().toList();

    // Parallel requests
    final results = await Future.wait([
      _checkBulkPingStatuses(moodIds),
      _checkBulkSparkStatuses(deviceIds),
    ]);

    final busyMoods = results[0];

    // Update if changed
    bool needsUpdate = false;
    for (var moodId in busyMoods) {
      _vibeManager.setLocalState(
          moodId: moodId,
          status: VibeStatus.receivingPing,
          color: Colors.white);
      needsUpdate = true;
    }

    if (needsUpdate) {
      await _updateCenterColors();
    }
  }

  // Check ping statuses for all moods
  Future<Set<String>> _checkBulkPingStatuses(List<String> moodIds) async {
    if (moodIds.isEmpty) return {};

    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/pings';
      final queryParams = {
        'to_mood_id': 'in.(${moodIds.join(',')})',
        'status': 'eq.pending',
        'expires_at': 'gt.${DateTime.now().toIso8601String()}',
        'select': 'to_mood_id',
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
        'apikey': AppConfig.supabaseAnonKey,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((p) => p['to_mood_id'] as String).toSet();
      }
    } catch (e) {
      debugPrint('Error checking ping statuses: $e');
    }
    return {};
  }

  // Check Spark sessions for all devices
  Future<Set<String>> _checkBulkSparkStatuses(List<String> deviceIds) async {
    if (deviceIds.isEmpty) return {};

    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/spark_sessions';
      final queryParams = {
        'or':
            '(device_1.in.(${deviceIds.join(',')}),device_2.in.(${deviceIds.join(',')}))',
        'is_active': 'eq.true',
        'select': 'device_1,device_2',
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
        'apikey': AppConfig.supabaseAnonKey,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final devices = <String>{};
        for (var session in data) {
          devices.add(session['device_1'] as String);
          devices.add(session['device_2'] as String);
        }
        return devices;
      }
    } catch (e) {
      debugPrint('Error checking spark statuses: $e');
    }
    return {};
  }

  // Update center dot colors WITHOUT recreating them
  Future<void> _updateCenterColors() async {
    if (_circleAnnotationManager == null) return;

    for (var emotion in _activeEmotions) {
      // Skip own vibe - NEVER change it
      if (emotion.isOwn) continue;

      // Get color from VibeStateManager ONLY
      Color newColor = _vibeManager.getVibeColor(
        emotion.id,
        emotion.deviceId,
        emotion.emotion,
      );

      // Update center dot WITHOUT deleting
      final center = _emotionCenters[emotion.id];
      if (center != null) {
        try {
          // Just update the color property
          await _circleAnnotationManager!
              .update(center..circleColor = newColor.toARGB32());
        } catch (e) {
          // If update fails, circle was deleted - need to recreate
          try {
            final newCenterOption = mapbox.CircleAnnotationOptions(
              geometry: mapbox.Point(
                  coordinates: mapbox.Position(emotion.lon, emotion.lat)),
              circleRadius: 5.0,
              circleColor: newColor.toARGB32(),
              circleStrokeWidth: 0,
              circleOpacity: 1.0,
            );

            final newCenter =
                await _circleAnnotationManager!.create(newCenterOption);
            _emotionCenters[emotion.id] = newCenter;
          } catch (e) {
            debugPrint('Could not recreate center: $e');
          }
        }
      }
    }
  }

  Future<void> _updateSingleCenterColor(String moodId, Color? newColor) async {
    if (_circleAnnotationManager == null) return;

    // PRIORITY: If this is my active ping - always white
    if (_processingPings[moodId] == true) {
      newColor = Colors.white;
      debugPrint('FORCED WHITE: Active ping $moodId');
    }

    // CRITICAL PROTECTION: If this is active ping - ALWAYS white
    if (_processingPings[moodId] == true && newColor != Colors.white) {
      debugPrint('⚠️ BLOCKED: Trying to change active ping color from white!');
      newColor = Colors.white; // Force white
    }

    // Safe emotion lookup
    EmotionData? emotion;
    try {
      emotion = _activeEmotions.firstWhere((e) => e.id == moodId);
    } catch (e) {
      return;
    }

    if (emotion.isOwn) return; // Never change own emotion color

    final color = newColor ?? Emotions.getEmotion(emotion.emotion).color;
    final center = _emotionCenters[moodId];

    if (center != null && _circleAnnotationManager != null) {
      try {
        // Safe deletion of old center
        try {
          await _circleAnnotationManager!.delete(center);
        } catch (e) {
          // Ignore
        }

        // Create new center with correct color
        final newCenterOption = mapbox.CircleAnnotationOptions(
          geometry: mapbox.Point(
              coordinates: mapbox.Position(emotion.lon, emotion.lat)),
          circleRadius: 5.0,
          circleColor: color.toARGB32(),
          circleStrokeWidth: 0,
          circleOpacity: 1.0,
        );

        final newCenter =
            await _circleAnnotationManager!.create(newCenterOption);
        _emotionCenters[moodId] = newCenter;

        debugPrint(
            '✅ Updated center color for $moodId to white: ${color == Colors.white}');
      } catch (e) {
        debugPrint('Error updating single center color: $e');
      }
    }
  }

  void _onEmotionTap(EmotionData emotion) async {
    final l10n = AppLocalizations.of(context)!;
    debugPrint('👆 Tapped on emotion: ${emotion.id}');

    if (emotion.isOwn) {
      _showToast(l10n.mapToastYourOwnVibe);
      HapticFeedback.lightImpact();
      return;
    }

    // Find my emotion
    EmotionData? myEmotion;
    try {
      myEmotion = _activeEmotions.firstWhere((e) => e.isOwn);
    } catch (e) {
      myEmotion = null;
    }

    if (myEmotion == null) {
      _showToast(l10n.mapErrorNeedActiveVibeToPing);
      HapticFeedback.lightImpact();
      return;
    }

    // Check if can send ping using controller
    if (!_pingWinkController.canSendPing(emotion)) {
      if (_pingWinkController.processingPings[emotion.id] == true) {
        _pingWinkController.cancelPing(emotion.id);
        _showToast(l10n.pingCancelled);
      } else {
        _showToast(l10n.mapErrorAlreadyHavePingOrUnavailable);
      }
      HapticFeedback.mediumImpact();
      return;
    }

    // Calculate distance
    final distance = geo.Geolocator.distanceBetween(
        myEmotion.lat, myEmotion.lon, emotion.lat, emotion.lon);

    // Show bottom sheet
    HapticFeedback.mediumImpact();
    _showPingBottomSheet(emotion, distance);
  }

  void _showPingBottomSheet(EmotionData emotion, double distance) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => PingBottomSheet(
        emotion: emotion,
        distance: distance,
        onSendPing: () => _sendPing(emotion),
      ),
    );
  }

  Future<void> _sendPing(EmotionData emotion) async {
    final l10n = AppLocalizations.of(context)!;
    debugPrint('🚀 Sending ping to ${emotion.id}');

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    // Find my emotion
    EmotionData? myEmotion;
    try {
      myEmotion = _activeEmotions.firstWhere((e) => e.isOwn);
    } catch (e) {
      _showError(l10n.mapErrorNeedActiveVibeToPing);
      return;
    }

    // Send ping through controller
    final success = await _pingWinkController.sendPing(
      targetEmotion: emotion,
      myEmotion: myEmotion,
      activeEmotions: _activeEmotions,
    );

    if (!success) {
      // Error already shown by controller
      return;
    }
  }

  Future<void> _addPingAnimation(EmotionData emotion) async {
    if (_circleAnnotationManager == null) return;

    try {
      final List<mapbox.CircleAnnotation> pulseAnnotations = [];

      for (int i = 0; i < 3; i++) {
        final pulseOption = mapbox.CircleAnnotationOptions(
          geometry: mapbox.Point(
              coordinates: mapbox.Position(emotion.lon, emotion.lat)),
          circleRadius: 15.0 + (i * 8),
          circleColor: Colors.transparent.toARGB32(),
          circleOpacity: 0,
          circleStrokeWidth: 1.5,
          circleStrokeColor: const Color(0xFF00D4FF).toARGB32(),
          circleStrokeOpacity: 0.6 - (i * 0.15),
        );

        final pulse = await _circleAnnotationManager!.create(pulseOption);
        pulseAnnotations.add(pulse);
      }

      _pingAnimations[emotion.id] = pulseAnnotations;

      // Animate pulses every 2 seconds for full 60 seconds
      int animationCount = 0;
      _pingAnimationTimers[emotion.id] =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        animationCount++;

        // Check if ping was cancelled
        if (!_processingPings.containsKey(emotion.id) ||
            !mounted ||
            animationCount >= 33) {
          timer.cancel();
          for (var annotation in pulseAnnotations) {
            _circleAnnotationManager?.delete(annotation);
          }
          _pingAnimations.remove(emotion.id);
          _pingAnimationTimers.remove(emotion.id);
          return;
        }

        for (int i = 0; i < pulseAnnotations.length; i++) {
          _circleAnnotationManager?.update(pulseAnnotations[i]
            ..circleStrokeOpacity =
                (0.6 - (i * 0.15)) * (1 - (animationCount % 3) * 0.3)
            ..circleRadius = 15.0 + (i * 8) + ((animationCount % 3) * 5));
        }
      });

      debugPrint('Added 60-second ping animation for emotion ${emotion.id}');
    } catch (e) {
      debugPrint('Error adding ping animation: $e');
    }
  }

  Future<void> _animatePingSource(IncomingPing ping) async {
    if (_circleAnnotationManager == null || !_mapReady) return;

    try {
      // Center map on ping sender
      if (ping.fromLat != null && ping.fromLon != null) {
        final cameraOptions = mapbox.CameraOptions(
          center: mapbox.Point(
              coordinates: mapbox.Position(ping.fromLon!, ping.fromLat!)),
          zoom: 15.0,
        );

        await _mapboxMap!.flyTo(
          cameraOptions,
          mapbox.MapAnimationOptions(duration: 2000),
        );

        // Stop old animation if exists
        final oldAnimations = _winkAnimations[ping.pingId];
        if (oldAnimations != null) {
          _winkAnimations.remove(ping.pingId);
        }

        // Create pulse circles
        final List<mapbox.CircleAnnotation> pulseCircles = [];

        for (int i = 0; i < 3; i++) {
          final pulseOption = mapbox.CircleAnnotationOptions(
            geometry: mapbox.Point(
                coordinates: mapbox.Position(ping.fromLon!, ping.fromLat!)),
            circleRadius: 12.0 + (i * 6),
            circleColor: Colors.transparent.toARGB32(),
            circleOpacity: 0,
            circleStrokeWidth: 2,
            circleStrokeColor: const Color(0xFF00D4FF).toARGB32(),
            circleStrokeOpacity: 0.9 - (i * 0.25),
          );

          final circle = await _circleAnnotationManager!.create(pulseOption);
          pulseCircles.add(circle);
        }

        _winkAnimations[ping.pingId] = pulseCircles;

        // Smooth animation for 15 seconds
        _winkAnimationTimer?.cancel();
        int animationCount = 0;
        _winkAnimationTimer =
            Timer.periodic(const Duration(milliseconds: 100), (timer) async {
          animationCount++;

          if (!_winkAnimations.containsKey(ping.pingId)) {
            timer.cancel();
            return;
          }

          if (animationCount >= 250) {
            timer.cancel();
            _stopPingAnimation(ping.pingId);
            return;
          }

          if (_circleAnnotationManager == null || !mounted) {
            timer.cancel();
            return;
          }

          try {
            double animPhase = (animationCount * 0.1) % (3.14159 * 2);
            double pulseFactor = (sin(animPhase) + 1) / 2;

            for (int i = 0; i < pulseCircles.length; i++) {
              await _circleAnnotationManager!.update(pulseCircles[i]
                ..circleRadius = 12.0 + (i * 6) + (pulseFactor * 10)
                ..circleStrokeOpacity =
                    (0.9 - (i * 0.25)) * (0.3 + pulseFactor * 0.7));
            }
          } catch (e) {
            debugPrint('Error updating animation: $e');
          }
        });

        debugPrint(
            '✅ Started 15-second smooth ping animation for ${ping.pingId}');
      }
    } catch (e) {
      debugPrint('Error animating ping source: $e');
    }
  }

  void _stopPingAnimation(String pingId) async {
    final animations = _winkAnimations[pingId];
    if (animations != null && _circleAnnotationManager != null) {
      for (var circle in animations) {
        try {
          if (_circleAnnotationManager != null) {
            await _circleAnnotationManager!.delete(circle);
          }
        } catch (e) {
          // Silently ignore if already deleted
        }
      }
      _winkAnimations.remove(pingId);
    }
  }

  Future<void> _showSparkAnimation() async {
    final completer = Completer<void>();

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => _SparkAnimation(
        onComplete: () {
          if (mounted && Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          completer.complete();
        },
      ),
    );

    await completer.future;
  }

  Future<void> _submitMood(int emotion) async {
    if (_isSubmitting || _userData == null) return;

    // First show the vibe confirmation animation
    await _showVibeConfirmationAnimation(emotion);

    // Now hide the selector and start submission
    setState(() {
      _showEmotionSelector = false;
      _isSubmitting = true;
    });

    HapticFeedback.mediumImpact();

    try {
      final locationData = await LocationService.getLocationForSubmission();

      double? submitLat;
      double? submitLon;

      if (locationData != null) {
        submitLat = locationData['lat'];
        submitLon = locationData['lon'];
      } else {
        submitLat = _currentPosition?.latitude;
        submitLon = _currentPosition?.longitude;
      }

      final response = await ApiService.submitMood(
        emotion: emotion,
        deviceId: _userData!.deviceId,
        lat: submitLat,
        lon: submitLon,
        birthYear: _userData!.birthYear,
      );

      if (mounted) {
        setState(() {
          _hasActiveEmotion = true;
        });

        await StorageService.updateStreakOnVibe();

        if (_mapReady && _mapboxMap != null) {
          await _loadEmotionsForViewport();
        } else {
          await _loadEmotionsFromAPI();
        }

        if (_currentPosition != null && _mapboxMap != null && _mapReady) {
          await _centerMapOnLocation();
        }

        _showSuccessSnackbar(response['nearby_count'] ?? 0);
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

// New method to show vibe confirmation animation
  Future<void> _showVibeConfirmationAnimation(int emotion) async {
    final completer = Completer<void>();

    final overlayEntry = OverlayEntry(
      builder: (context) => VibeConfirmationAnimation(
        vibeIndex: emotion,
        tapPosition: null,
        onComplete: () {
          completer.complete();
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Wait for animation to complete
    await completer.future;
    overlayEntry.remove();
  }

  Future<void> _centerMapOnLocation({bool animate = true}) async {
    if (_mapboxMap == null || _currentPosition == null || !_mapReady) return;

    try {
      final cameraOptions = mapbox.CameraOptions(
        center: mapbox.Point(
            coordinates: mapbox.Position(
                _currentPosition!.longitude, _currentPosition!.latitude)),
        zoom: AppConfig.defaultMapZoom,
        bearing: 0,
        pitch: 0,
      );

      if (animate) {
        await _mapboxMap!.flyTo(
          cameraOptions,
          mapbox.MapAnimationOptions(duration: 2000),
        );
      } else {
        await _mapboxMap!.setCamera(cameraOptions);
      }
    } catch (e) {
      debugPrint('Error centering map: $e');
    }
  }

  void _onMapCreated(mapbox.MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    await mapboxMap.setBounds(mapbox.CameraBoundsOptions(
      minZoom: AppConfig.minMapZoom,
      maxZoom: AppConfig.maxMapZoom,
    ));

    await mapboxMap.gestures.updateSettings(
      mapbox.GesturesSettings(
        rotateEnabled: false,
        pitchEnabled: false,
      ),
    );

    _circleAnnotationManager =
        await mapboxMap.annotations.createCircleAnnotationManager();

    _tapCircleManager =
        await mapboxMap.annotations.createCircleAnnotationManager();

    _tapCircleManager!.addOnCircleAnnotationClickListener(
      _CircleClickListener(this),
    );

    _mapReady = true;

    if (_currentPosition != null) {
      await _centerMapOnLocation(animate: false);
    }

    if (_userData?.birthYear != null) {
      Timer(const Duration(milliseconds: 500), () {
        _loadEmotionsForViewport();
      });
    } else {
      debugPrint('⏳ Waiting for birth year before loading emotions');
    }

    Timer(const Duration(milliseconds: 500), () {
      _loadEmotionsForViewport();
    });
  }

  void _showSuccessSnackbar(int nearbyCount) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.mapSuccessVibeSent(nearbyCount)),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFFED77FF).withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showEmotionSelector() async {
    final l10n = AppLocalizations.of(context)!;
    if (!mounted) return;

    // Check ban BEFORE showing selector
    if (_userData != null) {
      await _checkBanStatus();

      if (_banStatus?.isBanned ?? false) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                l10n.mapBanRestrictionMessage(_banStatus!.remainingTimeText)),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
    }

    setState(() {
      _showEmotionSelector = true;
    });
  }

  // ============ PING TUTORIAL METHODS ============
  Future<void> _checkAndShowTutorial() async {
    if (_showingTutorial) return;
    if (_showEmotionSelector) return;
    if (!_hasActiveEmotion) return;

    final hasSeenTutorial = await StorageService.hasSeenPingTutorial();
    if (hasSeenTutorial) return;

    final otherVibes = _activeEmotions.where((e) => !e.isOwn).toList();
    if (otherVibes.length < 2) return;

    EmotionData? nearestVibe;
    double minDistance = double.infinity;

    EmotionData? myVibe;
    try {
      myVibe = _activeEmotions.firstWhere((e) => e.isOwn);
    } catch (e) {
      myVibe = null;
    }

    if (myVibe == null) return;

    for (var vibe in otherVibes) {
      final distance = geo.Geolocator.distanceBetween(
          myVibe.lat, myVibe.lon, vibe.lat, vibe.lon);
      if (distance < minDistance) {
        minDistance = distance;
        nearestVibe = vibe;
      }
    }

    if (nearestVibe == null) return;

    setState(() {
      _showingTutorial = true;
      _tutorialTargetVibe = nearestVibe;
    });

    _createTutorialPulse(nearestVibe);

    _tutorialBlinkTimer =
        Timer.periodic(const Duration(milliseconds: 600), (_) {
      if (mounted) {
        setState(() => _tutorialBlinking = !_tutorialBlinking);
      }
    });

    Timer(const Duration(seconds: 15), () {
      _hideTutorial();
    });
  }

  void _createTutorialPulse(EmotionData vibe) async {
    if (_circleAnnotationManager == null) return;

    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration(milliseconds: i * 500));

      if (!_showingTutorial) return;

      final pulseRing = await _circleAnnotationManager!.create(
        mapbox.CircleAnnotationOptions(
          geometry:
              mapbox.Point(coordinates: mapbox.Position(vibe.lon, vibe.lat)),
          circleRadius: 10.0,
          circleColor: Colors.transparent.toARGB32(),
          circleStrokeWidth: 2.5,
          circleStrokeColor: const Color(0xFF00D4FF).toARGB32(),
          circleStrokeOpacity: 0.9,
        ),
      );

      double radius = 10.0;
      double opacity = 0.9;

      Timer.periodic(const Duration(milliseconds: 50), (timer) async {
        if (!_showingTutorial || radius > 35) {
          timer.cancel();
          try {
            await _circleAnnotationManager?.delete(pulseRing);
          } catch (e) {
            // Already deleted
          }
          return;
        }

        radius += 1.5;
        opacity *= 0.96;

        try {
          await _circleAnnotationManager?.update(pulseRing
            ..circleRadius = radius
            ..circleStrokeOpacity = opacity);
        } catch (e) {
          timer.cancel();
        }
      });
    }
  }

  void _hideTutorial() {
    if (!_showingTutorial) return;

    setState(() {
      _showingTutorial = false;
      _tutorialTargetVibe = null;
    });

    _tutorialBlinkTimer?.cancel();
    _tutorialBlinkTimer = null;

    StorageService.setPingTutorialSeen();
  }

  Widget _buildGenZTutorial() {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedOpacity(
      opacity: _showingTutorial ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
        margin: const EdgeInsets.only(top: 50),
        child: Center(
          child: GestureDetector(
            onTap: () {
              _hideTutorial();
              if (_tutorialTargetVibe != null) {
                _onEmotionTap(_tutorialTargetVibe!);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00D4FF),
                    Color(0xFFFF00FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8 + (value * 0.2),
                        child: const Text('👆', style: TextStyle(fontSize: 20)),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.mapTutorialTapToSpark,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedOpacity(
                    opacity: _tutorialBlinking ? 1.0 : 0.3,
                    duration: const Duration(milliseconds: 300),
                    child: const Text('⚡', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          // Map widget
          MoodMapWidget(
            onMapCreated: _onMapCreated,
            currentPosition: _currentPosition,
          ),

          // Top gradient
          IgnorePointer(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Bottom gradient
          if (!widget.isInContainer)
            IgnorePointer(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Location button
          if (!_showEmotionSelector)
            Positioned(
              right: 20,
              bottom: widget.isInContainer ? 110 : 100,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: const Icon(Icons.my_location, color: Colors.white),
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  await _getCurrentLocation();
                  await _centerMapOnLocation();
                },
              ),
            ),

          // Tutorial widget
          if (_showingTutorial)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: _buildGenZTutorial(),
            ),

          // Empty State Widget
          ListenableBuilder(
            listenable: _emptyStateController,
            builder: (context, child) {
              return EmptyStateWidget(
                message: _emptyStateController.currentMessage,
                submessage: _emptyStateController.currentSubmessage,
                isVisible: _emptyStateController.isMessageVisible,
                onDismiss: () => _emptyStateController.dismissMessage(),
              );
            },
          ),

          // Streak counter widget
          if (!_showEmotionSelector)
            Positioned(
              right: 20,
              top: 100,
              child: FutureBuilder<int>(
                future: StorageService.getStreak(),
                builder: (context, snapshot) {
                  final streak = snapshot.data ?? 0;
                  if (streak == 0) return const SizedBox.shrink();

                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFF6B00).withValues(alpha: 0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B00).withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🔥',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$streak',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          // Share button widget
          if (!_showEmotionSelector)
            Positioned(
              right: 20,
              bottom: widget.isInContainer ? 170 : 160,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black.withValues(alpha: 0.9),
                    builder: (context) => const ViralShareCard(),
                  );
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),

          // Add emotion button (show even if banned to display ban overlay)
          if (!widget.isInContainer && !_showEmotionSelector)
            Positioned(
              right: 20,
              bottom: 160,
              child: FloatingActionButton(
                backgroundColor: (_banStatus?.isBanned ?? false)
                    ? Colors.grey
                    : Emotions.getEmotion(0).color,
                child: Icon(
                  (_banStatus?.isBanned ?? false) ? Icons.lock : Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  if (_userData != null) {
                    await _checkBanStatus();
                  }

                  setState(() {
                    _showEmotionSelector = true;
                  });
                },
              ),
            ),

          // Emotion selector overlay with ban blocking
          if (_showEmotionSelector)
            IgnorePointer(
              ignoring: _banStatus?.isBanned ?? false,
              child: Container(
                color: Colors.black.withValues(alpha: 0.8),
                child: Stack(
                  children: [
                    // Emotion selector
                    Center(
                      child: EmotionSelector(
                        onEmotionSelected: _submitMood,
                        isSubmitting: _isSubmitting,
                        userData: _userData,
                        onSwipeDown: _hasActiveEmotion
                            ? () {
                                setState(() {
                                  _showEmotionSelector = false;
                                });
                              }
                            : null,
                      ),
                    ),

                    // Ban overlay on top if banned
                    if (_banStatus != null && _banStatus!.isBanned)
                      Center(
                        child: BanOverlay(
                          banStatus: _banStatus!,
                          onBanExpired: () {
                            setState(() => _banStatus = null);
                            _checkBanStatus();
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),

          // Visual indicator for active pings with timer - FIXED to use ListenableBuilder
          ListenableBuilder(
            listenable: _pingWinkController,
            builder: (context, child) {
              if (!_pingWinkController.hasActivePings) {
                return const SizedBox.shrink();
              }

              return Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final activePingId =
                          _pingWinkController.firstActivePingId;
                      if (activePingId != null) {
                        _pingWinkController.cancelPing(activePingId);
                        _showToast(l10n.pingCancelled);
                        HapticFeedback.mediumImpact();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF00D4FF).withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF00D4FF)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              final activePingId =
                                  _pingWinkController.firstActivePingId;
                              if (activePingId == null) {
                                return const SizedBox.shrink();
                              }

                              final remainingSeconds = _pingWinkController
                                  .getRemainingSeconds(activePingId);

                              return Text(
                                l10n.mapActivePingStatus(remainingSeconds),
                                style: const TextStyle(
                                  color: Color(0xFF00D4FF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _refreshTimer?.cancel();
    _statusUpdateTimer?.cancel();
    _viewportDebounce?.cancel();
    _tutorialBlinkTimer?.cancel();
    _winkAnimationTimer?.cancel();

    // Clean up wink animations
    for (var animations in _winkAnimations.values) {
      for (var annotation in animations) {
        _circleAnnotationManager?.delete(annotation);
      }
    }
    _winkAnimations.clear();

    // Clean up ping animations
    for (var timer in _pingAnimationTimers.values) {
      timer?.cancel();
    }
    _pingAnimationTimers.clear();

    for (var animations in _pingAnimations.values) {
      for (var annotation in animations) {
        _circleAnnotationManager?.delete(annotation);
      }
    }
    _pingAnimations.clear();

    _pulseController.dispose();
    _pingWinkController.dispose();
    _emptyStateController.dispose();
    super.dispose();
  }
}

// Spark animation widget
class _SparkAnimation extends StatefulWidget {
  final VoidCallback? onComplete;

  const _SparkAnimation({this.onComplete});

  @override
  State<_SparkAnimation> createState() => _SparkAnimationState();
}

class _SparkAnimationState extends State<_SparkAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0),
    ));

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });

    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withValues(alpha: 0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '✨',
                      style: TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 20),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF00D4FF),
                          Color(0xFFFF00FF),
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'SPARK!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Implementation of click listener for Mapbox
class _CircleClickListener extends OnCircleAnnotationClickListener {
  final MapScreenState _mapScreen;

  _CircleClickListener(this._mapScreen);

  @override
  void onCircleAnnotationClick(mapbox.CircleAnnotation annotation) {
    // Find emotion by tap area annotation
    final emotion = _mapScreen._annotationToEmotion[annotation.id];

    if (emotion != null && !emotion.isOwn) {
      _mapScreen._onEmotionTap(emotion);
    }
  }
}
