# FeedShift Figma Screen Spec — Explore v1

## Frame

Name: `Explore / iPhone 16 Pro`  
Size: `393 x 852`

## Purpose

Offer one cognitive supplement direction.

## Layer Tree

```text
Explore / iPhone 16 Pro
├─ 00 Atmosphere
│  ├─ Photography Base
│  ├─ Air Overlay
│  ├─ Light Veil
│  └─ Darkroom Depth
├─ 01 Header
│  ├─ Back Control
│  └─ Header Text Group
│     ├─ Screen Title
│     └─ Subtitle
├─ 02 Content Stack
│  ├─ Exploration Statement
│  │  ├─ Direction Marker
│  │  ├─ Direction Label
│  │  └─ Summary
│  ├─ Topic Path
│  │  ├─ Section Label
│  │  ├─ Topic Row / 01
│  │  ├─ Topic Row / 02
│  │  ├─ Topic Row / 03
│  │  └─ Topic Row / 04
│  ├─ Reason Block
│  │  ├─ Section Label
│  │  └─ Reason Text
│  └─ Return Context
│     └─ Footer Line
```

## Wireframe

```text
┌─────────────────────────┐
│  ←  轻探索               │
│     换一个角度看今天      │
│                         │
│  科技趋势                │
│  增加一点科技与产业视角， │
│  让今天的信息结构更开阔。 │
│                         │
│  可以先关注              │
│  01  AI 应用趋势         │
│  02  芯片发展            │
│  03  自动驾驶            │
│  04  新能源技术          │
│                         │
│  为什么推荐给你           │
│  当前娱乐内容偏高，科技   │
│  视角能提供理性补充。     │
│                         │
│  认知增长，来自多元输入。 │
└─────────────────────────┘
```

## Layout

```text
Frame: Vertical / 393 x 852 / padding 20 x, 12 top, 40 bottom / gap 14
Header: Horizontal / Fill x 56 / gap 10
Content Stack: Vertical / Fill / gap 14
Exploration Statement: Vertical / Fill / padding 24 / gap 12
Topic Path: Vertical / Fill / padding 20 / gap 12
Reason Block: Vertical / Fill / padding 20 / gap 12
Return Context: Vertical / Fill / center
```

## Content

```text
Screen Title: 轻探索
Subtitle: 换一个角度看今天
Direction Label: 科技趋势
Summary: 增加一点科技与产业视角，让今天的信息结构更开阔。
Topic 01: AI 应用趋势
Topic 02: 芯片发展
Topic 03: 自动驾驶
Topic 04: 新能源技术
Reason: 当前娱乐内容偏高，科技视角能提供理性补充。
Footer: 认知增长，来自多元输入。
```

## Component Instances

```text
Atmosphere Layer / Entertainment
Header / Back
Suggestion Pill / Default
Reason Row / Default
```

## Sizing

```text
Back Control: 40 x 40
Direction Marker: 44 x 44
Topic Row: Fill x 34
Reason Block: Fill x Hug
Footer Line: Fill x Hug
```

## Motion

```text
Screen Enter: 520ms / 0ms / ease out
Exploration Statement: 620ms / 120ms / ease out cubic
Topic Path Reveal: 380ms / 280ms / ease out
Reason Reveal: 360ms / 440ms / ease out
```

## Variants To Prepare

```text
Technology supplement
Knowledge supplement
Emotion supplement
International supplement
Consumption supplement
```

## Must Exist

```text
Header
Exploration Statement
Topic Path
Reason Block
Footer Line
Atmosphere Layer
```

## Can Remove

```text
Large icon
Multiple cards per topic
Images inside topics
Extra CTAs
Long explanation
Category percentages
Related recommendations
Progress indicators
```

## Explicitly Removed

```text
Topic cards
Topic images
Explore CTA button
More recommendations
Category data
Decorative illustration
Large direction icon
Secondary metadata
```

## QA

| Risk | Score |
|---|---:|
| Dashboard Risk | 1 |
| AI SaaS Risk | 1 |
| Apple Journal Risk | 2 |
| Calm Risk | 3 |
| Arc Risk | 1 |

Recognition score without logo/name:

```text
82 / 100
```

Status:

```text
Ready for Figma build
```
