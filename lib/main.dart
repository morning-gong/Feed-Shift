// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'accessibility_page.dart';
import 'data/mock/feed_profiles.dart';
import 'data/topic_taxonomy.dart';
import 'detail_page.dart';
import 'recommendation_page.dart';
import 'services/accessibility_reader.dart';
import 'theme/app_theme.dart';
import 'theme/feed_visual_theme.dart';
import 'widgets/cognitive_terrain.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const FeedShiftApp());
}

class FeedShiftApp extends StatelessWidget {
  const FeedShiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeedShift',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB9A78D),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF11100D),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {TargetPlatform.android: _FadeSlideTransitionBuilder()},
        ),
      ),
      home: const HomePage(),
    );
  }
}

class _FadeSlideTransitionBuilder extends PageTransitionsBuilder {
  const _FadeSlideTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _enabled = false;
  bool _loading = true;
  WeatherSnapshot? _weather;
  List<AccessibilityLogEntry> _logs = const [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _refresh();
    _timer = Timer.periodic(
      const Duration(seconds: 6),
      (_) => _refresh(silent: true),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _refresh({bool silent = false}) async {
    if (!silent && mounted) setState(() => _loading = true);
    try {
      final enabled = await AccessibilityReader.isEnabled();
      final logs = await AccessibilityReader.getLogs();
      WeatherSnapshot? weather = _weather;
      if (logs.isEmpty) {
        weather = await WeatherSnapshot.fetchShanghai().timeout(
          const Duration(seconds: 4),
          onTimeout: () => _weather ?? WeatherSnapshot.fallback(),
        );
      }
      if (!mounted) return;
      setState(() {
        _enabled = enabled;
        _logs = logs;
        _weather = weather;
        _loading = false;
      });
    } on Object {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final insight = FeedInsight.from(logs: _logs, weather: _weather);
    final current = insight.state;
    final palette = insight.palette;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _AmbientBackground(palette: palette)),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                children: [
                  _TopBar(
                    enabled: _enabled,
                    loading: _loading,
                    palette: palette,
                    onAccessibility: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AccessibilityPage(),
                      ),
                    ).then((_) => _refresh()),
                    onSettings: AccessibilityReader.openSettings,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  _CinematicClimatePanel(
                    insight: insight,
                    onOpenDetail: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          state: current,
                          palette: palette,
                          sceneTitle: insight.sceneTitle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CognitiveTerrain(
                    taxonomy: insight.taxonomy,
                    palette: palette,
                    recordCount: insight.recordCount,
                  ),
                  const SizedBox(height: 14),
                  _TerrainPrompt(insight: insight),
                  const SizedBox(height: 14),
                  _QuietExploreRow(
                    state: current,
                    palette: palette,
                    sceneTitle: insight.sceneTitle,
                    onOpen: (item) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecommendationPage(
                          item: item,
                          palette: palette,
                          sceneTitle: insight.sceneTitle,
                          backgroundImage: palette.backgroundImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedInsight {
  final FeedState state;
  final FeedVisualTheme palette;
  final TopicTaxonomyResult taxonomy;
  final bool fromLogs;
  final String sourceLabel;
  final String title;
  final String description;
  final String action;
  final String reason;
  final String sceneTitle;
  final String topPackage;
  final int recordCount;
  final WeatherSnapshot? weather;

  const FeedInsight({
    required this.state,
    required this.palette,
    required this.taxonomy,
    required this.fromLogs,
    required this.sourceLabel,
    required this.title,
    required this.description,
    required this.action,
    required this.reason,
    required this.sceneTitle,
    required this.topPackage,
    required this.recordCount,
    required this.weather,
  });

  factory FeedInsight.from({
    required List<AccessibilityLogEntry> logs,
    required WeatherSnapshot? weather,
  }) {
    final text = logs.map((e) => e.packageName + '\n' + e.text).join('\n');
    final taxonomy = TopicTaxonomy.analyzeText(text);
    if (logs.isEmpty) {
      final selected = _stateFromWeather(weather);
      final palette = kFeedVisualThemes[FeedVisualFamily.archive]!;
      final weatherLabel = weather == null
          ? '天气加载中'
          : '上海 ' +
                weather.temperature.round().toString() +
                '℃ · ' +
                weather.label;
      return FeedInsight(
        state: selected,
        palette: palette,
        taxonomy: taxonomy,
        fromLogs: false,
        sourceLabel: '有记录后会按你的内容切换',
        title: '先等一片地形长出来',
        description: weatherLabel + '。现在还没有足够记录，先用一层安静的背景承接首页。',
        action: '明天可以补：睡眠、公司财报、住房报道',
        reason: '打开内容 App 看几条，再回到 FeedShift。这里会按最近看到的内容重新生成地形。',
        sceneTitle: '从熟悉内容旁边走一步',
        topPackage: '暂无',
        recordCount: 0,
        weather: weather,
      );
    }

    final palette = taxonomy.visualTheme;
    final family = taxonomy.highlands.isEmpty
        ? FeedVisualFamily.archive
        : taxonomy.highlands.first.topic.visualFamily;
    final topPackage = _topPackage(logs);
    return FeedInsight(
      state: _stateFromVisualFamily(family),
      palette: palette,
      taxonomy: taxonomy,
      fromLogs: true,
      sourceLabel: '根据最近看到的内容',
      title: '最近的信息地形',
      description: '高地：${taxonomy.highlandLabel}\n稀疏区：${taxonomy.sparseLabel}',
      action: '明天可以补：${_tomorrowTopics(taxonomy)}',
      reason: taxonomy.dailyPrompt,
      sceneTitle: taxonomy.sceneTitle,
      topPackage: topPackage,
      recordCount: logs.length,
      weather: weather,
    );
  }

  static String _tomorrowTopics(TopicTaxonomyResult taxonomy) {
    final sparse = taxonomy.sparseTopics;
    if (sparse.isNotEmpty) {
      return sparse.expand((topic) => topic.expandTo).take(3).join('、');
    }
    final highlands = taxonomy.highlands;
    if (highlands.isNotEmpty) {
      return highlands.first.topic.expandTo.take(3).join('、');
    }
    return '睡眠、公司财报、住房报道';
  }

  static String _topPackage(List<AccessibilityLogEntry> logs) {
    final counts = <String, int>{};
    for (final log in logs) {
      if (log.packageName.isEmpty) continue;
      counts[log.packageName] = (counts[log.packageName] ?? 0) + 1;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.isEmpty ? '未知 App' : entries.first.key;
  }

  static FeedState _stateFromVisualFamily(FeedVisualFamily family) {
    switch (family) {
      case FeedVisualFamily.tech:
        return kFeedStates[4];
      case FeedVisualFamily.archive:
        return kFeedStates[3];
      case FeedVisualFamily.health:
        return kFeedStates[1];
      case FeedVisualFamily.finance:
        return kFeedStates[8];
      case FeedVisualFamily.entertainment:
        return kFeedStates[0];
      case FeedVisualFamily.reflection:
        return kFeedStates[7];
    }
  }

  static FeedState _stateFromWeather(WeatherSnapshot? weather) {
    final code = weather?.weatherCode;
    if (code == null) return kFeedStates[0];
    if (code == 0 || code == 1) return kFeedStates[1];
    if (code == 2 || code == 3 || code == 45 || code == 48) {
      return kFeedStates[6];
    }
    if (code >= 51 && code <= 67) return kFeedStates[7];
    if (code >= 71 && code <= 77) return kFeedStates[8];
    if (code >= 80 && code <= 99) return kFeedStates[3];
    return kFeedStates[0];
  }
}

class WeatherSnapshot {
  final double temperature;
  final int weatherCode;
  final String label;

  const WeatherSnapshot({
    required this.temperature,
    required this.weatherCode,
    required this.label,
  });

  static WeatherSnapshot fallback() =>
      const WeatherSnapshot(temperature: 22, weatherCode: 3, label: '默认多云');

  static Future<WeatherSnapshot> fetchShanghai() async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=31.2304&longitude=121.4737&current=temperature_2m,weather_code&timezone=Asia%2FShanghai',
    );
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 4);
    try {
      final request = await client.getUrl(uri);
      final response = await request.close();
      final raw = await response.transform(utf8.decoder).join();
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final current = data['current'] as Map<String, dynamic>;
      final temperature = (current['temperature_2m'] as num).toDouble();
      final code = (current['weather_code'] as num).toInt();
      return WeatherSnapshot(
        temperature: temperature,
        weatherCode: code,
        label: _weatherLabel(code),
      );
    } finally {
      client.close(force: true);
    }
  }

  static String _weatherLabel(int code) {
    if (code == 0 || code == 1) return '晴朗';
    if (code == 2 || code == 3) return '多云';
    if (code == 45 || code == 48) return '雾';
    if (code >= 51 && code <= 67) return '小雨';
    if (code >= 71 && code <= 77) return '雪';
    if (code >= 80 && code <= 82) return '阵雨';
    if (code >= 95) return '雷雨';
    return '天气变化';
  }
}

class _TopBar extends StatelessWidget {
  final bool enabled;
  final bool loading;
  final FeedVisualTheme palette;
  final VoidCallback onAccessibility;
  final VoidCallback onSettings;

  const _TopBar({
    required this.enabled,
    required this.loading,
    required this.palette,
    required this.onAccessibility,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FeedShift', style: FsText.sectionHeader(Colors.white)),
              const SizedBox(height: 3),
              Text(
                loading
                    ? '正在更新最近注意力'
                    : enabled
                    ? '根据最近看到的内容'
                    : '开启无障碍后开始观察',
                style: FsText.label(Colors.white).copyWith(
                  color: palette.mutedTextColor.withValues(alpha: 0.64),
                ),
              ),
            ],
          ),
        ),
        _IconCircleButton(
          icon: Icons.settings_accessibility_rounded,
          tooltip: '开启无障碍',
          palette: palette,
          onTap: onSettings,
        ),
        const SizedBox(width: 8),
        _IconCircleButton(
          icon: Icons.visibility_rounded,
          tooltip: '查看日志探针',
          palette: palette,
          onTap: onAccessibility,
        ),
      ],
    );
  }
}

class _CinematicClimatePanel extends StatelessWidget {
  final FeedInsight insight;
  final VoidCallback onOpenDetail;

