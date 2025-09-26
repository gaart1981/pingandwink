// lib/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../config/theme.dart';
import '../l10n/app_localizations.dart';

/// Bottom navigation bar with 5 items and center add button
class MoodMapBottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MoodMapBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<MoodMapBottomNav> createState() => _MoodMapBottomNavState();
}

class _MoodMapBottomNavState extends State<MoodMapBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 85 + MediaQuery.of(context).padding.bottom,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Container(
                height: 85,
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.map_outlined,
                      activeIcon: Icons.map,
                      label: l10n.bottomNavMap,
                      index: 0,
                    ),
                    _buildNavItem(
                      icon: Icons.history_outlined,
                      activeIcon: Icons.history,
                      label: l10n.bottomNavHistory,
                      index: 1,
                    ),
                    _buildCenterButton(),
                    _buildNavItem(
                      icon: Icons.trending_up_outlined,
                      activeIcon: Icons.trending_up,
                      label: l10n.bottomNavTrends,
                      index: 2,
                    ),
                    _buildNavItem(
                      icon: Icons.settings_outlined,
                      activeIcon: Icons.settings,
                      label: l10n.bottomNavSettings,
                      index: 3,
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

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = widget.currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap(index);
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  key: ValueKey(isSelected),
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Colors.white.withOpacity(0.4),
                  size: 26,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Colors.white.withOpacity(0.4),
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(label),
              ),
              // Indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppTheme.primaryColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
        HapticFeedback.mediumImpact();
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap(-1); // Special index for emotion selector
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.secondaryColor,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: AppTheme.secondaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          );
        },
      ),
    );
  }
}
