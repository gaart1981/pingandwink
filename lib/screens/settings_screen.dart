// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../config/theme.dart';
import '../config/app_config.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../l10n/app_localizations.dart';
import 'legal/privacy_policy.dart';
import 'legal/terms_of_service.dart';
import 'main_container.dart';
import 'onboarding_screen.dart';
import '../widgets/viral_share_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _deviceId;
  bool _notificationsEnabled = true;
  bool _isLoadingNotificationState = true;
  bool _isDarkMapTheme = true;
  bool _isDeletingMood = false;
  bool _isSoftLocation = false;
  int _versionTapCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadNotificationState();
  }

  Future<void> _loadSettings() async {
    _deviceId = await StorageService.getDeviceId();
    // Load saved map theme preference
    _isDarkMapTheme = await StorageService.isDarkMapTheme();
    // Load soft location preference
    _isSoftLocation = await StorageService.isSoftLocationEnabled();
    setState(() {});
  }

  Future<void> _loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _isLoadingNotificationState = false;
    });
  }

  Future<void> _toggleMapTheme(bool isDark, AppLocalizations l10n) async {
    setState(() {
      _isDarkMapTheme = isDark;
    });
    // Save preference
    await StorageService.setDarkMapTheme(isDark);

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isDark
            ? l10n.settingsMapThemeCyberpunkActivated
            : l10n.settingsMapThemeDayActivated),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: l10n.commonOk,
          textColor: Colors.white,
          onPressed: () {
            // Navigate to MainContainer (not /map route)
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MainContainer()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteMoodFromMap(AppLocalizations l10n) async {
    if (_deviceId == null) return;

    setState(() {
      _isDeletingMood = true;
    });

    try {
      // Delete mood from database
      final url = '${AppConfig.supabaseUrl}/rest/v1/moods';
      final queryParams = {
        'device_id': 'eq.$_deviceId',
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
          'apikey': AppConfig.supabaseAnonKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.settingsVibeDeletedSuccess),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
      } else {
        throw Exception('Failed to delete mood');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.settingsVibeDeleteError),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isDeletingMood = false;
      });
    }
  }

  void _showDeleteMoodDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0B2E),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.mood_bad,
                  color: AppTheme.primaryColor,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.settingsDeleteVibeDialogTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.settingsDeleteVibeDialogMessage,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Non button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    // Oui button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pop(context);
                        _deleteMoodFromMap(l10n);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.primaryColor,
                              AppTheme.secondaryColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.settingsTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A0B2E),
                  Colors.black,
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Info Card
                  _buildAppInfoCard(l10n),
                  const SizedBox(height: 20),

                  // Share section
                  _buildShareSection(l10n),

                  // Préférences Section
                  _buildSectionTitle(l10n.settingsSectionPreferences),
                  _buildSettingTile(
                    icon: Icons.notifications_outlined,
                    title: l10n.settingsNotificationsTitle,
                    subtitle: _notificationsEnabled
                        ? l10n.settingsNotificationsEnabled
                        : l10n.settingsNotificationsDisabled,
                    trailing: _isLoadingNotificationState
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primaryColor),
                            ),
                          )
                        : Switch(
                            value: _notificationsEnabled,
                            onChanged: (value) async {
                              // Si désactive - montrer avertissement
                              if (!value) {
                                final shouldDisable = await showDialog<bool>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: const Color(0xFF1A0B2E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(Icons.warning_amber,
                                            color: Color(0xFFFF9900), size: 24),
                                        SizedBox(width: 8),
                                        Text(
                                          l10n.settingsNotificationWarningTitle,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      l10n.settingsNotificationWarningMessage,
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text(
                                            l10n
                                                .settingsNotificationWarningCancel,
                                            style: TextStyle(
                                                color: Colors.white54)),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text(
                                          l10n.settingsNotificationWarningDisable,
                                          style: TextStyle(
                                              color: Color(0xFFFF9900)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (shouldDisable != true) {
                                  return; // Utilisateur a annulé
                                }
                              }

                              // Appliquer le changement
                              setState(() {
                                _notificationsEnabled = value;
                              });

                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool(
                                  'notifications_enabled', value);

                              if (!value) {
                                // Désactiver toutes les notifications
                                await NotificationService
                                    .cancelAllNotifications();
                                OneSignal.Notifications.clearAll();
                                // Правильный способ отключить push в OneSignal
                                OneSignal.User.pushSubscription.optOut();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n
                                        .settingsNotificationsDisabledMessage),
                                    backgroundColor: Color(0xFFFF9900),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              } else {
                                // Réactiver - правильный способ включить push
                                OneSignal.User.pushSubscription.optIn();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n
                                        .settingsNotificationsEnabledMessage),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                  ),

                  _buildSettingTile(
                    icon: Icons.dark_mode_outlined,
                    title: l10n.settingsMapThemeTitle,
                    subtitle: _isDarkMapTheme
                        ? l10n.settingsMapThemeCyberpunk
                        : l10n.settingsMapThemeMinimalist,
                    trailing: Switch(
                      value: _isDarkMapTheme,
                      onChanged: (value) => _toggleMapTheme(value, l10n),
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),

                  _buildSettingTile(
                    icon: Icons.location_on_outlined,
                    title: l10n.settingsLocationModeTitle,
                    subtitle: _isSoftLocation
                        ? l10n.settingsLocationModeSoft
                        : l10n.settingsLocationModeExact,
                    trailing: Switch(
                      value: _isSoftLocation,
                      onChanged: (value) async {
                        setState(() {
                          _isSoftLocation = value;
                        });

                        // Save preference
                        await StorageService.setSoftLocationMode(value);

                        // Show confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  value ? Icons.shuffle : Icons.my_location,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  value
                                      ? l10n.settingsSoftModeEnabled
                                      : l10n.settingsNormalModeEnabled,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            backgroundColor: AppTheme.primaryColor,
                            duration: const Duration(seconds: 3),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),

                  _buildSettingTile(
                    icon: Icons.mood_bad,
                    title: l10n.settingsDeleteVibeTitle,
                    subtitle: l10n.settingsDeleteVibeSubtitle,
                    onTap: () => _showDeleteMoodDialog(l10n),
                    textColor: const Color(0xFFFF9900),
                    loading: _isDeletingMood,
                  ),

                  const SizedBox(height: 20),

                  // Légal Section
                  _buildSectionTitle(l10n.settingsSectionLegal),
                  _buildSettingTile(
                    icon: Icons.privacy_tip_outlined,
                    title: l10n.settingsPrivacyTitle,
                    subtitle: l10n.settingsPrivacySubtitle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),

                  _buildSettingTile(
                    icon: Icons.description_outlined,
                    title: l10n.settingsTermsTitle,
                    subtitle: l10n.settingsTermsSubtitle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TermsOfServiceScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Support Section
                  _buildSectionTitle(l10n.settingsSectionSupport),
                  _buildSettingTile(
                    icon: Icons.help_outline,
                    title: l10n.settingsHelpTitle,
                    subtitle: l10n.settingsHelpSubtitle,
                    onTap: () {
                      _launchURL('https://pingandwink.com/help');
                    },
                  ),

                  _buildSettingTile(
                    icon: Icons.mail_outline,
                    title: l10n.settingsContactTitle,
                    subtitle: l10n.settingsContactEmail,
                    onTap: () {
                      _launchURL(
                          'mailto:hello@pingandwink.com?subject=Ping&Wink Support');
                    },
                  ),

                  const SizedBox(height: 20),

                  // Gestion des données Section
                  _buildSectionTitle(l10n.settingsSectionDataManagement),
                  _buildSettingTile(
                    icon: Icons.delete_outline,
                    title: l10n.settingsDeleteAccountTitle,
                    subtitle: l10n.settingsDeleteAccountSubtitle,
                    onTap: () {
                      _showDeleteAccountDialog(l10n);
                    },
                    textColor: Colors.red,
                  ),

                  const SizedBox(height: 40),

                  // Footer
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _versionTapCount++;
                            if (_versionTapCount >= 5) {
                              _versionTapCount = 0;
                              _showModerationPanel(l10n);
                            }
                          },
                          child: Text(
                            l10n.settingsFooterTagline,
                            style: TextStyle(
                              color: Color.fromARGB(172, 255, 255, 255),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.settingsFooterCopyright,
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                        if (_deviceId != null) ...[
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: _deviceId!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.settingsIdCopied),
                                  backgroundColor: AppTheme.primaryColor,
                                ),
                              );
                            },
                            child: Text(
                              l10n.settingsDeviceIdPrefix(
                                  _deviceId!.substring(0, 8)),
                              style: const TextStyle(
                                color: Colors.white24,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                        // Space for bottom navigation
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.2),
            AppTheme.secondaryColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                '💫',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsAppName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  l10n.settingsAppTagline,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareSection(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.9),
          builder: (context) => const ViralShareCard(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF00D4FF).withOpacity(0.15),
              const Color(0xFFFF00FF).withOpacity(0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                const Color(0xFF00D4FF).withOpacity(0.4), // border brightness
            width: 1.5, // border
          ),
          boxShadow: [
            // illumination
            BoxShadow(
              color: const Color(0xFF00D4FF).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: const Color(0xFFFF00FF).withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon animated
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFFFF00FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsShareTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.settingsShareSubtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7), // brightness
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.7), // arrow fwd
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
    bool loading = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.white.withOpacity(0.05),
            child: InkWell(
              onTap: loading ? null : onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: textColor ?? Colors.white70,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: textColor ?? Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color:
                                  textColor?.withOpacity(0.7) ?? Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (loading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryColor),
                        ),
                      )
                    else if (trailing != null)
                      trailing
                    else if (onTap != null)
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white24,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A0B2E),
        title: Text(
          l10n.settingsDeleteAccountDialogTitle,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          l10n.settingsDeleteAccountDialogMessage,
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              _deleteAccount(l10n);
            },
            child: Text(
              l10n.settingsDeleteAccountDialogDelete,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount(AppLocalizations l10n) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      ),
    );

    try {
      // Delete from server
      await ApiService.deleteUserData(_deviceId!);

      // Clear local data (but keep device ID for new account)
      await StorageService.clearUserData();

      // Cancel notifications
      await NotificationService.cancelAllNotifications();

      // Clear OneSignal subscription
      OneSignal.User.pushSubscription.optOut();

      // Reset onboarding flag to show it again
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_complete', false);

      // Navigate to OnboardingScreen directly
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const OnboardingScreen(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.settingsDeleteAccountError),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showModerationPanel(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0B2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.admin_panel_settings,
                color: AppTheme.primaryColor,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.settingsModerationPanelTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.settingsModerationPanelSubtitle,
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 20),
              // Active bans counter (mock data for review)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(l10n.settingsModerationActiveBans,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text('0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(l10n.settingsModerationReports,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.settingsModerationDataCleared),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.settingsModerationClearData,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
