import 'content_classifier.dart';

class InformationStructureResult {
  final String title;
  final String description;
  final String hint;
  final List<String> reasons;
  final List<String> suggestions;
  final ContentClassificationResult classification;

  const InformationStructureResult({
    required this.title,
    required this.description,
    required this.hint,
    required this.reasons,
    required this.suggestions,
    required this.classification,
  });
}

class InformationStructureAnalyzer {
  static InformationStructureResult analyze(String text) {
    final classification = ContentClassifier.classify(text);
    final charCount = text.trim().replaceAll(RegExp(r'\s+'), '').length;

    if (!classification.hasSignal) {
      return InformationStructureResult(
        title: '暂时看不出明显主题',
        description: '当前读取到的文字还不够明确，先保留原文观察。',
        hint: '可以切换到文字更多的页面，再回来刷新读取。',
        reasons: ['没有识别到足够明显的主题词', '当前文本长度约 $charCount 个字符'],
        suggestions: ['换到一页文字更多的内容', '读完一段再回来刷新', '先不急着做判断'],
        classification: classification,
      );
    }

    final top = classification.topCategoryId;
    final second = classification.scores.length > 1
        ? classification.scores[1]
        : classification.scores.first;
    final topScore = classification.scores.first.score;
    final topTopic = classification.taxonomy.highlands.isEmpty
        ? classification.topCategoryLabel
        : classification.taxonomy.highlands.first.topic.label;

    return InformationStructureResult(
      title: _titleFor(top, topTopic),
      description: _descriptionFor(top, topTopic),
      hint: _hintFor(top, topScore),
      reasons: [
        '最明显的内容高地是「$topTopic」',
        '旁边的弱信号是「${second.label}」，占比约 ${(second.score * 100).round()}%',
        '当前文本长度约 $charCount 个字符',
      ],
      suggestions: _suggestionsFor(top),
      classification: classification,
    );
  }

  static String _titleFor(String categoryId, String topic) {
    switch (categoryId) {
      case 'entertainment':
        return '从 $topic 旁边走一步';
      case 'tech':
        return '把技术放回人身上';
      case 'knowledge':
        return '给知识找一条原始来源';
      case 'emotion':
        return '把感受写成一个问题';
      case 'consumption':
        return '让喜欢过一晚';
      case 'finance':
        return '给热度降一点温';
      case 'health':
        return '把训练放回身体里';
      case 'public':
        return '把事件放回普通人的处境';
      default:
        return '换一个更宽的入口';
    }
  }

  static String _descriptionFor(String categoryId, String topic) {
    switch (categoryId) {
      case 'entertainment':
        return '$topic 内容适合放松。连续出现太多时，可以补一点产业、历史或社会背景。';
      case 'tech':
        return '技术内容很亮，但真正的变化会落在工作、关系和生活成本上。';
      case 'knowledge':
        return '这类内容适合积累背景。下一步是看来源，而不是继续收藏摘要。';
      case 'emotion':
        return '情绪内容会提供陪伴，也容易把同一种感受反复放大。';
      case 'consumption':
        return '种草内容会缩短决策时间。让它过一晚，通常能看清真实需要。';
      case 'finance':
        return '财经内容需要慢一点。先看业务、风险和数据，再看涨跌判断。';
      case 'health':
        return '健康内容有用，但要回到身体反馈、恢复和长期节奏。';
      case 'public':
        return '公共议题适合从普通人的处境进入，再看宏观判断。';
      default:
        return '当前内容信号不够稳定，先做轻一点的观察。';
    }
  }

  static String _hintFor(String categoryId, double topScore) {
    final strength = topScore >= 0.70
        ? '这个方向很集中'
        : topScore >= 0.45
        ? '这个方向比较明显'
        : '这个方向刚露出来';

    switch (categoryId) {
      case 'entertainment':
        return '$strength。可以补一篇音乐产业、影视制作或社会背景，不急着看评论区。';
      case 'tech':
        return '$strength。找一位非技术作者，看它怎样影响具体的人。';
      case 'knowledge':
        return '$strength。给这段内容找一条原始材料或长报道。';
      case 'emotion':
        return '$strength。把一个情绪词改写成可以查证的问题。';
      case 'consumption':
        return '$strength。把想买的东西放进清单，明天同一时间再看。';
      case 'finance':
        return '$strength。打开一份财报或风险说明，先看事实部分。';
      case 'health':
        return '$strength。补一条睡眠、恢复或伤病预防知识。';
      case 'public':
        return '$strength。先看普通人的处境，再看立场和评论。';
      default:
        return '当前信号较弱，先观察即可。';
    }
  }

  static List<String> _suggestionsFor(String categoryId) {
    switch (categoryId) {
      case 'entertainment':
        return ['看一篇产业或版权报道', '找一段创作者长访谈', '先看完整内容再看评论'];
      case 'tech':
        return ['找一位非技术作者的视角', '查它依赖的数据或供应链', '看一篇普通使用者报道'];
      case 'knowledge':
        return ['找一条原始材料', '读完一篇长报道', '写下一个还没回答的问题'];
      case 'emotion':
        return ['把一个感受写成事实问题', '只查一条可靠来源', '看完后离屏十分钟'];
      case 'consumption':
        return ['把购买决定延迟到明天', '先查一次差评', '写下它解决的真实问题'];
      case 'finance':
        return ['打开一份公司财报', '先看风险提示', '查清楚收入从哪里来'];
      case 'health':
        return ['补一篇睡眠或恢复科普', '记录一次身体反馈', '先看动作安全再加量'];
      case 'public':
        return ['读一篇住房或就业长报道', '先看普通人的处境', '暂时不打开评论区'];
      default:
        return ['换到一页文字更多的内容', '读完一段再回来刷新', '先不急着做判断'];
    }
  }
}
