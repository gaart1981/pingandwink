// lib/models/ping_data.dart

/// Data model for ping
class PingData {
  final String id;
  final String fromDeviceId;
  final String toMoodId;
  final String toDeviceId;
  final int? fromEmotion;
  final int? distanceMeters;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String status;

  PingData({
    required this.id,
    required this.fromDeviceId,
    required this.toMoodId,
    required this.toDeviceId,
    this.fromEmotion,
    this.distanceMeters,
    required this.createdAt,
    required this.expiresAt,
    required this.status,
  });

  factory PingData.fromJson(Map<String, dynamic> json) {
    return PingData(
      id: json['id'],
      fromDeviceId: json['from_device_id'],
      toMoodId: json['to_mood_id'],
      toDeviceId: json['to_device_id'],
      fromEmotion: json['from_emotion'],
      distanceMeters: json['distance_meters'],
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: DateTime.parse(json['expires_at']),
      status: json['status'],
    );
  }

  int get remainingSeconds {
    final now = DateTime.now();
    final remaining = expiresAt.difference(now).inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  bool get isExpired => remainingSeconds == 0;

  String get distanceText {
    if (distanceMeters == null) return 'nearby';
    if (distanceMeters! < 50) return 'very close';
    if (distanceMeters! < 100) return '${distanceMeters}m';
    if (distanceMeters! < 1000)
      return '${(distanceMeters! / 10).round() * 10}m';
    return '${(distanceMeters! / 1000).toStringAsFixed(1)}km';
  }
}

/// Incoming ping model for notifications
class IncomingPing {
  final String pingId;
  final String fromDeviceId;
  final int? fromEmotion;
  final double? fromLat;
  final double? fromLon;
  final int? distance;
  final DateTime expiresAt;

  IncomingPing({
    required this.pingId,
    required this.fromDeviceId,
    this.fromEmotion,
    this.fromLat,
    this.fromLon,
    this.distance,
    required this.expiresAt,
  });

  factory IncomingPing.fromJson(Map<String, dynamic> json) {
    return IncomingPing(
      pingId: json['id'] ?? json['ping_id'],
      fromDeviceId: json['from_device_id'],
      fromEmotion: json['from_emotion'],
      fromLat: json['from_lat']?.toDouble(),
      fromLon: json['from_lon']?.toDouble(),
      distance: json['distance_meters'],
      expiresAt: DateTime.parse(json['expires_at']),
    );
  }

  int get remainingSeconds {
    final now = DateTime.now();
    final remaining = expiresAt.difference(now).inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  bool get isExpired => remainingSeconds == 0;

  String get distanceText {
    if (distance == null) return 'nearby';
    if (distance! < 50) return 'very close';
    if (distance! < 100) return '${distance}m';
    if (distance! < 500) return '${(distance! / 10).round() * 10}m';
    return '${(distance! / 1000).toStringAsFixed(1)}km';
  }
}
