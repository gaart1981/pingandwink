// lib/widgets/emotion_selector.dart
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/emotions.dart';
import '../config/theme.dart';
import '../models/user_data.dart';
import '../l10n/app_localizations.dart';
import 'vibe_confirmation_animation.dart';
import '../services/storage_service.dart';

/// VIRAL Vibe Selector - designed to make Gen Z tap instantly
class EmotionSelector extends StatefulWidget {
  final Function(int) onEmotionSelected;
  final bool isSubmitting;
  final UserData? userData;
  final VoidCallback? onSwipeDown;

  const EmotionSelector({
    super.key,
    required this.onEmotionSelected,
    required this.isSubmitting,
    this.userData,
    this.onSwipeDown,
  });

  @override
  State<EmotionSelector> createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector>
    with TickerProviderStateMixin {
  Offset? _lastTapPosition;
  // Main controllers
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  late AnimationController _entryController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Pulse animations for each vibe
  late List<AnimationController> _pulseControllers;
  late List<Animation<double>> _pulseAnimations;

  // Arrow bounce animation
  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;

  // Selected vibe animation
  int? _hoveredIndex;

  // Swipe tracking
  double _dragDistance = 0;
  bool _isDragging = false;
  bool _isClosing = false;

  // Fake nearby counts for viral effect
  final List<int> _nearbyCounts = [23, 45, 12, 67, 34, 8, 91, 34];

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    ));

    // Initialize pulse animations for each vibe
    _pulseControllers = List.generate(
      Emotions.list.length,
      (index) => AnimationController(
        duration:
            Duration(milliseconds: 1500 + (index * 200)), // Different speeds
        vsync: this,
      )..repeat(reverse: true),
    );

    _pulseAnimations = _pulseControllers.map((controller) {
      return Tween<double>(
        begin: 0.95,
        end: 1.05,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    // Arrow animation
    _arrowController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(
      begin: 0,
      end: 8,
    ).animate(CurvedAnimation(
      parent: _arrowController,
      curve: Curves.easeInOut,
    ));

    _entryController.forward();

    _slideController.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onSwipeDown != null) {
        widget.onSwipeDown!();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _entryController.dispose();
    _arrowController.dispose();
    for (var controller in _pulseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isClosing) return;
    setState(() {
      _isDragging = true;
      _dragDistance += details.primaryDelta!;
      _dragDistance = math.max(0, _dragDistance);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isClosing) return;
    final velocity = details.primaryVelocity ?? 0;
    final shouldClose = _dragDistance > 100 || velocity > 500;

    if (shouldClose && widget.onSwipeDown != null) {
      setState(() {
        _isClosing = true;
      });
      HapticFeedback.lightImpact();
      _slideController.forward();
    } else {
      setState(() {
        _isDragging = false;
        _dragDistance = 0;
      });
    }
  }

  void _showVibeConfirmation(int vibeIndex) {
    HapticFeedback.mediumImpact();

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (_, __, ___) => VibeConfirmationAnimation(
          vibeIndex: vibeIndex,
          tapPosition: _lastTapPosition,
          onComplete: () {
            Navigator.of(context).pop();
            widget.onEmotionSelected(vibeIndex);
          },
        ),
        transitionDuration: Duration.zero,
      ),
    );
  }

  String _getVibeLabel(int index, AppLocalizations l10n) {
    switch (index) {
      case 0:
        return l10n.vibeLabelBrainMode;
      case 1:
        return l10n.vibeLabelLatteBreak;
      case 2:
        return l10n.vibeLabelSportMode;
      case 3:
        return l10n.vibeLabelSoundLoop;
      case 4:
        return l10n.vibeLabelCityWalk;
      case 5:
        return l10n.vibeLabelContentMode;
      case 6:
        return l10n.vibeLabelChillNight;
      case 7:
        return l10n.vibeLabelPartyMode;
      default:
        return l10n.vibeLabelBrainMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final canSwipeDown = widget.onSwipeDown != null;
    final dragTransform =
        _isDragging ? _dragDistance / MediaQuery.of(context).size.height : 0.0;
    final totalTransform = dragTransform + (_slideAnimation.value * 1.5);

    return GestureDetector(
      onVerticalDragUpdate: canSwipeDown ? _handleDragUpdate : null,
      onVerticalDragEnd: canSwipeDown ? _handleDragEnd : null,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _slideAnimation,
          _fadeAnimation,
          _scaleAnimation,
          _arrowAnimation,
          ..._pulseAnimations,
        ]),
        builder: (context, child) {
          return Transform.translate(
            offset:
                Offset(0, totalTransform * MediaQuery.of(context).size.height),
            child: Opacity(
              opacity:
                  _fadeAnimation.value * (1 - (_slideAnimation.value * 0.5)),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Swipe indicator
                            if (canSwipeDown) ...[
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: _isDragging ? 60 : 40,
                                height: 4,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(_isDragging ? 0.6 : 0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],

                            // Streak banner
                            FutureBuilder<int>(
                              future: StorageService.getStreak(),
                              builder: (context, snapshot) {
                                final streak = snapshot.data ?? 0;
                                if (streak == 0) return const SizedBox.shrink();

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFFF6B00)
                                            .withOpacity(0.2),
                                        const Color(0xFFFF0080)
                                            .withOpacity(0.2),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFFFF6B00)
                                          .withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('🔥',
                                          style: TextStyle(fontSize: 20)),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.emotionSelectorStreakDay(streak),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            // Main Title with animated arrow
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Glow behind text
                                Container(
                                  width: 250,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                        colors: [
                                          AppTheme.primaryColor,
                                          AppTheme.secondaryColor,
                                        ],
                                      ).createShader(bounds),
                                      child: Text(
                                        l10n.emotionSelectorTapYourVibe,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Transform.translate(
                                      offset: Offset(0, _arrowAnimation.value),
                                      child: const Icon(
                                        Icons.arrow_downward_rounded,
                                        color: AppTheme.primaryColor,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Subtitle
                            Text(
                              l10n.emotionSelectorWhatsYourVibe,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Vibe Cards Grid
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1.6,
                              ),
                              itemCount: Emotions.list.length,
                              itemBuilder: (context, index) {
                                final vibe = Emotions.list[index];
                                final isHovered = _hoveredIndex == index;
                                final pulseValue =
                                    _pulseAnimations[index].value;

                                return GestureDetector(
                                  onTapDown: (details) {
                                    setState(() {
                                      _hoveredIndex = index;
                                      _lastTapPosition = details.globalPosition;
                                    });
                                    HapticFeedback.lightImpact();
                                  },
                                  onTapUp: (_) {
                                    setState(() => _hoveredIndex = null);
                                    if (!widget.isSubmitting) {
                                      HapticFeedback.mediumImpact();
                                      _showVibeConfirmation(index);
                                    }
                                  },
                                  onTapCancel: () {
                                    setState(() => _hoveredIndex = null);
                                  },
                                  child: AnimatedScale(
                                    scale: isHovered ? 0.95 : pulseValue,
                                    duration: const Duration(milliseconds: 150),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            vibe.gradient[0].withOpacity(
                                                isHovered ? 0.4 : 0.2),
                                            vibe.gradient[1].withOpacity(
                                                isHovered ? 0.3 : 0.1),
                                          ],
                                        ),
                                        border: Border.all(
                                          color: isHovered
                                              ? vibe.color
                                              : vibe.color.withOpacity(0.5),
                                          width: isHovered ? 2 : 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: vibe.color.withOpacity(
                                                isHovered ? 0.6 : 0.3),
                                            blurRadius: isHovered ? 20 : 15,
                                            spreadRadius: isHovered ? 2 : 0,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          // Animated gradient overlay
                                          if (isHovered)
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: RadialGradient(
                                                    center: Alignment.center,
                                                    colors: [
                                                      vibe.color
                                                          .withOpacity(0.3),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                          // Content
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Emoji with subtle float animation
                                                Transform.translate(
                                                  offset: Offset(
                                                    math.sin(DateTime.now()
                                                                    .millisecondsSinceEpoch /
                                                                1000 +
                                                            index) *
                                                        2,
                                                    math.cos(DateTime.now()
                                                                    .millisecondsSinceEpoch /
                                                                1000 +
                                                            index) *
                                                        1,
                                                  ),
                                                  child: Text(
                                                    vibe.icon,
                                                    style: TextStyle(
                                                      fontSize:
                                                          isHovered ? 32 : 28,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),

                                                // Label
                                                Text(
                                                  _getVibeLabel(index, l10n),
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.5,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Nearby count badge
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: vibe.color
                                                      .withOpacity(0.5),
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.people,
                                                    size: 10,
                                                    color: vibe.color,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    '${_nearbyCounts[index]}',
                                                    style: TextStyle(
                                                      color: vibe.color,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 16),

                            // Social proof
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00FF00),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF00FF00)
                                              .withOpacity(0.5),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.emotionSelectorActiveNow(
                                        _nearbyCounts.reduce((a, b) => a + b)),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
