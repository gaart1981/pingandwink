// lib/widgets/wink_banner.dart
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ping_data.dart';
import '../config/theme.dart';
import '../config/emotions.dart';

/// Minimalist cyberpunk wink banner
class WinkBanner extends StatefulWidget {
  final IncomingPing ping;
  final VoidCallback onWink;
  final VoidCallback onDismiss;
  final VoidCallback onExpired;
  
  const WinkBanner({
    Key? key,
    required this.ping,
    required this.onWink,
    required this.onDismiss,
    required this.onExpired,
  }) : super(key: key);
  
  @override
  State<WinkBanner> createState() => _WinkBannerState();
}

class _WinkBannerState extends State<WinkBanner> 
    with TickerProviderStateMixin {
  
  late AnimationController _slideController;
  late AnimationController _glowController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _glowAnimation;
  
  Timer? _countdownTimer;
  int _remainingSeconds = 60;
  bool _isAccepting = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    _glowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.6,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
    
    // Start slide in
    _slideController.forward();
    
    // Start countdown
    _remainingSeconds = widget.ping.remainingSeconds;
    _startCountdown();
    
    // Initial haptic
    HapticFeedback.mediumImpact();
  }
  
  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });
      
      // Haptic at critical moments
      if (_remainingSeconds == 10 || _remainingSeconds == 5 || _remainingSeconds == 3) {
        HapticFeedback.lightImpact();
      }
      
      if (_remainingSeconds <= 0) {
        timer.cancel();
        widget.onExpired();
      }
    });
  }
  
  void _handleWink() async {
    if (_isAccepting) return;
    
    setState(() => _isAccepting = true);
    HapticFeedback.heavyImpact();
    
    await _slideController.reverse();
    widget.onWink();
  }
  
  void _handleDismiss() async {
    HapticFeedback.selectionClick();
    await _slideController.reverse();
    widget.onDismiss();
  }
  
  Color _getTimerColor() {
    if (_remainingSeconds <= 10) return const Color(0xFFFF0066);
    if (_remainingSeconds <= 30) return const Color(0xFFFF9900);
    return AppTheme.primaryColor;
  }
  
  @override
  Widget build(BuildContext context) {
    final emotionConfig = widget.ping.fromEmotion != null 
      ? Emotions.getEmotion(widget.ping.fromEmotion!)
      : Emotions.getEmotion(0);
    
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _remainingSeconds <= 10
                        ? const Color(0xFFFF0066).withOpacity(_glowAnimation.value)
                        : AppTheme.primaryColor.withOpacity(_glowAnimation.value),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: emotionConfig.color.withOpacity(_glowAnimation.value * 0.4),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          // Emoji
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  emotionConfig.color.withOpacity(0.3),
                                  emotionConfig.color.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                emotionConfig.icon,
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.flash_on,
                                      color: AppTheme.primaryColor,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'PING ${widget.ping.distanceText}',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'sparkmate wants to connect',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Timer
                          Container(
                            width: 44,
                            height: 44,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: _remainingSeconds / 60,
                                  strokeWidth: 2.5,
                                  backgroundColor: Colors.white.withOpacity(0.1),
                                  valueColor: AlwaysStoppedAnimation<Color>(_getTimerColor()),
                                ),
                                Text(
                                  '${_remainingSeconds}s',
                                  style: TextStyle(
                                    color: _getTimerColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Action buttons
                      Row(
                        children: [
                          // Dismiss button
                          GestureDetector(
                            onTap: _handleDismiss,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white.withOpacity(0.5),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 10),
                          
                          // Wink button
                          Expanded(
                            child: GestureDetector(
                              onTap: _isAccepting ? null : _handleWink,
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor,
                                      AppTheme.secondaryColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: _isAccepting
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.electric_bolt,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'WINK BACK',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _slideController.dispose();
    _glowController.dispose();
    super.dispose();
  }
}