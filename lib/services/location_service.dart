// lib/services/location_service.dart
import 'dart:io' show Platform;
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import '../config/app_config.dart';
import 'storage_service.dart';

/// Service for handling device location
class LocationService {
  static Position? _lastPosition;

  /// Get current device position
  static Future<Position?> getCurrentLocation() async {
    try {
      print('🔍 Checking location services...');

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ Location services are disabled');
        return _getDefaultPosition();
      }

      print('🔍 Checking location permission...');
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        print('🔍 Requesting location permission...');
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        print('❌ Location permission permanently denied');
        return _getDefaultPosition();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        print('✅ Location permission granted, getting position...');

        try {
          // Try to get last known position first (faster)
          Position? lastPosition = await Geolocator.getLastKnownPosition();
          if (lastPosition != null) {
            print(
                '📍 Using last known position: ${lastPosition.latitude}, ${lastPosition.longitude}');
            _lastPosition = lastPosition;

            // Get current position in background for accuracy
            _updateCurrentPosition();
            return lastPosition;
          }

          // Get current position
          _lastPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy:
                Platform.isIOS ? LocationAccuracy.best : LocationAccuracy.high,
            timeLimit: const Duration(seconds: 15),
          );

          print(
              '📍 Got current position: ${_lastPosition!.latitude}, ${_lastPosition!.longitude}');
          return _lastPosition;
        } catch (e) {
          print('⚠️ Error getting position: $e');

          // Try with lower accuracy
          try {
            _lastPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.medium,
              timeLimit: const Duration(seconds: 5),
            );
            print('📍 Got position with lower accuracy');
            return _lastPosition;
          } catch (e2) {
            print('❌ Failed to get position: $e2');
            return _getDefaultPosition();
          }
        }
      } else {
        print('⚠️ Location permission not granted: $permission');
        return _getDefaultPosition();
      }
    } catch (e) {
      print('❌ Location error: $e');
      return _getDefaultPosition();
    }
  }

  /// NEW: Get location for vibe submission with soft mode support
  static Future<Map<String, double>?> getLocationForSubmission() async {
    // Get current position
    final position = await getCurrentLocation();
    if (position == null) return null;

    // Check if soft location is enabled
    final isSoftMode = await StorageService.isSoftLocationEnabled();

    if (isSoftMode) {
      // Apply random offset
      final offset = _generateRandomOffset(position.latitude);

      print('📍 Soft location enabled:');
      print('   Original: ${position.latitude}, ${position.longitude}');
      print(
          '   Offset: ${offset['latOffset']!.toStringAsFixed(6)}°, ${offset['lonOffset']!.toStringAsFixed(6)}°');

      final newLat = position.latitude + offset['latOffset']!;
      final newLon = position.longitude + offset['lonOffset']!;

      print('   Final: $newLat, $newLon');

      return {
        'lat': newLat,
        'lon': newLon,
      };
    } else {
      // Return exact location
      print('📍 Normal location mode - using exact coordinates');
      return {
        'lat': position.latitude,
        'lon': position.longitude,
      };
    }
  }

  /// Generate random offset for soft location with correct longitude adjustment
  static Map<String, double> _generateRandomOffset(double currentLatitude) {
    final random = Random();

    // Random distance between 80 and 120 meters
    final distanceMeters = 80 + random.nextDouble() * 40;

    // Random angle (0 to 360 degrees, converted to radians)
    final angleDegrees = random.nextDouble() * 360;
    final angleRadians = angleDegrees * (pi / 180);

    // Convert current latitude to radians for calculation
    final latRadians = currentLatitude * (pi / 180);

    // Calculate meters per degree
    // Latitude: 1 degree ≈ 111,111 meters (constant everywhere)
    const metersPerDegreeLat = 111111.0;

    // Longitude: 1 degree ≈ 111,111 * cos(latitude) meters
    final metersPerDegreeLon = 111111.0 * cos(latRadians);

    // Calculate offset in degrees
    // North-South component (latitude)
    final latOffset = (distanceMeters * cos(angleRadians)) / metersPerDegreeLat;

    // East-West component (longitude) - adjusted for latitude
    final lonOffset = (distanceMeters * sin(angleRadians)) / metersPerDegreeLon;

    print('🎲 Soft location offset:');
    print('   Distance: ${distanceMeters.toStringAsFixed(0)}m');
    print('   Angle: ${angleDegrees.toStringAsFixed(0)}°');
    print('   At latitude: ${currentLatitude.toStringAsFixed(4)}°');

    return {
      'latOffset': latOffset,
      'lonOffset': lonOffset,
      'distanceMeters': distanceMeters,
      'angleDegrees': angleDegrees,
    };
  }

  /// Update position in background
  static void _updateCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 30),
      );
      _lastPosition = position;
      print('📍 Updated position in background');
    } catch (e) {
      print('⚠️ Background position update failed: $e');
    }
  }

  /// Get default position (Paris)
  static Position _getDefaultPosition() {
    return Position(
      latitude: AppConfig.defaultLatitude,
      longitude: AppConfig.defaultLongitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  /// Get last known position
  static Position? get lastPosition => _lastPosition;

  /// Check if location is available
  static bool get hasLocation => _lastPosition != null;
}
