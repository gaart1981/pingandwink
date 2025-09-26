// lib/services/onesignal_service.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class OneSignalService {
  static bool _isInitialized = false;

  /// Initialize OneSignal push notification service
  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      debugPrint('🔔 Initializing OneSignal...');

      // Get OneSignal App ID from environment variables
      final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'] ?? '';

      if (oneSignalAppId.isEmpty) {
        debugPrint('⌛ OneSignal App ID not found in .env file');
        return;
      }

      // Set appropriate log level - warn for debug, none for production
      if (kDebugMode) {
        OneSignal.Debug.setLogLevel(OSLogLevel.warn);
      } else {
        OneSignal.Debug.setLogLevel(OSLogLevel.none);
      }

      // Initialize OneSignal with app ID
      OneSignal.initialize(oneSignalAppId);

      // Request notification permissions
      OneSignal.Notifications.requestPermission(true);

      // Get device ID for tracking
      final deviceId = await StorageService.getDeviceId();

      // Listen for push subscription changes
      OneSignal.User.pushSubscription.addObserver((state) async {
        debugPrint('🔔 OneSignal subscription changed');

        if (state.current.id != null && state.current.token != null) {
          // Save token to database via API
          await _savePushToken(deviceId, state.current.id!);
        }
      });

      // Check current subscription state
      final subscriptionState = OneSignal.User.pushSubscription;
      if (subscriptionState.id != null) {
        debugPrint('🔔 Current OneSignal State: Active');
        debugPrint('💾 Saving initial push token...');
        await _savePushToken(deviceId, subscriptionState.id!);
        debugPrint('✅ Initial push token saved');
      }

      _isInitialized = true;
      debugPrint('✅ OneSignal initialized successfully');
    } catch (e) {
      // Log error without exposing sensitive details
      debugPrint('⌛ Error initializing OneSignal');
      if (kDebugMode) {
        debugPrint('   Details: ${e.toString()}');
      }
    }
  }

  /// Save push token to database
  static Future<void> _savePushToken(String deviceId, String playerId) async {
    try {
      debugPrint('💾 Saving push token to database...');

      await ApiService.savePushToken(
        deviceId: deviceId,
        playerId: playerId,
      );

      debugPrint('✅ Push token saved successfully');
    } catch (e) {
      debugPrint('⌛ Error saving push token');
      if (kDebugMode) {
        debugPrint('   Details: ${e.toString()}');
      }
    }
  }

  /// Send test push notification via Edge Function
  static Future<void> testPush() async {
    try {
      final deviceId = await StorageService.getDeviceId();
      final playerId = OneSignal.User.pushSubscription.id;

      if (playerId == null) {
        debugPrint('⌛ No OneSignal player ID available');
        return;
      }

      debugPrint('🔔 Sending test push...');

      // Send via Edge Function that has REST API key
      await ApiService.testPushNotification(playerId);

      debugPrint('✅ Test push sent');
    } catch (e) {
      debugPrint('⌛ Error sending test push');
      if (kDebugMode) {
        debugPrint('   Details: ${e.toString()}');
      }
    }
  }
}
