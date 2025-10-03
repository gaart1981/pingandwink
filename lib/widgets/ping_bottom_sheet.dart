// lib/widgets/ping_bottom_sheet.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/emotion_data.dart';
import '../config/emotions.dart';
import '../config/theme.dart';

/// Minimalist cyberpunk ping bottom sheet
class PingBottomSheet extends StatefulWidget {
  final EmotionData emotion;
  final double distance;
  final VoidCallback onSendPing;

  const PingBottomSheet({
    Key? key,
    required this.emotion,
    required this.distance,
    required this.onSendPing,
  }) : super(key: key);

  @override
  State<PingBottomSheet> createState() => _PingBottomSheetState();
}

class _PingBottomSheetState extends State<PingBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    HapticFeedback.lightImpact();
  }

  String _formatDistance(double meters) {
    if (meters < 50) return 'very close';
    if (meters < 100) return '${meters.round()}m';
    if (meters < 500) return '${(meters / 10).round() * 10}m';
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }

  String _formatTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}min';
    return '${diff.inHours}h';
  }

  void _sendPing() async {
    if (_isSending) return;

    // Check if DISTANCE to ping is too far
    if (widget.distance > 50000) {
      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vibe too far'),
          backgroundColor: const Color(0xFFFF0066),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isSending = true);
    HapticFeedback.mediumImpact();

    // Call the callback
    widget.onSendPing();

    // Close sheet after short delay
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final emotionConfig = Emotions.getEmotion(widget.emotion.emotion);

    return Container(
      height: widget.distance > 50000 ? 320 : 280,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0015),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(
          color: emotionConfig.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Emotion icon with glow
              AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: emotionConfig.color
                              .withOpacity(_glowAnimation.value),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Container(
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
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Info row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Distance chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: widget.distance > 50000
                          ? const Color(0xFFFF0066).withOpacity(0.1)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.distance > 50000
                            ? const Color(0xFFFF0066).withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.distance > 50000
                              ? Icons.warning
                              : Icons.near_me,
                          size: 14,
                          color: widget.distance > 50000
                              ? const Color(0xFFFF0066)
                              : emotionConfig.color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatDistance(widget.distance),
                          style: TextStyle(
                            color: widget.distance > 50000
                                ? const Color(0xFFFF0066)
                                : emotionConfig.color,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Time chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatTime(widget.emotion.createdAt),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Warning message if distance too far
              if (widget.distance > 50000)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF0066).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFF0066).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: const Color(0xFFFF0066).withOpacity(0.8),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Vibe too far - max 3km to send ping',
                            style: TextStyle(
                              color: const Color(0xFFFF0066).withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const Spacer(),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    // Cancel button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white.withOpacity(0.5),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Send ping button
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: _isSending || widget.distance > 50000
                            ? null
                            : _sendPing,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: widget.distance > 50000
                                  ? [
                                      const Color(0xFFFF0066).withOpacity(0.3),
                                      const Color(0xFFFF0066).withOpacity(0.2)
                                    ]
                                  : _isSending
                                      ? [
                                          Colors.grey.shade800,
                                          Colors.grey.shade700
                                        ]
                                      : [
                                          AppTheme.primaryColor,
                                          AppTheme.secondaryColor
                                        ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: widget.distance > 50000
                                ? Border.all(
                                    color: const Color(0xFFFF0066)
                                        .withOpacity(0.5),
                                    width: 1)
                                : null,
                            boxShadow: _isSending || widget.distance > 50000
                                ? []
                                : [
                                    BoxShadow(
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: widget.distance > 50000
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.block,
                                        color: const Color(0xFFFF0066)
                                            .withOpacity(0.8),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'TROP LOIN',
                                        style: TextStyle(
                                          color: const Color(0xFFFF0066)
                                              .withOpacity(0.8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  )
                                : _isSending
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.flash_on,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'PING',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.2,
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
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }
}
