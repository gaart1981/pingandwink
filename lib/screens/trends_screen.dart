// lib/screens/trends_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../config/emotions.dart';
import '../config/theme.dart';
import '../config/app_config.dart';
import '../services/storage_service.dart';
import '../services/location_service.dart';
import '../helpers/emotion_labels_helper.dart';
import '../l10n/app_localizations.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen>
    with TickerProviderStateMixin {
  // Animations
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  // Data
  Map<int, int> emotionCounts = {};
  int totalVibes = 0;
  int activeUsers = 0;
  bool isLoading = true;
  Timer? _refreshTimer;

  // Top emotion
  int? topEmotionId;
  String timeOfDay = '';

  // Radius selection
  double selectedRadius = 3; // km
  final List<double> availableRadii = [2, 3, 7, 10];
  String searchRadius = '3 km';

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadTrends();
    _updateTimeOfDay();

    // Refresh every 30 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _loadTrends();
    });
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _fadeController.forward();
  }

  String _getLocalizedTimeOfDay(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return l10n.trendsTimeMorning;
    } else if (hour >= 12 && hour < 17) {
      return l10n.trendsTimeAfternoon;
    } else if (hour >= 17 && hour < 22) {
      return l10n.trendsTimeEvening;
    } else {
      return l10n.trendsTimeLateNight;
    }
  }

  void _updateTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      timeOfDay = 'this morning';
    } else if (hour >= 12 && hour < 17) {
      timeOfDay = 'this afternoon';
    } else if (hour >= 17 && hour < 22) {
      timeOfDay = 'tonight';
    } else {
      timeOfDay = 'late night';
    }
  }

  Future<void> _loadTrends() async {
    try {
      final userData = await StorageService.loadUserData();
      Position? currentPosition = await LocationService.getCurrentLocation();

      // Build query parameters
      final queryParams = <String, String>{
        'device_id': userData.deviceId,
      };

      if (userData.birthYear != null) {
        queryParams['birth_year'] = userData.birthYear.toString();
      }

      if (currentPosition != null) {
        queryParams['lat'] = currentPosition.latitude.toString();
        queryParams['lon'] = currentPosition.longitude.toString();
      }

      // Add radius parameter
      queryParams['radius'] = selectedRadius.toString();

      // Make API request
      final uri = Uri.parse('${AppConfig.supabaseUrl}/functions/v1/get-map')
          .replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Process emotions
        Map<int, int> counts = {};
        final moods = data['moods'] as List? ?? [];

        for (var mood in moods) {
          final emotion = mood['emotion'] as int? ?? 0;
          counts[emotion] = (counts[emotion] ?? 0) + 1;
        }

        // Find top emotion
        int? topEmotion;
        int maxCount = 0;
        counts.forEach((emotion, count) {
          if (count > maxCount) {
            maxCount = count;
            topEmotion = emotion;
          }
        });

        if (!mounted) return;

        setState(() {
          emotionCounts = counts;
          totalVibes = moods.length;
          activeUsers = data['stats']?['unique_users'] ?? moods.length;
          topEmotionId = topEmotion;
          searchRadius = '${selectedRadius.toInt()} km';
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading trends: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
      child: SafeArea(
        bottom: false, 
        child: isLoading
            ? _buildLoading()
            : FadeTransition(
                opacity: _fadeAnimation,
                child: _buildContent(l10n),
              ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
      ),
    );
  }

  Widget _buildContent(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(l10n),
          const SizedBox(height: 20),

          // Radius selector
          _buildRadiusSelector(),
          const SizedBox(height: 20),

          // Stats cards
          _buildStatsRow(l10n),
          const SizedBox(height: 24),

          // Top emotion
          if (topEmotionId != null) ...[
            _buildTopEmotionCard(l10n),
            const SizedBox(height: 24),
          ],

          // Emotion distribution
          _buildEmotionGrid(l10n),
          const SizedBox(height: 24),

          // Motivational quote
          _buildQuoteCard(l10n),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.trendsTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.radar,
                    size: 14,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    searchRadius,
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.trendsEmotionalPulse(_getLocalizedTimeOfDay(l10n)),
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildRadiusSelector() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableRadii.length,
        itemBuilder: (context, index) {
          final radius = availableRadii[index];
          final isSelected = radius == selectedRadius;

          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                selectedRadius = radius;
                isLoading = true;
              });
              _loadTrends();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryColor.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              child: Center(
                child: Text(
                  '${radius.toInt()} km',
                  style: TextStyle(
                    color: isSelected ? AppTheme.primaryColor : Colors.white54,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsRow(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: '⚡',
            value: totalVibes.toString(),
            label: l10n.trendsActiveVibes,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: '👥',
            value: activeUsers.toString(),
            label: l10n.trendsSparkers,
            color: AppTheme.secondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopEmotionCard(AppLocalizations l10n) {
    final emotion = Emotions.getEmotion(topEmotionId!);
    final count = emotionCounts[topEmotionId] ?? 0;
    final percentage =
        totalVibes > 0 ? ((count / totalVibes) * 100).toInt() : 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            emotion.color.withOpacity(0.2),
            emotion.color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: emotion.color.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: emotion.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      emotion.icon,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.trendsDominantEmotion,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  EmotionLabels.getLabel(emotion.index, l10n),
                  style: TextStyle(
                    color: emotion.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.trendsPercentOfSparkers(percentage),
                  style: const TextStyle(
                    color: Colors.white70,
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

  Widget _buildEmotionGrid(AppLocalizations l10n) {
    final sortedEmotions = emotionCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.trendsEmotionDistribution,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...sortedEmotions.map((entry) {
          final emotion = Emotions.getEmotion(entry.key);
          final percentage = totalVibes > 0 ? (entry.value / totalVibes) : 0.0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildEmotionBar(
              emotion: emotion,
              count: entry.value,
              percentage: percentage,
              l10n: l10n,
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildEmotionBar({
    required EmotionConfig emotion,
    required int count,
    required double percentage,
    required AppLocalizations l10n,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Progress bar
            FractionallySizedBox(
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      emotion.color.withOpacity(0.3),
                      emotion.color.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(emotion.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    EmotionLabels.getLabel(emotion.index, l10n),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: emotion.color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard(AppLocalizations l10n) {
    final quotes = [
      l10n.trendsQuote1,
      l10n.trendsQuote2,
      l10n.trendsQuote3,
      l10n.trendsQuote4,
    ];

    final quote = quotes[DateTime.now().hour % quotes.length];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.secondaryColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Center(
        child: Text(
          quote,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
