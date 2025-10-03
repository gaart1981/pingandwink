// lib/screens/main_container.dart
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'map_screen.dart';
import 'history_screen.dart';
import 'trends_screen.dart';
import 'settings_screen.dart';
import '../widgets/bottom_navigation.dart';
import '../l10n/app_localizations.dart';
import '../services/onesignal_service.dart';
import '../services/onesignal_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// Main container for Stage 1 - simplified
class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _currentIndex = 0;

  // Key for MapScreen to access its methods
  final GlobalKey<MapScreenState> _mapScreenKey = GlobalKey<MapScreenState>();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Add lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    _screens = [
      MapScreen(
        key: _mapScreenKey,
        isInContainer: true,
      ),
      const HistoryScreen(),
      const TrendsScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  void dispose() {
    // Remove lifecycle observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check OneSignal status when app resumes
    if (state == AppLifecycleState.resumed) {
      debugPrint('🔄 App resumed - checking OneSignal status');
      
      // Проверяем статус OneSignal для обеих платформ
      OneSignalService.diagnoseStatus();
      OneSignalService.checkOnResume();
      
      // Для iOS запускаем retry если нужно
      if (Platform.isIOS) {
        final playerId = OneSignal.User.pushSubscription.id;
        if (playerId == null) {
          debugPrint('🍎 iOS: Starting retry sequence on resume');
          OneSignalService.retryIOSRegistration();
        }
      }
    }
  }

  void _onNavigationTap(int index) {
    if (index == -1) {
      // Center button - show emotion selector
      if (_currentIndex == 0) {
        // If on map screen, show emotion selector
        _mapScreenKey.currentState?.showEmotionSelector();
      } else {
        // Navigate to map first
        setState(() {
          _currentIndex = 0;
        });
        // Show selector immediately after navigation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapScreenKey.currentState?.showEmotionSelector();
        });
      }
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main content - IndexedStack with Offstage for performance
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MoodMapBottomNav(
              currentIndex: _currentIndex,
              onTap: _onNavigationTap,
            ),
          ),
        ],
      ),
    );
  }
}

// Keeping the placeholder class for future use or as fallback
// You can remove it if you don't need it anymore
/// Placeholder for Trends screen (future feature)
class TrendsPlaceholder extends StatelessWidget {
  const TrendsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A0B2E),
            Colors.black,
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '📊',
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.trendsTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.trendsSubtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
