// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';

import 'config/app_config.dart';
import 'config/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_container.dart';
import 'services/notification_service.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';
import 'l10n/app_localizations.dart';

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

  // OneSignal платформо-зависимая инициализация
  try {
    final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'] ?? '';

    if (oneSignalAppId.isEmpty) {
      debugPrint('❌ OneSignal App ID not found in .env file');
      throw Exception('ONESIGNAL_APP_ID not configured');
    }

    // Set log level for debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    if (Platform.isAndroid) {
      // Android: инициализируем сразу (FCM требует немедленной инициализации)
      debugPrint('🤖 Android detected - initializing OneSignal immediately');
      OneSignal.initialize(oneSignalAppId);
      _setupOneSignalObserver(deviceId);
      debugPrint('✅ OneSignal initialized for Android');
    } else if (Platform.isIOS) {
      // iOS: откладываем инициализацию для подготовки APNs delegate
      debugPrint('🍎 iOS detected - delaying OneSignal initialization');
      debugPrint('🍎 Waiting 3 seconds for UI to be ready...');

      Future.delayed(const Duration(seconds: 3), () {
        debugPrint('🍎 iOS: Initializing OneSignal after 3 second delay');
        OneSignal.initialize(oneSignalAppId);
        _setupOneSignalObserver(deviceId);
        debugPrint('✅ OneSignal initialized for iOS');
      });
    }

    // НЕ запрашиваем разрешения здесь!
    debugPrint('ℹ️ Permissions will be requested during onboarding page 4');
  } catch (e) {
    debugPrint('❌ Error with OneSignal setup: $e');
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

  // Initialize notifications service (without requesting permissions)
  await NotificationService.init();
  debugPrint('🔔 Notifications service initialized');

  // Check if onboarding was completed
  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  debugPrint('📱 Onboarding complete: $onboardingComplete');

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

  runApp(MoodMapApp(showOnboarding: !onboardingComplete));
}

// Вспомогательная функция для настройки OneSignal observer
void _setupOneSignalObserver(String deviceId) {
  OneSignal.User.pushSubscription.addObserver((state) async {
    debugPrint('');
    debugPrint('🔔 ═══════════════════════════════════');
    debugPrint('🔔 PUSH SUBSCRIPTION STATE CHANGED');
    debugPrint('🔔 ═══════════════════════════════════');
    debugPrint('   Platform: ${Platform.isIOS ? "iOS" : "Android"}');
    debugPrint('   Previous Player ID: ${state.previous.id ?? "null"}');
    debugPrint('   Current Player ID: ${state.current.id ?? "null"}');
    debugPrint('   Previous Token: ${state.previous.token ?? "null"}');
    debugPrint('   Current Token: ${state.current.token ?? "null"}');
    debugPrint('   Opted In: ${state.current.optedIn}');
    debugPrint('🔔 ═══════════════════════════════════');
    debugPrint('');

    final playerId = state.current.id;

    if (playerId != null && playerId.trim().isNotEmpty) {
      debugPrint('✅ Valid Player ID received: $playerId');
      debugPrint('💾 Saving token to database...');

      bool saved = false;
      int retryCount = 0;
      const maxRetries = 3;

      while (!saved && retryCount < maxRetries) {
        try {
          await ApiService.savePushToken(
            deviceId: deviceId,
            playerId: playerId,
          );
          saved = true;
          debugPrint(
              '✅ Push token saved to database (attempt ${retryCount + 1})');
        } catch (e) {
          retryCount++;
          debugPrint('❌ Error saving push token (attempt $retryCount): $e');
          if (retryCount < maxRetries) {
            await Future.delayed(Duration(seconds: 2 * retryCount));
          }
        }
      }
    } else {
      debugPrint('⚠️ Player ID is null or empty, cannot save');
    }
  });
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
