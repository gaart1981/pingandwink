// lib/widgets/community_guidelines_dialog.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
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
    
    // Получаем размеры экрана для адаптации
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;
    
    // Рассчитываем максимальную высоту диалога (80% от доступной высоты)
    final maxDialogHeight = (screenHeight - padding.top - padding.bottom) * 0.85;
    
    // Адаптивные отступы в зависимости от размера экрана
    final isSmallScreen = screenHeight < 700;
    final contentPadding = isSmallScreen ? 16.0 : 24.0;
    final verticalSpacing = isSmallScreen ? 16.0 : 24.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: math.max(padding.top + 16, 24),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: math.min(350, screenWidth - 32),
          maxHeight: maxDialogHeight,
        ),
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
                  // Header с градиентом (фиксированный)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(contentPadding),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.2),
                          AppTheme.secondaryColor.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: isSmallScreen ? 50 : 60,
                          height: isSmallScreen ? 50 : 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryColor,
                                AppTheme.secondaryColor,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '✨',
                              style: TextStyle(fontSize: isSmallScreen ? 24 : 28),
                            ),
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 12 : 16),
                        Text(
                          l10n.guidelinesTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Прокручиваемый контент
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(contentPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGuideline(
                            '💜',
                            l10n.guidelinesRespectTitle,
                            l10n.guidelinesRespectSubtitle,
                            isSmallScreen,
                          ),
                          _buildGuideline(
                            '🚫',
                            l10n.guidelinesNoHarassmentTitle,
                            l10n.guidelinesNoHarassmentSubtitle,
                            isSmallScreen,
                          ),
                          _buildGuideline(
                            '✨',
                            l10n.guidelinesKeepRealTitle,
                            l10n.guidelinesKeepRealSubtitle,
                            isSmallScreen,
                          ),
                          _buildGuideline(
                            '🎉',
                            l10n.guidelinesHaveFunTitle,
                            l10n.guidelinesHaveFunSubtitle,
                            isSmallScreen,
                          ),

                          SizedBox(height: verticalSpacing),

                          // Важное примечание
                          Container(
                            padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.orange.shade300,
                                  size: isSmallScreen ? 18 : 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    l10n.guidelinesViolationWarning,
                                    style: TextStyle(
                                      color: Colors.orange.shade200,
                                      fontSize: isSmallScreen ? 11 : 12,
                                      height: 1.3,
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

                  // Кнопка принятия (всегда видима)
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      contentPadding,
                      isSmallScreen ? 12 : 16,
                      contentPadding,
                      contentPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final deviceId = await StorageService.getDeviceId();
                            await ModerationService.acceptGuidelines(deviceId);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 14 : 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            l10n.guidelinesButtonUnderstand,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 15 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildGuideline(String emoji, String title, String subtitle, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 6 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isSmallScreen ? 36 : 40,
            height: isSmallScreen ? 36 : 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                emoji, 
                style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: isSmallScreen ? 11 : 12,
                    height: 1.3,
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