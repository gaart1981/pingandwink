// lib/models/chat_message.dart

/// Chat message model
class ChatMessage {
  final String id;
  final String sessionId;
  final String senderDevice;
  final String message;
  final DateTime createdAt;
  
  ChatMessage({
    required this.id,
    required this.sessionId,
    required this.senderDevice,
    required this.message,
    required this.createdAt,
  });
  
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      sessionId: json['session_id'],
      senderDevice: json['sender_device'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  bool isOwn(String myDeviceId) => senderDevice == myDeviceId;
  
  String getTimeAgo() {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    
    if (diff.inSeconds < 60) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    return '${diff.inHours}h';
  }
}