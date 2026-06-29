# FeedShift

FeedShift（破茧）是一个认知陪伴产品，用来帮助用户观察自己的信息环境，降低信息茧房影响，提升认知多样性。
当前项目处于 MVP 阶段。
## Product Positioning

FeedShift = Cognitive Climate Observatory

核心对象：
- Climate Snapshot

当前核心能力：
- Today 首页
- Detail 详情页
- Explore 探索页
- Accessibility 页面读取 MVP
- 本地内容分类
- 本地信息结构分析

## Design Foundation

以下设计基础已冻结，不再重新定义：
- Visual Manifesto v1
- Symbol System v1
- Visual Grammar v1
- Spatial Identity v1
- Art Direction v1
- Design Constitution v2
- Product-to-UI Genesis v3

核心设计约束：
- Space Before Interface
- Air Before Information
- Development Before Presentation
- Photography Before Graphics
- Single Focus Principle
- Non Dashboard Principle
- Non AI SaaS Principle

## Figma Assembly Specs

Figma 搭建规格位于：
```text
design-research/specs/
```

入口文件：
```text
design-research/specs/figma-handoff-index-v1.md
```

当前已生成：

- `figma-handoff-index-v1.md`
- `figma-designer-brief-v1.md`
- `figma-production-readiness-audit-v1.md`
- `figma-asset-placeholder-spec-v1.md`
- `figma-assembly-index-v1.md`
- `figma-assembly-tokens-v1.md`
- `figma-assembly-components-v1.md`
- `figma-assembly-screens-v1.md`
- `figma-assembly-states-v1.md`
- `figma-assembly-prototype-v1.md`
- `figma-assembly-qa-v1.md`
- `figma-build-checklist-v1.md`
- `figma-page-01-tokens-build-v1.md`
- `figma-page-02-components-build-v1.md`
- `figma-page-03-p0-screens-build-v1.md`
- `figma-page-04-reflection-screens-build-v1.md`
- `figma-page-05-states-build-v1.md`
- `figma-page-06-prototype-build-v1.md`
- `figma-page-07-qa-build-v1.md`
- `figma-screen-today-v1.md`
- `figma-screen-detail-v1.md`
- `figma-screen-explore-v1.md`
- `figma-screen-history-v1.md`
- `figma-screen-settings-v1.md`
- `figma-screen-reflections-v1.md`

## Figma MCP / Plugin Status

Configured:

- Remote MCP server: `figma`
- MCP URL: `https://mcp.figma.com/mcp`
- Codex plugin: `figma@openai-curated`
- Installed plugin cache: `E:\Codex\plugins\cache\openai-curated\figma\2abb1c44`

Available Figma plugin skills after Codex reload:

- `figma-create-new-file`
- `figma-generate-design`
- `figma-generate-library`
- `figma-use`
- `figma-code-connect`

Current note:

- `codex mcp add figma --url https://mcp.figma.com/mcp --oauth-resource https://mcp.figma.com/mcp` completed.
- Figma MCP network access works outside the restricted sandbox.
- `codex mcp login figma` completed.
- `codex mcp list` now reports Figma auth as `OAuth`.
- Current Codex session exposes Figma tools and has created the Figma production file.
- Current Figma account status observed through `whoami`: Starter plan, View seat.
- Figma MCP Starter/View call limit has been reached, so additional Figma MCP writes, screenshots, and metadata reads are currently blocked.

Current Figma file:

```text
FeedShift MVP UI v1
https://www.figma.com/design/nRQsjQuviY9B4iQdEDaxsJ
```

Figma build progress:

- Created `FeedShift MVP UI v1`.
- Because the Starter plan limits files to 3 pages, compressed the original 9-page Figma tree into:
  - `00 Foundation`
  - `01 System`
  - `02 Product Screens`
- Built Foundation / System / Tokens / Components base boards.
- Built 11 mobile frames:
  - Today
  - Detail
  - Explore
  - History
  - Settings
  - Weekly Reflection
  - Monthly Reflection
  - Yearly Review
  - Empty State
  - Loading State
  - Error State

Pending after MCP quota recovers:

- Prototype flow map.
- QA gate board.
- Screen acceptance inventory.
- Expanded state variants.
- Screenshot-based visual QA.
- Figma structure readback verification.

Prepared continuation script:

```text
C:\Users\lenovo\feedshift-figma-continuation-v1.js
```

Recovery plan:

- Apply for Figma Education using the Wuhan University email.
- After approval, confirm plan and seat with `whoami`.
- If the new plan/seat allows enough MCP calls, run the continuation script against file key `nRQsjQuviY9B4iQdEDaxsJ`.

## Tech Stack

- Flutter
- Material 3
- Android
- Local mock data
- Android AccessibilityService MVP

当前不使用：

- Riverpod
- Bloc
- Provider
- GetX
- Database
- Cloud API

## Project Structure

```text
lib/
├─ main.dart
├─ detail_page.dart
├─ recommendation_page.dart
├─ accessibility_page.dart
├─ data/mock/feed_profiles.dart
├─ services/
│  ├─ accessibility_reader.dart
│  ├─ content_classifier.dart
│  └─ information_structure_analyzer.dart
├─ theme/app_theme.dart
└─ widgets/glass_card.dart

design-research/
├─ references/
├─ research-notes/
└─ specs/
```

## Run

项目目录：
```bash
cd E:/FeedShiftDev/projects/feedshift
```

运行到模拟器：
```bash
flutter run
```

运行测试：
```bash
flutter test
```

静态分析：

```bash
flutter analyze
```

构建 debug APK：
```bash
flutter build apk --debug
```

## Android Accessibility MVP

使用方式：
1. 打开 FeedShift。
2. 点击首页右上角页面读取入口。
3. 在系统无障碍设置中开启 FeedShift。
4. 打开其他 App 或页面。
5. 回到 FeedShift 刷新读取。
6. 查看本地分类和信息结构分析。

说明：
- MVP 阶段只做本地读取与本地规则分析。
- 不上传数据。
- 不连接云端 API。

## Current Status

已完成：

- Stage 1 项目理解
- Stage 2 Design System 方向
- Stage 3 首页重构
- Stage 4 详情页重构
- Stage 5 探索页重构
- Stage 6 Accessibility MVP
- Stage 7 内容分类系统
- Stage 8 真实信息结构分析
- UI Production Specs
- Figma Assembly Specs
- Figma Handoff Specs
- Figma Page Build Specs

下一步：

- 申请 Figma Education 或等待 MCP 月度额度恢复
- 恢复后继续执行 `C:\Users\lenovo\feedshift-figma-continuation-v1.js`
- 补齐 Prototype / QA / expanded states
- 完成截图视觉 QA 与 Figma 结构验证

