// lib/widgets/vibe_confirmation_animation.dart
import 'dart:ui';
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

  late Animation<double> _scaleAnimation;
  late Animation<double> _textScaleAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _emojiRotationAnimation;

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

    // Scale animation for the expanding circle
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutExpo,
    ));

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 30,
      ),
    ]).animate(_textController);

    _textOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 20,
      ),
    ]).animate(_textController);

    // Emoji rotation for fun
    _emojiRotationAnimation = Tween<double>(
      begin: -0.2,
      end: 0.2,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.elasticInOut,
    ));

    // Background fade
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
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
    await Future.delayed(const Duration(milliseconds: 50));
    _scaleController.forward();

    // Start text animation
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();

    // Wait for completion
    await Future.delayed(const Duration(milliseconds: 900));

    // Fade out
    _backgroundController.reverse();

    await Future.delayed(const Duration(milliseconds: 300));
    widget.onComplete();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
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
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              // Dark background with blur
              Positioned.fill(
                child: IgnorePointer(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10 * _backgroundAnimation.value,
                      sigmaY: 10 * _backgroundAnimation.value,
                    ),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.7 * _backgroundAnimation.value),
                    ),
                  ),
                ),
              ),

              // Expanding circle effect from tap position
              Positioned(
                left: expandOrigin.dx -
                    (screenSize.width * _scaleAnimation.value),
                top: expandOrigin.dy -
                    (screenSize.width * _scaleAnimation.value),
                child: Container(
                  width: screenSize.width * 2 * _scaleAnimation.value,
                  height: screenSize.width * 2 * _scaleAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        vibe.gradient[0]
                            .withOpacity(0.3 * _scaleAnimation.value),
                        vibe.gradient[1]
                            .withOpacity(0.1 * _scaleAnimation.value),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
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
                        // Rotating emoji
                        Transform.rotate(
                          angle: _emojiRotationAnimation.value,
                          child: Transform.scale(
                            scale: 1.0 + (_scaleAnimation.value * 0.5),
                            child: Text(
                              vibe.icon,
                              style: TextStyle(
                                fontSize: 80,
                                shadows: [
                                  Shadow(
                                    color: vibe.color.withOpacity(0.5),
                                    blurRadius: 30,
                                  ),
                                ],
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

                        // Sub message
                        Text(
                          _getVibeSubMessage(widget.vibeIndex, l10n),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Pulse indicator
                        Container(
                          width: 60,
                          height: 3,
                          decoration: BoxDecoration(
                            color: vibe.color,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: vibe.color,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Particle effects (optional fancy addition)
              ..._buildParticles(vibe, screenSize),
            ],
          );
        },
      ),
    );
  }

  // Generate floating particles for extra wow
  List<Widget> _buildParticles(EmotionConfig vibe, Size screenSize) {
    if (_scaleAnimation.value < 0.5) return [];

    return List.generate(6, (index) {
      final angle = (index * 60) * (3.14159 / 180);
      final distance = 100 * _scaleAnimation.value;

      return Positioned(
        left: screenSize.width / 2 +
            (distance * _scaleAnimation.value * (index.isEven ? 1 : -1)),
        top: screenSize.height / 2 +
            (distance * _scaleAnimation.value * (index.isOdd ? 1 : -1)),
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: vibe.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: vibe.color,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
