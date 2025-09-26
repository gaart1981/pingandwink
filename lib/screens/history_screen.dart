// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import '../config/emotions.dart';
import '../config/theme.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../helpers/emotion_labels_helper.dart';
import '../l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;
  String? _deviceId;

  // Stats
  int _totalEmotions = 0;
  int _streakDays = 0;
  int? _dominantEmotion;
  final Map<int, int> _emotionCounts = {};

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    // Don't show loading indicator on refresh
    if (_history.isEmpty) {
      setState(() => _isLoading = true);
    }

    try {
      _deviceId = await StorageService.getDeviceId();
      final history = await ApiService.getUserHistory(_deviceId!);

      // Calculate stats
      _calculateStats(history);

      if (mounted) {
        setState(() {
          _history = history;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _calculateStats(List<Map<String, dynamic>> history) {
    _totalEmotions = history.length;

    // Count emotions
    _emotionCounts.clear();
    for (var item in history) {
      final emotion = item['emotion'] as int;
      _emotionCounts[emotion] = (_emotionCounts[emotion] ?? 0) + 1;
    }

    // Find dominant emotion
    if (_emotionCounts.isNotEmpty) {
      _dominantEmotion = _emotionCounts.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
    }

    // Calculate streak (simplified)
    if (history.isNotEmpty) {
      final uniqueDays = history
          .map((e) => DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(e['created_at']).toLocal()))
          .toSet()
          .length;
      _streakDays = uniqueDays;
    }
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
          l10n.historyTitle,
          style: const TextStyle(
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
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  )
                : _history.isEmpty
                    ? _buildEmptyState(l10n)
                    : _buildContent(l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return RefreshIndicator(
      color: AppTheme.primaryColor,
      backgroundColor: Colors.black,
      strokeWidth: 2.5,
      onRefresh: _loadHistory,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '📊',
                  style: TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.historyEmptyTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.historyEmptySubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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

  Widget _buildContent(AppLocalizations l10n) {
    return RefreshIndicator(
      color: AppTheme.primaryColor,
      backgroundColor: Colors.black,
      strokeWidth: 2.5,
      displacement: 40,
      onRefresh: _loadHistory, // Returns Future<void>
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Always allow scroll
        slivers: [
          // Stats header
          SliverToBoxAdapter(
            child: _buildStatsHeader(l10n),
          ),

          // History list
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        l10n.historyMyEmotions,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final emotion = _history[index - 1];
                  return _buildEmotionCard(emotion, l10n);
                },
                childCount: _history.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                icon: '📊',
                value: _totalEmotions.toString(),
                label: l10n.historyStatTotal,
              ),
              _buildStatItem(
                icon: '🔥',
                value: _streakDays.toString(),
                label: l10n.days,
              ),
              if (_dominantEmotion != null)
                _buildStatItem(
                  icon: Emotions.getEmotion(_dominantEmotion!).icon,
                  value:
                      '${((_emotionCounts[_dominantEmotion!]! / _totalEmotions) * 100).round()}%',
                  label: l10n.historyStatDominant,
                ),
            ],
          ),
          if (_emotionCounts.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildEmotionBar(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: _emotionCounts.entries.map((entry) {
            final emotion = Emotions.getEmotion(entry.key);
            final percentage = entry.value / _totalEmotions;

            return Expanded(
              flex: (percentage * 100).round(),
              child: Container(
                color: emotion.color,
                child: percentage > 0.15
                    ? Center(
                        child: Text(
                          emotion.icon,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmotionCard(
      Map<String, dynamic> emotion, AppLocalizations l10n) {
    final emotionConfig = Emotions.getEmotion(emotion['emotion']);
    final dateTime = DateTime.parse(emotion['created_at']).toLocal();
    final date = DateFormat('dd MMM').format(dateTime);
    final time = DateFormat('HH:mm').format(dateTime);
    final isToday = DateFormat('yyyy-MM-dd').format(dateTime) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: emotionConfig.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: emotionConfig.gradient,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      emotionConfig.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        EmotionLabels.getLabel(emotion['emotion'], l10n),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isToday
                            ? l10n.historyTodayFormat(l10n.historyToday, time)
                            : l10n.historyTimeFormat(date, time),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
