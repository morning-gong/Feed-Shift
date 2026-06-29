import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'data/mock/feed_profiles.dart';
import 'theme/app_theme.dart';
import 'theme/feed_visual_theme.dart';
import 'widgets/glass_card.dart';

class RecommendationPage extends StatelessWidget {
  final ExploreItem item;
  final FeedVisualTheme palette;
  final String sceneTitle;
  final String backgroundImage;

  const RecommendationPage({
    super.key,
    required this.item,
    required this.palette,
    required this.sceneTitle,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _ExploreWallpaper(
              imagePath: backgroundImage,
              palette: palette,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _ExploreTopBar(
                  title: sceneTitle,
                  subtitle: item.subtitle,
                  palette: palette,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroExploreCard(item: item, palette: palette),
                        const SizedBox(height: 14),
                        _TopicsCard(item: item, palette: palette),
                        const SizedBox(height: 14),
                        _ReasonCard(item: item, palette: palette),
                        const SizedBox(height: 24),
                        _FooterText(text: item.footer, palette: palette),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreTopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final FeedVisualTheme palette;

  const _ExploreTopBar({
    required this.title,
    required this.subtitle,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white.withValues(alpha: FsAlpha.icon),
              size: 20,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FsText.sectionHeader(Colors.white)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: FsText.label(Colors.white).copyWith(
                    color: palette.mutedTextColor.withValues(alpha: 0.66),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroExploreCard extends StatelessWidget {
  final ExploreItem item;
  final FeedVisualTheme palette;

  const _HeroExploreCard({required this.item, required this.palette});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 360,
        decoration: BoxDecoration(
          color: palette.surfaceColor.withValues(alpha: 0.74),
          border: Border.all(
            color: palette.borderColor.withValues(alpha: 0.42),
          ),
          boxShadow: [
            BoxShadow(
              color: palette.glowColor.withValues(alpha: 0.18),
              blurRadius: 34,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item.imagePath, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 1.0],
                  colors: [
                    palette.baseColor.withValues(alpha: 0.14),
                    palette.baseColor.withValues(alpha: 0.30),
                    palette.surfaceColor.withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: palette.accentColor.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: palette.borderColor.withValues(alpha: 0.44),
                          ),
                        ),
                        child: Text(
                          '今天就做这一步',
                          style: FsText.chip(Colors.white),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: palette.accentColor.withValues(alpha: 0.86),
                        size: 22,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.08,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.summary,
                    style: FsText.body(
                      Colors.white,
                    ).copyWith(color: Colors.white.withValues(alpha: 0.82)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicsCard extends StatelessWidget {
  final ExploreItem item;
  final FeedVisualTheme palette;

  const _TopicsCard({required this.item, required this.palette});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      palette: palette,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: '具体怎么做',
            subtitle: '按顺序做，不需要打开更多推荐',
            palette: palette,
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < item.topics.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == item.topics.length - 1 ? 0 : 12,
              ),
              child: _TopicRow(
                index: i + 1,
                text: item.topics[i],
                palette: palette,
              ),
            ),
        ],
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  final int index;
  final String text;
  final FeedVisualTheme palette;

  const _TopicRow({
    required this.index,
    required this.text,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: palette.accentColor.withValues(alpha: 0.16),
            border: Border.all(
              color: palette.borderColor.withValues(alpha: 0.34),
            ),
          ),
          child: Center(
            child: Text(
              '$index',
              style: FsText.label(
                Colors.white,
              ).copyWith(color: Colors.white.withValues(alpha: 0.72)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: FsText.bodySmall(Colors.white))),
      ],
    );
  }
}

class _ReasonCard extends StatelessWidget {
  final ExploreItem item;
  final FeedVisualTheme palette;

  const _ReasonCard({required this.item, required this.palette});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      palette: palette,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: '为什么现在适合',
            subtitle: '根据最近看到的内容给出的下一步',
            palette: palette,
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: palette.baseColor.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: palette.borderColor.withValues(alpha: 0.26),
              ),
            ),
            child: Text(
              item.reason,
              style: FsText.caption(Colors.white).copyWith(
                fontSize: 14,
                color: palette.mutedTextColor.withValues(alpha: 0.78),
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final FeedVisualTheme palette;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FsText.cardHeader(Colors.white)),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: FsText.label(
            Colors.white,
          ).copyWith(color: palette.mutedTextColor.withValues(alpha: 0.62)),
        ),
      ],
    );
  }
}

class _FooterText extends StatelessWidget {
  final String text;
  final FeedVisualTheme palette;

  const _FooterText({required this.text, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: FsText.footer(
          Colors.white,
        ).copyWith(color: palette.mutedTextColor.withValues(alpha: 0.48)),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ExploreWallpaper extends StatelessWidget {
  final String imagePath;
  final FeedVisualTheme palette;

  const _ExploreWallpaper({required this.imagePath, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: FsGlass.bgBlurSigma,
            sigmaY: FsGlass.bgBlurSigma,
          ),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.42, 1.0],
              colors: [
                Colors.black.withValues(alpha: 0.42),
                palette.baseColor.withValues(alpha: 0.46),
                palette.surfaceColor.withValues(alpha: 0.92),
              ],
            ),
          ),
        ),
        CustomPaint(painter: _NoisePainter(palette.noiseOpacity)),
      ],
    );
  }
}

class _NoisePainter extends CustomPainter {
  final double opacity;

  const _NoisePainter(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 0.42
      ..color = Colors.white.withValues(alpha: opacity);
    for (var i = 0; i < 150; i++) {
      final x = _noise(i * 6.7, 0.23) * size.width;
      final y = _noise(i * 4.1, 0.71) * size.height;
      canvas.drawLine(Offset(x, y), Offset(x + 0.5, y + 0.2), paint);
    }
  }

  double _noise(double value, double salt) {
    final raw = math.sin(value * 12.9898 + salt * 78.233) * 43758.5453;
    return raw - raw.floorToDouble();
  }

  @override
  bool shouldRepaint(covariant _NoisePainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
