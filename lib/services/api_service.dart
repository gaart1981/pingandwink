// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import '../config/app_config.dart';
import '../models/emotion_data.dart';

/// API Service for Ping&Wink application with age filtering support
class ApiService {
  // Using environment variables from AppConfig
  static String get _submitMoodUrl =>
      '${AppConfig.supabaseUrl}/functions/v1/submit-mood';
  static String get _getMapUrl =>
      '${AppConfig.supabaseUrl}/functions/v1/get-map';
  static String get _testPushUrl =>
      '${AppConfig.supabaseUrl}/functions/v1/test-push';
  static String get _saveBirthYearUrl =>
      '${AppConfig.supabaseUrl}/functions/v1/save-birth-year';

  /// Save birth year to server
  static Future<bool> saveBirthYear({
    required String deviceId,
    required int birthYear,
  }) async {
    try {
      final url = _saveBirthYearUrl;
      final requestBody = {
        'device_id': deviceId,
        'birth_year': birthYear,
      };

      debugPrint('📤 Calling Edge Function save-birth-year:');
      debugPrint('   URL: $url');
      debugPrint('   Device ID: $deviceId');
      debugPrint('   Birth Year: $birthYear');
      debugPrint('   Request Body: ${json.encode(requestBody)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      debugPrint('📥 Response Status: ${response.statusCode}');
      debugPrint('   Response Body: ${response.body}');

      // Детально парсим ответ при ошибке
      if (response.statusCode == 400 && response.body.isNotEmpty) {
        try {
          final errorData = json.decode(response.body);
          debugPrint('   ❌ Error field: ${errorData['error']}');
          debugPrint('   ❌ Details field: ${errorData['details']}');
        } catch (e) {
          debugPrint('   ❌ Could not parse error response');
        }
      }

      // Проверяем успешные статусы
      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint('✅ Birth year saved successfully to Edge Function');
        return true;
      } else {
        debugPrint('❌ Failed to save birth year: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Exception in saveBirthYear:');
      debugPrint('   Error: $e');
      debugPrint('   Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  /// Submit mood to server with birth year support
  static Future<Map<String, dynamic>> submitMood({
    required int emotion,
    required String deviceId,
    double? lat,
    double? lon,
    int? birthYear,
  }) async {
    try {
      final body = {
        'emotion': emotion,
        'device_id': deviceId,
        'lat': lat ?? 48.8566, // Default to Paris
        'lon': lon ?? 2.3522,
      };

      // Add birth year if available
      if (birthYear != null) {
        body['birth_year'] = birthYear;
      }

      final response = await http.post(
        Uri.parse(_submitMoodUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw Exception(error['error'] ?? 'Failed to submit mood');
      }
    } catch (e) {
      debugPrint('Error submitting mood: $e');
      throw e;
    }
  }

  /// Get all active moods from map with age filtering and viewport support
  /// ОБНОВЛЕНО: Теперь возвращает active_sparks и active_pings
  static Future<Map<String, dynamic>> getMapData({
    String? deviceId,
    double? lat,
    double? lon,
    int? birthYear,
    // Viewport parameters for optimization
    double? north,
    double? south,
    double? east,
    double? west,
    double? zoom,
  }) async {
    try {
      final queryParams = <String, String>{};

      // Existing parameters for device and location
      if (deviceId != null) queryParams['device_id'] = deviceId;
      if (lat != null) queryParams['lat'] = lat.toString();
      if (lon != null) queryParams['lon'] = lon.toString();

      // Add birth year for age filtering
      if (birthYear != null) {
        queryParams['birth_year'] = birthYear.toString();
      }

      // Viewport parameters - only add if all boundaries are provided
      if (north != null && south != null && east != null && west != null) {
        queryParams['north'] = north.toString();
        queryParams['south'] = south.toString();
        queryParams['east'] = east.toString();
        queryParams['west'] = west.toString();
        if (zoom != null) queryParams['zoom'] = zoom.toString();
      }

      final uri = Uri.parse(_getMapUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ВАЖНОЕ ИЗМЕНЕНИЕ: Возвращаем ВСЕ поля, включая новые
        return {
          'success': data['success'] ?? true,
          'moods': data['moods'] ?? [],
          'active_sparks': data['active_sparks'] ?? [], // НОВОЕ
          'active_pings': data['active_pings'] ?? [], // НОВОЕ
          'stats': data['stats'] ?? {},
          'server_time': data['server_time'],
        };
      } else {
        throw Exception('Failed to get map data');
      }
    } catch (e) {
      debugPrint('Error getting map data: $e');
      throw e;
    }
  }

  /// Parse emotions from API response with safe type conversions
  static List<EmotionData> parseEmotions(
      Map<String, dynamic> data, String? deviceId) {
    final emotions = <EmotionData>[];

    if (data['moods'] != null && data['moods'] is List) {
      final moods = data['moods'] as List;

      for (var mood in moods) {
        try {
          // Safe type conversions for all fields
          final id = mood['id']?.toString() ?? '';

          // Safe emotion parsing
          int emotion = 0;
          if (mood['emotion'] != null) {
            if (mood['emotion'] is int) {
              emotion = mood['emotion'];
            } else if (mood['emotion'] is String) {
              emotion = int.tryParse(mood['emotion']) ?? 0;
            } else {
              emotion = int.tryParse(mood['emotion'].toString()) ?? 0;
            }
          }

          // Safe lat/lon parsing
          double lat = 0.0;
          if (mood['lat'] != null) {
            if (mood['lat'] is double) {
              lat = mood['lat'];
            } else if (mood['lat'] is int) {
              lat = mood['lat'].toDouble();
            } else {
              lat = double.tryParse(mood['lat'].toString()) ?? 0.0;
            }
          }

          double lon = 0.0;
          if (mood['lon'] != null) {
            if (mood['lon'] is double) {
              lon = mood['lon'];
            } else if (mood['lon'] is int) {
              lon = mood['lon'].toDouble();
            } else {
              lon = double.tryParse(mood['lon'].toString()) ?? 0.0;
            }
          }

          final deviceIdStr = mood['device_id']?.toString() ?? '';

          // Safe date parsing with fallback
          DateTime createdAt;
          try {
            createdAt = DateTime.parse(mood['created_at']);
          } catch (e) {
            createdAt = DateTime.now();
            debugPrint('Error parsing created_at: ${mood['created_at']}');
          }

          DateTime expiresAt;
          try {
            expiresAt = DateTime.parse(mood['expires_at']);
          } catch (e) {
            expiresAt = DateTime.now().add(const Duration(hours: 2));
            debugPrint('Error parsing expires_at: ${mood['expires_at']}');
          }

          // Safe opacity parsing (though we always use 1.0)
          double opacity = 1.0;
          if (mood['opacity'] != null) {
            if (mood['opacity'] is double) {
              opacity = mood['opacity'];
            } else if (mood['opacity'] is int) {
              opacity = mood['opacity'].toDouble();
            } else {
              opacity = double.tryParse(mood['opacity'].toString()) ?? 1.0;
            }
          }

          // Safe isOwn parsing
          bool isOwn = false;
          if (mood['is_own'] != null) {
            if (mood['is_own'] is bool) {
              isOwn = mood['is_own'];
            } else if (mood['is_own'] is String) {
              isOwn = mood['is_own'] == 'true';
            }
          } else {
            isOwn = deviceIdStr == deviceId;
          }

          emotions.add(EmotionData(
            id: id,
            emotion: emotion,
            lat: lat,
            lon: lon,
            deviceId: deviceIdStr,
            createdAt: createdAt,
            expiresAt: expiresAt,
            opacity: opacity,
            isOwn: isOwn,
          ));
        } catch (e) {
          // Continue with next mood instead of breaking
          continue;
        }
      }
    }

    return emotions;
  }

  /// Test push notification
  static Future<void> testPushNotification(String playerId) async {
    try {
      final response = await http.post(
        Uri.parse(_testPushUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'player_id': playerId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send test push');
      }
    } catch (e) {
      debugPrint('Error sending test push: $e');
      throw e;
    }
  }

  /// Get user history for history_screen.dart
  static Future<List<Map<String, dynamic>>> getUserHistory(
      String deviceId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/moods';
      final queryParams = {
        'device_id': 'eq.$deviceId',
        'order': 'created_at.desc',
        'limit': '100',
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        debugPrint('Error fetching history: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Error in getUserHistory: $e');
      return [];
    }
  }

  /// Delete user data for settings_screen.dart
  static Future<void> deleteUserData(String deviceId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/moods';
      final queryParams = {
        'device_id': 'eq.$deviceId',
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to delete user data');
      }
    } catch (e) {
      debugPrint('Error deleting user data: $e');
      rethrow;
    }
  }

  /// Save push token to database - fixed version with platform support
  static Future<void> savePushToken({
    required String deviceId,
    required String playerId,
  }) async {
    try {
      // Определяем платформу
      String platformName = 'android'; // default
      if (Platform.isIOS) {
        platformName = 'ios';
      } else if (Platform.isAndroid) {
        platformName = 'android';
      }

      debugPrint('💾 Saving push token:');
      debugPrint('   Device ID: $deviceId');
      debugPrint('   Player ID: $playerId');
      debugPrint('   Platform: $platformName');

      // Using UPSERT (insert or update) to avoid duplicates
      final response = await http.post(
        Uri.parse(
            '${AppConfig.supabaseUrl}/rest/v1/push_tokens?on_conflict=device_id'),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
          'Prefer': 'resolution=merge-duplicates',
        },
        body: json.encode({
          'device_id': deviceId,
          'player_id': playerId,
          'platform': platformName, // КРИТИЧЕСКИ ВАЖНО!
          'push_enabled': true,
          'updated_at': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        debugPrint('❌ Failed to save push token: ${response.statusCode}');
        debugPrint('   Response body: ${response.body}');
      } else {
        debugPrint('✅ Push token saved successfully');
        debugPrint('   Platform: $platformName');
      }
    } catch (e) {
      debugPrint('❌ Error saving push token: $e');
    }
  }
}
