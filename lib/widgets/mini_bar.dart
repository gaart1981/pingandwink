// lib/widgets/mini_bar.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/emotions.dart';
import '../l10n/app_localizations.dart';

/// Mini bar widget shown when emotion selector is hidden - NO TIMERS
class MiniBar extends StatelessWidget {
  final int? lastEmotion;
  final bool canSubmit;
  final VoidCallback onSwipeUp;

  const MiniBar({
    super.key,
    this.lastEmotion,
    required this.canSubmit,
    required this.onSwipeUp,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < -50) {
          onSwipeUp();
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Row(
                  children: [
                    if (lastEmotion != null)
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: Emotions.getEmotion(lastEmotion!).gradient,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            Emotions.getEmotion(lastEmotion!).icon,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            canSubmit
                                ? 'Send a new ping' // Can send new ping
                                : 'Your ping is active', // Ping already active
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.swipeUp,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
