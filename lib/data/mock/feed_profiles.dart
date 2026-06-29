import 'package:flutter/material.dart';

class ExploreItem {
  final String label;
  final String subtitle;
  final String summary;
  final List<String> topics;
  final String reason;
  final String footer;
  final String imagePath;

  const ExploreItem({
    required this.label,
    required this.subtitle,
    required this.summary,
    required this.topics,
    required this.reason,
    required this.footer,
    required this.imagePath,
  });
}

class FeedState {
  final String emoji;
  final String tag;
  final String title;
  final String description;
  final String hint;
  final List<Map<String, dynamic>> structure;
  final List<String> reasons;
  final List<ExploreItem> explore;
  final List<Color> gradientColors;
  final String backgroundImage;

  const FeedState({
    required this.emoji,
    required this.tag,
    required this.title,
    required this.description,
    required this.hint,
    required this.structure,
    required this.reasons,
    required this.explore,
    required this.gradientColors,
    required this.backgroundImage,
  });
}

const String _base = 'assets/backgrounds/feedshift';

const List<FeedState> kFeedStates = [
  FeedState(
    emoji: '01',
    tag: '今日气候',
    title: '散风天气',
    description: '想法来得很快，真正留下的不多。',
    hint: '把今天先当成天气来读，不急着打分。',
    structure: _softStructure,
    reasons: ['高频信息浮在表面，容易把注意力带走。', '长一点的内容还没有形成稳定入口。', '今天需要少一点推送，多一点空白。'],
    explore: _fieldNotes,
    gradientColors: [Color(0xFF9C8B73), Color(0xFF4A4033), Color(0xFF15120E)],
    backgroundImage: '$_base/today-climate.png',
  ),
  FeedState(
    emoji: '02',
    tag: '认知生态',
    title: '活的系统',
    description: '不同内容正在形成同一个气候。',
    hint: '你的输入更像栖息地，不只是几个频道。',
    structure: _softStructure,
    reasons: ['多个主题开始彼此连接。', '不同领域背后有相似的问题。', '没有单一信息流占满视野时，系统更健康。'],
    explore: _ecosystemNotes,
    gradientColors: [Color(0xFF6E8A68), Color(0xFF26341F), Color(0xFF0B1109)],
    backgroundImage: '$_base/ecosystems.png',
  ),
  FeedState(
    emoji: '03',
    tag: '慢问题',
    title: '慢一点想',
    description: '确定感退开以后，还剩下什么？',
    hint: '给那些不必立刻回答的问题留一个房间。',
    structure: _softStructure,
    reasons: ['抽象问题比短刺激停留得更久。', '确定的判断开始让位给观察。', '最强的信号不是更多内容，而是更深一点。'],
    explore: _philosophyNotes,
    gradientColors: [Color(0xFF9A7357), Color(0xFF3B281C), Color(0xFF120B07)],
    backgroundImage: '$_base/philosophy-field.png',
  ),
  FeedState(
    emoji: '04',
    tag: '历史档案',
    title: '档案室',
    description: '每个时代都会留下自己的气候。',
    hint: '把当下放到更长的时间里看，很多东西会安静下来。',
    structure: _softStructure,
    reasons: ['旧背景能解释今天的紧张感。', '档案让当下有了更长的影子。', '时间比结论更适合做入口。'],
    explore: _historyNotes,
    gradientColors: [Color(0xFFA48763), Color(0xFF4A3522), Color(0xFF160E08)],
    backgroundImage: '$_base/history-archive.png',
  ),
  FeedState(
    emoji: '05',
    tag: '技术信号',
    title: '新信号',
    description: '今天很弱的东西，明天可能会变强。',
    hint: '技术不只看功能，也看它改变了什么关系。',
    structure: _softStructure,
    reasons: ['新工具像轻微的气压变化。', '最清楚的移动来自底层系统。', '技术信号需要被拉回人的尺度。'],
    explore: _technologyNotes,
    gradientColors: [Color(0xFF9AA7A3), Color(0xFF39464B), Color(0xFF0A1115)],
    backgroundImage: '$_base/technology-signals.png',
  ),
  FeedState(
    emoji: '06',
    tag: '人的故事',
    title: '正在发生的生活',
    description: '一个人，一段生活，一个角度。',
    hint: '人的处境能把抽象事件重新放回真实尺度。',
    structure: _softStructure,
    reasons: ['个体故事比概念更容易留下痕迹。', '情绪被具体处境托住，而不是被放大。', '今天更适合看见，而不是继续堆叠信息。'],
    explore: _humanNotes,
    gradientColors: [Color(0xFF9B7053), Color(0xFF3C2418), Color(0xFF120907)],
    backgroundImage: '$_base/human-stories.png',
  ),
  FeedState(
    emoji: '07',
    tag: '认知地图',
    title: '你在这里',
    description: '你的信息气候一直在变化。',
    hint: '这张地图只帮你定位，不把你变成分数。',
    structure: _softStructure,
    reasons: ['同样的主题从不同路径返回。', '知道自己在哪，比测量自己更重要。', '安静的地图才真的有用。'],
    explore: _mapNotes,
    gradientColors: [Color(0xFFB6AD96), Color(0xFF5A5549), Color(0xFF14130F)],
    backgroundImage: '$_base/reflection.png',
  ),
  FeedState(
    emoji: '08',
    tag: '回到深处',
    title: '回到深处',
    description: '注意力绕了一圈，又慢慢回来。',
    hint: '反思不是审判今天，只是把散开的东西收回来。',
    structure: _softStructure,
    reasons: ['注意力先向外散开，然后重新落下。', '噪声退后，真正有用的线索才露出来。', '结束时需要一个更慢的表面。'],
    explore: _reflectionNotes,
    gradientColors: [Color(0xFFB6AD96), Color(0xFF5A5549), Color(0xFF14130F)],
    backgroundImage: '$_base/reflection.png',
  ),
  FeedState(
    emoji: '09',
    tag: '博物馆',
    title: '耐看的东西',
    description: '从档案里拿出一件不急着被消费的东西。',
    hint: '给值得停留的材料留一间慢房间。',
    structure: _softStructure,
    reasons: ['文化记忆带来更稳定的重量。', '最强的物件不需要大声解释。', '策展感能替代信息流速度。'],
    explore: _museumNotes,
    gradientColors: [Color(0xFFB2A189), Color(0xFF554534), Color(0xFF15100B)],
    backgroundImage: '$_base/museum-archive.png',
  ),
];

