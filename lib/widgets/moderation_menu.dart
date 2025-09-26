// lib/widgets/moderation_menu.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import '../config/theme.dart';
import '../l10n/app_localizations.dart';

class ModerationMenu extends StatelessWidget {
  final bool canBan;
  final VoidCallback onBan;
  final Function(String reason) onReport;
  final VoidCallback onEndChat;

  const ModerationMenu({
    super.key,
    required this.canBan,
    required this.onBan,
    required this.onReport,
    required this.onEndChat,
  });

  static void show({
    required BuildContext context,
    required bool canBan,
    required VoidCallback onBan,
    required Function(String) onReport,
    required VoidCallback onEndChat,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true, // Allows custom height
      useSafeArea: true, // Respects safe areas
      builder: (context) => ModerationMenu(
        canBan: canBan,
        onBan: onBan,
        onReport: onReport,
        onEndChat: onEndChat,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Fixed height menu that shows all content
    return Container(
      margin: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.6, // Max 60% of screen
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Take minimum required space
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 20),

                // Moderation options
                Flexible(
                  child: SingleChildScrollView(
                    physics:
                        const NeverScrollableScrollPhysics(), // No scroll if content fits
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Ban button (only if can ban)
                          if (canBan) ...[
                            _buildMenuItem(
                              icon: Icons.block,
                              iconColor: Colors.orange,
                              title: l10n.moderationBanTitle,
                              subtitle: l10n.moderationBanSubtitle,
                              onTap: () {
                                Navigator.pop(context);
                                onBan();
                              },
                            ),
                            _buildDivider(),
                          ],

                          // Report button
                          _buildMenuItem(
                            icon: Icons.flag_outlined,
                            iconColor: Colors.yellow,
                            title: l10n.moderationReportTitle,
                            subtitle: l10n.moderationReportSubtitle,
                            onTap: () {
                              Navigator.pop(context);
                              _showReportDialog(context, (String reason) {
                                onReport(reason);
                              });
                            },
                          ),

                          _buildDivider(),

                          // End chat button (highlighted)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.withOpacity(0.2),
                                  Colors.red.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.3),
                              ),
                            ),
                            child: _buildMenuItem(
                              icon: Icons.exit_to_app,
                              iconColor: Colors.red,
                              title: l10n.moderationEndChatTitle,
                              subtitle: l10n.moderationEndChatSubtitle,
                              onTap: () {
                                Navigator.pop(context);
                                onEndChat();
                              },
                              isHighlighted: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Cancel button - always visible
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        l10n.commonCancel,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Safe area padding for bottom
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
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
                    title,
                    style: TextStyle(
                      color: isHighlighted ? Colors.red.shade300 : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: Colors.white.withOpacity(0.05),
    );
  }

  void _showReportDialog(BuildContext context, Function(String) onConfirm) {
    final l10n = AppLocalizations.of(context)!;
    String selectedReason = 'harassment';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 350,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.moderationReportDialogTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Report reasons
                          _buildRadioOption(
                            value: 'harassment',
                            groupValue: selectedReason,
                            label: l10n.moderationReportReasonHarassment,
                            onChanged: (value) =>
                                setState(() => selectedReason = value!),
                          ),
                          _buildRadioOption(
                            value: 'spam',
                            groupValue: selectedReason,
                            label: l10n.moderationReportReasonSpam,
                            onChanged: (value) =>
                                setState(() => selectedReason = value!),
                          ),
                          _buildRadioOption(
                            value: 'hate_speech',
                            groupValue: selectedReason,
                            label: l10n.moderationReportReasonHateSpeech,
                            onChanged: (value) =>
                                setState(() => selectedReason = value!),
                          ),
                          _buildRadioOption(
                            value: 'other',
                            groupValue: selectedReason,
                            label: l10n.moderationReportReasonOther,
                            onChanged: (value) =>
                                setState(() => selectedReason = value!),
                          ),

                          const SizedBox(height: 24),

                          // Action buttons
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                  child: Text(
                                    l10n.commonCancel,
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    onConfirm(selectedReason);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    l10n.moderationReportSendButton,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildRadioOption({
    required String value,
    required String groupValue,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      height: 48,
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        activeColor: AppTheme.primaryColor,
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
