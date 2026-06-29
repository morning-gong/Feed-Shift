import 'dart:async';

import 'package:flutter/material.dart';

import 'services/accessibility_reader.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  bool _enabled = false;
  bool _loading = true;
  List<AccessibilityLogEntry> _logs = const [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _refresh();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _refresh(silent: true),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _refresh({bool silent = false}) async {
    if (!silent) setState(() => _loading = true);
    final enabled = await AccessibilityReader.isEnabled();
    final logs = await AccessibilityReader.getLogs();
    if (!mounted) return;
    setState(() {
      _enabled = enabled;
      _logs = logs;
      _loading = false;
    });
  }

  Future<void> _clear() async {
    await AccessibilityReader.clearLogs();
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final stats = _ProbeStats(_logs);

    return Scaffold(
      backgroundColor: const Color(0xFF0E1110),
      appBar: AppBar(
        title: const Text('读取记录'),
        backgroundColor: const Color(0xFF0E1110),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: '刷新',
            onPressed: _loading ? null : _refresh,
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            tooltip: '清空记录',
            onPressed: _logs.isEmpty ? null : _clear,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          children: [
            _StatusCard(
              enabled: _enabled,
              loading: _loading,
              logCount: _logs.length,
              onOpenSettings: AccessibilityReader.openSettings,
            ),
            const SizedBox(height: 12),
            _InsightCard(stats: stats),
            const SizedBox(height: 12),
            _LatestTextCard(entry: _logs.isEmpty ? null : _logs.first),
            const SizedBox(height: 12),
            _LogList(logs: _logs),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final bool enabled;
  final bool loading;
  final int logCount;
  final VoidCallback onOpenSettings;

  const _StatusCard({
    required this.enabled,
    required this.loading,
    required this.logCount,
    required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                enabled
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: enabled
                    ? const Color(0xFF8BE0A4)
                    : const Color(0xFFFFC27A),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  enabled ? '读取服务已开启' : '读取服务未开启',
                  style: _titleStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '只在小红书、抖音、快手、B站等内容平台前台时读取。高频内容会优先保留，最多保存 $logCount/200 条。',
            style: _bodyStyle,
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: onOpenSettings,
            icon: const Icon(Icons.settings_accessibility_rounded),
            label: const Text('打开无障碍设置'),
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final _ProbeStats stats;

  const _InsightCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('当前信号', style: _titleStyle),
          const SizedBox(height: 8),
          Text(stats.summary, style: _bodyStyle),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Metric(label: '条记录', value: '${stats.count}'),
              _Metric(label: '个应用', value: '${stats.packageCount}'),
              _Metric(label: '时间窗', value: stats.durationLabel),
            ],
          ),
          const SizedBox(height: 14),
          Text('高频倾向', style: _subtitleStyle),
          const SizedBox(height: 8),
          if (stats.signals.isEmpty)
            Text('还没有稳定倾向。打开抖音、小红书、快手或 B站浏览几条，再回到这里。', style: _bodyStyle)
          else
            ...stats.signals.map(
              (item) => _SignalRow(label: item.key, value: item.value),
            ),
        ],
      ),
    );
  }
}

class _LatestTextCard extends StatelessWidget {
  final AccessibilityLogEntry? entry;

  const _LatestTextCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('最近读取', style: _titleStyle),
          const SizedBox(height: 8),
          if (entry == null)
            Text('还没有读到内容。', style: _bodyStyle)
          else ...[
            Text(
              '${entry!.packageName} | ${_formatTime(entry!.timestamp)} | ${_eventLabel(entry!.eventType)} | ${entry!.count} 次',
              style: _captionStyle,
            ),
            const SizedBox(height: 10),
            Text(
              entry!.text,
              maxLines: 12,
              overflow: TextOverflow.ellipsis,
              style: _bodyStyle,
            ),
          ],
        ],
      ),
    );
  }
}

class _LogList extends StatelessWidget {
  final List<AccessibilityLogEntry> logs;

