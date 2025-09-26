// lib/helpers/emotion_labels.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Helper class to get localized labels for emotions
/// Separates localization from data models
class EmotionLabels {
  /// Get localized label for emotion by index
  static String getLabel(int index, AppLocalizations l10n) {
    switch (index) {
      case 0:
        return l10n.vibeLabelBrainMode;
      case 1:
        return l10n.vibeLabelLatteBreak;
      case 2:
        return l10n.vibeLabelSportMode;
      case 3:
        return l10n.vibeLabelSoundLoop;
      case 4:
        return l10n.vibeLabelCityWalk;
      case 5:
        return l10n.vibeLabelContentMode;
      case 6:
        return l10n.vibeLabelChillNight;
      case 7:
        return l10n.vibeLabelPartyMode;
      default:
        return l10n.vibeLabelBrainMode;
    }
  }
  
  /// Get localized label using BuildContext
  static String getLabelFromContext(int index, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return getLabel(index, l10n);
  }
}