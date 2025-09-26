// lib/services/ping_realtime_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ping_data.dart';

/// Service for real-time ping notifications using Supabase Realtime
class PingRealtimeService {
  static RealtimeChannel? _pingsChannel;
  static String? _currentDeviceId;
  static Timer? _reconnectTimer;
  static int _reconnectAttempts = 0;
  
  // Stream controller for incoming pings
  static final _incomingPingsController = StreamController<IncomingPing>.broadcast();
  static Stream<IncomingPing> get incomingPingsStream => _incomingPingsController.stream;
  
  // Track processed pings to avoid duplicates
  static final Set<String> _processedPingIds = {};
  
  /// Initialize Realtime subscription for pings
  static void initialize(String deviceId) {
    if (_currentDeviceId == deviceId && _pingsChannel != null) {
      debugPrint('🔄 Realtime already initialized for device: $deviceId');
      return;
    }
    
    _currentDeviceId = deviceId;
    _processedPingIds.clear();
    _reconnectAttempts = 0;
    
    debugPrint('🚀 Initializing Realtime for pings, device: $deviceId');
    
    final supabase = Supabase.instance.client;
    
    // Unsubscribe from old channel if exists
    if (_pingsChannel != null) {
      _pingsChannel!.unsubscribe();
      _pingsChannel = null;
    }
    
    // Create new channel for pings
    _pingsChannel = supabase
        .channel('pings_for_$deviceId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'pings',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'to_device_id',
            value: deviceId,
          ),
          callback: (payload) {
            debugPrint('🔔 New ping received via Realtime!');
            _handleNewPing(payload.newRecord);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'pings',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'to_device_id',
            value: deviceId,
          ),
          callback: (payload) {
            debugPrint('📝 Ping updated via Realtime');
            // Handle ping status updates (e.g., expired, rejected)
            final status = payload.newRecord['status'];
            if (status == 'expired' || status == 'rejected' || status == 'accepted') {
              final pingId = payload.newRecord['id'];
              _processedPingIds.add(pingId);
              debugPrint('⏹️ Ping $pingId marked as $status');
            }
          },
        )
        .subscribe((status, [error]) {
          if (status == RealtimeSubscribeStatus.subscribed) {
            debugPrint('✅ Successfully subscribed to pings Realtime channel');
            _reconnectAttempts = 0;
            _cancelReconnectTimer();
          } else if (status == RealtimeSubscribeStatus.closed || 
                     status == RealtimeSubscribeStatus.channelError) {
            debugPrint('❌ Realtime subscription error/closed: $error');
            _scheduleReconnect();
          }
        });
  }
  
  /// Handle new ping from Realtime
  static void _handleNewPing(Map<String, dynamic> pingData) {
    try {
      final pingId = pingData['id'] as String;
      
      // Check if already processed
      if (_processedPingIds.contains(pingId)) {
        debugPrint('⏭️ Ping already processed: $pingId');
        return;
      }
      
      // Check if not expired
      final expiresAt = DateTime.parse(pingData['expires_at']);
      if (DateTime.now().isAfter(expiresAt)) {
        debugPrint('⏰ Ping already expired: $pingId');
        _processedPingIds.add(pingId);
        return;
      }
      
      // Check status
      final status = pingData['status'] as String;
      if (status != 'pending') {
        debugPrint('⏭️ Ping not pending: $status');
        _processedPingIds.add(pingId);
        return;
      }
      
      // Create IncomingPing object
      final incomingPing = IncomingPing.fromJson(pingData);
      
      // Mark as processed
      _processedPingIds.add(pingId);
      
      // Emit to stream
      _incomingPingsController.add(incomingPing);
      
      debugPrint('✅ New ping emitted to stream: $pingId');
      debugPrint('   From: ${incomingPing.fromDeviceId}');
      debugPrint('   Distance: ${incomingPing.distanceText}');
      debugPrint('   Expires in: ${incomingPing.remainingSeconds}s');
      
    } catch (e) {
      debugPrint('❌ Error processing ping: $e');
    }
  }
  
  /// Schedule reconnection attempt
  static void _scheduleReconnect() {
    _cancelReconnectTimer();
    
    if (_reconnectAttempts >= 5) {
      debugPrint('❌ Max reconnection attempts reached');
      return;
    }
    
    _reconnectAttempts++;
    final delay = Duration(seconds: _reconnectAttempts * 5); // Exponential backoff
    
    debugPrint('🔄 Scheduling reconnect attempt $_reconnectAttempts in ${delay.inSeconds}s');
    
    _reconnectTimer = Timer(delay, () {
      if (_currentDeviceId != null) {
        debugPrint('🔄 Attempting to reconnect Realtime...');
        initialize(_currentDeviceId!);
      }
    });
  }
  
  /// Cancel reconnect timer
  static void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }
  
  /// Clean up old processed pings (keep last 100)
  static void cleanupProcessedPings() {
    if (_processedPingIds.length > 100) {
      final toRemove = _processedPingIds.length - 100;
      _processedPingIds.take(toRemove).forEach(_processedPingIds.remove);
      debugPrint('🧹 Cleaned up $toRemove old ping IDs');
    }
  }
  
  /// Check if ping was already processed
  static bool isPingProcessed(String pingId) {
    return _processedPingIds.contains(pingId);
  }
  
  /// Manually mark ping as processed
  static void markPingAsProcessed(String pingId) {
    _processedPingIds.add(pingId);
  }
  
  /// Dispose and clean up
  static void dispose() {
    debugPrint('👋 Disposing PingRealtimeService');
    _cancelReconnectTimer();
    _pingsChannel?.unsubscribe();
    _pingsChannel = null;
    _incomingPingsController.close();
    _processedPingIds.clear();
    _currentDeviceId = null;
  }
}