// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../config/theme.dart';
import '../services/notification_service.dart';
import '../l10n/app_localizations.dart';
import 'main_container.dart';
import 'legal/privacy_policy.dart';
import 'legal/terms_of_service.dart';
import 'birth_year_selection_screen.dart';
import 'dart:io' show Platform;
import 'dart:async';

/// Gen Z optimized onboarding for Ping&Wink
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _locationGranted = false;
  bool _notificationsGranted = false;

  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _glowController;

  // Animations
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  // Map animation
  late AnimationController _mapPingController;
  final List<_MapPing> _mapPings = [];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startMapPingAnimation();
    // Start animation for first slide
    Future.delayed(Duration(milliseconds: 100), () {
      _slideController.forward();
    });

    // Trigger haptic on start
    HapticFeedback.lightImpact();
  }

  void _initAnimations() {
    // Pulse animation for CTAs
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Slide animation for page transitions
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Scale animation for elements
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    ));

    // Glow animation
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    // Map ping animation controller
    _mapPingController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  void _startMapPingAnimation() {
    // Create random pings on the map
    final random = math.Random();
    for (int i = 0; i < 5; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        if (mounted) {
          setState(() {
            _mapPings.add(_MapPing(
              position: Offset(
                random.nextDouble() * 300 + 50,
                random.nextDouble() * 400 + 100,
              ),
              delay: Duration(milliseconds: random.nextInt(2000)),
              emoji: ['⚡', '🔥', '✨', '💫', '🎉'][random.nextInt(5)],
            ));
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _glowController.dispose();
    _mapPingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    HapticFeedback.selectionClick();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  // Determine if swiping is allowed
  ScrollPhysics _getPagePhysics() {
    // Block swipe on location screen (index 2)
    if (_currentPage == 2 && !_locationGranted) {
      return const NeverScrollableScrollPhysics();
    }
    // Block swipe on notifications screen (index 3)
    if (_currentPage == 3 && !_notificationsGranted) {
      return const NeverScrollableScrollPhysics();
    }
    // Block swipe on birth year screen (index 4)
    if (_currentPage == 4) {
      return const NeverScrollableScrollPhysics();
    }
    // Block swipe on legal screen (index 5)
    if (_currentPage == 5) {
      return const NeverScrollableScrollPhysics();
    }
    // Allow swipe on other screens
    return const BouncingScrollPhysics();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 1.5,
                    colors: [
                      AppTheme.primaryColor
                          .withOpacity(_glowAnimation.value * 0.15),
                      const Color(0xFF0A0015),
                      Colors.black,
                    ],
                  ),
                ),
              );
            },
          ),

          // Content
          PageView(
            controller: _pageController,
            physics: _getPagePhysics(), // Dynamic swipe blocking
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              _slideController.forward(from: 0);
              HapticFeedback.lightImpact();
            },
            children: [
              _buildHookPage(l10n),
              _buildValuePage(l10n),
              _buildLocationPage(l10n),
              _buildNotificationPage(l10n),
              _buildBirthYearPage(),
              _buildLegalPage(l10n),
            ],
          ),

          // Modern progress dots
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppTheme.primaryColor
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: _currentPage == index
                        ? [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHookPage(AppLocalizations l10n) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated map with pings
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  // Map visual
                  Center(
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  AppTheme.primaryColor.withOpacity(0.1),
                                  AppTheme.primaryColor.withOpacity(0.05),
                                  Colors.transparent,
                                ],
                              ),
                              border: Border.all(
                                color: AppTheme.primaryColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Animated pings
                  ..._mapPings.map((ping) => _AnimatedPing(ping: ping)),

                  // Center notification
                  Center(
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '⚡',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.onboardingMapNotification,
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Main title
            ShaderMask(
              shaderCallback: (bounds) {
                
                final expandedBounds = Rect.fromLTRB(
                  bounds.left,
                  bounds.top - 10, 
                  bounds.right,
                  bounds.bottom + 10, 
                );
                return LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(expandedBounds);
              },
              blendMode: BlendMode.srcIn,
              child: Text(
                l10n.onboardingTitlePingWink,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                  color: Colors.white,
                  height: 1.2, // Увеличиваем line height для большего пространства
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Subtitle
            Text(
              l10n.onboardingSubtitleSeeWhatsPoppin,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.6),
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 60),

            // CTA Button
            _buildCTAButton(
              l10n.onboardingButtonLetsGo,
              _nextPage,
              icon: Icons.arrow_forward_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuePage(AppLocalizations l10n) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Age verification badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.onboardingBadgeAge13Plus,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Value cards
            ...[
              _ValueCard(
                emoji: '⚡',
                title: l10n.onboardingValueTitleInstantSparks,
                subtitle: l10n.onboardingValueSubtitleConnect60Sec,
                color: AppTheme.primaryColor,
                delay: 0,
              ),
              _ValueCard(
                emoji: '📍',
                title: l10n.onboardingValueTitleHyperlocalVibes,
                subtitle: l10n.onboardingValueSubtitleOnly2kmRadius,
                color: const Color(0xFFFF9E6B),
                delay: 100,
              ),
              _ValueCard(
                emoji: '👻',
                title: l10n.onboardingValueTitleNoProfiles,
                subtitle: l10n.onboardingValueSubtitleJustPureMoments,
                color: AppTheme.secondaryColor,
                delay: 200,
              ),
            ],

            const SizedBox(height: 60),

            // CTA
            _buildCTAButton(
              l10n.onboardingButtonImReady,
              _nextPage,
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPage(AppLocalizations l10n) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated radar
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Radar circles
                  ...List.generate(3, (index) {
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(milliseconds: 600 + (index * 200)),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 80.0 + (index * 50),
                            height: 80.0 + (index * 50),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.primaryColor
                                    .withOpacity(0.3 - (index * 0.1)),
                                width: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),

                  // Center dot
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.8),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),

                  // Scanning line
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 2 * math.pi),
                    duration: const Duration(seconds: 3),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: Container(
                          width: 1,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.topCenter,
                              colors: [
                                AppTheme.primaryColor,
                                AppTheme.primaryColor.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onEnd: () {
                      // Repeat animation
                      if (mounted && _currentPage == 2) {
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Title
            Text(
              l10n.onboardingLocationTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Subtitle
            Text(
              l10n.onboardingLocationSubtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Info box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock_rounded,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.onboardingLocationPrivacyTitle,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.onboardingLocationPrivacyFormatted,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // CTA - FIXED LOGIC
            _buildCTAButton(
              l10n.onboardingButtonEnableRadar,
              () async {
                HapticFeedback.mediumImpact();

                // Check current permission status first
                final currentPermission = await Geolocator.checkPermission();

                // If already granted, just proceed
                if (currentPermission == LocationPermission.whileInUse ||
                    currentPermission == LocationPermission.always) {
                  setState(() {
                    _locationGranted = true;
                  });
                  _nextPage();
                  return;
                }

                // If permanently denied, show settings dialog
                if (currentPermission == LocationPermission.deniedForever) {
                  _showLocationPermanentlyDeniedDialog(l10n);
                  return;
                }

                // If just denied, try to request
                final permission = await Geolocator.requestPermission();

                if (permission == LocationPermission.whileInUse ||
                    permission == LocationPermission.always) {
                  setState(() {
                    _locationGranted = true;
                  });
                  _nextPage();
                } else if (permission == LocationPermission.deniedForever) {
                  _showLocationPermanentlyDeniedDialog(l10n);
                } else {
                  _showLocationDeniedDialog(l10n);
                }
              },
              icon: Icons.my_location_rounded,
            ),

            // Skip button
            TextButton(
              onPressed: () {
                // Skip this step
                setState(() {
                  _locationGranted = false;
                });
                _nextPage();
              },
              child: Text(
                l10n.onboardingButtonMaybeLater,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationPermanentlyDeniedDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0B2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.orange.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.onboardingLocationDeniedTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.onboardingLocationDeniedFormatted,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Geolocator.openAppSettings();
                      },
                      child: Text(
                        l10n.settingsTitle,
                        style: TextStyle(color: AppTheme.primaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _locationGranted = false;
                        });
                        _nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.onboardingButtonContinueAnyway,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationPage(AppLocalizations l10n) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated notification preview
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.primaryColor,
                                    AppTheme.secondaryColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  '⚡',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.onboardingNotificationExampleTitle,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  l10n.onboardingNotificationExampleNow,
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '⚡ ${l10n.onboardingNotificationExamplePing}',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.onboardingNotificationExampleMessage,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // Title
            Text(
              l10n.onboardingNotificationTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Subtitle
            Text(
              l10n.onboardingNotificationSubtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Features
            _buildFeatureRow(
                Icons.flash_on_rounded, l10n.onboardingNotificationFeature1),
            const SizedBox(height: 12),
            _buildFeatureRow(
                Icons.schedule_rounded, l10n.onboardingNotificationFeature2),
            const SizedBox(height: 12),
            _buildFeatureRow(
                Icons.trending_up_rounded, l10n.onboardingNotificationFeature3),

            const SizedBox(height: 40),

            // CTA с платформо-зависимой логикой
            _buildCTAButton(
              l10n.onboardingButtonTurnOnPings,
              () async {
                HapticFeedback.mediumImpact();

                // Инициализация локальных уведомлений
                await NotificationService.init();

                bool oneSignalGranted = false;

                if (Platform.isAndroid) {
                  // Android: можем запросить разрешения сразу
                  debugPrint(
                      '🤖 Android: Requesting OneSignal permissions immediately');

                  oneSignalGranted =
                      await OneSignal.Notifications.requestPermission(true);
                  debugPrint('🤖 Android permission result: $oneSignalGranted');
                } else if (Platform.isIOS) {
                  // iOS: нужна задержка перед запросом
                  debugPrint('🍎 iOS detected: Special handling required');
                  debugPrint(
                      '🍎 iOS: Waiting 3 seconds before permission request...');

                  // Показываем loading индикатор
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A0B2E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primaryColor),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Preparing notifications...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'iOS requires setup time',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  // Ждем 3 секунды для iOS (согласно исследованию)
                  await Future.delayed(const Duration(seconds: 3));

                  // Закрываем loading
                  if (context.mounted && Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }

                  // Теперь запрашиваем разрешение
                  debugPrint(
                      '🍎 iOS: Now requesting permission after 3 second delay');
                  oneSignalGranted =
                      await OneSignal.Notifications.requestPermission(true);
                  debugPrint('🍎 iOS permission result: $oneSignalGranted');

                  // Дополнительная проверка для iOS
                  if (!oneSignalGranted) {
                    debugPrint(
                        '🍎 iOS: Permission not granted, checking again in 2 seconds...');
                    await Future.delayed(const Duration(seconds: 2));

                    // Проверяем статус подписки
                    final status = OneSignal.User.pushSubscription.optedIn;
                    oneSignalGranted = status ?? false;
                    debugPrint('🍎 iOS: Recheck result: $oneSignalGranted');
                  }

                  // Диагностика для iOS
                  if (Platform.isIOS) {
                    debugPrint('🍎 iOS Diagnostic after permission:');
                    final playerId = OneSignal.User.pushSubscription.id;
                    final token = OneSignal.User.pushSubscription.token;
                    final optedIn = OneSignal.User.pushSubscription.optedIn;
                    debugPrint('   Player ID: ${playerId ?? "null"}');
                    debugPrint('   Token: ${token ?? "null"}');
                    debugPrint('   Opted In: ${optedIn ?? false}');
                  }
                }

                // Запрашиваем локальные уведомления
                final localGranted =
                    await NotificationService.requestNotificationPermissions();
                debugPrint('📱 Local notifications result: $localGranted');

                if (oneSignalGranted || localGranted) {
                  setState(() {
                    _notificationsGranted = true;
                  });

                  // Для iOS - дополнительная проверка player_id через 5 секунд
                  if (Platform.isIOS) {
                    Timer(const Duration(seconds: 5), () {
                      final playerId = OneSignal.User.pushSubscription.id;
                      if (playerId == null || playerId.isEmpty) {
                        debugPrint(
                            '⚠️ iOS: Player ID still null after 5 seconds');
                        debugPrint('⚠️ iOS: This may require app restart');
                      } else {
                        debugPrint(
                            '✅ iOS: Player ID successfully obtained: $playerId');
                      }
                    });
                  }

                  _nextPage();
                } else {
                  _showNotificationsDeniedDialog(l10n);
                }
              },
              icon: Icons.notifications_active_rounded,
            ),

            // Skip button
            TextButton(
              onPressed: () {
                _showNotificationsDeniedDialog(l10n);
              },
              child: Text(
                l10n.onboardingButtonNotNow,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthYearPage() {
    return BirthYearSelectionScreen(
      onComplete: () {
        _nextPage();
      },
    );
  }

  Widget _buildCTAButton(String text, VoidCallback onTap, {IconData? icon}) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.secondaryColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 40),
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLegalPage(AppLocalizations l10n) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Age verification icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.2),
                    AppTheme.secondaryColor.withOpacity(0.2),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Title
            Text(
              l10n.onboardingLegalTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Age verification
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cake_rounded,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.onboardingLegalAgeRequirement,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.onboardingLegalAgeSubtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Legal text with links
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.onboardingLegalConsent,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegalLink(l10n.onboardingLegalTerms, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TermsOfServiceScreen(),
                          ),
                        );
                      }),
                      Text(
                        l10n.onboardingLegalAnd,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                      _buildLegalLink(l10n.onboardingLegalPrivacyPolicy, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyScreen(),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Safety features
            _buildSafetyFeature(Icons.visibility_off_rounded,
                l10n.onboardingLegalSafetyFeature1),
            const SizedBox(height: 12),
            _buildSafetyFeature(
                Icons.block_rounded, l10n.onboardingLegalSafetyFeature2),
            const SizedBox(height: 12),
            _buildSafetyFeature(
                Icons.timer_rounded, l10n.onboardingLegalSafetyFeature3),

            const SizedBox(height: 40),

            // Final CTA
            _buildCTAButton(
              l10n.onboardingButtonImAge13AndAgree,
              () async {
                HapticFeedback.heavyImpact();

                // Save age verification
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('age_verified', true);
                await prefs.setBool('terms_accepted', true);
                await prefs.setString(
                    'terms_accepted_date', DateTime.now().toIso8601String());

                _completeOnboarding();
              },
              icon: Icons.check_rounded,
            ),

            // Decline option
            TextButton(
              onPressed: () {
                // Show age restriction dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1A0B2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      '👋 ${l10n.onboardingAgeDialogTitle}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      l10n.onboardingAgeDialogMessage,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close app
                          SystemNavigator.pop();
                        },
                        child: Text(
                          l10n.onboardingButtonUnderstood,
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                l10n.onboardingButtonImUnder13,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSafetyFeature(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.green,
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // Popup when location is denied
  void _showLocationDeniedDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0B2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.red.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '😔',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.onboardingLocationDeniedTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.onboardingLocationDeniedFormatted,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.onboardingButtonGoBack,
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Continue without location
                        setState(() {
                          _locationGranted = false;
                        });
                        _nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.onboardingButtonContinueAnyway,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Popup when notifications are denied
  void _showNotificationsDeniedDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0B2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '👻',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.onboardingNotificationDeniedTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.onboardingNotificationDeniedFormatted,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.onboardingButtonLetMeReconsider,
                        style: TextStyle(color: AppTheme.primaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _notificationsGranted = true;
                        });
                        _nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.onboardingButtonContinueAnyway,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    HapticFeedback.heavyImpact();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainContainer(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
}

// Value card widget
class _ValueCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final int delay;

  const _ValueCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.delay,
  });

  @override
  State<_ValueCard> createState() => _ValueCardState();
}

class _ValueCardState extends State<_ValueCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: widget.color,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Map ping data
class _MapPing {
  final Offset position;
  final Duration delay;
  final String emoji;

  _MapPing({
    required this.position,
    required this.delay,
    required this.emoji,
  });
}

// Animated ping widget
class _AnimatedPing extends StatefulWidget {
  final _MapPing ping;

  const _AnimatedPing({required this.ping});

  @override
  State<_AnimatedPing> createState() => _AnimatedPingState();
}

class _AnimatedPingState extends State<_AnimatedPing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0),
    ));

    Future.delayed(widget.ping.delay, () {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.ping.position.dx,
      top: widget.ping.position.dy,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(0.3),
                ),
                child: Center(
                  child: Text(
                    widget.ping.emoji,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
