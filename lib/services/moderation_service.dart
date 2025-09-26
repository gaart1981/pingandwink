// lib/services/moderation_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../config/app_config.dart';

/// Service for managing moderation: bans and reports
class ModerationService {
  static String get _banUserUrl => '${AppConfig.supabaseUrl}/functions/v1/ban-user';
  static String get _reportUserUrl => '${AppConfig.supabaseUrl}/functions/v1/report-user';
  
  /// Ban a user for 7 minutes
  static Future<Map<String, dynamic>> banUser({
    required String bannerDevice,
    required String bannedDevice,
    required String sessionId,
    String? reason,
  }) async {
    try {
      debugPrint('⛔ Banning user: $bannedDevice');
      
      final response = await http.post(
        Uri.parse(_banUserUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'banner_device': bannerDevice,
          'banned_device': bannedDevice,
          'session_id': sessionId,
          'reason': reason ?? 'Inappropriate behavior',
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        debugPrint('✅ User banned successfully');
        return {
          'success': true,
          'banned_until': data['banned_until'],
          'message': data['message'],
        };
      } else if (response.statusCode == 429 && data['autoban'] == true) {
        debugPrint('⚠️ Autoban triggered for excessive banning');
        return {
          'success': false,
          'error': data['error'],
          'autoban': true,
        };
      } else {
        debugPrint('❌ Ban failed: ${data['error']}');
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to ban user',
        };
      }
    } catch (e) {
      debugPrint('❌ Error banning user: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Report a user
  static Future<Map<String, dynamic>> reportUser({
    required String reporterDevice,
    required String reportedDevice,
    required String reason,
    String? sessionId,
    String? messageId,
    String? description,
  }) async {
    try {
      debugPrint('⚠️ Reporting user: $reportedDevice for $reason');
      
      final response = await http.post(
        Uri.parse(_reportUserUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'reporter_device': reporterDevice,
          'reported_device': reportedDevice,
          'reason': reason,
          'session_id': sessionId,
          'message_id': messageId,
          'description': description,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        debugPrint('✅ Report submitted successfully');
        return {
          'success': true,
          'message': data['message'],
          'reports_count': data['reports_count'],
        };
      } else {
        debugPrint('❌ Report failed: ${data['error']}');
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to submit report',
        };
      }
    } catch (e) {
      debugPrint('❌ Error reporting user: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Check if user is currently banned
  static Future<BanStatus> checkBanStatus(String deviceId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/rpc/check_user_ban';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({'p_device_id': deviceId}),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final banData = data.first;
          return BanStatus(
            isBanned: banData['is_banned'] ?? false,
            bannedUntil: banData['banned_until'] != null 
              ? DateTime.parse(banData['banned_until']) 
              : null,
            remainingSeconds: banData['remaining_seconds'] ?? 0,
          );
        }
      }
      
      return BanStatus(isBanned: false);
    } catch (e) {
      debugPrint('Error checking ban status: $e');
      return BanStatus(isBanned: false);
    }
  }
  
  /// Check if user accepted community guidelines
  static Future<bool> hasAcceptedGuidelines(String deviceId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/community_guidelines_acceptance';
      final queryParams = {
        'device_id': 'eq.$deviceId',
        'select': 'accepted_at',
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
        return data.isNotEmpty;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error checking guidelines acceptance: $e');
      return false;
    }
  }
  
  /// Save user's acceptance of community guidelines
  static Future<void> acceptGuidelines(String deviceId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/community_guidelines_acceptance';
      
      await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
          'Prefer': 'resolution=merge-duplicates',
        },
        body: json.encode({
          'device_id': deviceId,
          'accepted_at': DateTime.now().toIso8601String(),
          'version': '1.0',
        }),
      );
      
      debugPrint('✅ Community guidelines accepted');
    } catch (e) {
      debugPrint('Error accepting guidelines: $e');
    }
  }
}

/// Ban status model
class BanStatus {
  final bool isBanned;
  final DateTime? bannedUntil;
  final int remainingSeconds;
  
  BanStatus({
    required this.isBanned,
    this.bannedUntil,
    this.remainingSeconds = 0,
  });
  
  String get remainingTimeText {
    if (!isBanned || remainingSeconds <= 0) return '';
    
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    
    if (minutes > 0) {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '0:${seconds.toString().padLeft(2, '0')}';
    }
  }
}