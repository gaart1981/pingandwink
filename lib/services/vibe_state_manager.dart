// lib/services/vibe_state_manager.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../config/emotions.dart';

/// Possible states for a vibe
enum VibeStatus {
  available, // Available for ping
  ownActive, // User's own active vibe
  sendingPing, // User is sending ping to this vibe
  receivingPing, // User is receiving ping from this vibe
  inSpark, // In active Spark chat
  expired, // Vibe has expired
}

/// Complete state information for a vibe
class VibeState {
  final String id;
  final String deviceId;
  final VibeStatus status;
  final Color color;
  final DateTime? expiresAt;
  final Map<String, dynamic> metadata;

  VibeState({
    required this.id,
    required this.deviceId,
    required this.status,
    required this.color,
    this.expiresAt,
    this.metadata = const {},
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  VibeState copyWith({
    VibeStatus? status,
    Color? color,
    DateTime? expiresAt,
    Map<String, dynamic>? metadata,
  }) {
    return VibeState(
      id: id,
      deviceId: deviceId,
      status: status ?? this.status,
      color: color ?? this.color,
      expiresAt: expiresAt ?? this.expiresAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Centralized state manager for all vibes
class VibeStateManager {
  // Singleton pattern
  static final VibeStateManager _instance = VibeStateManager._internal();
  factory VibeStateManager() => _instance;
  VibeStateManager._internal();

  // Separate storage for global and local states
  // Global states come from server (other users' states)
  final Map<String, VibeState> _globalStatesByMoodId = {};
  final Map<String, VibeState> _globalStatesByDeviceId = {};

  // Local states are my own actions
  final Map<String, VibeState> _localStatesByMoodId = {};
  final Map<String, VibeState> _localStatesByDeviceId = {};

  /// Sync global states from server (complete replacement)
  void syncGlobalStates({
    required List<dynamic> activeSparks,
    required List<dynamic> activePings,
    required String myDeviceId,
  }) {
    // Clear all global states for fresh sync
    _globalStatesByMoodId.clear();
    _globalStatesByDeviceId.clear();

    // Process Spark sessions
    for (var spark in activeSparks) {
      final device1 = spark['device_1'] as String;
      final device2 = spark['device_2'] as String;
      final expiresAt = DateTime.parse(spark['expires_at']);

      // Add both participants as busy (gray)
      _globalStatesByDeviceId[device1] = VibeState(
        id: device1,
        deviceId: device1,
        status: VibeStatus.inSpark,
        color: const Color(0xFF808080), // Gray color
        expiresAt: expiresAt,
      );

      _globalStatesByDeviceId[device2] = VibeState(
        id: device2,
        deviceId: device2,
        status: VibeStatus.inSpark,
        color: const Color(0xFF808080), // Gray color
        expiresAt: expiresAt,
      );

      debugPrint(
          'GLOBAL: Devices $device1 and $device2 in Spark until $expiresAt');
    }

    // Process active pings
    for (var ping in activePings) {
      final toMoodId = ping['to_mood_id'] as String;
      final toDeviceId = ping['to_device_id'] as String;
      final fromDeviceId = ping['from_device_id'] as String;
      final expiresAt = DateTime.parse(ping['expires_at']);

      // Skip my own outgoing pings (they are managed locally)
      if (fromDeviceId == myDeviceId) {
        debugPrint('SKIP: My own ping to mood $toMoodId');
        continue;
      }

      // Save state BY MOOD_ID (important - ping targets specific mood)
      _globalStatesByMoodId[toMoodId] = VibeState(
        id: toMoodId,
        deviceId: toDeviceId,
        status: VibeStatus.receivingPing,
        color: Colors.white, // White for receiving ping
        expiresAt: expiresAt,
      );

      debugPrint('GLOBAL: Mood $toMoodId receiving ping until $expiresAt');
    }

    debugPrint(
        'Sync complete: ${_globalStatesByMoodId.length} moods busy, ${_globalStatesByDeviceId.length} devices in Spark');
  }

  /// Set local state (my own actions)
  void setLocalState({
    String? moodId,
    String? deviceId,
    required VibeStatus status,
    required Color color,
    Duration? duration,
  }) {
    final state = VibeState(
      id: moodId ?? deviceId ?? '',
      deviceId: deviceId ?? '',
      status: status,
      color: color,
      expiresAt: duration != null ? DateTime.now().add(duration) : null,
    );

    // Store by moodId if provided
    if (moodId != null) {
      _localStatesByMoodId[moodId] = state;
      debugPrint('LOCAL: Set mood $moodId to $status (color: $color)');
    }

    // Store by deviceId if provided
    if (deviceId != null) {
      _localStatesByDeviceId[deviceId] = state;
      debugPrint('LOCAL: Set device $deviceId to $status (color: $color)');
    }
  }

  /// Clear specific local state
  void clearLocalState({String? moodId, String? deviceId}) {
    if (moodId != null) {
      _localStatesByMoodId.remove(moodId);
      debugPrint('LOCAL: Cleared mood $moodId state');
    }
    if (deviceId != null) {
      _localStatesByDeviceId.remove(deviceId);
      debugPrint('LOCAL: Cleared device $deviceId state');
    }
  }

  /// Clear all local states of specific type
  void clearAllLocalStatesOfType(VibeStatus type) {
    _localStatesByMoodId.removeWhere((_, state) => state.status == type);
    _localStatesByDeviceId.removeWhere((_, state) => state.status == type);
    debugPrint('LOCAL: Cleared all states of type $type');
  }

  /// Get final color for vibe with priority system
  Color getVibeColor(String moodId, String deviceId, int emotionIndex) {
    // Priority 1: My local states by moodId
    if (_localStatesByMoodId.containsKey(moodId)) {
      final color = _localStatesByMoodId[moodId]!.color;
      debugPrint('COLOR: Mood $moodId = $color (local by mood)');
      return color;
    }

    // Priority 2: My local states by deviceId
    if (_localStatesByDeviceId.containsKey(deviceId)) {
      final color = _localStatesByDeviceId[deviceId]!.color;
      debugPrint('COLOR: Device $deviceId = $color (local by device)');
      return color;
    }

    // Priority 3: Global states by moodId
    if (_globalStatesByMoodId.containsKey(moodId)) {
      final color = _globalStatesByMoodId[moodId]!.color;
      debugPrint('COLOR: Mood $moodId = $color (global by mood)');
      return color;
    }

    // Priority 4: Global states by deviceId
    if (_globalStatesByDeviceId.containsKey(deviceId)) {
      final color = _globalStatesByDeviceId[deviceId]!.color;
      debugPrint('COLOR: Device $deviceId = $color (global by device)');
      return color;
    }

    // Priority 5: Original emotion color
    final color = Emotions.getEmotion(emotionIndex).color;
    return color;
  }

  /// Check if vibe is available for ping
  bool isAvailableForPing(String moodId, String deviceId) {
    // Check all possible states
    final hasLocalState = _localStatesByMoodId.containsKey(moodId) ||
        _localStatesByDeviceId.containsKey(deviceId);
    final hasGlobalState = _globalStatesByMoodId.containsKey(moodId) ||
        _globalStatesByDeviceId.containsKey(deviceId);

    // Available if no states found
    final available = !hasLocalState && !hasGlobalState;

    if (!available) {
      debugPrint(
          'UNAVAILABLE: mood=$moodId device=$deviceId (local=$hasLocalState global=$hasGlobalState)');
    }

    return available;
  }

  /// Get status of a vibe
  VibeStatus? getStatus(String moodId, String deviceId) {
    // Check by priority
    if (_localStatesByMoodId.containsKey(moodId)) {
      return _localStatesByMoodId[moodId]!.status;
    }
    if (_localStatesByDeviceId.containsKey(deviceId)) {
      return _localStatesByDeviceId[deviceId]!.status;
    }
    if (_globalStatesByMoodId.containsKey(moodId)) {
      return _globalStatesByMoodId[moodId]!.status;
    }
    if (_globalStatesByDeviceId.containsKey(deviceId)) {
      return _globalStatesByDeviceId[deviceId]!.status;
    }
    return null;
  }

  /// Clear all states (for logout/reset)
  void clearAll() {
    _globalStatesByMoodId.clear();
    _globalStatesByDeviceId.clear();
    _localStatesByMoodId.clear();
    _localStatesByDeviceId.clear();
    debugPrint('Cleared all vibe states');
  }

  /// Debug: print current state
  void printDebugInfo() {
    debugPrint('=== VIBE STATE MANAGER ===');
    debugPrint('Global states by mood: ${_globalStatesByMoodId.keys}');
    debugPrint('Global states by device: ${_globalStatesByDeviceId.keys}');
    debugPrint('Local states by mood: ${_localStatesByMoodId.keys}');
    debugPrint('Local states by device: ${_localStatesByDeviceId.keys}');
    debugPrint('========================');
  }

  /// Remove all states for banned user (called after ban)
  void removeBannedUserStates(String bannedDeviceId) {
    // Remove from global states
    _globalStatesByDeviceId.remove(bannedDeviceId);

    // Remove moods associated with this device
    _globalStatesByMoodId
        .removeWhere((moodId, state) => state.deviceId == bannedDeviceId);

    // Remove from local states (if any)
    _localStatesByDeviceId.remove(bannedDeviceId);
    _localStatesByMoodId
        .removeWhere((moodId, state) => state.deviceId == bannedDeviceId);

    debugPrint('BANNED: Removed all states for device $bannedDeviceId');
  }
}
