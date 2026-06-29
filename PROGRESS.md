# FeedShift 项目进度

最后更新：2026-05-25

## 项目定位
帮助用户识别短视频信息结构、减少信息茧房影响、提升认知多样性的安卓 App。

## 技术栈
- Flutter 3.44.0 / Dart 3.12.0
- Material 3 + 深色模式，Glassmorphism UI
- `setState` 状态管理，无第三方状态库
- 纯本地假数据，无网络/数据库/AI
- 无外部 package 依赖

## 约束（始终遵守）
- 禁止：数据库 / API / AI / Riverpod / Bloc / 复杂状态管理 / 大规模重构
- 只允许：本地假数据
- 优先：简单方案（setState + 本地 model）

## 文件结构
```
lib/
├── main.dart                    # 首页 UI（HomePage, _MainStatusCard, _ExploreCard）
├── detail_page.dart             # 详情页 UI
├── recommendation_page.dart     # 推荐探索页 UI
├── data/mock/
│   └── feed_profiles.dart       # 所有假数据（ExploreItem, FeedState, kFeedStates）
└── widgets/
    └── glass_card.dart          # 公共玻璃卡片组件（GlassCard）
```

## 数据模型
- `ExploreItem`：label, subtitle, summary, topics, reason, footer
- `FeedState`：emoji, tag, title, description, hint, structure, reasons, explore, gradientColors
- `kFeedStates`：4 个状态（娱乐偏高、科技探索型、学习探索型、情绪内容偏多）

## 导航链路
HomePage → DetailPage(state) → RecommendationPage(item, gradientColors)

## 已完成阶段

### 阶段 1-2：静态首页 + 动态状态切换
- Glassmorphism 风格首页，4 种信息状态
- AnimatedContainer 背景渐变动画（600ms easeInOut）
- `setState` 驱动状态切换

### 阶段 3-4：详情页 + 状态同步
- 详情页：内容占比进度条、原因分析、推荐探索标签
- 首页与详情页渐变色完全同步，数据通过 `FeedState` 传递

### 阶段 5：推荐探索页
- 详情页标签点击跳转到 `RecommendationPage`
- 展示摘要、可关注话题、推荐理由、页脚

### 阶段 6：数据与 UI 分离
- 创建 `lib/data/mock/feed_profiles.dart`，集中管理所有假数据
- 三个页面文件只负责渲染，不再定义数据

### 优化（2026-05-25）
- 问候语和日期改为读取系统时间（凌晨好/早上好/下午好/晚上好）
- 首页推荐标签支持点击跳转到 `RecommendationPage`
- 提取公共 `GlassCard` 到 `lib/widgets/glass_card.dart`，消除重复代码

## 关键路径
- **项目根目录**：`E:\FeedShiftDev\projects\feedshift`
- **Flutter SDK**：`E:\FeedShiftDev\sdk\flutter`
- **Android SDK**：`E:\FeedShiftDev\android-sdk`
- **AVD 目录**：`E:\FeedShiftDev\.android\avd\Pixel_6a.avd`

## 启动方式

### 启动模拟器
需手动从 Android Studio 启动（Pixel_6a x86_64 / API 34）。
命令行方式（备用）：
```bash
"E:/FeedShiftDev/android-sdk/emulator/emulator.exe" -avd Pixel_6a -no-snapshot-load
```

### 跑 App
```bash
cd "E:/FeedShiftDev/projects/feedshift"
flutter run lib/main.dart
```

### 热重载
- `r` = hot reload（改 widget 内容）
- `R` = hot restart（改主题/全局结构）
- `q` = 退出

## 已踩过的坑（避免重复）
1. **AVD 目录在 E 盘不在 C 盘** — ANDROID_USER_HOME 改到 `E:\FeedShiftDev\.android\`，C 盘 `.android\avd` 是空架子。
2. **AVD 默认创建为 ARM 架构** — Windows x86_64 跑不动，必须用 `avdmanager` 强制 `system-images;android-34;google_apis_playstore;x86_64`。
3. **adb 密钥不匹配** — 模拟器读 E 盘 `.android/adbkey`，需把 `adbkey/adbkey.pub` 从 C 盘复制到 E 盘。
4. **模拟器窗口渲染崩溃**（UpdateLayeredWindowIndirect failed）— 通过 Android Studio GUI 手动启动可绕过。
5. **Gradle 第一次构建慢** — 国内网拉 Google Maven 慢，后续有缓存会快。