  const _LogList({required this.logs});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('高频记录池', style: _titleStyle),
          const SizedBox(height: 8),
          if (logs.isEmpty)
            Text('等待目标内容平台产生读取记录。', style: _bodyStyle)
          else
            for (final entry in logs.take(200))
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_formatTime(entry.timestamp)} | ${entry.packageName} | ${entry.count} 次',
                      style: _captionStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.text.replaceAll('\n', '  '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _bodyStyle,
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class _ProbeStats {
  final List<AccessibilityLogEntry> logs;

  _ProbeStats(this.logs);

  int get count => logs.length;

  int get packageCount =>
      logs.map((e) => e.packageName).where((e) => e.isNotEmpty).toSet().length;

  String get durationLabel {
    if (logs.length < 2) return '0 分钟';
    final newest = logs.first.timestamp;
    final oldest = logs.last.timestamp;
    final minutes = newest.difference(oldest).inMinutes.abs();
    if (minutes < 1) return '<1 分钟';
    return '$minutes 分钟';
  }

  String get summary {
    if (logs.isEmpty) return '还没有真实使用数据。';
    final top = _topPackage;
    if (top == null) {
      return '已经开始读取，但还没有明显集中的应用。';
    }
    final repeats = _packageCounts[top] ?? 0;
    return '最近注意力主要集中在 $top（$repeats/$count 条）。数据链路已接通，可以继续观察偏好。';
  }

  List<MapEntry<String, int>> get signals {
    final text = logs
        .map((e) => '${e.packageName}\n${e.text}')
        .join('\n')
        .toLowerCase();
    final patterns = <String, List<String>>{
      '短视频循环': [
        'douyin',
        'tiktok',
        'kuaishou',
        'reels',
        'shorts',
        'video',
        'live',
      ],
      '情绪牵引': ['anxiety', 'stress', 'heal', 'mood', 'love', 'lonely', 'sleep'],
      '消费种草': ['buy', 'sale', 'shop', 'price', 'review', 'cart'],
      '知识输入': ['learn', 'course', 'science', 'history', 'study', 'tutorial'],
      '娱乐内容': ['movie', 'music', 'game', 'funny', 'star', 'show'],
    };

    final result =
        patterns.entries
            .map((entry) {
              var score = 0;
              for (final keyword in entry.value) {
                score += _count(text, keyword);
              }
              return MapEntry(entry.key, score);
            })
            .where((entry) => entry.value > 0)
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    return result;
  }

  Map<String, int> get _packageCounts {
    final counts = <String, int>{};
    for (final log in logs) {
      if (log.packageName.isEmpty) continue;
      counts[log.packageName] = (counts[log.packageName] ?? 0) + 1;
    }
    return counts;
  }

  String? get _topPackage {
    final entries = _packageCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.isEmpty ? null : entries.first.key;
  }

  int _count(String text, String keyword) {
    if (keyword.isEmpty) return 0;
    var total = 0;
    var index = 0;
    while (true) {
      index = text.indexOf(keyword, index);
      if (index == -1) return total;
      total++;
      index += keyword.length;
    }
  }
}

class _Panel extends StatelessWidget {
  final Widget child;

  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F1D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: child,
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('$value$label', style: _captionStyle),
    );
  }
}

class _SignalRow extends StatelessWidget {
  final String label;
  final int value;

  const _SignalRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: _bodyStyle)),
          Text('$value 次', style: _captionStyle),
        ],
      ),
    );
  }
}

String _formatTime(DateTime time) {
  final h = time.hour.toString().padLeft(2, '0');
  final m = time.minute.toString().padLeft(2, '0');
  final s = time.second.toString().padLeft(2, '0');
  return '$h:$m:$s';
}

String _eventLabel(int type) {
  switch (type) {
    case 32:
      return '窗口切换';
    case 2048:
      return '内容变化';
    case 16:
      return '文字变化';
    default:
      return '事件 $type';
  }
}

const _titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

const _subtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

final _bodyStyle = TextStyle(
  color: Colors.white.withValues(alpha: 0.74),
  fontSize: 14,
  height: 1.35,
);

final _captionStyle = TextStyle(
  color: Colors.white.withValues(alpha: 0.52),
  fontSize: 12,
  height: 1.25,
);
