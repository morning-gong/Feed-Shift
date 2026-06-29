import 'package:feedshift/services/information_structure_analyzer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('analyzes technology leaning text', () {
    final result = InformationStructureAnalyzer.analyze(
      'AI 模型和软件产品正在改变自动驾驶应用，也带来新的科技趋势。',
    );

    expect(result.classification.topCategoryLabel, '科技');
    expect(result.title, contains('技术'));
    expect(result.reasons, isNotEmpty);
    expect(result.suggestions, contains('找一位非技术作者的视角'));
  });

  test('keeps weak text as uncertain', () {
    final result = InformationStructureAnalyzer.analyze('普通文字，没有明确方向。');

    expect(result.classification.hasSignal, isFalse);
    expect(result.title, '暂时看不出明显主题');
    expect(result.suggestions, contains('换到一页文字更多的内容'));
  });
}
