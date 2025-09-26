// lib/models/user_data.dart

/// Model for user data and preferences with birth year support
class UserData {
  final String deviceId;
  final DateTime? lastSubmissionTime;
  final int? lastEmotion;
  final int streakDays;
  final String languageCode;
  final int? birthYear; // Новое поле

  const UserData({
    required this.deviceId,
    this.lastSubmissionTime,
    this.lastEmotion,
    this.streakDays = 1,
    this.languageCode = 'fr',
    this.birthYear,
  });

  /// Check if language is French
  bool get isFrench => languageCode.toLowerCase().startsWith('fr');

  /// Check if user has set birth year
  bool get hasBirthYear => birthYear != null;

  /// Get user age
  int? get age {
    if (birthYear == null) return null;
    return DateTime.now().year - birthYear!;
  }

  /// Get age range that user can see
  AgeRange? get visibleAgeRange {
    if (birthYear == null) return null;

    final currentYear = DateTime.now().year;
    final userAge = currentYear - birthYear!;

    int minYear, maxYear;

    if (userAge < 19) {
      // Если младше 19, минимум 13 лет
      minYear = currentYear - 13;
      maxYear = birthYear! + 6;
    } else {
      // Если 19+, ±6 лет от пользователя
      minYear = birthYear! - 6;
      maxYear = birthYear! + 6;
    }

    return AgeRange(
      minYear: minYear,
      maxYear: maxYear,
      minAge: currentYear - maxYear,
      maxAge: currentYear - minYear,
    );
  }

  /// Copy with new values
  UserData copyWith({
    String? deviceId,
    DateTime? lastSubmissionTime,
    int? lastEmotion,
    int? streakDays,
    String? languageCode,
    int? birthYear,
  }) {
    return UserData(
      deviceId: deviceId ?? this.deviceId,
      lastSubmissionTime: lastSubmissionTime ?? this.lastSubmissionTime,
      lastEmotion: lastEmotion ?? this.lastEmotion,
      streakDays: streakDays ?? this.streakDays,
      languageCode: languageCode ?? this.languageCode,
      birthYear: birthYear ?? this.birthYear,
    );
  }

  /// Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'birth_year': birthYear,
      'language_code': languageCode,
    };
  }
}

/// Age range model
class AgeRange {
  final int minYear;
  final int maxYear;
  final int minAge;
  final int maxAge;

  const AgeRange({
    required this.minYear,
    required this.maxYear,
    required this.minAge,
    required this.maxAge,
  });

  @override
  String toString() => '$minAge-$maxAge лет';
}
