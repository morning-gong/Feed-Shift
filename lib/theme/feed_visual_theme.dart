import 'package:flutter/material.dart';

enum FeedVisualFamily {
  tech,
  archive,
  health,
  finance,
  entertainment,
  reflection,
}

class FeedVisualTheme {
  final String backgroundImage;
  final Color baseColor;
  final Color surfaceColor;
  final Color borderColor;
  final Color accentColor;
  final Color glowColor;
  final Color terrainSpikeColor;
  final Color mutedTextColor;
  final double noiseOpacity;

  const FeedVisualTheme({
    required this.backgroundImage,
    required this.baseColor,
    required this.surfaceColor,
    required this.borderColor,
    required this.accentColor,
    required this.glowColor,
    required this.terrainSpikeColor,
    required this.mutedTextColor,
    required this.noiseOpacity,
  });

  List<Color> get gradientColors => [accentColor, baseColor, surfaceColor];
}

const String _base = 'assets/backgrounds/feedshift';

const Map<FeedVisualFamily, FeedVisualTheme> kFeedVisualThemes = {
  FeedVisualFamily.tech: FeedVisualTheme(
    backgroundImage: '$_base/terrain-tech-generated.png',
    baseColor: Color(0xFF102229),
    surfaceColor: Color(0xCC111B1F),
    borderColor: Color(0x668BC7D3),
    accentColor: Color(0xFFA8D7D9),
    glowColor: Color(0x6675C4D6),
    terrainSpikeColor: Color(0xFFD7F4F0),
    mutedTextColor: Color(0xFFC0D2D0),
    noiseOpacity: 0.034,
  ),
  FeedVisualFamily.archive: FeedVisualTheme(
    backgroundImage: '$_base/terrain-archive-generated.png',
    baseColor: Color(0xFF251C14),
    surfaceColor: Color(0xCC211A13),
    borderColor: Color(0x66D8B983),
    accentColor: Color(0xFFD9B87A),
    glowColor: Color(0x669C7A45),
    terrainSpikeColor: Color(0xFFF1D6A0),
    mutedTextColor: Color(0xFFD7C5A4),
    noiseOpacity: 0.042,
  ),
  FeedVisualFamily.health: FeedVisualTheme(
    backgroundImage: '$_base/terrain-health-generated.png',
    baseColor: Color(0xFF102015),
    surfaceColor: Color(0xCC121C14),
    borderColor: Color(0x667DB28A),
    accentColor: Color(0xFF9BC899),
    glowColor: Color(0x665AA76A),
    terrainSpikeColor: Color(0xFFCFEEC7),
    mutedTextColor: Color(0xFFC3D5BD),
    noiseOpacity: 0.032,
  ),
  FeedVisualFamily.finance: FeedVisualTheme(
    backgroundImage: '$_base/terrain-finance-generated.png',
    baseColor: Color(0xFF0D1F18),
    surfaceColor: Color(0xCC111B17),
    borderColor: Color(0x6679A186),
    accentColor: Color(0xFFC4CDA0),
    glowColor: Color(0x666C8A64),
    terrainSpikeColor: Color(0xFFE0E8B8),
    mutedTextColor: Color(0xFFC7D0B8),
    noiseOpacity: 0.038,
  ),
  FeedVisualFamily.entertainment: FeedVisualTheme(
    backgroundImage: '$_base/terrain-entertainment-generated.png',
    baseColor: Color(0xFF2A1115),
    surfaceColor: Color(0xCC211114),
    borderColor: Color(0x668E6370),
    accentColor: Color(0xFFE1A0A9),
    glowColor: Color(0x668F4D61),
    terrainSpikeColor: Color(0xFFF3C0C8),
    mutedTextColor: Color(0xFFD4B9BE),
    noiseOpacity: 0.036,
  ),
  FeedVisualFamily.reflection: FeedVisualTheme(
    backgroundImage: '$_base/terrain-reflection-generated.png',
    baseColor: Color(0xFF1B1C1C),
    surfaceColor: Color(0xCC181919),
    borderColor: Color(0x667D8580),
    accentColor: Color(0xFFBFC4BE),
    glowColor: Color(0x667A817D),
    terrainSpikeColor: Color(0xFFE1E5DE),
    mutedTextColor: Color(0xFFC8CDC5),
    noiseOpacity: 0.045,
  ),
};
