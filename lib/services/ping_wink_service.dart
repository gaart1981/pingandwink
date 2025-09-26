// lib/services/ping_wink_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart' as geo;
import '../config/app_config.dart';
import '../models/ping_data.dart';
import '../models/spark_session.dart';

/// Service for managing Ping&Wink interactions
class PingWinkService {
  static String get _sendPingUrl => '${AppConfig.supabaseUrl}/functions/v1/send-ping';
  static String get _sendWinkUrl => '${AppConfig.supabaseUrl}/functions/v1/send-wink';
  
  /// Send a ping to another emotion
  static Future<Map<String, dynamic>> sendPing({
    required String fromDeviceId,
    required String toMoodId,
    double? fromLat,
    double? fromLon,
  }) async {
    try {
      debugPrint('📤 Sending ping to mood: $toMoodId');
      
      final response = await http.post(
        Uri.parse(_sendPingUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'from_device_id': fromDeviceId,
          'to_mood_id': toMoodId,
          'from_lat': fromLat,
          'from_lon': fromLon,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        debugPrint('✅ Ping sent successfully: ${data['ping_id']}');
        return {
          'success': true,
          'ping_id': data['ping_id'],
          'expires_at': data['expires_at'],
          'distance_meters': data['distance_meters'],
        };
      } else {
        debugPrint('❌ Ping failed: ${data['error']}');
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to send ping',
        };
      }
    } catch (e) {
      debugPrint('❌ Error sending ping: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Send a wink (accept ping)
  static Future<Map<String, dynamic>> sendWink({
    required String pingId,
    required String winkDeviceId,
  }) async {
    try {
      debugPrint('💫 Sending wink for ping: $pingId');
      
      final response = await http.post(
        Uri.parse(_sendWinkUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'ping_id': pingId,
          'wink_device_id': winkDeviceId,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        debugPrint('✅ Wink sent, spark created: ${data['spark_session']['id']}');
        return {
          'success': true,
          'wink_id': data['wink_id'],
          'spark_session': SparkSession.fromJson(data['spark_session']),
        };
      } else {
        debugPrint('❌ Wink failed: ${data['error']}');
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to send wink',
        };
      }
    } catch (e) {
      debugPrint('❌ Error sending wink: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Get active incoming pings
  static Future<List<IncomingPing>> getIncomingPings(String deviceId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/pings';
      final queryParams = {
        'to_device_id': 'eq.$deviceId',
        'status': 'eq.pending',
        'expires_at': 'gt.${DateTime.now().toIso8601String()}',
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
        return data.map((json) => IncomingPing.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      debugPrint('❌ Error getting incoming pings: $e');
      return [];
    }
  }
  
  /// Reject a ping
  static Future<void> rejectPing(String pingId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/pings';
      final queryParams = {'id': 'eq.$pingId'};
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      
      await http.patch(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({'status': 'rejected'}),
      );
      
      debugPrint('✅ Ping rejected: $pingId');
    } catch (e) {
      debugPrint('❌ Error rejecting ping: $e');
    }
  }
}