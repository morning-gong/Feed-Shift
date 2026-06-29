# FeedShift Figma Screen Spec — Detail v1

## Frame

Name: `Detail / iPhone 16 Pro`  
Size: `393 x 852`

## Purpose

Explain today's Climate Snapshot.

## Layer Tree

```text
Detail / iPhone 16 Pro
├─ 00 Atmosphere
│  ├─ Photography Base
│  ├─ Air Overlay
│  ├─ Light Veil
│  └─ Darkroom Depth
├─ 01 Header
│  ├─ Back Control
│  └─ Header Text Group
│     ├─ Screen Title
│     └─ Date State Label
├─ 02 Content Stack
│  ├─ Snapshot Summary
│  │  ├─ Micro Halo
│  │  ├─ Primary Explanation
│  │  └─ Secondary Hint
│  ├─ Reason Layers
│  │  ├─ Section Label
│  │  ├─ Reason Row / 01
│  │  ├─ Reason Row / 02
│  │  └─ Reason Row / 03
│  ├─ Structure Glimpse
│  │  ├─ Section Label
│  │  ├─ Distribution Row / 01
│  │  ├─ Distribution Row / 02
│  │  └─ Distribution Row / 03
│  └─ Suggestion Bridge
│     ├─ Section Label
│     ├─ Suggestion Pill / 01
│     ├─ Suggestion Pill / 02
│     └─ Suggestion Pill / 03
```

## Wireframe

```text
┌─────────────────────────┐
│  ←  今日信息结构          │
│     6月4日 · 娱乐偏高     │
│                         │
│  娱乐内容稍微多了一点     │
│  可以打开一点边界         │
│                         │
│  为什么会这样             │
│  01  娱乐内容停留较多      │
│  02  热门话题重复出现      │
│  03  情绪表达内容上升      │
│                         │
│  今日结构                 │
│  娱乐 ████████ 60%        │
│  情绪 ███ 20%             │
│  消费 ██ 10%              │
│                         │
│  可以补充                 │
│  科技趋势  国际观察        │
└─────────────────────────┘
```

## Layout

### Frame Auto Layout

```text
Direction: Vertical
Width: 393
Height: 852
Padding: 12 top, 20 left, 20 right, 40 bottom
Gap: 14
Alignment: Left
```

### Header

```text
Direction: Horizontal
Width: Fill
Height: 56
Gap: 10
Alignment: Center
```

### Content Stack

```text
Direction: Vertical
Width: Fill
Height: Hug
Gap: 14
Alignment: Left
```

### Snapshot Summary

```text
Direction: Vertical
Width: Fill
Height: Hug
Padding: 24
Gap: 14
Alignment: Left
```

### Reason Layers

```text
Direction: Vertical
Width: Fill
Height: Hug
Padding: 20
Gap: 12
Alignment: Left
```

### Structure Glimpse

```text
Direction: Vertical
Width: Fill
Height: Hug
Padding: 20
Gap: 12
Alignment: Left
```

### Suggestion Bridge

```text
Direction: Vertical
Width: Fill
Height: Hug
Padding: 20
Gap: 12
Alignment: Left
```

## Content

```text
Screen Title: 今日信息结构
Date State Label: 6月4日 · 娱乐偏高
Primary Explanation: 娱乐内容稍微多了一点
Secondary Hint: 可以打开一点边界
Reason 01: 娱乐内容停留较多
Reason 02: 热门话题重复出现
Reason 03: 情绪表达内容上升
Distribution 01: 娱乐 / 60%
Distribution 02: 情绪 / 20%
Distribution 03: 消费 / 10%
Suggestion 01: 科技趋势
Suggestion 02: 国际观察
Suggestion 03: 工业设计
```

## Component Instances

```text
Atmosphere Layer / Entertainment
Header / Back
Developing Halo / Entertainment / Static / Small
Reason Row / Default
Structure Row / Top category
Suggestion Pill / Default
```

## Sizing

```text
Back Control: 40 x 40
Micro Halo: 56 x 56
Reason Row: Fill x 32
Distribution Row: Fill x 30
Suggestion Pill: min 72 x 34
```

## Motion

```text
Screen Enter: 520ms / 0ms delay / ease out
Summary Development: 620ms / 120ms delay / ease out cubic
Reason Reveal: 360ms / 280ms delay / ease out
Suggestion Reveal: 360ms / 420ms delay / ease out
```

## Variants To Prepare

```text
Entertainment
Tech
Knowledge
Emotion
Balanced
Unclear
```

## Must Exist

```text
Header
Snapshot Summary
Reasons
Structure Glimpse
Suggestions
Atmosphere Layer
```

## Can Remove

```text
Full radial chart
All five categories
Long explanation
Footer quote
Extra decorative icon
Repeated state emoji
Raw source text
Secondary navigation
```

## Explicitly Removed

```text
Full chart
Footer sentence
Large emoji block
Long reason paragraph
More than 3 categories
More than 3 suggestions
Extra card header copy
Decorative graph elements
```

## QA

| Risk | Score |
|---|---:|
| Dashboard Risk | 3 |
| AI SaaS Risk | 2 |
| Apple Journal Risk | 2 |
| Calm Risk | 2 |
| Arc Risk | 1 |

Recognition score without logo/name:

```text
84 / 100
```

Status:

```text
Ready for Figma build
```
