// lib/services/notification_service.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Simplified notification service without timezone
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  /// Initialize notification service WITHOUT requesting permissions
  static Future<void> init() async {
    if (_isInitialized) return;

    debugPrint('🔔 Initializing notifications...');

    // Android settings
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS settings - set to false to avoid requesting permissions on init
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _isInitialized = true;
    debugPrint('✅ Notifications initialized (without permissions)');
  }

  /// Request notification permissions - public method for onboarding
  static Future<bool> requestNotificationPermissions() async {
    debugPrint('🔔 Requesting notification permissions...');
    return await _requestPermissions();
  }

  /// Private method for requesting permissions
  static Future<bool> _requestPermissions() async {
    if (Platform.isIOS) {
      final IOSFlutterLocalNotificationsPlugin? iosImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();

      if (iosImplementation != null) {
        final bool? granted = await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        debugPrint('🔔 iOS permissions granted: $granted');
        return granted ?? false;
      }
      return false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        // Получаем реальную версию Android SDK
        final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        final int sdkInt = androidInfo.version.sdkInt;

        debugPrint('🔔 Android SDK version: $sdkInt');
        debugPrint('🔔 Android version: ${androidInfo.version.release}');
        debugPrint(
            '🔔 Android device: ${androidInfo.brand} ${androidInfo.model}');

        // Для Android 13+ (API 33+) требуется явный запрос разрешения
        if (sdkInt >= 33) {
          debugPrint(
              '🔔 Android 13+ detected, requesting POST_NOTIFICATIONS permission...');
          final bool? granted =
              await androidImplementation.requestNotificationsPermission();
          debugPrint('🔔 Android 13+ permission result: $granted');
          return granted ?? false;
        } else {
          // Для Android < 13 разрешения не требуются
          debugPrint(
              '🔔 Android < 13 (SDK $sdkInt), permissions granted by default');
          return true;
        }
      }
    }
    return true;
  }

  /// Handle notification tap
  static void _onNotificationTap(NotificationResponse response) {
    debugPrint('🔔 Notification tapped: ${response.payload}');
  }

  /// Show instant notification
  static Future<void> showInstantNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // Check initialization
    if (!_isInitialized) {
      await init();
    }

    const androidDetails = AndroidNotificationDetails(
      'pingwink_instant',
      'Instant Notifications',
      channelDescription: 'Instant notification channel for Ping&Wink',
      importance: Importance.max,
      priority: Priority.high,
      color: Color(0xFF00D4FF),
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload ?? 'instant',
    );
  }

  /// Show notification from L10n
  static Future<void> showLocalizedNotification({
    required String title,
    required String body,
    required String type,
  }) async {
    await showInstantNotification(
      title: title,
      body: body,
      payload: type,
    );
  }

  /// Schedule daily notifications
  static Future<void> scheduleDailyNotifications() async {
    debugPrint(
        '📅 Daily notifications will be triggered by timer in MapScreen');
    // Notifications are handled by timer in MapScreen
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    debugPrint('🚫 All notifications cancelled');
  }

  /// Check pending notifications
  static Future<void> checkPendingNotifications() async {
    final List<PendingNotificationRequest> pending =
        await _notifications.pendingNotificationRequests();

    debugPrint('📋 Pending notifications: ${pending.length}');
    for (var notification in pending) {
      debugPrint('  - ID: ${notification.id}, Title: ${notification.title}');
    }
  }

  /// Check if notifications are enabled
  static Future<bool> areNotificationsEnabled() async {
    if (Platform.isIOS) {
      final IOSFlutterLocalNotificationsPlugin? iosImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();

      if (iosImplementation != null) {
        // Just check, don't request
        final bool? hasPermission = await iosImplementation.requestPermissions(
          alert: false,
          badge: false,
          sound: false,
        );
        return hasPermission ?? false;
      }
    } else if (Platform.isAndroid) {
      // Для Android используем device_info_plus для проверки версии
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        // Для Android 13+ проверяем разрешение
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            _notifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidImplementation != null) {
          final bool? hasPermission =
              await androidImplementation.areNotificationsEnabled();
          return hasPermission ?? false;
        }
      }
      // Для Android < 13 всегда возвращаем true
      return true;
    }
    return true;
  }
}
