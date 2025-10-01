// lib/services/onesignal_service.dart
// ИСПРАВЛЕНО: Добавлена задержка для iOS и детальное логирование
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io' show Platform;
import '../services/api_service.dart';
import '../services/storage_service.dart';

class OneSignalService {
  static bool _isInitialized = false;
  static bool _tokenSaved = false; // Флаг для предотвращения дублирования

  /// Initialize OneSignal push notification service
  static Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('⚠️ OneSignal already initialized');
      return;
    }

    try {
      debugPrint('🚀 Initializing OneSignal...');
      debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');

      // Get OneSignal App ID from environment variables
      final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'] ?? '';

      if (oneSignalAppId.isEmpty) {
        debugPrint('❌ OneSignal App ID not found in .env file');
        return;
      }

      debugPrint('✅ OneSignal App ID: ${oneSignalAppId.substring(0, 8)}...');

      // Set appropriate log level - warn for debug, none for production
      if (kDebugMode) {
        OneSignal.Debug.setLogLevel(OSLogLevel.warn);
      } else {
        OneSignal.Debug.setLogLevel(OSLogLevel.none);
      }

      // Initialize OneSignal with app ID
      OneSignal.initialize(oneSignalAppId);
      debugPrint('✅ OneSignal initialized');

      // Request notification permissions
      debugPrint('📱 Requesting notification permissions...');
      OneSignal.Notifications.requestPermission(true);

      // Get device ID for tracking
      final deviceId = await StorageService.getDeviceId();
      debugPrint('📱 Device ID: ${deviceId.substring(0, 8)}...');

      // Listen for push subscription changes
      OneSignal.User.pushSubscription.addObserver((state) async {
        debugPrint('');
        debugPrint('🔔 ═══════════════════════════════════');
        debugPrint('🔔 PUSH SUBSCRIPTION STATE CHANGED');
        debugPrint('🔔 ═══════════════════════════════════');
        debugPrint('   Previous Player ID: ${state.previous.id ?? "null"}');
        debugPrint('   Current Player ID: ${state.current.id ?? "null"}');
        debugPrint('   Previous Token: ${state.previous.token ?? "null"}');
        debugPrint('   Current Token: ${state.current.token ?? "null"}');
        debugPrint('   Opted In: ${state.current.optedIn}');
        debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
        debugPrint('🔔 ═══════════════════════════════════');
        debugPrint('');

        final playerId = state.current.id;

        if (playerId != null && playerId.trim().isNotEmpty && !_tokenSaved) {
          debugPrint('✅ Valid Player ID received: $playerId');
          debugPrint('💾 Saving token to database...');

          await _savePushToken(deviceId, playerId);
          _tokenSaved = true;

          debugPrint('✅ Token saved successfully');
        } else if (_tokenSaved) {
          debugPrint('ℹ️ Token already saved, skipping');
        } else {
          debugPrint('⚠️ Player ID is null or empty, cannot save');
        }
      });

      // КРИТИЧЕСКОЕ ИСПРАВЛЕНИЕ ДЛЯ iOS:
      // На iOS токен создаётся позже, чем на Android
      // Добавляем задержку перед проверкой начального состояния
      if (Platform.isIOS) {
        debugPrint(
          '⏳ iOS detected - waiting 2 seconds for token generation...',
        );
        await Future.delayed(const Duration(seconds: 2));
      }

      // Check current subscription state
      debugPrint('🔍 Checking initial subscription state...');
      final subscriptionState = OneSignal.User.pushSubscription;
      final initialPlayerId = subscriptionState.id;
      final initialToken = subscriptionState.token;
      final isOptedIn = subscriptionState.optedIn;

      debugPrint('');
      debugPrint('📊 ═══════════════════════════════════');
      debugPrint('📊 INITIAL SUBSCRIPTION STATE');
      debugPrint('📊 ═══════════════════════════════════');
      debugPrint('   Player ID: ${initialPlayerId ?? "null"}');
      debugPrint('   Token: ${initialToken ?? "null"}');
      debugPrint('   Opted In: $isOptedIn');
      debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
      debugPrint('📊 ═══════════════════════════════════');
      debugPrint('');

      if (initialPlayerId != null &&
          initialPlayerId.trim().isNotEmpty &&
          !_tokenSaved) {
        debugPrint('✅ Initial Player ID found: $initialPlayerId');
        debugPrint('💾 Saving initial push token...');

        await _savePushToken(deviceId, initialPlayerId);
        _tokenSaved = true;

        debugPrint('✅ Initial push token saved');
      } else if (_tokenSaved) {
        debugPrint('ℹ️ Token already saved');
      } else {
        debugPrint('⚠️ No initial Player ID available');
        debugPrint('   Will be saved when subscription state changes');

        // ДЛЯ iOS: Попробуем ещё раз через 5 секунд
        if (Platform.isIOS) {
          debugPrint('⏳ iOS: Scheduling retry in 5 seconds...');
          Future.delayed(const Duration(seconds: 5), () async {
            final retryState = OneSignal.User.pushSubscription;
            final retryPlayerId = retryState.id;

            debugPrint('');
            debugPrint('🔄 ═══════════════════════════════════');
            debugPrint('🔄 iOS RETRY ATTEMPT');
            debugPrint('🔄 ═══════════════════════════════════');
            debugPrint('   Player ID: ${retryPlayerId ?? "null"}');
            debugPrint('   Token Saved: $_tokenSaved');
            debugPrint('🔄 ═══════════════════════════════════');
            debugPrint('');

            if (retryPlayerId != null &&
                retryPlayerId.trim().isNotEmpty &&
                !_tokenSaved) {
              debugPrint('✅ iOS: Player ID found on retry: $retryPlayerId');
              debugPrint('💾 Saving token on retry...');

              await _savePushToken(deviceId, retryPlayerId);
              _tokenSaved = true;

              debugPrint('✅ iOS: Token saved on retry');
            } else if (_tokenSaved) {
              debugPrint('ℹ️ iOS: Token already saved');
            } else {
              debugPrint('❌ iOS: Still no Player ID after retry');
            }
          });
        }
      }

      _isInitialized = true;

      debugPrint('');
      debugPrint('✅ ═══════════════════════════════════');
      debugPrint('✅ ONESIGNAL INITIALIZATION COMPLETE');
      debugPrint('✅ ═══════════════════════════════════');
      debugPrint('');
    } catch (e) {
      debugPrint('❌ Error initializing OneSignal');
      if (kDebugMode) {
        debugPrint('   Error: ${e.toString()}');
        debugPrint('   Stack trace: ${StackTrace.current}');
      }
    }
  }

  /// Save push token to database
  static Future<void> _savePushToken(String deviceId, String playerId) async {
    try {
      debugPrint('');
      debugPrint('💾 ═══════════════════════════════════');
      debugPrint('💾 SAVING PUSH TOKEN TO DATABASE');
      debugPrint('💾 ═══════════════════════════════════');
      debugPrint('   Device ID: ${deviceId.substring(0, 8)}...');
      debugPrint('   Player ID: $playerId');
      debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
      debugPrint('💾 ═══════════════════════════════════');
      debugPrint('');

      await ApiService.savePushToken(deviceId: deviceId, playerId: playerId);

      debugPrint('');
      debugPrint('✅ ═══════════════════════════════════');
      debugPrint('✅ PUSH TOKEN SAVED SUCCESSFULLY');
      debugPrint('✅ ═══════════════════════════════════');
      debugPrint('');
    } catch (e) {
      debugPrint('');
      debugPrint('❌ ═══════════════════════════════════');
      debugPrint('❌ ERROR SAVING PUSH TOKEN');
      debugPrint('❌ ═══════════════════════════════════');
      if (kDebugMode) {
        debugPrint('   Error: ${e.toString()}');
        debugPrint('   Stack trace: ${StackTrace.current}');
      }
      debugPrint('❌ ═══════════════════════════════════');
      debugPrint('');
    }
  }

  /// Send test push notification via Edge Function
  static Future<void> testPush() async {
    try {
      final deviceId = await StorageService.getDeviceId();
      final playerId = OneSignal.User.pushSubscription.id;

      if (playerId == null) {
        debugPrint('❌ No OneSignal player ID available');
        return;
      }

      debugPrint('📤 Sending test push...');

      // Send via Edge Function that has REST API key
      await ApiService.testPushNotification(playerId);

      debugPrint('✅ Test push sent');
    } catch (e) {
      debugPrint('❌ Error sending test push');
      if (kDebugMode) {
        debugPrint('   Details: ${e.toString()}');
      }
    }
  }
}
