// lib/widgets/vibe_confirmation_animation.dart
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/emotions.dart';
import '../config/theme.dart';
import '../l10n/app_localizations.dart';

/// Emotional confirmation animation after vibe selection
/// Creates a "THIS IS ME!" moment for the user
class VibeConfirmationAnimation extends StatefulWidget {
  final int vibeIndex;
  final VoidCallback onComplete;
  final Offset? tapPosition; // Where user tapped

  const VibeConfirmationAnimation({
    super.key,
    required this.vibeIndex,
    required this.onComplete,
    this.tapPosition,
  });

  @override
  State<VibeConfirmationAnimation> createState() =>
      _VibeConfirmationAnimationState();
}

class _VibeConfirmationAnimationState extends State<VibeConfirmationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late AnimationController _particleController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _textScaleAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _emojiRotationAnimation;
  late Animation<double> _emojiScaleAnimation;
  late Animation<double> _particleAnimation;

  // Get vibe messages from localization
  String _getVibeMessage(int index, AppLocalizations l10n) {
    switch (index) {
      case 0:
        return l10n.vibeAnimBrainEnergy;
      case 1:
        return l10n.vibeAnimCozy;
      case 2:
        return l10n.vibeAnimSweatSlay;
      case 3:
        return l10n.vibeAnimLostInBeat;
      case 4:
        return l10n.vibeAnimCityLights;
      case 5:
        return l10n.vibeAnimLightsCameraVibes;
      case 6:
        return l10n.vibeAnimEveningVibes;
      case 7:
        return l10n.vibeAnimPartyMode;
      default:
        return l10n.vibeAnimDefaultMessage;
    }
  }

  // Get vibe sub-messages from localization
  String _getVibeSubMessage(int index, AppLocalizations l10n) {
    switch (index) {
      case 0:
        return l10n.vibeAnimSubBrainTime;
      case 1:
        return l10n.vibeAnimSubCaffeine;
      case 2:
        return l10n.vibeAnimSubNoDaysOff;
      case 3:
        return l10n.vibeAnimSubVolumeMax;
      case 4:
        return l10n.vibeAnimSubUrbanExplorer;
      case 5:
        return l10n.vibeAnimSubCreateGlow;
      case 6:
        return l10n.vibeAnimSubNightFlow;
      case 7:
        return l10n.vibeAnimSubUnleashChaos;
      default:
        return l10n.vibeAnimDefaultSubMessage;
    }
  }

  @override
  void initState() {
    super.initState();

    // Scale animation for the expanding circle - smoother curve
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve:
          Curves.easeOutCubic, // Changed from easeOutExpo for smoother effect
    ));

    // Text animations - longer duration
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOutBack)), // Smoother curve
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 40,
      ),
    ]).animate(_textController);

    _textOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(_textController);

    // Smoother emoji rotation
    _emojiRotationAnimation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOutSine,
    ));

    // Emoji scale pulse
    _emojiScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.3),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 0.95),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Background fade - smoother
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOutCubic,
    ));

    // Particle animation controller
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeOut,
    ));

    // Start animations sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Trigger haptic
    HapticFeedback.heavyImpact();

    // Start background fade
    _backgroundController.forward();

    // Small delay then expand circle
    await Future.delayed(const Duration(milliseconds: 100));
    _scaleController.forward();
    _particleController.forward();

    // Start text animation
    await Future.delayed(const Duration(milliseconds: 250));
    _textController.forward();

    // Wait for completion - extended by 100ms
    await Future.delayed(const Duration(milliseconds: 1100));

    // Fade out
    _backgroundController.reverse();

    await Future.delayed(const Duration(milliseconds: 400));
    widget.onComplete();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vibe = Emotions.list[widget.vibeIndex];
    final screenSize = MediaQuery.of(context).size;

    // Calculate position for expansion effect
    final expandOrigin = widget.tapPosition ??
        Offset(screenSize.width / 2, screenSize.height / 2);

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _scaleAnimation,
          _textScaleAnimation,
          _textOpacityAnimation,
          _backgroundAnimation,
          _emojiRotationAnimation,
          _emojiScaleAnimation,
          _particleAnimation,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              // Dark background with blur
              Positioned.fill(
                child: IgnorePointer(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 15 * _backgroundAnimation.value,
                      sigmaY: 15 * _backgroundAnimation.value,
                    ),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.8 * _backgroundAnimation.value),
                    ),
                  ),
                ),
              ),

              // Expanding circle effect - smoother gradient
              Positioned(
                left: expandOrigin.dx -
                    (screenSize.width * 1.5 * _scaleAnimation.value),
                top: expandOrigin.dy -
                    (screenSize.width * 1.5 * _scaleAnimation.value),
                child: Container(
                  width: screenSize.width * 3 * _scaleAnimation.value,
                  height: screenSize.width * 3 * _scaleAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        vibe.gradient[0]
                            .withOpacity(0.4 * _scaleAnimation.value),
                        vibe.gradient[1]
                            .withOpacity(0.2 * _scaleAnimation.value),
                        vibe.gradient[0]
                            .withOpacity(0.05 * _scaleAnimation.value),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Main content
              Center(
                child: Opacity(
                  opacity: _textOpacityAnimation.value,
                  child: Transform.scale(
                    scale: _textScaleAnimation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Rotating and scaling emoji
                        Transform.rotate(
                          angle: _emojiRotationAnimation.value,
                          child: Transform.scale(
                            scale: _emojiScaleAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: vibe.color.withOpacity(0.3),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Text(
                                vibe.icon,
                                style: const TextStyle(
                                  fontSize: 80,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Main message with gradient
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              vibe.gradient[0],
                              vibe.gradient[1],
                              vibe.gradient[0],
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            _getVibeMessage(widget.vibeIndex, l10n),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Sub message with fade
                        AnimatedOpacity(
                          opacity: _textOpacityAnimation.value * 0.9,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            _getVibeSubMessage(widget.vibeIndex, l10n),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Animated pulse indicator
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          width: 60 + (_scaleAnimation.value * 20),
                          height: 3,
                          decoration: BoxDecoration(
                            color: vibe.color,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: vibe.color.withOpacity(0.8),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Smooth particle effects
              ..._buildSmoothParticles(vibe, screenSize),
            ],
          );
        },
      ),
    );
  }

  // Generate smooth floating particles
  List<Widget> _buildSmoothParticles(EmotionConfig vibe, Size screenSize) {
    if (_particleAnimation.value < 0.1) return [];

    return List.generate(8, (index) {
      final angle = (index * 45) * (math.pi / 180);
      final distance = 150 * _particleAnimation.value;
      final offsetX = math.cos(angle) * distance;
      final offsetY = math.sin(angle) * distance;

      // Add floating effect
      final floatOffset =
          math.sin(_particleAnimation.value * math.pi * 2 + index) * 10;

      return Positioned(
        left: screenSize.width / 2 + offsetX - 4,
        top: screenSize.height / 2 + offsetY + floatOffset - 4,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: (1 - _particleAnimation.value) * 0.8,
          child: Transform.scale(
            scale: 0.5 + (_particleAnimation.value * 0.5),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: vibe.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: vibe.color.withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
