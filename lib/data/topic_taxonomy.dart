import '../theme/feed_visual_theme.dart';

class TopicDefinition {
  final String id;
  final String label;
  final String domain;
  final List<String> aliases;
  final List<String> expandTo;
  final String missingPrompt;
  final FeedVisualFamily visualFamily;

  const TopicDefinition({
    required this.id,
    required this.label,
    required this.domain,
    required this.aliases,
    required this.expandTo,
    required this.missingPrompt,
    required this.visualFamily,
  });
}

class TopicSignal {
  final TopicDefinition topic;
  final int hits;
  final double strength;
  final double confidence;

  const TopicSignal({
    required this.topic,
    required this.hits,
    required this.strength,
    required this.confidence,
  });
}

class DomainSignal {
  final String domain;
  final int hits;
  final double strength;

  const DomainSignal({
    required this.domain,
    required this.hits,
    required this.strength,
  });
}

class TopicTaxonomyResult {
  final List<TopicSignal> topics;
  final List<DomainSignal> domains;
  final int totalHits;

  const TopicTaxonomyResult({
    required this.topics,
    required this.domains,
    required this.totalHits,
  });

  bool get hasSignal => totalHits > 0;

  List<TopicSignal> get highlands =>
      topics.where((item) => item.hits > 0).take(3).toList();

  List<TopicDefinition> get sparseTopics {
    final hitIds = topics
        .where((item) => item.hits > 0)
        .map((item) => item.topic.id)
        .toSet();
    final hitDomains = domains
        .where((item) => item.hits > 0)
        .map((item) => item.domain)
        .toSet();
    return kTopicTaxonomy
        .where(
          (topic) =>
              !hitIds.contains(topic.id) && !hitDomains.contains(topic.domain),
        )
        .take(3)
        .toList();
  }

  String get highlandLabel {
    final labels = highlands.map((item) => item.topic.label).toList();
    if (labels.isEmpty) return '等待记录';
    return labels.join(' / ');
  }

  String get sparseLabel {
    final labels = sparseTopics
        .map((topic) => topic.domain)
        .toSet()
        .take(3)
        .toList();
    if (labels.isEmpty) return '长篇报道 / 健康知识 / 公共议题';
    return labels.join(' / ');
  }

  FeedVisualTheme get visualTheme {
    final top = highlands.isEmpty ? null : highlands.first.topic.visualFamily;
    return kFeedVisualThemes[top ?? FeedVisualFamily.archive]!;
  }

  String get sceneTitle {
    final top = highlands.isEmpty ? null : highlands.first.topic.label;
    switch (top) {
      case 'K-POP':
        return '从 K-POP 旁边走一步';
      case '股票':
      case '基金':
      case 'A股':
      case '美股':
      case '港股':
        return '给股票热度降一点温';
      case '健身':
      case '力量训练':
      case '减脂':
      case '跑步':
        return '在健身内容外补一条身体知识';
      case 'AI':
      case '手机':
      case '芯片':
        return '把技术放回人身上';
      case '焦虑':
      case '孤独':
      case '亲密关系':
        return '把感受放慢一点看';
      default:
        return '从熟悉内容旁边走一步';
    }
  }

  String get dailyPrompt {
    final sparse = sparseTopics.isEmpty ? null : sparseTopics.first;
    if (sparse != null) return sparse.missingPrompt;
    final top = highlands.isEmpty ? null : highlands.first.topic;
    return top?.missingPrompt ?? '明天可以看一篇长报道。先看事实部分，再看观点，不急着打开评论区。';
  }
}

