// lib/services/onesignal_service.dart
// УПРОЩЕННАЯ ВЕРСИЯ БЕЗ ДУБЛИРУЮЩЕЙ ИНИЦИАЛИЗАЦИИ
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io' show Platform;
import 'dart:async';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class OneSignalService {
  // НЕТ инициализации здесь! Она только в main.dart

  /// Проверить и сохранить player_id если доступен
  static Future<void> checkAndSavePlayerId() async {
    final playerId = OneSignal.User.pushSubscription.id;
    final token = OneSignal.User.pushSubscription.token;
    final optedIn = OneSignal.User.pushSubscription.optedIn;

    debugPrint('');
    debugPrint('📊 ═══════════════════════════════════');
    debugPrint('📊 CHECKING ONESIGNAL STATUS');
    debugPrint('📊 ═══════════════════════════════════');
    debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
    debugPrint('   Player ID: ${playerId ?? "null"}');
    debugPrint('   Token: ${token ?? "null"}');
    debugPrint('   Opted In: ${optedIn ?? false}');
    debugPrint('📊 ═══════════════════════════════════');
    debugPrint('');

    if (playerId != null && playerId.isNotEmpty && optedIn == true) {
      final deviceId = await StorageService.getDeviceId();

      try {
        await ApiService.savePushToken(
          deviceId: deviceId,
          playerId: playerId,
        );
        debugPrint('✅ Player ID saved successfully to backend');
      } catch (e) {
        debugPrint('❌ Failed to save player ID: $e');
      }
    } else {
      debugPrint(
          '⚠️ Cannot save - Player ID not available or user not opted in');
    }
  }

  /// Диагностика состояния OneSignal
  static void diagnoseStatus() {
    debugPrint('');
    debugPrint('🔍 ═══════════════════════════════════');
    debugPrint('🔍 ONESIGNAL DIAGNOSTIC');
    debugPrint('🔍 ═══════════════════════════════════');
    debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
    debugPrint('   Time: ${DateTime.now().toIso8601String()}');

    final id = OneSignal.User.pushSubscription.id;
    debugPrint('   Player ID: ${id ?? "NULL"}');

    final token = OneSignal.User.pushSubscription.token;
    debugPrint('   Push Token: ${token ?? "NULL"}');

    final optedIn = OneSignal.User.pushSubscription.optedIn;
    debugPrint('   Opted In: $optedIn');

    debugPrint('🔍 ═══════════════════════════════════');
    debugPrint('');
  }

  /// Retry логика специально для iOS
  static Future<void> retryIOSRegistration() async {
    if (!Platform.isIOS) {
      debugPrint('📱 Skipping iOS retry on Android platform');
      return;
    }

    debugPrint('🍎 iOS: Starting retry sequence for player_id');

    // Попытка 1: через 5 секунд
    Timer(const Duration(seconds: 5), () async {
      debugPrint('🍎 iOS Retry 1/3 (5 seconds)');
      await checkAndSavePlayerId();

      if (OneSignal.User.pushSubscription.id == null) {
        debugPrint('⚠️ iOS Retry 1 failed - player_id still null');
      } else {
        debugPrint('✅ iOS Retry 1 successful!');
      }
    });

    // Попытка 2: через 15 секунд
    Timer(const Duration(seconds: 15), () async {
      debugPrint('🍎 iOS Retry 2/3 (15 seconds)');
      await checkAndSavePlayerId();

      if (OneSignal.User.pushSubscription.id == null) {
        debugPrint('⚠️ iOS Retry 2 failed - player_id still null');
      } else {
        debugPrint('✅ iOS Retry 2 successful!');
      }
    });

    // Попытка 3: через 30 секунд
    Timer(const Duration(seconds: 30), () async {
      debugPrint('🍎 iOS Retry 3/3 (30 seconds)');
      await checkAndSavePlayerId();

      if (OneSignal.User.pushSubscription.id == null) {
        debugPrint('❌ iOS: All retries failed - manual intervention needed');
        debugPrint('❌ iOS: User may need to restart app or check settings');
      } else {
        debugPrint('✅ iOS Retry 3 successful!');
      }
    });
  }

  /// Проверка при возврате из фона
  static Future<void> checkOnResume() async {
    debugPrint('📱 App resumed - checking OneSignal status');
    diagnoseStatus();

    // Для iOS делаем дополнительную проверку
    if (Platform.isIOS) {
      final playerId = OneSignal.User.pushSubscription.id;
      if (playerId == null || playerId.isEmpty) {
        debugPrint('🍎 iOS: No player_id on resume, starting retry');
        await retryIOSRegistration();
      } else {
        // Пробуем сохранить если есть
        await checkAndSavePlayerId();
      }
    } else {
      // Для Android просто сохраняем если есть
      await checkAndSavePlayerId();
    }
  }
}
