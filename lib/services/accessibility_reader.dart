import 'package:flutter/services.dart';

class AccessibilityLogEntry {
  final DateTime timestamp;
  final String packageName;
  final int eventType;
  final String text;
  final int count;

  const AccessibilityLogEntry({
    required this.timestamp,
    required this.packageName,
    required this.eventType,
    required this.text,
    required this.count,
  });

  factory AccessibilityLogEntry.fromMap(Map<dynamic, dynamic> map) {
    final millis = map['timestamp'];
    return AccessibilityLogEntry(
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        millis is int ? millis : int.tryParse('$millis') ?? 0,
      ),
      packageName: '${map['packageName'] ?? ''}',
      eventType: map['eventType'] is int
          ? map['eventType'] as int
          : int.tryParse('${map['eventType']}') ?? 0,
      text: '${map['text'] ?? ''}'.trim(),
      count: map['count'] is int
          ? map['count'] as int
          : int.tryParse('${map['count']}') ?? 1,
    );
  }
}

class AccessibilityReader {
  static const MethodChannel _channel = MethodChannel(
    'feedshift/accessibility',
  );

  static Future<String> getLatestText() async {
    final text = await _channel.invokeMethod<String>('getLatestText');
    return text ?? '';
  }

  static Future<List<AccessibilityLogEntry>> getLogs() async {
    final rawLogs = await _channel.invokeMethod<List<dynamic>>('getLogs');
    return (rawLogs ?? const <dynamic>[])
        .whereType<Map<dynamic, dynamic>>()
        .map(AccessibilityLogEntry.fromMap)
        .where((entry) => entry.text.isNotEmpty)
        .take(200)
        .toList();
  }

  static Future<void> clearLogs() {
    return _channel.invokeMethod<void>('clearLogs');
  }

  static Future<void> openSettings() {
    return _channel.invokeMethod<void>('openAccessibilitySettings');
  }

  static Future<bool> isEnabled() async {
    final enabled = await _channel.invokeMethod<bool>('isServiceEnabled');
    return enabled ?? false;
  }
}
