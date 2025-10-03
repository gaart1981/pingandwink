// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';
import 'dart:async'; // Добавлен импорт Timer

import 'config/app_config.dart';
import 'config/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_container.dart';
import 'services/notification_service.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';
import 'l10n/app_localizations.dart';
import 'services/onesignal_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
    debugPrint('✅ Environment variables loaded successfully');
  } catch (e) {
    debugPrint('⚠️ Warning: .env file not found, using defaults');
  }

  // Initialize storage first
  await StorageService.init();
  final deviceId = await StorageService.getDeviceId();
  debugPrint('📱 Device ID: $deviceId');

  // Initialize OneSignal push notification service
  try {
    debugPrint('🔔 Initializing OneSignal...');

    final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'] ?? '';

    if (oneSignalAppId.isEmpty) {
      debugPrint('⌛ OneSignal App ID not found in .env file');
      throw Exception('ONESIGNAL_APP_ID not configured');
    }

    // Set appropriate log level
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    // Initialize OneSignal
    OneSignal.initialize(oneSignalAppId);

    // Setup observer with retry logic
    int retryCount = 0;
    const maxRetries = 3;

    OneSignal.User.pushSubscription.addObserver((state) async {
      debugPrint('🔔 ============= Push Subscription Changed =============');
      debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
      debugPrint('   Player ID: ${state.current.id}');
      debugPrint('   Token: ${state.current.token}');
      debugPrint('   OptedIn: ${state.current.optedIn}');
      debugPrint('🔔 ===================================================');

      if (state.current.id != null && state.current.id!.isNotEmpty) {
        bool saved = false;
        retryCount = 0; // Reset retry count for new attempt

        while (!saved && retryCount < maxRetries) {
          try {
            await ApiService.savePushToken(
              deviceId: deviceId,
              playerId: state.current.id!,
            );
            saved = true;
            debugPrint(
                '✅ Push token saved to database (attempt ${retryCount + 1})');
          } catch (e) {
            retryCount++;
            debugPrint('⌛ Error saving push token (attempt $retryCount): $e');
            if (retryCount < maxRetries) {
              await Future.delayed(Duration(seconds: 2 * retryCount));
            }
          }
        }
      } else {
        debugPrint('⚠️ No player ID available yet');
      }
    });

    // iOS specific: Multiple retry attempts
    if (Platform.isIOS) {
      // First attempt after 15 seconds
      Timer(const Duration(seconds: 15), () async {
        await _tryToSaveIOSToken(deviceId, 'First attempt (15s)');
      });

      // Second attempt after 30 seconds
      Timer(const Duration(seconds: 30), () async {
        await _tryToSaveIOSToken(deviceId, 'Second attempt (30s)');
      });

      // Final attempt after 45 seconds
      Timer(const Duration(seconds: 45), () async {
        await _tryToSaveIOSToken(deviceId, 'Final attempt (45s)');
      });
    }

    // Handle notification clicks
    OneSignal.Notifications.addClickListener((notification) async {
      debugPrint(
          '🔔 Notification clicked: ${notification.notification.additionalData}');

      final data = notification.notification.additionalData;
      if (data != null && data['type'] == 'ping' && data['ping_id'] != null) {
        final pingId = data['ping_id'] as String;
        debugPrint('💾 Saving ping_id from notification: $pingId');
        await StorageService.savePendingPing(pingId);
      }
    });

    debugPrint('✅ OneSignal initialized successfully');
  } catch (e) {
    debugPrint('⌛ Error initializing OneSignal: $e');
  }

  // Initialize Mapbox
  String mapboxToken = AppConfig.mapboxToken;
  if (mapboxToken.isEmpty) {
    debugPrint('❌ CRITICAL ERROR: Mapbox token not found!');
    debugPrint('Please create .env file with your credentials');
    debugPrint('Copy .env.example to .env and fill with your values');
    throw Exception('Missing required configuration. Please check .env file');
  }
  MapboxOptions.setAccessToken(mapboxToken);

  // Initialize Supabase
  final supabaseUrl = AppConfig.supabaseUrl;
  final supabaseAnonKey = AppConfig.supabaseAnonKey;

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    debugPrint('❌ CRITICAL ERROR: Supabase credentials not found!');
    debugPrint('Please create .env file with your credentials');
    debugPrint('Copy .env.example to .env and fill with your values');
    throw Exception('Missing required configuration. Please check .env file');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // Initialize notifications
  await NotificationService.init();
  debugPrint('🔔 Notifications service initialized');

  // Check if onboarding was completed
  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  debugPrint('📱 Onboarding complete: $onboardingComplete');

  // Check and refresh OneSignal token if needed
  if (Platform.isAndroid) {
    await OneSignalService.checkAndRefresh();
  }

  runApp(MoodMapApp(showOnboarding: !onboardingComplete));
}

// Helper function for iOS token save attempts
Future<void> _tryToSaveIOSToken(String deviceId, String attemptName) async {
  final playerId = OneSignal.User.pushSubscription.id;
  final optedIn = OneSignal.User.pushSubscription.optedIn;

  debugPrint('🔔 ========= iOS CHECK: $attemptName =========');
  debugPrint('   Player ID exists: ${playerId != null}');
  debugPrint('   Player ID: $playerId');
  debugPrint('   Opted In: $optedIn');

  if (playerId != null && playerId.isNotEmpty && optedIn == true) {
    debugPrint('💾 Saving iOS token...');

    try {
      await ApiService.savePushToken(
        deviceId: deviceId,
        playerId: playerId,
      );
      debugPrint('✅ iOS token saved successfully');

      // Save to shared preferences to avoid duplicate saves
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_saved_player_id', playerId);
      await prefs.setString(
          'last_saved_player_id_time', DateTime.now().toIso8601String());
    } catch (e) {
      debugPrint('⌛ Failed to save: $e');
    }
  }
}

/// Main application widget
class MoodMapApp extends StatelessWidget {
  final bool showOnboarding;

  const MoodMapApp({
    super.key,
    required this.showOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ping&Wink',
      theme: AppTheme.getTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English (основной)
        Locale('es', '419'), // Spanish (Latin America)
        Locale('ru'), // Russian
        Locale('fr'), // French
        Locale('de'), // German
        Locale('pt', 'BR'), // Portuguese (Brazil)
        Locale('ko'), // Korean
        Locale('ar'), // Arabic
        Locale('tr'), // Turkish
        Locale('id'), // Indonesian
        Locale('hi'), // Hindi
      ],
      home:
          showOnboarding ? const OnboardingScreen() : const SplashToMainFlow(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Flow from splash to main container
class SplashToMainFlow extends StatefulWidget {
  const SplashToMainFlow({super.key});

  @override
  State<SplashToMainFlow> createState() => _SplashToMainFlowState();
}

class _SplashToMainFlowState extends State<SplashToMainFlow> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  Future<void> _navigateToMain() async {
    // Show splash
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainContainer(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