  const _CinematicClimatePanel({
    required this.insight,
    required this.onOpenDetail,
  });

  @override
  Widget build(BuildContext context) {
    final palette = insight.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        color: palette.surfaceColor.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: palette.borderColor.withValues(alpha: 0.40)),
        boxShadow: [
          BoxShadow(
            color: palette.glowColor.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _NoisePainter(palette.noiseOpacity)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    insight.sourceLabel,
                    style: FsText.label(Colors.white).copyWith(
                      color: palette.mutedTextColor.withValues(alpha: 0.72),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    insight.fromLogs ? '${insight.recordCount} 条' : '等待记录',
                    style: FsText.label(Colors.white).copyWith(
                      color: palette.mutedTextColor.withValues(alpha: 0.52),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                insight.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  height: 1.12,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                insight.description,
                style: FsText.body(Colors.white).copyWith(
                  color: Colors.white.withValues(alpha: 0.78),
                  height: 1.52,
                ),
              ),
              const SizedBox(height: 20),
              _ActionStrip(text: insight.action, palette: palette),
              const SizedBox(height: 16),
              Text(
                insight.reason,
                style: FsText.caption(Colors.white).copyWith(
                  color: palette.mutedTextColor.withValues(alpha: 0.70),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _TextAction(
                    label: '打开卡片',
                    palette: palette,
                    onTap: onOpenDetail,
                  ),
                  const SizedBox(width: 12),
                  _Pill(label: insight.sceneTitle, palette: palette),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TerrainPrompt extends StatelessWidget {
  final FeedInsight insight;

  const _TerrainPrompt({required this.insight});

  @override
  Widget build(BuildContext context) {
    final palette = insight.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      decoration: BoxDecoration(
        color: palette.surfaceColor.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: palette.borderColor.withValues(alpha: 0.32)),
      ),
      child: Text(
        insight.reason,
        style: FsText.bodySmall(
          Colors.white,
        ).copyWith(color: palette.mutedTextColor.withValues(alpha: 0.78)),
      ),
    );
  }
}

class _QuietExploreRow extends StatelessWidget {
  final FeedState state;
  final FeedVisualTheme palette;
  final String sceneTitle;
  final ValueChanged<ExploreItem> onOpen;

  const _QuietExploreRow({
    required this.state,
    required this.palette,
    required this.sceneTitle,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: state.explore.take(2).map((item) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: item == state.explore.first ? 10 : 0,
            ),
            child: _QuietCard(
              item: item,
              palette: palette,
              onTap: () => onOpen(item),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuietCard extends StatelessWidget {
  final ExploreItem item;
  final FeedVisualTheme palette;
  final VoidCallback onTap;

  const _QuietCard({
    required this.item,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 154,
          decoration: BoxDecoration(
            color: palette.surfaceColor.withValues(alpha: 0.66),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: palette.borderColor.withValues(alpha: 0.34),
            ),
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
                    colors: [
                      palette.baseColor.withValues(alpha: 0.14),
                      palette.baseColor.withValues(alpha: 0.28),
                      palette.surfaceColor.withValues(alpha: 0.88),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('下一步', style: FsText.label(Colors.white)),
                    const Spacer(),
                    Text(
                      item.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FsText.cardHeader(Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FsText.label(Colors.white).copyWith(
                        color: palette.mutedTextColor.withValues(alpha: 0.68),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionStrip extends StatelessWidget {
  final String text;
  final FeedVisualTheme palette;

  const _ActionStrip({required this.text, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: palette.accentColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: palette.borderColor.withValues(alpha: 0.42)),
      ),
      child: Row(
        children: [
          Icon(Icons.explore_rounded, color: palette.accentColor, size: 18),
          const SizedBox(width: 9),
          Expanded(child: Text(text, style: FsText.cardHeader(Colors.white))),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final FeedVisualTheme palette;

  const _Pill({required this.label, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: palette.baseColor.withValues(alpha: 0.32),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: palette.borderColor.withValues(alpha: 0.36),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: FsText.chip(Colors.white),
        ),
      ),
    );
  }
}

class _TextAction extends StatelessWidget {
  final String label;
  final FeedVisualTheme palette;
  final VoidCallback onTap;

  const _TextAction({
    required this.label,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: palette.accentColor.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: palette.borderColor.withValues(alpha: 0.42),
          ),
        ),
        child: Text(
          label,
          style: FsText.chip(
            Colors.white,
          ).copyWith(color: Colors.white.withValues(alpha: 0.88)),
        ),
      ),
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final FeedVisualTheme palette;
  final VoidCallback onTap;

  const _IconCircleButton({
    required this.icon,
    required this.tooltip,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: palette.surfaceColor.withValues(alpha: 0.54),
            border: Border.all(
              color: palette.borderColor.withValues(alpha: 0.36),
            ),
          ),
          child: Icon(
            icon,
            size: 19,
            color: Colors.white.withValues(alpha: 0.82),
          ),
        ),
      ),
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  final FeedVisualTheme palette;

  const _AmbientBackground({required this.palette});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: _BgImage(key: ValueKey(palette.backgroundImage), palette: palette),
    );
  }
}

class _BgImage extends StatelessWidget {
  final FeedVisualTheme palette;

  const _BgImage({super.key, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(palette.backgroundImage, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
          child: const SizedBox.expand(),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.34, 0.72, 1.0],
              colors: [
                Colors.black.withValues(alpha: 0.38),
                palette.baseColor.withValues(alpha: 0.18),
                palette.baseColor.withValues(alpha: 0.58),
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
    for (var i = 0; i < 180; i++) {
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
