// lib/controllers/empty_state_controller.dart
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../services/notification_service.dart';
import '../l10n/app_localizations.dart';

/// Psychologically optimized controller for empty map retention with fixed push notifications
class EmptyStateController extends ChangeNotifier {
  // Keys for SharedPreferences
  static const String _lastShownKey = 'empty_state_last_shown';
  static const String _shownCountKey = 'empty_state_shown_count';
  static const String _lastVariantKey = 'empty_state_last_variant';
  static const String _pushScheduledKey = 'empty_state_push_scheduled';
  static const String _returnCountKey = 'empty_state_return_count';
  static const String _lastDayKey = 'empty_state_last_day';
  static const String _abTestGroupKey = 'empty_state_ab_group';

  // State
  bool _isMessageVisible = false;
  String _currentMessage = '';
  String _currentSubmessage = '';
  Timer? _hideTimer;
  Timer? _showDelayTimer;
  int _vibesCount = 0;

  // Analytics
  DateTime? _messageShownTime;
  int _readingSeconds = 0;

  // Flutter Local Notifications instance
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Callbacks
  final VoidCallback? onRequestPushPermission;
  final VoidCallback? onNavigateToSettings;

  EmptyStateController({
    this.onRequestPushPermission,
    this.onNavigateToSettings,
  }) {
    _initializeNotifications();
  }

  // Getters
  bool get isMessageVisible => _isMessageVisible;
  String get currentMessage => _currentMessage;
  String get currentSubmessage => _currentSubmessage;

