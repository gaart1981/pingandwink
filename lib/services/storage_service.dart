// lib/services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import '../models/user_data.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/moderation_service.dart';

/// Service for local storage management with birth year support
class StorageService {
  static const String _deviceIdKey = 'device_id';
  static const String _lastSubmissionKey = 'last_submission_time';
  static const String _lastEmotionKey = 'last_emotion';
  static const String _streakDaysKey = 'streak_days';
  static const String _languageKey = 'language_code';
  static const String _mapThemeKey = 'map_theme_dark';
  static const String _pendingPingKey = 'pending_ping_id';
  static const String _pendingPingTimeKey = 'pending_ping_time';
  static const String _birthYearKey = 'birth_year'; // New key for age filtering
  static const String _banStatusKey = 'ban_status';
  static const String _banUntilKey = 'ban_until';
  static const String _softLocationKey =
      'soft_location_mode'; // NEW: Soft location setting

  static SharedPreferences? _prefs;

  /// Initialize storage service
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get or create device ID
  static Future<String> getDeviceId() async {
    await _ensureInitialized();

    // Check cached value for performance
    String? cachedId = _prefs!.getString(_deviceIdKey);
    if (cachedId != null && cachedId.isNotEmpty) {
      return cachedId;
    }

    String deviceId = '';

    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        // Android: use Android ID
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;

        // Fallback if Android ID is unavailable
        if (deviceId.isEmpty) {
          deviceId = const Uuid().v4();
          debugPrint('Android ID unavailable, using UUID fallback');
        } else {
          debugPrint('Using Android ID for device identification');
        }
      } else if (Platform.isIOS) {
        // iOS: use Secure Storage for persistence
        const secureStorage = FlutterSecureStorage();
        const String keyName = 'pingwink_device_id';

        // Try to read from Keychain
        String? storedId = await secureStorage.read(key: keyName);

        if (storedId == null || storedId.isEmpty) {
          // First launch or after complete reinstall
          final iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor ?? '';

          if (deviceId.isEmpty) {
            deviceId = const Uuid().v4();
            debugPrint('identifierForVendor unavailable, using UUID fallback');
          } else {
            debugPrint('Using identifierForVendor for device identification');
          }

          // Save to Keychain
          await secureStorage.write(key: keyName, value: deviceId);
          debugPrint('Device ID saved to iOS Keychain');
        } else {
          deviceId = storedId;
          debugPrint('Device ID restored from iOS Keychain');
        }
      } else {
        // Web or other platforms
        deviceId = const Uuid().v4();
        debugPrint('Using UUID for web/other platform');
      }
    } catch (e) {
      // Use UUID on any error
      debugPrint('Error getting device ID: $e');
      deviceId = const Uuid().v4();
      debugPrint('Using UUID fallback due to error');
    }

    // Check that ID is not empty
    if (deviceId.isEmpty) {
      deviceId = const Uuid().v4();
      debugPrint('Empty device ID detected, using UUID fallback');
    }

    // Cache for quick access
    await _prefs!.setString(_deviceIdKey, deviceId);
    debugPrint('Device ID finalized: ${deviceId.substring(0, 8)}...');

    return deviceId;
  }

  /// Save birth year
  static Future<void> saveBirthYear(int birthYear) async {
    await _ensureInitialized();
    await _prefs!.setInt(_birthYearKey, birthYear);
    debugPrint('Saved birth year: $birthYear');
  }

  /// Get birth year
  static Future<int?> getBirthYear() async {
    await _ensureInitialized();
    return _prefs!.getInt(_birthYearKey);
  }

  /// Check if user has set birth year
  static Future<bool> hasBirthYear() async {
    await _ensureInitialized();
    return _prefs!.containsKey(_birthYearKey);
  }

  /// Save ban status locally
  static Future<void> saveBanStatus(
      bool isBanned, DateTime? bannedUntil) async {
    await _ensureInitialized();
    await _prefs!.setBool(_banStatusKey, isBanned);
    if (bannedUntil != null) {
      await _prefs!.setString(_banUntilKey, bannedUntil.toIso8601String());
    } else {
      await _prefs!.remove(_banUntilKey);
    }
  }

  /// Get cached ban status
  static Future<BanStatus?> getCachedBanStatus() async {
    await _ensureInitialized();

    final isBanned = _prefs!.getBool(_banStatusKey) ?? false;
    if (!isBanned) return null;

    final banUntilStr = _prefs!.getString(_banUntilKey);
    if (banUntilStr == null) return null;

    final bannedUntil = DateTime.parse(banUntilStr);

    // Check if ban expired
    if (DateTime.now().isAfter(bannedUntil)) {
      // Ban expired, clear cache
      await saveBanStatus(false, null);
      return null;
    }

    final remainingSeconds = bannedUntil.difference(DateTime.now()).inSeconds;
    return BanStatus(
      isBanned: true,
      bannedUntil: bannedUntil,
      remainingSeconds: remainingSeconds > 0 ? remainingSeconds : 0,
    );
  }

  /// NEW: Get soft location mode setting
  static Future<bool> isSoftLocationEnabled() async {
    await _ensureInitialized();
    return _prefs!.getBool(_softLocationKey) ?? true;
  }

  /// NEW: Set soft location mode
  static Future<void> setSoftLocationMode(bool enabled) async {
    await _ensureInitialized();
    await _prefs!.setBool(_softLocationKey, enabled);
    debugPrint('Soft location mode set to: $enabled');
  }

  /// Load user data from storage
  static Future<UserData> loadUserData() async {
    await _ensureInitialized();

    final deviceId = await getDeviceId();

    // Load last submission time
    DateTime? lastSubmissionTime;
    final lastSubmissionStr = _prefs!.getString(_lastSubmissionKey);
    if (lastSubmissionStr != null) {
      lastSubmissionTime = DateTime.parse(lastSubmissionStr);
    }

    // Load other data
    final lastEmotion = _prefs!.getInt(_lastEmotionKey);
    final streakDays = _prefs!.getInt(_streakDaysKey) ?? 1;
    final languageCode =
        _prefs!.getString(_languageKey) ?? _detectSystemLanguage();
    final birthYear = _prefs!.getInt(_birthYearKey); // Load birth year

    return UserData(
      deviceId: deviceId,
      lastSubmissionTime: lastSubmissionTime,
      lastEmotion: lastEmotion,
      streakDays: streakDays,
      languageCode: languageCode,
      birthYear: birthYear,
    );
  }

  /// Save submission data
  static Future<void> saveSubmission(int emotion, int newStreakDays) async {
    await _ensureInitialized();

    await _prefs!
        .setString(_lastSubmissionKey, DateTime.now().toIso8601String());
    await _prefs!.setInt(_lastEmotionKey, emotion);
    await _prefs!.setInt(_streakDaysKey, newStreakDays);
  }

  /// Update streak days
  static Future<void> updateStreak(int days) async {
    await _ensureInitialized();
    await _prefs!.setInt(_streakDaysKey, days);
  }

  /// Save language preference
  static Future<void> saveLanguage(String languageCode) async {
    await _ensureInitialized();
    await _prefs!.setString(_languageKey, languageCode);
  }

  /// Get map theme preference (dark by default)
  static Future<bool> isDarkMapTheme() async {
    await _ensureInitialized();
    return _prefs!.getBool(_mapThemeKey) ?? true;
  }

  /// Set map theme preference
  static Future<void> setDarkMapTheme(bool isDark) async {
    await _ensureInitialized();
    await _prefs!.setBool(_mapThemeKey, isDark);
  }

  /// Save pending ping ID from push notification
  static Future<void> savePendingPing(String pingId) async {
    await _ensureInitialized();
    await _prefs!.setString(_pendingPingKey, pingId);
    await _prefs!
        .setString(_pendingPingTimeKey, DateTime.now().toIso8601String());
    debugPrint('Saved pending ping: $pingId');
  }

  /// Get pending ping if still valid (not older than 60 seconds)
  static Future<String?> getPendingPing() async {
    await _ensureInitialized();

    final pingId = _prefs!.getString(_pendingPingKey);
    final timeStr = _prefs!.getString(_pendingPingTimeKey);

    if (pingId == null || timeStr == null) return null;

    final savedTime = DateTime.parse(timeStr);
    final age = DateTime.now().difference(savedTime).inSeconds;

    if (age > 60) {
      // Ping expired, remove it
      await clearPendingPing();
      debugPrint('Pending ping expired (${age}s old)');
      return null;
    }

    debugPrint('Found valid pending ping: $pingId (${age}s old)');
    return pingId;
  }

  /// Clear pending ping
  static Future<void> clearPendingPing() async {
    await _ensureInitialized();
    await _prefs!.remove(_pendingPingKey);
    await _prefs!.remove(_pendingPingTimeKey);
  }

  /// Get current streak count
  static Future<int> getStreak() async {
    await _ensureInitialized();
    return _prefs!.getInt('streak_count') ?? 0;
  }

  /// Update streak when user selects vibe
  static Future<void> updateStreakOnVibe() async {
    await _ensureInitialized();

    final lastDate = _prefs!.getString('last_vibe_date');
    final today = DateTime.now().toIso8601String().split('T')[0];
    final yesterday = DateTime.now()
        .subtract(const Duration(days: 1))
        .toIso8601String()
        .split('T')[0];

    if (lastDate == today) return; // Already vibed today

    if (lastDate == yesterday) {
      // Continue streak
      final current = _prefs!.getInt('streak_count') ?? 0;
      await _prefs!.setInt('streak_count', current + 1);
    } else {
      // Start new streak
      await _prefs!.setInt('streak_count', 1);
    }

    await _prefs!.setString('last_vibe_date', today);
  }

  /// Check if streak was lost
  static Future<bool> checkStreakLost() async {
    await _ensureInitialized();

    final lastDate = _prefs!.getString('last_vibe_date');
    if (lastDate == null) return false;

    final today = DateTime.now().toIso8601String().split('T')[0];
    final yesterday = DateTime.now()
        .subtract(const Duration(days: 1))
        .toIso8601String()
        .split('T')[0];

    // If last vibe was before yesterday - streak is lost
    if (lastDate != yesterday && lastDate != today) {
      final hadStreak = (_prefs!.getInt('streak_count') ?? 0) > 1;
      await _prefs!.setInt('streak_count', 0);
      return hadStreak;
    }
    return false;
  }

  /// Clear all user data
  static Future<void> clearUserData() async {
    await _ensureInitialized();

    // Keep device ID but clear other data
    final deviceId = await getDeviceId();
    await _prefs!.clear();
    await _prefs!.setString(_deviceIdKey, deviceId);
  }

  /// Ensure storage is initialized
  static Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      await init();
    }
  }

  /// Detect system language
  static String _detectSystemLanguage() {
    // This will be overridden by actual locale detection in the app
    // Default to English
    return 'en';
  }

  /// Check if user has seen ping tutorial
  static Future<bool> hasSeenPingTutorial() async {
    await _ensureInitialized();
    return _prefs!.getBool('seen_ping_tutorial') ?? false;
  }

  /// Mark ping tutorial as seen
  static Future<void> setPingTutorialSeen() async {
    await _ensureInitialized();
    await _prefs!.setBool('seen_ping_tutorial', true);
  }
}