class TopicTaxonomy {
  static TopicTaxonomyResult analyzeText(String text) {
    final normalized = text.toLowerCase();
    final rawScores = <TopicDefinition, int>{};
    var total = 0;

    for (final topic in kTopicTaxonomy) {
      var hits = 0;
      for (final alias in topic.aliases) {
        hits += _count(normalized, alias.toLowerCase());
      }
      rawScores[topic] = hits;
      total += hits;
    }

    final topicSignals =
        rawScores.entries.map((entry) {
          final strength = total == 0 ? 0.0 : entry.value / total;
          return TopicSignal(
            topic: entry.key,
            hits: entry.value,
            strength: strength,
            confidence: strength.clamp(0.18, 0.92),
          );
        }).toList()..sort((a, b) {
          final hitCompare = b.hits.compareTo(a.hits);
          if (hitCompare != 0) return hitCompare;
          return a.topic.label.compareTo(b.topic.label);
        });

    final domainHits = <String, int>{
      for (final domain in kTopicDomains) domain: 0,
    };
    for (final entry in rawScores.entries) {
      domainHits[entry.key.domain] =
          (domainHits[entry.key.domain] ?? 0) + entry.value;
    }
    final domains = domainHits.entries.map((entry) {
      return DomainSignal(
        domain: entry.key,
        hits: entry.value,
        strength: total == 0 ? 0.0 : entry.value / total,
      );
    }).toList()..sort((a, b) => b.hits.compareTo(a.hits));

    return TopicTaxonomyResult(
      topics: topicSignals,
      domains: domains,
      totalHits: total,
    );
  }