  /// Initialize notifications plugin
  Future<void> _initializeNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
    debugPrint('EmptyState: Notifications initialized');
  }

  /// Main method - check and show message
  Future<void> checkAndShowMessage(BuildContext context, int vibesCount) async {
    _vibesCount = vibesCount;

    // Don't show if enough vibes
    if (vibesCount >= 3) {
      if (_isMessageVisible) {
        _hideMessage();
      }
      return;
    }

    // Already showing - don't duplicate
    if (_isMessageVisible) return;

    // Check show frequency
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getInt(_lastShownKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Not more than once in 30 minutes
    if (now - lastShown < 1800000) {
      debugPrint('EmptyState: Too soon to show again');
      return;
    }

    // 5 second delay to let user look around
    _showDelayTimer?.cancel();
    _showDelayTimer = Timer(const Duration(seconds: 5), () async {
      // Check again after delay
      if (_vibesCount >= 3) return;

      await _selectAndShowMessage(context);
      await _schedulePushNotifications(context);
    });
  }

  /// Select the right message based on time and history
  Future<void> _selectAndShowMessage(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();

    // Get data for personalization
    final shownCount = prefs.getInt(_shownCountKey) ?? 0;
    final returnCount = prefs.getInt(_returnCountKey) ?? 0;
    final lastVariant = prefs.getString(_lastVariantKey) ?? '';

    // A/B test group
    String abGroup = prefs.getString(_abTestGroupKey) ?? '';
    if (abGroup.isEmpty) {
      abGroup = ['story', 'curiosity', 'social'][Random().nextInt(3)];
      await prefs.setString(_abTestGroupKey, abGroup);
    }

    // Determine time of day and day of week
    final now = DateTime.now();
    final hour = now.hour;
    final weekday = now.weekday;
    final isWeekend = weekday == 6 || weekday == 7;

    // Select message
    final messageData = _selectMessageByContext(
      hour: hour,
      weekday: weekday,
      isWeekend: isWeekend,
      shownCount: shownCount,
      returnCount: returnCount,
      lastVariant: lastVariant,
      abGroup: abGroup,
      l10n: l10n,
    );

    // Show
    _currentMessage = messageData['message']!;
    _currentSubmessage = messageData['submessage']!;
    _isMessageVisible = true;
    _messageShownTime = DateTime.now();
    notifyListeners();

    // Save show
    await prefs.setInt(_lastShownKey, now.millisecondsSinceEpoch);
    await prefs.setInt(_shownCountKey, shownCount + 1);
    await prefs.setString(_lastVariantKey, messageData['variant']!);

    // Auto-hide after 30 seconds
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 30), () {
      _hideMessage();
    });

    // Track reading time
    _startReadingTracking();

    debugPrint('EmptyState: Showing ${messageData['variant']} variant');
  }

  /// Smart message selection based on context
  Map<String, String> _selectMessageByContext({
    required int hour,
    required int weekday,
    required bool isWeekend,
    required int shownCount,
    required int returnCount,
    required String lastVariant,
    required String abGroup,
    required AppLocalizations l10n,
  }) {
    // Morning (6-12)
    if (hour >= 6 && hour < 12) {
      if (isWeekend) {
        return _getWeekendMorningMessage(abGroup, l10n);
      } else {
        return _getWeekdayMorningMessage(abGroup, shownCount, l10n);
      }
    }

    // Afternoon (12-17)
    else if (hour >= 12 && hour < 17) {
      if (weekday == 5) {
        // Friday
        return _getFridayAfternoonMessage(abGroup, l10n);
      } else {
        return _getAfternoonMessage(abGroup, returnCount, l10n);
      }
    }

    // Evening (17-22)
    else if (hour >= 17 && hour < 22) {
      if (isWeekend) {
        return _getWeekendEveningMessage(abGroup, l10n);
      } else {
        return _getPrimeTimeMessage(abGroup, shownCount, l10n);
      }
    }

    // Night (22-6)
    else {
      return _getLateNightMessage(abGroup, l10n);
    }
  }

  // === PSYCHOLOGICALLY OPTIMIZED MESSAGES ===

  /// Weekday morning - Commitment & Consistency
  Map<String, String> _getWeekdayMorningMessage(
      String abGroup, int shownCount, AppLocalizations l10n) {
    if (abGroup == 'story') {
      return {
        'variant': 'morning_story',
        'message': l10n.emptyStateMorningStoryMain,
        'submessage': l10n.emptyStateMorningStorySub
      };
    } else if (abGroup == 'curiosity') {
      return {
        'variant': 'morning_curiosity',
        'message': l10n.emptyStateMorningCuriosityMain,
        'submessage': l10n.emptyStateMorningCuriositySub
      };
    } else {
      return {
        'variant': 'morning_social',
        'message': l10n.emptyStateMorningSocialMain,
        'submessage': l10n.emptyStateMorningSocialSub
      };
    }
  }

  /// Friday afternoon - Anticipation & Transformation
  Map<String, String> _getFridayAfternoonMessage(
      String abGroup, AppLocalizations l10n) {
    final hoursLeft = 17 - DateTime.now().hour;
    return {
      'variant': 'friday_afternoon',
      'message': l10n.emptyStateFridayMain(hoursLeft),
      'submessage': l10n.emptyStateFridaySub
    };
  }

  /// Regular afternoon - Variable Ratio Reinforcement
  Map<String, String> _getAfternoonMessage(
      String abGroup, int returnCount, AppLocalizations l10n) {
    final hoursUntil = 19 - DateTime.now().hour;
    if (returnCount > 2) {
      return {
        'variant': 'afternoon_returning',
        'message': l10n.emptyStateAfternoonReturningMain,
        'submessage': l10n.emptyStateAfternoonReturningSub(hoursUntil)
      };
    }

    return {
      'variant': 'afternoon_first',
      'message': l10n.emptyStateAfternoonFirstMain,
      'submessage': l10n.emptyStateAfternoonFirstSub
    };
  }

  /// Prime time - FOMO & Social Proof
  Map<String, String> _getPrimeTimeMessage(
      String abGroup, int shownCount, AppLocalizations l10n) {
    if (shownCount == 0) {
      return {
        'variant': 'primetime_first',
        'message': l10n.emptyStatePrimetimeFirstMain,
        'submessage': l10n.emptyStatePrimetimeFirstSub
      };
    }

    return {
      'variant': 'primetime_return',
      'message': l10n.emptyStatePrimetimeReturnMain,
      'submessage': l10n.emptyStatePrimetimeReturnSub
    };
  }

  /// Weekend evening - Community & Adventure
  Map<String, String> _getWeekendEveningMessage(
      String abGroup, AppLocalizations l10n) {
    return {
      'variant': 'weekend_evening',
      'message': l10n.emptyStateWeekendEveningMain,
      'submessage': l10n.emptyStateWeekendEveningSub
    };
  }

  /// Weekend morning - Recovery & Anticipation
  Map<String, String> _getWeekendMorningMessage(
      String abGroup, AppLocalizations l10n) {
    return {
      'variant': 'weekend_morning',
      'message': l10n.emptyStateWeekendMorningMain,
      'submessage': l10n.emptyStateWeekendMorningSub
    };
  }

  /// Late night - Mystery & Intimacy
  Map<String, String> _getLateNightMessage(
      String abGroup, AppLocalizations l10n) {
    return {
      'variant': 'late_night',
      'message': l10n.emptyStateLateNightMain,
      'submessage': l10n.emptyStateLateNightSub
    };
  }

  /// FIXED: Schedule smart push notifications with proper timezone support
  Future<void> _schedulePushNotifications(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();

    // Check if already scheduled
    final alreadyScheduled = prefs.getBool(_pushScheduledKey) ?? false;
    if (alreadyScheduled) {
      debugPrint('EmptyState: Push notifications already scheduled');
      return;
    }

    // IMPORTANT: Check if notifications are enabled
    bool hasPermission = false;

    try {
      if (Platform.isIOS) {
        // iOS: Check if notifications are allowed
        final iosImplementation =
            _notifications.resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>();
        if (iosImplementation != null) {
          // Request permission status without showing dialog
          final result = await iosImplementation.requestPermissions(
            alert: false,
            badge: false,
            sound: false,
          );
          hasPermission = result ?? false;
        }
      } else if (Platform.isAndroid) {
        // Android: Check if notifications are allowed
        final androidImplementation =
            _notifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidImplementation != null) {
          // Android 13+ requires explicit permission
          if (Platform.version.contains('13') ||
              Platform.version.contains('14') ||
              Platform.version.contains('15')) {
            final granted =
                await androidImplementation.areNotificationsEnabled();
            hasPermission =
                granted ?? true; // Default to true for older Android
          } else {
            // Android < 13 doesn't need runtime permission
            hasPermission = true;
          }
        } else {
          hasPermission = true; // Assume yes if can't check
        }
      } else {
        // Web or other platforms
        hasPermission = true;
      }
    } catch (e) {
      debugPrint('EmptyState: Error checking notification permissions: $e');
      // If we can't check, assume we have permission and try anyway
      hasPermission = true;
    }

    if (!hasPermission) {
      debugPrint('EmptyState: No notification permission, requesting...');
      // Trigger the callback to request permission
      if (onRequestPushPermission != null) {
        onRequestPushPermission!();
      }
      return; // Don't schedule if no permission
    }

    final now = DateTime.now();
    final hour = now.hour;

    // Cancel any existing notifications first
    await _cancelAllEmptyStateNotifications();

    // Get timezone location
    final location = tz.local;

    // Push #1: After 2-3 hours (only if before 15:00)
    if (hour < 15) {
      final delayHours = 2 + Random().nextInt(2); // 2-4 hours random
      final scheduledTime = tz.TZDateTime.from(
        now.add(Duration(hours: delayHours)),
        location,
      );

      await _scheduleLocalNotification(
        id: 1001,
        title: l10n.emptyStatePush1Title,
        body: l10n.emptyStatePush1Body,
        scheduledTime: scheduledTime,
      );

      debugPrint(
          'EmptyState: Push #1 scheduled for ${scheduledTime.toString()}');
    }

    // Push #2: Prime time (19:00 weekdays, 20:00 weekends)
    final primeHour = now.weekday >= 6 ? 20 : 19;
    if (hour < primeHour - 2) {
      final scheduledTime = tz.TZDateTime(
        location,
        now.year,
        now.month,
        now.day,
        primeHour,
        0,
      );

      await _scheduleLocalNotification(
        id: 1002,
        title: l10n.emptyStatePush2Title,
        body: l10n.emptyStatePush2Body,
        scheduledTime: scheduledTime,
      );

      debugPrint(
          'EmptyState: Push #2 scheduled for ${scheduledTime.toString()}');
    }

    // Push #3: Next day at smart time
    final tomorrowHour = _calculateSmartTomorrowHour(hour);
    final tomorrow = now.add(const Duration(days: 1));
    final scheduledTime = tz.TZDateTime(
      location,
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      tomorrowHour,
      0,
    );

    await _scheduleLocalNotification(
      id: 1003,
      title: l10n.emptyStatePush3Title,
      body: l10n.emptyStatePush3Body,
      scheduledTime: scheduledTime,
    );

    debugPrint('EmptyState: Push #3 scheduled for ${scheduledTime.toString()}');

    // Mark as scheduled
    await prefs.setBool(_pushScheduledKey, true);

    // Reset flag after 48 hours
    Timer(const Duration(hours: 48), () async {
      await prefs.setBool(_pushScheduledKey, false);
    });
  }

  /// Check if notifications are enabled (for Android 13+)
  Future<bool> _checkNotificationPermission() async {
    if (Platform.isAndroid) {
      final androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? granted =
            await androidImplementation.areNotificationsEnabled();
        return granted ?? true;
      }
    }
    return true; // Default to true for iOS and other platforms
  }

  /// Calculate smart hour for tomorrow's push
  int _calculateSmartTomorrowHour(int currentHour) {
    // If now morning (before noon) - tomorrow evening
    if (currentHour < 12) {
      return 19; // 7 PM tomorrow
    }
    // If afternoon (12-17) - tomorrow same time
    else if (currentHour < 17) {
      return currentHour;
    }
    // If evening (17-20) - tomorrow afternoon
    else if (currentHour < 20) {
      return 15; // 3 PM tomorrow
    }
    // If late night - tomorrow evening
    else {
      return 19; // 7 PM tomorrow
    }
  }

  /// Schedule a local notification properly
  Future<void> _scheduleLocalNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
  }) async {
    // Android notification details
    const androidDetails = AndroidNotificationDetails(
      'empty_state_channel',
      'Empty State Notifications',
      channelDescription: 'Notifications when map is empty',
      importance: Importance.high,
      priority: Priority.high,
      color: Color(0xFF00D4FF),
      icon: '@mipmap/ic_launcher',
    );

    // iOS notification details
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      // Schedule the notification
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'empty_state_return',
      );

      debugPrint('EmptyState: Notification $id scheduled successfully');
    } catch (e) {
      debugPrint('EmptyState: Error scheduling notification: $e');
      // Fallback to simple delay if timezone scheduling fails
      final delay = scheduledTime.difference(DateTime.now());
      if (delay.isNegative) return;

      Timer(delay, () async {
        await NotificationService.showInstantNotification(
          title: title,
          body: body,
          payload: 'empty_state_push_$id',
        );
      });
    }
  }

  /// Cancel all empty state notifications
  Future<void> _cancelAllEmptyStateNotifications() async {
    await _notifications.cancel(1001);
    await _notifications.cancel(1002);
    await _notifications.cancel(1003);
    debugPrint('EmptyState: All notifications cancelled');
  }

  /// Track reading time
  void _startReadingTracking() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isMessageVisible) {
        timer.cancel();
        _logReadingTime();
        return;
      }
      _readingSeconds++;
    });
  }

  /// Log for analytics
  void _logReadingTime() {
    if (_readingSeconds > 0) {
      debugPrint('EmptyState: Message read for $_readingSeconds seconds');
      // Here will be Amplitude integration
    }
    _readingSeconds = 0;
  }

  /// Hide message
  void _hideMessage() {
    if (!_isMessageVisible) return;

    _isMessageVisible = false;
    _logReadingTime();
    notifyListeners();

    _hideTimer?.cancel();
    _hideTimer = null;
  }

  /// Manual dismiss by user
  void dismissMessage() {
    _hideMessage();
    // Track that user dismissed manually
    debugPrint('EmptyState: User dismissed message');
  }

  /// User returned to app - cancel remaining notifications
  Future<void> onUserReturned() async {
    final prefs = await SharedPreferences.getInstance();
    final returnCount = prefs.getInt(_returnCountKey) ?? 0;
    await prefs.setInt(_returnCountKey, returnCount + 1);

    // Cancel scheduled push notifications
    await _cancelAllEmptyStateNotifications();

    // Reset scheduled flag
    await prefs.setBool(_pushScheduledKey, false);

    debugPrint(
        'EmptyState: User returned (count: ${returnCount + 1}), cancelled notifications');
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _showDelayTimer?.cancel();
    super.dispose();
  }
}
