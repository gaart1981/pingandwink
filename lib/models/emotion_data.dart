// lib/models/emotion_data.dart

/// Simplified model for emotion data - Stage 1
class EmotionData {
  final String id;
  final int emotion;
  final double lat;
  final double lon;
  final String deviceId;
  final DateTime createdAt;
  final DateTime expiresAt;
  final double opacity; // Always 1.0 for Stage 1
  final bool isOwn;

  const EmotionData({
    required this.id,
    required this.emotion,
    required this.lat,
    required this.lon,
    required this.deviceId,
    required this.createdAt,
    required this.expiresAt,
    this.opacity = 1.0, // Always full opacity
    required this.isOwn,
  });

  /// Check if emotion is still valid (not expired)
  bool get isValid {
    return DateTime.now().isBefore(expiresAt);
  }

  /// Get remaining time in minutes
  int get remainingMinutes {
    if (!isValid) return 0;
    return expiresAt.difference(DateTime.now()).inMinutes;
  }

  /// Get age in minutes
  int get ageInMinutes {
    return DateTime.now().difference(createdAt).inMinutes;
  }

  /// Create from JSON
  factory EmotionData.fromJson(
      Map<String, dynamic> json, String? currentDeviceId) {
    return EmotionData(
      id: json['id'].toString(),
      emotion: json['emotion'] as int,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      deviceId: json['device_id'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: DateTime.parse(json['expires_at']),
      opacity: 1.0, // Always full opacity in Stage 1
      isOwn: json['is_own'] ??
          (currentDeviceId != null && json['device_id'] == currentDeviceId),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emotion': emotion,
      'lat': lat,
      'lon': lon,
      'device_id': deviceId,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      'opacity': opacity,
      'is_own': isOwn,
    };
  }
}
