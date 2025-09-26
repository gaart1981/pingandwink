// lib/widgets/success_dialog.dart
import 'package:flutter/material.dart';
import '../config/emotions.dart';
import '../config/theme.dart';
import '../models/user_data.dart';
import '../l10n/app_localizations.dart';

/// Success dialog shown after emotion submission
class SuccessDialog extends StatelessWidget {
  final int emotion;
  final int nearbyCount;
  final String socialProof;
  final int streakDays;
  final int happinessPercent;
  final UserData userData;
  final double latitude;
  final double longitude;

  const SuccessDialog({
    super.key,
    required this.emotion,
    required this.nearbyCount,
    required this.socialProof,
    required this.streakDays,
    required this.happinessPercent,
    required this.userData,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final emotionConfig = Emotions.getEmotion(emotion);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              emotionConfig.color.withOpacity(0.2),
              const Color(0xFF1A0B2E).withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: emotionConfig.color, width: 2),
          boxShadow: [
            BoxShadow(
              color: emotionConfig.color.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🔥✨💫⚡🌟',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.youAreNotAlone,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: emotionConfig.color.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(color: emotionConfig.color, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: emotionConfig.color.withOpacity(0.6),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      emotionConfig.icon,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    Text(
                      l10n.you,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '+$nearbyCount ${l10n.others}',
                      style: TextStyle(
                        color: emotionConfig.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: AppTheme.mainGradient),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                l10n.streak(streakDays),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (socialProof.isNotEmpty)
              Text(
                socialProof,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                l10n.close,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
