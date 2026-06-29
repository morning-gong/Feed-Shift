import 'package:feedshift/services/content_classifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('classifies technology text', () {
    final result = ContentClassifier.classify('AI 模型 正在改变很多软件产品和应用');
    expect(result.topCategoryLabel, '科技');
    expect(result.hasSignal, isTrue);
  });

  test('classifies emotion text', () {
    final result = ContentClassifier.classify('今天有点焦虑，也想找一些治愈和共鸣');
    expect(result.topCategoryLabel, '情绪');
    expect(result.hasSignal, isTrue);
  });

  test('returns no signal for unrelated text', () {
    final result = ContentClassifier.classify('这是一段没有明显关键词的普通文字');
    expect(result.topCategoryLabel, '未识别');
    expect(result.hasSignal, isFalse);
  });
}
