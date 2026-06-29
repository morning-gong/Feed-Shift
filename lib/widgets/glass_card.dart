import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/feed_visual_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool isPrimary;
  final FeedVisualTheme? palette;

  const GlassCard({
    super.key,
    required this.child,
    required this.padding,
    this.isPrimary = false,
    this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final localPalette = palette;
    final fill = isPrimary ? FsGlass.fillAlphaPrimary : FsGlass.fillAlpha;
    final surface =
        localPalette?.surfaceColor.withValues(alpha: isPrimary ? 0.82 : 0.72) ??
        Colors.black.withValues(alpha: isPrimary ? 0.24 : 0.18);
    final border =
        localPalette?.borderColor.withValues(alpha: isPrimary ? 0.46 : 0.34) ??
        Colors.white.withValues(alpha: FsGlass.borderAlpha);
    return ClipRRect(
      borderRadius: BorderRadius.circular(FsGlass.radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: FsGlass.blurSigma,
          sigmaY: FsGlass.blurSigma,
        ),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: localPalette == null
                ? Colors.white.withValues(alpha: fill)
                : surface,
            borderRadius: BorderRadius.circular(FsGlass.radius),
            border: Border.all(color: border, width: FsGlass.borderWidth),
            boxShadow: [
              if (isPrimary)
                BoxShadow(
                  color: (localPalette?.glowColor ?? Colors.black).withValues(
                    alpha: 0.20,
                  ),
                  blurRadius: 34,
                  offset: const Offset(0, 12),
                ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _CardNoisePainter(
                      localPalette?.noiseOpacity ?? 0.026,
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _CardNoisePainter extends CustomPainter {
  final double opacity;

  const _CardNoisePainter(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 0.35
      ..color = Colors.white.withValues(alpha: opacity);
    for (var i = 0; i < 88; i++) {
      final x = _noise(i * 7.9, 0.13) * size.width;
      final y = _noise(i * 5.1, 0.47) * size.height;
      canvas.drawLine(Offset(x, y), Offset(x + 0.55, y), paint);
    }
  }

  double _noise(double value, double salt) {
    final raw = math.sin(value * 12.9898 + salt * 78.233) * 43758.5453;
    return raw - raw.floorToDouble();
  }

  @override
  bool shouldRepaint(covariant _CardNoisePainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
