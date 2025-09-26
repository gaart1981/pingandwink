// lib/config/theme.dart
import 'package:flutter/material.dart';

/// Application theme configuration
class AppTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF00D4FF);
  static const Color secondaryColor = Color(0xFFFF0080);

  // Gradient colors
  static const List<Color> mainGradient = [
    Color(0xFFFF0080),
    Color(0xFFFFD700)
  ];
  static const List<Color> backgroundGradient = [
    Color(0xFF000000),
    Color(0xFF0A0A1A)
  ];

  // Vibe colors (activities)
  static const Color studyColor = Color(0xFF00F5D4);
  static const Color coffeeColor = Color(0xFFFF9E6B);
  static const Color sportColor = Color(0xFFFFB800);
  static const Color musicColor = Color(0xFF0099FF);
  static const Color cityColor = Color(0xFF9333EA);
  static const Color chillColor = Color(0xFF6EE7F9);
  static const Color barColor = Color(0xFFFF3DAE);
  static const Color partyColor = Color(0xFF7C3AED);

  // Get application theme
  static ThemeData getTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
    );
  }

  // Text styles
  static const TextStyle headingStyle = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
  );

  static const TextStyle subtitleStyle = TextStyle(
    color: primaryColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle statsLabelStyle = TextStyle(
    color: Colors.white54,
    fontSize: 10,
  );

  static const TextStyle statsValueStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
}
