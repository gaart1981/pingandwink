// lib/services/notification_service.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

    // Permission request removed - now called only from onboarding
  }

  /// Request notification permissions - public method for onboarding
  static Future<bool> requestNotificationPermissions() async {
    debugPrint('🔔 Requesting notification permissions...');
    return await _requestPermissions();
  }

  /// Private method for requesting permissions
  static Future<bool> _requestPermissions() async {
    if (Platform.isIOS) {
      final bool? granted = await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      debugPrint('🔔 iOS permissions granted: $granted');
      return granted ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        // For Android 13+ (API 33+)
        if (Platform.version.contains('13') ||
            Platform.version.contains('14') ||
            int.tryParse(Platform.version.split('.').first) != null &&
                int.parse(Platform.version.split('.').first) >= 33) {
          final bool? granted =
              await androidImplementation.requestNotificationsPermission();
          debugPrint('🔔 Android permissions granted: $granted');
          return granted ?? false;
        } else {
          // For Android < 13 permissions not required
          debugPrint('🔔 Android < 13, permissions not required');
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
      final implementation =
          _notifications.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (implementation != null) {
        // Check current permission status
        return await implementation.requestPermissions(
              alert: false,
              badge: false,
              sound: false,
            ) ??
            false;
      }
    }
    // For Android return true as permissions not required before Android 13
    return true;
  }
}
