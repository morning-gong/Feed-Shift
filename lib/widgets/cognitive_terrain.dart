import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/topic_taxonomy.dart';
import '../theme/feed_visual_theme.dart';
import '../theme/app_theme.dart';

class CognitiveTerrain extends StatelessWidget {
  final TopicTaxonomyResult taxonomy;
  final FeedVisualTheme palette;
  final int recordCount;

  const CognitiveTerrain({
    super.key,
    required this.taxonomy,
    required this.palette,
    required this.recordCount,
  });

  @override
  Widget build(BuildContext context) {
    final highlands = taxonomy.highlands;
    final sparse = taxonomy.sparseTopics;
    return RepaintBoundary(
      child: Container(
        height: 302,
        decoration: BoxDecoration(
          color: palette.surfaceColor.withValues(alpha: 0.76),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: palette.borderColor.withValues(alpha: 0.42),
          ),
          boxShadow: [
            BoxShadow(
              color: palette.glowColor.withValues(alpha: 0.16),
              blurRadius: 34,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _TerrainPainter(
                taxonomy: taxonomy,
                palette: palette,
                recordCount: recordCount,
              ),
            ),
            Positioned(
              left: 18,
              top: 16,
              right: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('最近的信息地形', style: FsText.cardHeader(Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    recordCount > 0 ? '$recordCount 条记录参与塑形' : '有记录后会按你的内容切换',
                    style: FsText.label(Colors.white).copyWith(
                      color: palette.mutedTextColor.withValues(alpha: 0.58),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _TerrainChip(
                    label:
                        '高地：${highlands.isEmpty ? '等待记录' : highlands.map((e) => e.topic.label).join(' / ')}',
                    palette: palette,
                  ),
                  _TerrainChip(
                    label:
                        '稀疏区：${sparse.isEmpty ? '长篇报道 / 健康知识' : sparse.map((e) => e.domain).toSet().take(3).join(' / ')}',
                    palette: palette,
                    quiet: true,
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

class _TerrainChip extends StatelessWidget {
  final String label;
  final FeedVisualTheme palette;
  final bool quiet;

  const _TerrainChip({
    required this.label,
    required this.palette,
    this.quiet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: (quiet ? palette.baseColor : palette.accentColor).withValues(
          alpha: quiet ? 0.32 : 0.20,
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: palette.borderColor.withValues(alpha: 0.36)),
      ),
      child: Text(
        label,
        style: FsText.chip(
          Colors.white,
        ).copyWith(color: Colors.white.withValues(alpha: quiet ? 0.70 : 0.84)),
      ),
    );
  }
}

class _TerrainPainter extends CustomPainter {
  final TopicTaxonomyResult taxonomy;
  final FeedVisualTheme palette;
  final int recordCount;

  const _TerrainPainter({
    required this.taxonomy,
    required this.palette,
    required this.recordCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.52, size.height * 0.57);
    final radiusX = size.width * 0.38;
    final radiusY = size.height * 0.22;
    final island = _organicIsland(center, radiusX, radiusY);

    canvas.drawPath(
      island.shift(const Offset(0, 14)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.24)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20),
    );

    canvas.drawPath(
      island,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            palette.accentColor.withValues(alpha: 0.18),
            palette.baseColor.withValues(alpha: 0.52),
            palette.surfaceColor.withValues(alpha: 0.38),
          ],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      island,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7
        ..color = palette.borderColor.withValues(alpha: 0.45),
    );

    final spikes = _buildSpikes(size, center, radiusX, radiusY);
    spikes.sort((a, b) => a.base.dy.compareTo(b.base.dy));

    for (final spike in spikes) {
      final base = spike.base;
      final top = base.translate(-spike.height * 0.12, -spike.height);
      final alpha = (0.16 + spike.confidence * 0.54).clamp(0.16, 0.82);
      final paint = Paint()
        ..strokeWidth = spike.width
        ..strokeCap = StrokeCap.round
        ..color = palette.terrainSpikeColor.withValues(alpha: alpha);
      canvas.drawLine(base, top, paint);
      canvas.drawCircle(
        top,
        spike.width * 0.42,
        Paint()
          ..color = palette.terrainSpikeColor.withValues(alpha: alpha * 0.56),
      );
    }

    final veilPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              palette.glowColor.withValues(alpha: 0.20),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.width * 0.42),
          );
    canvas.drawRect(Offset.zero & size, veilPaint);

    _drawFineNoise(canvas, size);
  }

  Path _organicIsland(Offset center, double radiusX, double radiusY) {
    final points = <Offset>[];
    const count = 18;
    for (var i = 0; i < count; i++) {
      final t = i / count * math.pi * 2;
      final warp =
          1 +
          math.sin(t * 3.1 + 0.7) * 0.085 +
          math.cos(t * 5.3 - 0.3) * 0.055 +
          math.sin(t * 7.0) * 0.025;
      points.add(
        center.translate(
          math.cos(t) * radiusX * warp,
          math.sin(t) * radiusY * (0.92 + math.cos(t * 2.4) * 0.08),
        ),
      );
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length; i++) {
      final current = points[i];
      final next = points[(i + 1) % points.length];
      final mid = Offset(
        (current.dx + next.dx) / 2,
        (current.dy + next.dy) / 2,
      );
      path.quadraticBezierTo(current.dx, current.dy, mid.dx, mid.dy);
    }
    path.close();
    return path;
  }

  List<_Spike> _buildSpikes(
    Size size,
    Offset center,
    double radiusX,
    double radiusY,
  ) {
    final highlands = taxonomy.highlands;
    final signals = highlands.isEmpty ? const <TopicSignal>[] : highlands;
    final baseStrength = taxonomy.hasSignal ? 1.0 : 0.42;
    final count = (88 + math.min(recordCount, 80)).round();
    final spikes = <_Spike>[];

    for (var i = 0; i < count; i++) {
      final u = _noise(i * 1.7, 0.13);
      final v = _noise(i * 2.1, 0.41);
      final angle = u * math.pi * 2;
      final radius = math.sqrt(v) * (0.98 + math.sin(i * 1.9) * 0.04);
      final x = center.dx + math.cos(angle) * radiusX * radius;
      final y = center.dy + math.sin(angle) * radiusY * radius * 0.92;
      final edge = radius.clamp(0.0, 1.0);
      final field = (1 - edge) * 0.28 + _noise(i * 4.4, 0.77) * 0.34;
      final signal = signals.isEmpty ? null : signals[i % signals.length];
      final strength = signal?.strength ?? 0.28;
      final clusterBoost = signal == null
          ? 0.36
          : (0.62 + strength * 2.8).clamp(0.62, 1.42);
      final height = (18 + 82 * field * baseStrength * clusterBoost)
          .clamp(10, 112)
          .toDouble();
      final confidence = signal?.confidence ?? 0.32;
      final drawChance = (0.34 + strength * 2.2 + (1 - edge) * 0.28).clamp(
        0.25,
        0.92,
      );
      if (_noise(i * 5.9, 0.29) <= drawChance) {
        spikes.add(
          _Spike(
            base: Offset(x, y),
            height: height,
            confidence: confidence,
            width: 0.55 + _noise(i * 3.3, 0.9) * 0.9,
          ),
        );
      }
    }
    return spikes;
  }

  void _drawFineNoise(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 0.35
      ..color = Colors.white.withValues(alpha: palette.noiseOpacity);
    for (var i = 0; i < 120; i++) {
      final x = _noise(i * 8.2, 0.12) * size.width;
      final y = _noise(i * 4.6, 0.54) * size.height;
      canvas.drawLine(Offset(x, y), Offset(x + 0.4, y + 0.4), paint);
    }
  }

  double _noise(double value, double salt) {
    final raw = math.sin(value * 12.9898 + salt * 78.233) * 43758.5453;
    return raw - raw.floorToDouble();
  }

  @override
  bool shouldRepaint(covariant _TerrainPainter oldDelegate) {
    return oldDelegate.taxonomy != taxonomy ||
        oldDelegate.palette != palette ||
        oldDelegate.recordCount != recordCount;
  }
}

class _Spike {
  final Offset base;
  final double height;
  final double confidence;
  final double width;

  const _Spike({
    required this.base,
    required this.height,
    required this.confidence,
    required this.width,
  });
}
