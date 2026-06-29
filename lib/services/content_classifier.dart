import '../data/topic_taxonomy.dart';

class ContentCategoryScore {
  final String id;
  final String label;
  final double score;

  const ContentCategoryScore({
    required this.id,
    required this.label,
    required this.score,
  });
}

class ContentClassificationResult {
  final String topCategoryId;
  final String topCategoryLabel;
  final List<ContentCategoryScore> scores;
  final TopicTaxonomyResult taxonomy;

  const ContentClassificationResult({
    required this.topCategoryId,
    required this.topCategoryLabel,
    required this.scores,
    required this.taxonomy,
  });

  bool get hasSignal => taxonomy.hasSignal;
}

class ContentClassifier {
  static const Map<String, String> _domainIds = {
    '娱乐文化': 'entertainment',
    '健康健身': 'health',
    '财经投资': 'finance',
    '科技产品': 'tech',
    '新闻公共议题': 'public',
    '学习知识': 'knowledge',
    '情绪关系': 'emotion',
    '消费种草': 'consumption',
    '生活方式': 'lifestyle',
    '体育赛事': 'sports',
  };

  static const Map<String, String> _domainLabels = {
    '娱乐文化': '娱乐',
    '健康健身': '健康',
    '财经投资': '财经',
    '科技产品': '科技',
    '新闻公共议题': '公共议题',
    '学习知识': '知识',
    '情绪关系': '情绪',
    '消费种草': '消费',
    '生活方式': '生活',
    '体育赛事': '体育',
  };

  static ContentClassificationResult classify(String text) {
    final taxonomy = TopicTaxonomy.analyzeText(text);
    final scores = taxonomy.domains.map((entry) {
      return ContentCategoryScore(
        id: _domainIds[entry.domain] ?? entry.domain,
        label: _domainLabels[entry.domain] ?? entry.domain,
        score: entry.strength,
      );
    }).toList()..sort((a, b) => b.score.compareTo(a.score));

    final top = scores.isEmpty
        ? const ContentCategoryScore(id: 'unknown', label: '未识别', score: 0)
        : scores.first;
    return ContentClassificationResult(
      topCategoryId: top.id,
      topCategoryLabel: top.score == 0 ? '未识别' : top.label,
      scores: scores,
      taxonomy: taxonomy,
    );
  }
}
