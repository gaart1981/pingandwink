// lib/models/spark_session.dart

/// Spark session model for chat
class SparkSession {
  final String id;
  final String pingId;
  final String device1;
  final String device2;
  final String alias1;
  final String alias2;
  final DateTime startedAt;
  final DateTime expiresAt;
  final int extendedCount;
  final List<String> extendRequestedBy;
  final bool isActive;
  final String? endedReason;

  SparkSession({
    required this.id,
    required this.pingId,
    required this.device1,
    required this.device2,
    required this.alias1,
    required this.alias2,
    required this.startedAt,
    required this.expiresAt,
    required this.extendedCount,
    required this.extendRequestedBy,
    required this.isActive,
    this.endedReason,
  });

  factory SparkSession.fromJson(Map<String, dynamic> json) {
    return SparkSession(
      id: json['id'] ?? '',
      pingId: json['ping_id'] ?? '',
      device1: json['device_1'] ?? '',
      device2: json['device_2'] ?? '',
      alias1: json['alias_1'] ?? 'Sparker1', // Default value if null
      alias2: json['alias_2'] ?? 'Sparker2', // Default value if null
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : DateTime.now(),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : DateTime.now().add(const Duration(minutes: 3)),
      extendedCount: json['extended_count'] ?? 0,
      extendRequestedBy: json['extend_requested_by'] != null
          ? List<String>.from(json['extend_requested_by'])
          : [],
      isActive: json['is_active'] ?? true,
      endedReason: json['ended_reason'],
    );
  }

  String getMyAlias(String myDeviceId) {
    return myDeviceId == device1 ? alias1 : alias2;
  }

  String getPartnerAlias(String myDeviceId) {
    return myDeviceId == device1 ? alias2 : alias1;
  }

  String getPartnerDevice(String myDeviceId) {
    return myDeviceId == device1 ? device2 : device1;
  }

  bool canExtend() => extendedCount < 2;

  bool hasRequestedExtend(String deviceId) {
    return extendRequestedBy.contains(deviceId);
  }

  bool get bothRequestedExtend {
    return extendRequestedBy.length == 2;
  }

  int get remainingSeconds {
    final now = DateTime.now();
    final remaining = expiresAt.difference(now).inSeconds;
    return remaining > 0 ? remaining : 0;
  }

  bool get isExpired => remainingSeconds == 0;
}