  static int _count(String text, String keyword) {
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

const List<String> kTopicDomains = [
  '娱乐文化',
  '健康健身',
  '财经投资',
  '科技产品',
  '新闻公共议题',
  '学习知识',
  '情绪关系',
  '消费种草',
  '生活方式',
  '体育赛事',
];

const List<TopicDefinition> kTopicTaxonomy = [
  TopicDefinition(
    id: 'kpop',
    label: 'K-POP',
    domain: '娱乐文化',
    aliases: [
      'k-pop',
      'kpop',
      '韩团',
      '爱豆',
      'idol',
      'aespa',
      'ive',
      'newjeans',
      'bts',
    ],
    expandTo: ['音乐产业', '版权', '韩国社会'],
    missingPrompt: '最近 K-POP 内容较多。可以补一篇音乐产业、版权或韩国社会相关内容。先看事实部分，再看观点。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'kdrama',
    label: '韩剧',
    domain: '娱乐文化',
    aliases: ['韩剧', '韩综', 'netflix', 'tvn'],
    expandTo: ['韩国社会', '影视工业', '编剧访谈'],
    missingPrompt: '如果最近追剧较多，可以看一篇剧集背后的制作访谈。先看创作和产业部分，不急着刷剪辑。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'cn_entertainment',
    label: '内娱',
    domain: '娱乐文化',
    aliases: ['内娱', '明星', '塌房', '热搜', '粉丝', '饭圈'],
    expandTo: ['媒体报道', '劳动关系', '平台机制'],
    missingPrompt: '内娱内容偏多时，可以补一篇关于平台、经纪公司或粉丝劳动的报道。先看机制，再看情绪。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'movie',
    label: '电影',
    domain: '娱乐文化',
    aliases: ['电影', '影评', '导演', '票房', 'cinema', 'movie'],
    expandTo: ['导演访谈', '电影史', '产业报道'],
    missingPrompt: '电影内容多的时候，可以读一篇导演访谈或电影史短文。重点看创作选择，不只看评分。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'variety',
    label: '综艺',
    domain: '娱乐文化',
    aliases: ['综艺', '真人秀', '脱口秀', '节目'],
    expandTo: ['节目制作', '嘉宾访谈', '媒介研究'],
    missingPrompt: '综艺刷得多时，可以看一篇节目制作或嘉宾长访谈。先看完整语境，再看片段。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'anime',
    label: '二次元',
    domain: '娱乐文化',
    aliases: ['二次元', '动漫', '动画', '番剧', 'acg', 'cos'],
    expandTo: ['动画制作', '漫画史', '创作者访谈'],
    missingPrompt: '二次元内容多时，可以看一篇动画制作或漫画史。重点看作品怎么被做出来。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'game_live',
    label: '游戏直播',
    domain: '娱乐文化',
    aliases: ['游戏直播', '直播', '主播', '电竞', '手游', 'steam', 'game'],
    expandTo: ['游戏设计', '电竞产业', '玩家社区'],
    missingPrompt: '游戏直播偏多时，可以补一篇游戏设计或玩家社区报道。看规则和社区，不只看胜负。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'fitness',
    label: '健身',
    domain: '健康健身',
    aliases: ['健身', '健康', '训练', '运动', 'workout', 'fitness'],
    expandTo: ['运动科学', '恢复', '营养'],
    missingPrompt: '健身内容较多。明天可以看一篇关于恢复、睡眠或运动损伤的科普。重点看身体信号，不急着加量。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'strength',
    label: '力量训练',
    domain: '健康健身',
    aliases: ['力量训练', '深蹲', '硬拉', '卧推', '增肌'],
    expandTo: ['动作安全', '恢复', '周期计划'],
    missingPrompt: '力量训练内容偏多时，可以看一篇动作安全或恢复计划。先看风险和节奏，再看重量。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'fat_loss',
    label: '减脂',
    domain: '健康健身',
    aliases: ['减脂', '减肥', '热量', '卡路里', '体脂'],
    expandTo: ['营养', '睡眠', '身体感受'],
    missingPrompt: '减脂内容偏多时，可以补一篇营养或睡眠科普。先看长期习惯，不急着找更狠的方法。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'running',
    label: '跑步',
    domain: '健康健身',
    aliases: ['跑步', '马拉松', '配速', '跑鞋', 'running'],
    expandTo: ['恢复', '伤病预防', '城市空间'],
    missingPrompt: '跑步内容多时，可以看一篇伤病预防或城市跑步空间。重点看身体和路线，不只看配速。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'yoga',
    label: '瑜伽',
    domain: '健康健身',
    aliases: ['瑜伽', '拉伸', '普拉提', 'pilates', 'yoga'],
    expandTo: ['呼吸', '体态', '疼痛管理'],
    missingPrompt: '瑜伽和拉伸多时，可以看一篇体态或疼痛管理科普。先看身体反馈，不追求动作漂亮。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'sleep',
    label: '睡眠',
    domain: '健康健身',
    aliases: ['睡眠', '失眠', '熬夜', '早睡', 'sleep'],
    expandTo: ['睡眠卫生', '压力', '光照'],
    missingPrompt: '最近很少接触到「健康知识」。明天可以看一篇关于睡眠、光照或压力恢复的科普。重点看可执行的部分。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'posture',
    label: '体态',
    domain: '健康健身',
    aliases: ['体态', '圆肩', '骨盆', '脊柱', '肩颈'],
    expandTo: ['康复', '久坐', '力量基础'],
    missingPrompt: '体态内容出现时，可以补一篇康复或久坐影响的科普。先看原因，不急着买器械。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'stock',
    label: '股票',
    domain: '财经投资',
    aliases: ['股票', '股市', '个股', '大盘', '财报', 'stock'],
    expandTo: ['公司财报', '产业链', '宏观数据'],
    missingPrompt: '股票内容较多。可以补一份公司财报或产业链报道。先看收入和风险，再看涨跌判断。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'fund',
    label: '基金',
    domain: '财经投资',
    aliases: ['基金', 'etf', '指数基金', '定投'],
    expandTo: ['持仓', '费用', '风险'],
    missingPrompt: '基金内容较多时，可以看一眼持仓和费用说明。先弄清楚买的是什么，不急着看收益截图。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'a_share',
    label: 'A股',
    domain: '财经投资',
    aliases: ['a股', '沪深', '上证', '创业板'],
    expandTo: ['政策背景', '公司基本面', '行业周期'],
    missingPrompt: 'A股热度较高时，可以补一篇行业周期或政策背景。先看公司怎么赚钱，再看情绪。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'us_stock',
    label: '美股',
    domain: '财经投资',
    aliases: ['美股', '纳指', '标普', 'nasdaq', 's&p'],
    expandTo: ['财报', '利率', '行业竞争'],
    missingPrompt: '美股内容较多时，可以看一份财报电话会摘要。先看业务和现金流，再看目标价。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'hk_stock',
    label: '港股',
    domain: '财经投资',
    aliases: ['港股', '恒生', 'h股'],
    expandTo: ['公司治理', '流动性', '产业政策'],
    missingPrompt: '港股内容偏多时，可以补一篇公司治理或行业政策。先看基本面，不急着看估值口号。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'gold',
    label: '黄金',
    domain: '财经投资',
    aliases: ['黄金', '金价', '贵金属', 'gold'],
    expandTo: ['通胀', '利率', '避险'],
    missingPrompt: '黄金内容偏多时，可以看一篇关于利率、通胀或避险需求的解释。先看机制，再看价格。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'exchange',
    label: '汇率',
    domain: '财经投资',
    aliases: ['汇率', '人民币', '美元指数', '外汇', 'exchange'],
    expandTo: ['贸易', '利率', '跨境消费'],
    missingPrompt: '汇率内容出现时，可以补一篇贸易或利率背景。先看影响谁，不只看数字跳动。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'crypto',
    label: '加密货币',
    domain: '财经投资',
    aliases: ['加密货币', '比特币', 'btc', 'eth', 'crypto', 'web3'],
    expandTo: ['监管', '能源', '风险'],
    missingPrompt: '加密货币内容偏多时，可以看一篇监管或风险案例。先看失败怎么发生，再看收益故事。',
    visualFamily: FeedVisualFamily.finance,
  ),
  TopicDefinition(
    id: 'ai',
    label: 'AI',
    domain: '科技产品',
    aliases: ['ai', '人工智能', '大模型', '模型', 'chatgpt', 'openai', 'llm'],
    expandTo: ['劳动变化', '教育', '创作者'],
    missingPrompt: 'AI 内容较多。可以补一篇教师、医生或创作者如何使用它的报道。重点看人的处境，不只看能力。',
    visualFamily: FeedVisualFamily.tech,
  ),
  TopicDefinition(
    id: 'phone',
    label: '手机',
    domain: '科技产品',
    aliases: ['手机', 'iphone', '安卓', '小米', '华为', 'oppo', 'vivo'],
    expandTo: ['供应链', '维修', '隐私'],
    missingPrompt: '手机内容偏多时，可以补一篇供应链、维修或隐私报道。先看使用成本，不只看参数。',
    visualFamily: FeedVisualFamily.tech,
  ),
  TopicDefinition(
    id: 'chip',
    label: '芯片',
    domain: '科技产品',
    aliases: ['芯片', '半导体', 'gpu', 'nvidia', '台积电'],
    expandTo: ['制造', '供应链', '地缘关系'],
    missingPrompt: '芯片内容较多时，可以看一篇制造流程或供应链报道。先看约束条件，再看性能。',
    visualFamily: FeedVisualFamily.tech,
  ),
  TopicDefinition(
    id: 'ev',
    label: '电动车',
    domain: '科技产品',
    aliases: ['电动车', '新能源车', '特斯拉', '比亚迪', '蔚来', '小鹏'],
    expandTo: ['电池', '城市交通', '安全'],
    missingPrompt: '电动车内容偏多时，可以看一篇电池、安全或城市交通报道。先看真实使用场景。',
    visualFamily: FeedVisualFamily.tech,
  ),
  TopicDefinition(
    id: 'robot',
    label: '机器人',
    domain: '科技产品',
    aliases: ['机器人', '人形机器人', '机械臂', 'robot'],
    expandTo: ['工厂', '照护', '劳动'],
    missingPrompt: '机器人内容多时，可以补一篇工厂或照护场景报道。先看它替谁做事，也看谁要配合它。',
    visualFamily: FeedVisualFamily.tech,
  ),
  TopicDefinition(
    id: 'software',
    label: '软件工具',
    domain: '科技产品',
    aliases: ['软件', '工具', 'app', '效率', '插件', 'workflow'],
    expandTo: ['工作流', '隐私', '维护成本'],
    missingPrompt: '软件工具内容偏多时，可以看一篇隐私或维护成本说明。先想它减少了什么，也想它增加了什么。',
    visualFamily: FeedVisualFamily.tech,
  ),
  TopicDefinition(
    id: 'housing',
    label: '住房',
    domain: '新闻公共议题',
    aliases: ['住房', '房价', '租房', '楼市', '物业', '保障房'],
    expandTo: ['城市治理', '就业', '教育'],
    missingPrompt: '最近很少接触到「公共议题」。明天可以看一篇关于住房、教育或就业的长报道。重点看普通人的处境，不急着看评论区。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'employment',
    label: '就业',
    domain: '新闻公共议题',
    aliases: ['就业', '招聘', '裁员', '失业', '职场', '薪资'],
    expandTo: ['劳动者故事', '行业变化', '教育'],
    missingPrompt: '就业议题少时，可以看一篇普通劳动者或行业变化的报道。先看具体处境，再看宏观判断。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'education',
    label: '教育',
    domain: '新闻公共议题',
    aliases: ['教育', '学校', '高考', '大学', '老师', '学生'],
    expandTo: ['家庭', '地区差异', '就业'],
    missingPrompt: '教育议题少时，可以看一篇学校、家庭或地区差异报道。重点看人怎么被影响。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'city_governance',
    label: '城市治理',
    domain: '新闻公共议题',
    aliases: ['城市治理', '社区', '交通', '城管', '公共服务', '市政'],
    expandTo: ['住房', '环保', '公共服务'],
    missingPrompt: '城市治理内容少时，可以读一篇社区、交通或公共服务报道。先看一件小事怎么被处理。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'international',
    label: '国际关系',
    domain: '新闻公共议题',
    aliases: ['国际关系', '外交', '战争', '地缘', '联合国', '关税'],
    expandTo: ['历史背景', '普通人处境', '经济影响'],
    missingPrompt: '国际议题少时，可以看一篇带历史背景的报道。先看事实线，再看各方立场。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'environment',
    label: '环保',
    domain: '新闻公共议题',
    aliases: ['环保', '气候', '污染', '碳排放', '垃圾分类', '生态'],
    expandTo: ['城市治理', '产业', '生活方式'],
    missingPrompt: '环保内容少时，可以看一篇关于污染、气候或城市治理的报道。重点看影响如何落到日常生活。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'cooking',
    label: '做饭',
    domain: '生活方式',
    aliases: ['做饭', '菜谱', '料理', '烘焙', '下厨'],
    expandTo: ['营养', '家庭', '食物来源'],
    missingPrompt: '做饭内容多时，可以看一篇食材来源或营养科普。先看食物怎么来到餐桌。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'home',
    label: '家居',
    domain: '生活方式',
    aliases: ['家居', '装修', '收纳', '家具', '居住'],
    expandTo: ['住房', '材料', '长期使用'],
    missingPrompt: '家居内容多时，可以补一篇材料、居住或长期使用经验。先看耐用性，再看风格。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'travel',
    label: '旅行',
    domain: '生活方式',
    aliases: ['旅行', '旅游', '攻略', '机票', '酒店'],
    expandTo: ['地方历史', '交通', '环境'],
    missingPrompt: '旅行内容多时，可以看一篇目的地的地方历史或公共交通。先了解地方，再看打卡点。',
    visualFamily: FeedVisualFamily.archive,
  ),
  TopicDefinition(
    id: 'pet',
    label: '宠物',
    domain: '生活方式',
    aliases: ['宠物', '猫', '狗', '猫粮', '狗粮', '兽医'],
    expandTo: ['照护', '城市生活', '消费'],
    missingPrompt: '宠物内容多时，可以补一篇照护或兽医科普。先看长期责任，不只看可爱片段。',
    visualFamily: FeedVisualFamily.health,
  ),
  TopicDefinition(
    id: 'outfit',
    label: '穿搭',
    domain: '消费种草',
    aliases: ['穿搭', '搭配', 'ootd', '衣服', '鞋', '包'],
    expandTo: ['面料', '耐用', '消费心理'],
    missingPrompt: '穿搭内容较多时，可以看一篇面料或衣物耐用性的文章。先看怎么长期使用，再决定是否购买。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'skincare',
    label: '护肤',
    domain: '消费种草',
    aliases: ['护肤', '美妆', '精华', '防晒', '面霜', '成分'],
    expandTo: ['皮肤科', '成分证据', '消费心理'],
    missingPrompt: '护肤内容较多时，可以看一篇皮肤科或成分证据。先看适用人群，不急着下单。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'relationship',
    label: '亲密关系',
    domain: '情绪关系',
    aliases: ['亲密关系', '恋爱', '分手', '伴侣', '婚姻', '爱情'],
    expandTo: ['沟通', '边界', '心理学'],
    missingPrompt: '亲密关系内容较多时，可以看一篇沟通或边界相关的长文。先看具体行为，不急着套标签。',
    visualFamily: FeedVisualFamily.reflection,
  ),
  TopicDefinition(
    id: 'anxiety',
    label: '焦虑',
    domain: '情绪关系',
    aliases: ['焦虑', '压力', '内耗', '崩溃', 'anxiety', 'stress'],
    expandTo: ['睡眠', '工作压力', '心理学'],
    missingPrompt: '焦虑内容多时，可以把一个担心写成可查证的问题。只查一条可靠来源，然后停下来。',
    visualFamily: FeedVisualFamily.reflection,
  ),
  TopicDefinition(
    id: 'lonely',
    label: '孤独',
    domain: '情绪关系',
    aliases: ['孤独', '孤单', '陪伴', '社恐', '寂寞'],
    expandTo: ['社区', '关系', '生活节奏'],
    missingPrompt: '孤独相关内容多时，可以读一篇关于社区、关系或城市生活的报道。重点看人如何互相支持。',
    visualFamily: FeedVisualFamily.reflection,
  ),
  TopicDefinition(
    id: 'work_stress',
    label: '职场压力',
    domain: '情绪关系',
    aliases: ['职场压力', '加班', '绩效', '领导', '同事', 'burnout'],
    expandTo: ['劳动权益', '就业', '恢复'],
    missingPrompt: '职场压力内容多时，可以看一篇劳动权益或恢复方法。先区分制度问题和个人感受。',
    visualFamily: FeedVisualFamily.reflection,
  ),
  TopicDefinition(
    id: 'self_growth',
    label: '自我成长',
    domain: '情绪关系',
    aliases: ['自我成长', '成长', '自律', '习惯', '人生建议'],
    expandTo: ['心理学', '生活结构', '具体行动'],
    missingPrompt: '自我成长内容多时，可以选一个建议试一天。只记录是否有用，不急着收藏更多方法。',
    visualFamily: FeedVisualFamily.reflection,
  ),
  TopicDefinition(
    id: 'football',
    label: '足球',
    domain: '体育赛事',
    aliases: ['足球', '中超', '英超', '欧冠', '世界杯', 'football'],
    expandTo: ['俱乐部经营', '球员故事', '城市文化'],
    missingPrompt: '足球内容多时，可以看一篇俱乐部经营或球员长访谈。先看人和城市，不只看比分。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
  TopicDefinition(
    id: 'basketball',
    label: '篮球',
    domain: '体育赛事',
    aliases: ['篮球', 'nba', 'cba', '湖人', '勇士', 'basketball'],
    expandTo: ['球队经营', '训练', '球员故事'],
    missingPrompt: '篮球内容多时，可以看一篇球队经营或球员训练报道。先看长期结构，再看单场输赢。',
    visualFamily: FeedVisualFamily.entertainment,
  ),
];