const List<Map<String, dynamic>> _softStructure = [
  {'label': '当下', 'value': 0.34},
  {'label': '背景', 'value': 0.24},
  {'label': '行动', 'value': 0.20},
  {'label': '他人', 'value': 0.14},
  {'label': '回看', 'value': 0.08},
];

const String _longformImage = '$_base/recommendation-longform.png';
const String _delayImage = '$_base/recommendation-delay.png';
const String _factsImage = '$_base/recommendation-facts.png';
const String _topicImage = '$_base/recommendation-topic.png';
const String _humanImage = '$_base/recommendation-human.png';
const String _archiveImage = '$_base/history-archive.png';
const String _ecosystemImage = '$_base/ecosystems.png';
const String _museumImage = '$_base/museum-archive.png';
const String _reflectionImage = '$_base/reflection.png';

const List<ExploreItem> _fieldNotes = [
  ExploreItem(
    label: '把一件事看完',
    subtitle: '8 分钟以上 · 完整读到结尾',
    summary: '从收藏夹或浏览记录里选一篇完整文章、访谈或长视频。只完成一篇，不连续刷新。',
    topics: ['先定 12 分钟计时器', '看到结尾再判断值不值得', '最后写一句你真正记住的点'],
    reason: '你现在缺的不是更多入口，而是一次完整停留。完整内容能把注意力从碎片节奏里拉出来。',
    footer: '今天只把一件事看完。',
    imagePath: _longformImage,
  ),
  ExploreItem(
    label: '留一段空白',
    subtitle: '离屏 10 分钟 · 不换另一个 App',
    summary: '退出当前内容 App，把手机扣在桌面上。十分钟后再决定是否继续。',
    topics: ['不要立刻换另一个 App', '喝水或走到窗边', '回来后删掉一个不想再看的推荐源'],
    reason: '信息流最会利用连续切换。短暂停顿能让你重新拿回选择权。',
    footer: '空档也是输入的一部分。',
    imagePath: _reflectionImage,
  ),
];
const List<ExploreItem> _ecosystemNotes = [
  ExploreItem(
    label: '找一个陌生主题',
    subtitle: '跨出常看领域',
    summary: '用一个平时不会主动搜索的关键词开始，比如城市排水、口述史、种子保存或社区剧场。',
    topics: ['选一个陌生名词', '先看百科或长报道', '记录它和你常看内容的连接'],
    reason: '你的内容已经有一定广度，下一步不是继续加量，而是让两个原本不相邻的领域产生连接。',
    footer: '从一个陌生词开始。',
    imagePath: _topicImage,
  ),
  ExploreItem(
    label: '画三点关系',
    subtitle: '把主题连起来',
    summary: '把今天看到的三个主题写成三点，再各画一条它们之间可能存在的关系。',
    topics: ['一个事实', '一个人群', '一个长期影响'],
    reason: '当信息开始成网，最有用的不是再收集，而是看清关系。',
    footer: '关系比数量更重要。',
    imagePath: _ecosystemImage,
  ),
];
const List<ExploreItem> _philosophyNotes = [
  ExploreItem(
    label: '把情绪改成问题',
    subtitle: '可验证的一问',
    summary: '把“我很焦虑/烦/被冒犯”改写成一个能查证的问题，比如“我具体担心哪件事会发生？”',
    topics: ['先写原始情绪词', '改成一个事实问题', '只查一条可靠来源'],
    reason: '短刺激容易直接推高情绪。把情绪翻译成问题，会让你从反应回到判断。',
    footer: '先问清楚，再继续看。',
    imagePath: _factsImage,
  ),
  ExploreItem(
    label: '保留一个不回答',
    subtitle: '慢问题',
    summary: '遇到复杂观点时，不急着站队。把它存成一个暂时没有答案的问题。',
    topics: ['它在反对什么', '它忽略了谁', '我需要什么证据'],
    reason: '有些问题留一晚，比立刻得到态度更有价值。',
    footer: '不是每个问题都要马上合上。',
    imagePath: _reflectionImage,
  ),
];
const List<ExploreItem> _historyNotes = [
  ExploreItem(
    label: '给热点找前史',
    subtitle: '往前看十年',
    summary: '挑一个今天反复出现的话题，查它十年前、二十年前被怎样讨论。',
    topics: ['一个旧新闻', '一个政策背景', '一个当时的普通人视角'],
    reason: '热点会制造“刚刚发生”的错觉。前史能帮你看见它真正累积了多久。',
    footer: '把今天放回时间里。',
    imagePath: _archiveImage,
  ),
  ExploreItem(
    label: '读一份原始材料',
    subtitle: '少看二手总结',
    summary: '从报告、访谈、判决书、展览说明或旧报纸里选一份原始材料，只读关键页。',
    topics: ['材料是谁写的', '它想解决什么', '哪些词今天还在用'],
    reason: '原始材料比观点摘要慢，但它能减少被二手情绪带跑的概率。',
    footer: '少一点转述，多一点证据。',
    imagePath: _archiveImage,
  ),
];
const List<ExploreItem> _technologyNotes = [
  ExploreItem(
    label: '把技术放回人身上',
    subtitle: '看具体的人 · 不只看功能',
    summary: '看一位教师、医生、工人、创作者或社区组织者怎样使用或拒绝这项技术。',
    topics: ['谁受益', '谁多做了工作', '谁被排除在外'],
    reason: '技术新闻容易只谈能力。人的处境能帮你判断它真正改变了什么关系。',
    footer: '技术要落在人身上。',
    imagePath: _humanImage,
  ),
  ExploreItem(
    label: '查背后的基础设施',
    subtitle: '不只看功能',
    summary: '遇到新产品时，顺手查它依赖的数据、能源、供应链或审核机制。',
    topics: ['数据从哪里来', '谁维护系统', '失败时谁承担成本'],
    reason: '功能介绍通常很亮，基础设施才解释它能不能长期改变生活。',
    footer: '看见看不见的部分。',
    imagePath: _topicImage,
  ),
];
const List<ExploreItem> _humanNotes = [
  ExploreItem(
    label: '读一个人的完整经历',
    subtitle: '不要只看金句',
    summary: '找一篇人物报道、口述史或访谈，读完一个人的处境，而不是只摘观点。',
    topics: ['他在哪里生活', '他被什么限制', '他做过哪些选择'],
    reason: '当技术或热点过于抽象时，一个人的完整处境能把判断拉回现实。',
    footer: '从一个具体的人开始。',
    imagePath: _humanImage,
  ),
  ExploreItem(
    label: '补一个反例',
    subtitle: '让判断更稳',
    summary: '如果你刚看完一个强观点，主动找一个可信反例，看看它在哪里成立。',
    topics: ['反例来自谁', '它反驳哪一点', '它有没有证据'],
    reason: '不是为了平均立场，而是避免被单一叙事带着走。',
    footer: '观点需要压力测试。',
    imagePath: _factsImage,
  ),
];
const List<ExploreItem> _mapNotes = [
  ExploreItem(
    label: '做一张偏好地图',
    subtitle: '三类内容就够',
    summary: '把最近常看的内容分成“放松、学习、担心”三类，看看哪一类占了太多。',
    topics: ['各写三个例子', '圈出重复来源', '决定明天少看哪一类'],
    reason: '你不需要一个复杂评分，只需要知道注意力最近被哪条路反复带走。',
    footer: '先定位，再调整。',
    imagePath: _topicImage,
  ),
  ExploreItem(
    label: '删掉一个重复入口',
    subtitle: '减少回声',
    summary: '取消关注一个只重复同类情绪、同类观点或同类消费建议的账号。',
    topics: ['它是否给新信息', '它是否只放大情绪', '它是否总引向购买'],
    reason: '开拓视野有时不是增加内容，而是移除一个过度重复的入口。',
    footer: '少一个入口，也会更宽。',
    imagePath: _reflectionImage,
  ),
];
const List<ExploreItem> _reflectionNotes = [
  ExploreItem(
    label: '写下留下来的三件事',
    subtitle: '睡前回看',
    summary: '不要复盘所有内容，只写今天真正留下来的三个信息、问题或画面。',
    topics: ['一个事实', '一个问题', '一个明天再看的方向'],
    reason: '情绪内容会在当下很响，写下来之后，你更容易分辨什么真的有用。',
    footer: '让有用的东西过夜。',
    imagePath: _factsImage,
  ),
  ExploreItem(
    label: '把未读清空一半',
    subtitle: '给明天留空间',
    summary: '从收藏、稍后看或浏览器标签里删掉一半不会再看的内容。',
    topics: ['重复的删掉', '只留原始来源', '给每个保留项写用途'],
    reason: '未读堆积会制造压力。清掉无效入口，比继续收藏更能恢复注意力。',
    footer: '轻一点进入明天。',
    imagePath: _reflectionImage,
  ),
];
const List<ExploreItem> _museumNotes = [
  ExploreItem(
    label: '让喜欢过一晚',
    subtitle: '不下单 · 明天同一时间再看',
    summary: '把想买的东西放进清单，不下单。明天再问：我还记得它解决什么问题吗？',
    topics: ['写下真实用途', '查一次差评', '明天同一时间再决定'],
    reason: '种草内容擅长把“喜欢”包装成“需要”。延迟一天能把两者分开。',
    footer: '先不买，也是一个选择。',
    imagePath: _delayImage,
  ),
  ExploreItem(
    label: '看一件耐久物',
    subtitle: '换掉消费速度',
    summary: '找一件用了三年以上的东西，想想它为什么留下来了。',
    topics: ['它解决了什么', '它哪里经得住用', '新东西是否真的更好'],
    reason: '耐久物能对冲即时购买冲动，让注意力回到使用而不是拥有。',
    footer: '耐用，比新鲜更难得。',
    imagePath: _museumImage,
  ),
];
