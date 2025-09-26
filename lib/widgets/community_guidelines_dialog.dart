// lib/widgets/community_guidelines_dialog.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import '../config/theme.dart';
import '../services/moderation_service.dart';
import '../services/storage_service.dart';
import '../l10n/app_localizations.dart';

class CommunityGuidelinesDialog extends StatelessWidget {
  const CommunityGuidelinesDialog({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final deviceId = await StorageService.getDeviceId();
    final hasAccepted = await ModerationService.hasAcceptedGuidelines(deviceId);

    if (!hasAccepted && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CommunityGuidelinesDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with gradient
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.2),
                          AppTheme.secondaryColor.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryColor,
                                AppTheme.secondaryColor,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '✨',
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.guidelinesTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Guidelines content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGuideline(
                          '💜',
                          l10n.guidelinesRespectTitle,
                          l10n.guidelinesRespectSubtitle,
                        ),
                        _buildGuideline(
                          '🚫',
                          l10n.guidelinesNoHarassmentTitle,
                          l10n.guidelinesNoHarassmentSubtitle,
                        ),
                        _buildGuideline(
                          '✨',
                          l10n.guidelinesKeepRealTitle,
                          l10n.guidelinesKeepRealSubtitle,
                        ),
                        _buildGuideline(
                          '🎉',
                          l10n.guidelinesHaveFunTitle,
                          l10n.guidelinesHaveFunSubtitle,
                        ),

                        const SizedBox(height: 24),

                        // Important note
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.orange.shade300,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  l10n.guidelinesViolationWarning,
                                  style: TextStyle(
                                    color: Colors.orange.shade200,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Accept button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final deviceId =
                                  await StorageService.getDeviceId();
                              await ModerationService.acceptGuidelines(
                                  deviceId);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              l10n.guidelinesButtonUnderstand,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
    );
  }

  Widget _buildGuideline(String emoji, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
