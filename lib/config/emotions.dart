// lib/config/emotions.dart
import 'package:flutter/material.dart';

/// Vibe configuration with SUPER BRIGHT NEON colors for Gen Z
class EmotionConfig {
  final String icon;
  final int index;
  final Color color;
  final List<Color> gradient;

  const EmotionConfig({
    required this.icon,
    required this.index,
    required this.color,
    required this.gradient,
  });
}

/// List of all available vibes - Activities instead of emotions
class Emotions {
  static const List<EmotionConfig> list = [
    EmotionConfig(
      icon: '💻',
      index: 0,
      color: Color(0xFF00F5D4), // Mint
      gradient: [Color(0xFF00F5D4), Color(0xFF00D4AA)],
    ),
    EmotionConfig(
      icon: '☕',
      index: 1,
      color: Color(0xFFFF9E6B), // Warm Orange
      gradient: [Color(0xFFFF9E6B), Color(0xFFFF6B3D)],
    ),
    EmotionConfig(
      icon: '🏃',
      index: 2,
      color: Color(0xFFFFB800), // Neon Orange
      gradient: [Color(0xFFFFB800), Color(0xFFFF6B00)],
    ),
    EmotionConfig(
      icon: '🎧',
      index: 3,
      color: Color(0xFF0099FF), // Electric Blue
      gradient: [Color(0xFF0099FF), Color(0xFF00D4FF)],
    ),
    EmotionConfig(
      icon: '🏙️',
      index: 4,
      color: Color.fromARGB(255, 180, 104, 250), // Purple
      gradient: [Color.fromARGB(255, 185, 110, 255), Color(0xFFFF3DAE)],
    ),
    EmotionConfig(
      icon: '📸',
      index: 5,
      color: Color(0xFF6EE7F9), // Soft Cyan
      gradient: [Color(0xFF6EE7F9), Color(0xFFA5B4FC)],
    ),
    EmotionConfig(
      icon: '🍹',
      index: 6,
      color: Color.fromARGB(255, 255, 103, 192), // Hot Pink
      gradient: [Color.fromARGB(255, 250, 94, 185), Color(0xFFFF1744)],
    ),
    EmotionConfig(
      icon: '🎉',
      index: 7,
      color: Color.fromARGB(255, 208, 4, 123), // Pink base
      gradient: [Color.fromARGB(255, 212, 39, 140), Color(0xFF7C3AED)],
    ),
  ];

  static EmotionConfig getEmotion(int index) {
    if (index < 0 || index >= list.length) {
      return list[0];
    }
    return list[index];
  }

  /// Get super neon color for any vibe
  static Color getSuperNeonColor(int index) {
    // Using the main colors from our vibes for consistency
    final vibe = getEmotion(index);
    return vibe.color;
  }

  /// Get glow gradient for vibe
  static List<Color> getGlowGradient(int index) {
    final vibe = getEmotion(index);
    return [
      vibe.gradient[0].withOpacity(0.0),
      vibe.gradient[0].withOpacity(0.3),
      vibe.gradient[1].withOpacity(0.6),
      vibe.gradient[1],
    ];
  }
}
