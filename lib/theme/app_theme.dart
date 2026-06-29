import 'package:flutter/material.dart';

// 鈹€鈹€ Text opacity levels 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsAlpha {
  static const double primary = 0.92;
  static const double secondary = 0.60;
  static const double tertiary = 0.40;
  static const double disabled = 0.35;
  static const double hint = 0.55;
  static const double icon = 0.80;
  static const double dot = 0.40;
}

// 鈹€鈹€ Glass card surface 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsGlass {
  static const double fillAlpha = 0.07; // secondary card background
  static const double fillAlphaPrimary = 0.10; // primary/hero card background
  static const double borderAlpha = 0.10; // card border
  static const double blurSigma = 7.0; // BackdropFilter sigma
  static const double radius = 8.0; // card corner radius
  static const double borderWidth = 1.0;
  static const double bgBlurSigma = 1.1; // ambient background blur
}

// 鈹€鈹€ Chip / pill surfaces 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsChip {
  static const double fillAlpha = 0.07;
  static const double borderAlpha = 0.10;
  static const double radius = 16.0;
}

// 鈹€鈹€ Button surfaces 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsButton {
  static const double primaryFill = 0.15;
  static const double primaryBorder = 0.25;
  static const double secondaryFill = 0.07;
  static const double secondaryBorder = 0.15;
  static const double height = 50.0;
  static const double secondaryHeight = 44.0;
  static const double radius = 25.0;
}

// 鈹€鈹€ Spacing 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;

  static const EdgeInsets pagePadding = EdgeInsets.fromLTRB(20, 36, 20, 40);
  static const EdgeInsets cardPaddingLg = EdgeInsets.all(24);
  static const EdgeInsets cardPaddingMd = EdgeInsets.all(20);
  static const EdgeInsets cardPaddingHome = EdgeInsets.all(18);
}

// 鈹€鈹€ Typography 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsText {
  static TextStyle display(Color base) => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: base.withValues(alpha: FsAlpha.primary),
    height: 1.2,
    letterSpacing: 0,
  );

  static TextStyle title(Color base) => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: base.withValues(alpha: FsAlpha.primary),
    height: 1.3,
    letterSpacing: 0,
  );

  static TextStyle sectionHeader(Color base) => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: base.withValues(alpha: FsAlpha.primary),
  );

  static TextStyle cardHeader(Color base) => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: base.withValues(alpha: 0.90),
  );

  static TextStyle body(Color base) => TextStyle(
    fontSize: 15,
    color: base.withValues(alpha: FsAlpha.secondary),
    height: 1.6,
  );

  static TextStyle bodySmall(Color base) =>
      TextStyle(fontSize: 14, color: base.withValues(alpha: 0.70), height: 1.5);

  static TextStyle caption(Color base) => TextStyle(
    fontSize: 13,
    color: base.withValues(alpha: FsAlpha.hint),
    height: 1.5,
  );

  static TextStyle label(Color base) =>
      TextStyle(fontSize: 12, color: base.withValues(alpha: FsAlpha.tertiary));

  static TextStyle chip(Color base) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: base.withValues(alpha: 0.80),
  );

  static TextStyle footer(Color base) => TextStyle(
    fontSize: 13,
    color: base.withValues(alpha: FsAlpha.disabled),
    height: 1.6,
  );
}

// 鈹€鈹€ Radial glow decoration (reused across pages) 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
class FsGlow {
  static Widget topLeft() =>
      Positioned(top: -80, left: -60, child: _glowCircle(320, 0.08));

  static Widget bottomRight() =>
      Positioned(bottom: -100, right: -80, child: _glowCircle(280, 0.05));

  static Widget _glowCircle(double size, double alpha) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          Colors.white.withValues(alpha: alpha),
          Colors.transparent,
        ],
      ),
    ),
  );
}
