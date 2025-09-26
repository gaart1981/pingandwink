// lib/widgets/viral_share_card.dart
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../config/theme.dart';
import '../l10n/app_localizations.dart';

class ViralShareCard extends StatefulWidget {
  const ViralShareCard({super.key});

  @override
  State<ViralShareCard> createState() => _ViralShareCardState();
}

class _ViralShareCardState extends State<ViralShareCard> {
  final GlobalKey _cardKey = GlobalKey();
  bool _isGenerating = false;

  Future<void> _shareCard() async {
    setState(() => _isGenerating = true);
    HapticFeedback.mediumImpact();

    try {
      // Capture widget as image
      RenderRepaintBoundary boundary =
          _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) throw Exception('Failed to generate image');

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/pingwink_share.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Share via native share sheet
      await Share.shareXFiles(
        [XFile(file.path)],
        text: _getShareText(),
      );
    } catch (e) {
      debugPrint('Error sharing: $e');
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.viralShareFailed),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  String _getShareText() {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 6) {
      return l10n.viralShareTextNight;
    } else if (hour >= 18 && hour < 23) {
      return l10n.viralShareTextEvening;
    } else {
      return l10n.viralShareTextDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),

          // The card to be captured
          RepaintBoundary(
            key: _cardKey,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  // Subtle gradient background
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.5,
                        colors: [
                          const Color(0xFF00D4FF).withOpacity(0.05),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),

                  // Content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Time
                        Text(
                          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.3),
                            fontSize: 14,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Main text
                        Text(
                          l10n.viralShareMainText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 26,
                            height: 1.3,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sub text
                        Text(
                          l10n.viralShareFindOut,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Logo
                        Text(
                          l10n.viralShareLogo,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.25),
                            fontSize: 13,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Minimal floating dots
                  Positioned(
                    top: 50,
                    left: 50,
                    child: _buildDot(),
                  ),
                  Positioned(
                    top: 80,
                    right: 70,
                    child: _buildDot(),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 80,
                    child: _buildDot(),
                  ),
                  Positioned(
                    bottom: 60,
                    right: 50,
                    child: _buildDot(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Share button
          // Share button with pulsing glow effect
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return GestureDetector(
                onTap: _isGenerating ? null : _shareCard,
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00D4FF)
                            .withOpacity(0.15 + value * 0.05),
                        const Color(0xFFFF0080)
                            .withOpacity(0.10 + value * 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF00D4FF)
                          .withOpacity(0.3 + value * 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withOpacity(0.2 * value),
                        blurRadius: 20,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isGenerating
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withOpacity(0.5)),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.white.withOpacity(0.9),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n.viralShareButton,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 2,
      height: 2,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
