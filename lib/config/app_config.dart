// lib/config/app_config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration class
/// Provides centralized access to environment variables
class AppConfig {
  // Supabase configuration
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  
  // Mapbox configuration
  static String get mapboxToken => dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
  static String get mapboxStyleUrl => dotenv.env['MAPBOX_STYLE_URL'] ?? '';
  
  // Edge functions URLs
  static String get submitMoodUrl => dotenv.env['EDGE_FUNCTION_SUBMIT_MOOD'] ?? '';
  static String get getMapUrl => dotenv.env['EDGE_FUNCTION_GET_MAP'] ?? '';
  
  // App settings
  static const int minIntervalMinutes = 15;
  static const int maxMoodsPerDay = 50;
  
  // Map settings
  static const double minMapZoom = 9.0;  // city view 9
  static const double maxMapZoom = 16.0;  // street view
  static const double defaultMapZoom = 14.0;  // ~2km view
  static const double focusedMapZoom = 12.0;  // view when adding emotion
  
  // Default location (Atlantic ocean NY)
  static const double defaultLatitude = 40.000000;
  static const double defaultLongitude = -72.000000;

  // ============ POLLING CONFIGURATION ============
  // Change these values to adjust all timers at once
  // Main map polling interval (seconds)
  static const int mapPollingInterval = 8;
  // Ping check polling interval (should match map polling)
  static const int pingPollingInterval = 8;
  // Delay offset for ping polling to avoid peak load (seconds)
  // Should be roughly half of polling interval
  static const int pingPollingDelayOffset = 4;
  // ============ END POLLING CONFIG ============
  
  // Animation durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration animationDuration = Duration(milliseconds: 400);
  static const Duration refreshInterval = Duration(seconds: 30);
  static const Duration statsInterval = Duration(seconds: 10);
}