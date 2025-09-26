// lib/services/chat_service.dart
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';
import '../models/chat_message.dart';
import '../models/spark_session.dart';

/// Service for managing spark chat with Realtime support
class ChatService {
  static String get _sendMessageUrl =>
      '${AppConfig.supabaseUrl}/functions/v1/send-message';
  static String get _extendChatUrl =>
      '${AppConfig.supabaseUrl}/functions/v1/extend-chat';

  // Realtime channels
  static RealtimeChannel? _messageChannel;
  static RealtimeChannel? _presenceChannel;
  static String? _currentChatSession;

  // Stream controllers for real-time updates
  static final _messagesController =
      StreamController<List<ChatMessage>>.broadcast();
  static final _sessionController = StreamController<SparkSession>.broadcast();

  static Stream<List<ChatMessage>> get messagesStream =>
      _messagesController.stream;
  static Stream<SparkSession> get sessionStream => _sessionController.stream;

  /// Enter chat with Realtime support
  static void enterChat(
      String sessionId, String myDeviceId, Function(ChatMessage) onNewMessage) {
    _currentChatSession = sessionId;
    final supabase = Supabase.instance.client;

    debugPrint('🔔 Subscribing to Realtime for session: $sessionId');

    // Subscribe to new messages
    _messageChannel = supabase
        .channel('messages_$sessionId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'spark_messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'session_id',
            value: sessionId,
          ),
          callback: (payload) {
            debugPrint('📨 New message received via Realtime');
            final message = ChatMessage.fromJson(payload.newRecord);
            if (message.senderDevice != myDeviceId) {
              debugPrint('🔔 Triggering vibration for incoming message');
              onNewMessage(message);
            }
          },
        )
        .subscribe();

    // FIXED Presence channel for typing indicator
    _presenceChannel = supabase.channel(
      'presence_$sessionId',
      opts: const RealtimeChannelConfig(self: true), // Important!
    );

    _presenceChannel!.onPresenceSync((_) {
      debugPrint('🔄 Presence sync triggered');
    }).onPresenceJoin((payload) {
      debugPrint('👋 User joined: ${payload.newPresences}');
    }).onPresenceLeave((payload) {
      debugPrint('👋 User left: ${payload.leftPresences}');
    }).subscribe((status, [error]) async {
      if (status == RealtimeSubscribeStatus.subscribed) {
        debugPrint('✅ Presence channel subscribed');
        // Send initial state
        await _presenceChannel!.track({
          'device_id': myDeviceId,
          'typing': false,
          'online_at': DateTime.now().toIso8601String(),
        });
      }
    });
  }

  /// Update typing status - FIXED with debugging
  static Future<void> updateTypingStatus(
      bool isTyping, String myDeviceId) async {
    if (_presenceChannel != null) {
      debugPrint('⌨️ SENDING typing=$isTyping for device=$myDeviceId');
      try {
        final payload = {
          'device_id': myDeviceId,
          'typing': isTyping,
          'online_at': DateTime.now().toIso8601String(),
        };
        debugPrint('⌨️ Payload: $payload');
        await _presenceChannel!.track(payload);

        // Check what was sent
        final state = _presenceChannel!.presenceState();
        debugPrint('⌨️ Current state after update: $state');
      } catch (e) {
        debugPrint('❌ Error updating typing status: $e');
      }
    } else {
      debugPrint('❌ Presence channel is NULL!');
    }
  }

  /// Get presence channel
  static RealtimeChannel? get presenceChannel => _presenceChannel;

  /// Leave chat
  static void leaveChat() {
    debugPrint('👋 Leaving chat, unsubscribing from Realtime');
    _messageChannel?.unsubscribe();
    _presenceChannel?.unsubscribe();
    _messageChannel = null;
    _presenceChannel = null;
    _currentChatSession = null;
  }

  /// Send a message in chat
  static Future<Map<String, dynamic>> sendMessage({
    required String sessionId,
    required String senderDevice,
    required String message,
  }) async {
    try {
      debugPrint('💬 Sending message in session: $sessionId');

      final response = await http.post(
        Uri.parse(_sendMessageUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'session_id': sessionId,
          'sender_device': senderDevice,
          'message': message,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        debugPrint('✅ Message sent: ${data['message_id']}');
        return {
          'success': true,
          'message_id': data['message_id'],
        };
      } else {
        debugPrint('❌ Message failed: ${data['error']}');
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to send message',
        };
      }
    } catch (e) {
      debugPrint('❌ Error sending message: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Request chat extension
  static Future<Map<String, dynamic>> requestExtension({
    required String sessionId,
    required String deviceId,
  }) async {
    try {
      debugPrint('⏰ Requesting chat extension for session: $sessionId');

      final response = await http.post(
        Uri.parse(_extendChatUrl),
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'session_id': sessionId,
          'device_id': deviceId,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['extended'] == true) {
          debugPrint('✅ Chat extended: ${data['new_expires_at']}');
        } else {
          debugPrint('⏳ Extension requested, waiting for partner');
        }
        return data;
      } else {
        debugPrint('❌ Extension failed: ${data['error']}');
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to extend chat',
        };
      }
    } catch (e) {
      debugPrint('❌ Error extending chat: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Load messages for a session
  static Future<List<ChatMessage>> loadMessages(String sessionId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/spark_messages';
      final queryParams = {
        'session_id': 'eq.$sessionId',
        'select': '*',
        'order': 'created_at.asc',
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
        final messages =
            data.map((json) => ChatMessage.fromJson(json)).toList();
        _messagesController.add(messages);
        return messages;
      }

      return [];
    } catch (e) {
      debugPrint('❌ Error loading messages: $e');
      return [];
    }
  }

  /// Get session details
  static Future<SparkSession?> getSession(String sessionId) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/spark_sessions';
      final queryParams = {
        'id': 'eq.$sessionId',
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
        if (data.isNotEmpty) {
          final session = SparkSession.fromJson(data.first);
          _sessionController.add(session);
          return session;
        }
      }

      return null;
    } catch (e) {
      debugPrint('❌ Error getting session: $e');
      return null;
    }
  }

  /// End chat session
  static Future<void> endChat(String sessionId, String reason) async {
    try {
      final url = '${AppConfig.supabaseUrl}/rest/v1/spark_sessions';
      final queryParams = {'id': 'eq.$sessionId'};
      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      await http.patch(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'is_active': false,
          'ended_reason': reason,
        }),
      );

      debugPrint('✅ Chat ended: $sessionId');
    } catch (e) {
      debugPrint('❌ Error ending chat: $e');
    }
  }

  /// Dispose resources
  static void dispose() {
    leaveChat();
    _messagesController.close();
    _sessionController.close();
  }
}
