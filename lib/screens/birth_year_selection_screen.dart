// lib/screens/birth_year_selection_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/theme.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class BirthYearSelectionScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const BirthYearSelectionScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<BirthYearSelectionScreen> createState() =>
      _BirthYearSelectionScreenState();
}

class _BirthYearSelectionScreenState extends State<BirthYearSelectionScreen>
    with TickerProviderStateMixin {
  // Year range
  final int currentYear = DateTime.now().year;
  late final int maxYear = currentYear - 13; // 2011 for 2024
  final int minYear = 1969; // 1969+ for older users

  // Selected year tracking
  int selectedYear = 2005; // Default to middle-ish
  bool _isSaving = false;

  // Countdown timer for button
  int _countdownSeconds = 6;
  Timer? _countdownTimer;
  bool _buttonEnabled = false;

  // Scroll controller
  late FixedExtentScrollController _scrollController;

  // Animation controllers - simplified
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  // Generation labels map - will be populated from localization
  Map<int, String> generationLabels = {};

  @override
  void initState() {
    super.initState();

    // Initialize scroll controller
    final years = _getYearsList();
    final initialIndex = years.indexOf(selectedYear);
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);

    // Simple animations only
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    // Start countdown timer
    _startCountdown();

    HapticFeedback.lightImpact();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownSeconds > 0) {
        setState(() {
          _countdownSeconds--;
        });
      } else {
        setState(() {
          _buttonEnabled = true;
        });
        timer.cancel();
        HapticFeedback.lightImpact(); // Haptic when button becomes enabled
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize generation labels with localized strings
    final l10n = AppLocalizations.of(context)!;
    generationLabels = {
      2012: l10n.genLabel2012,
      2011: l10n.genLabel2011,
      2010: l10n.genLabel2010,
      2009: l10n.genLabel2009,
      2008: l10n.genLabel2008,
      2007: l10n.genLabel2007,
      2006: l10n.genLabel2006,
      2005: l10n.genLabel2005,
      2004: l10n.genLabel2004,
      2003: l10n.genLabel2003,
      2002: l10n.genLabel2002,
      2001: l10n.genLabel2001,
      2000: l10n.genLabel2000,
      1999: l10n.genLabel1999,
      1998: l10n.genLabel1998,
      1997: l10n.genLabel1997,
      1996: l10n.genLabel1996,
      1995: l10n.genLabel1995,
      1994: l10n.genLabel1994,
      1993: l10n.genLabel1993,
      1992: l10n.genLabel1992,
      1991: l10n.genLabel1991,
      1990: l10n.genLabel1990,
      1989: l10n.genLabel1989,
      1988: l10n.genLabel1988,
      1987: l10n.genLabel1987,
      1986: l10n.genLabel1986,
      1985: l10n.genLabel1985,
      1984: l10n.genLabel1984,
      1983: l10n.genLabel1983,
      1982: l10n.genLabel1982,
      1981: l10n.genLabel1981,
      1980: l10n.genLabel1980,
      1979: l10n.genLabel1979,
      1978: l10n.genLabel1978,
      1977: l10n.genLabel1977,
      1976: l10n.genLabel1976,
      1975: l10n.genLabel1975,
      1974: l10n.genLabel1974,
      1973: l10n.genLabel1973,
      1972: l10n.genLabel1972,
      1971: l10n.genLabel1971,
      1970: l10n.genLabel1970,
      1969: l10n.genLabel1969,
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  List<int> _getYearsList() {
    // Generate list but show "1969+" for the last item
    return List.generate(maxYear - minYear + 1, (i) => maxYear - i);
  }

  int _getAdjustedYear() {
    // For users 1969 and older, always save as 1969
    return selectedYear <= 1969 ? 1969 : selectedYear;
  }

  Future<void> _confirmAndSave() async {
    if (_isSaving || !_buttonEnabled) return;

    HapticFeedback.heavyImpact();
    setState(() {
      _isSaving = true;
    });

    try {
      // Save adjusted year (1969 for all 1969+ users)
      final yearToSave = _getAdjustedYear();

      // Save locally
      await StorageService.saveBirthYear(yearToSave);

      // Save to server
      final deviceId = await StorageService.getDeviceId();
      await ApiService.saveBirthYear(
        deviceId: deviceId,
        birthYear: yearToSave,
      );

      // Complete onboarding
      widget.onComplete();
    } catch (e) {
      debugPrint('Error saving birth year: $e');
      widget.onComplete(); // Continue anyway
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Get safe area padding
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.5, -0.5),
            radius: 1.5,
            colors: [
              AppTheme.primaryColor.withOpacity(0.15),
              const Color(0xFF0A0015),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false, // Handle bottom padding manually
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Simple, clear title
                Text(
                  l10n.birthYearTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 25),

                // Generation badge ABOVE selector - minimal
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(selectedYear),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      generationLabels[selectedYear] ??
                          l10n.birthYearDefaultGeneration,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Year wheel selector - cleaner
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Simple selection highlight with gradient border
                      Container(
                        height: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryColor.withOpacity(0.05),
                              AppTheme.secondaryColor.withOpacity(0.05),
                            ],
                          ),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                      ),

                      // Year list wheel
                      SizedBox(
                        height: 280,
                        child: ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          itemExtent: 70,
                          diameterRatio: 2.0,
                          perspective: 0.003,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            HapticFeedback.selectionClick();
                            setState(() {
                              final years = _getYearsList();
                              selectedYear = years[index];
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: maxYear - minYear + 1,
                            builder: (context, index) {
                              final years = _getYearsList();
                              final year = years[index];
                              final isSelected = year == selectedYear;
                              final displayYear = year == 1969
                                  ? l10n.birthYear1969Plus
                                  : '$year';

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                alignment: Alignment.center,
                                child: isSelected
                                    ? AnimatedBuilder(
                                        animation: _pulseAnimation,
                                        builder: (context, child) {
                                          return Transform.scale(
                                            scale: _pulseAnimation.value,
                                            child: ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                colors: [
                                                  AppTheme.primaryColor,
                                                  AppTheme.secondaryColor,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ).createShader(bounds),
                                              child: Text(
                                                displayYear,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 42,
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Text(
                                        displayYear,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.3),
                                          fontSize: 28,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom section with proper spacing and gradient button
                Container(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: bottomPadding + 60, // Higher position + safe area
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      // Clean countdown button with semi-transparent gradient
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _buttonEnabled
                                ? 1.0 + (_pulseAnimation.value - 1.0) * 0.05
                                : 1.0,
                            child: GestureDetector(
                              onTap: (_isSaving || !_buttonEnabled)
                                  ? null
                                  : _confirmAndSave,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOutExpo,
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: _buttonEnabled
                                        ? [
                                            AppTheme.primaryColor,
                                            AppTheme.secondaryColor,
                                          ]
                                        : [
                                            AppTheme.primaryColor
                                                .withOpacity(0.3),
                                            AppTheme.secondaryColor
                                                .withOpacity(0.3),
                                          ],
                                  ),
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: _buttonEnabled
                                      ? [
                                          BoxShadow(
                                            color: AppTheme.primaryColor
                                                .withOpacity(0.4),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Center(
                                  child: _isSaving
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          switchInCurve: Curves.easeOutExpo,
                                          child: _buttonEnabled
                                              ? Text(
                                                  l10n.commonContinue,
                                                  key: const ValueKey(
                                                      'continue'),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.5,
                                                  ),
                                                )
                                              : Row(
                                                  key: ValueKey(
                                                      'countdown$_countdownSeconds'),
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Circular countdown timer
                                                    SizedBox(
                                                      width: 28,
                                                      height: 28,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          // Background circle
                                                          CircularProgressIndicator(
                                                            value: 1.0,
                                                            strokeWidth: 2.5,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                          ),
                                                          // Animated progress
                                                          TweenAnimationBuilder<
                                                              double>(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                            tween: Tween(
                                                              begin:
                                                                  (_countdownSeconds +
                                                                          1) /
                                                                      6,
                                                              end:
                                                                  _countdownSeconds /
                                                                      6,
                                                            ),
                                                            builder: (context,
                                                                value, child) {
                                                              return CircularProgressIndicator(
                                                                value: value,
                                                                strokeWidth:
                                                                    2.5,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  Colors.white
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                                strokeCap:
                                                                    StrokeCap
                                                                        .round,
                                                              );
                                                            },
                                                          ),
                                                          // Number
                                                          Text(
                                                            '$_countdownSeconds',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    // Just show Continue text with lower opacity
                                                    Text(
                                                      l10n.commonContinue,
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 0.5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Privacy text - more visible
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock_rounded,
                              color: Colors.white.withOpacity(0.5),
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.birthYearPrivacyText,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
