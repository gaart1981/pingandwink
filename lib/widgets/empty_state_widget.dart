// lib/widgets/empty_state_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Beautiful widget for displaying empty map messages
class EmptyStateWidget extends StatefulWidget {
  final String message;
  final String submessage;
  final VoidCallback onDismiss;
  final bool isVisible;
  
  const EmptyStateWidget({
    super.key,
    required this.message,
    required this.submessage,
    required this.onDismiss,
    required this.isVisible,
  });
  
  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    
    // Slide animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Pulse animation for glow effect
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
    
    if (widget.isVisible) {
      _show();
    }
  }
  
  @override
  void didUpdateWidget(EmptyStateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isVisible && !oldWidget.isVisible) {
      _show();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _hide();
    }
  }
  
  void _show() {
    _fadeController.forward();
    _slideController.forward();
    HapticFeedback.lightImpact();
  }
  
  void _hide() {
    _fadeController.reverse();
    _slideController.reverse();
  }
  
  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible && _fadeController.status == AnimationStatus.dismissed) {
      return const SizedBox.shrink();
    }
    
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GestureDetector(
                    onTap: widget.onDismiss,
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color.lerp(
                                const Color(0xFF00D4FF).withOpacity(0.3),
                                const Color(0xFFFF00FF).withOpacity(0.5),
                                _pulseAnimation.value,
                              )!,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.lerp(
                                  const Color(0xFF00D4FF).withOpacity(0.2),
                                  const Color(0xFFFF00FF).withOpacity(0.2),
                                  _pulseAnimation.value,
                                )!,
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Close hint
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'tap to close',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Main message
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  widget.message,
                                  key: ValueKey(widget.message),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Divider with gradient
                              Container(
                                height: 1,
                                width: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Color.lerp(
                                        const Color(0xFF00D4FF),
                                        const Color(0xFFFF00FF),
                                        _pulseAnimation.value,
                                      )!,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Submessage
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  widget.submessage,
                                  key: ValueKey(widget.submessage),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.lerp(
                                      const Color(0xFF00D4FF),
                                      const Color(0xFFFF00FF),
                                      _pulseAnimation.value,
                                    ),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Progress indicator
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: const Duration(seconds: 30),
                                builder: (context, value, child) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    backgroundColor: Colors.white.withOpacity(0.1),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.lerp(
                                        const Color(0xFF00D4FF),
                                        const Color(0xFFFF00FF),
                                        value,
                                      )!.withOpacity(0.5),
                                    ),
                                    minHeight: 2,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}