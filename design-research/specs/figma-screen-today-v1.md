# FeedShift Figma Screen Spec — Today v1

## Frame

Name: `Today / iPhone 16 Pro`  
Size: `393 x 852`

## Purpose

Present today's Climate Snapshot.

## Layer Tree

```text
Today / iPhone 16 Pro
├─ 00 Atmosphere
│  ├─ Photography Base
│  ├─ Air Overlay
│  ├─ Light Veil
│  └─ Darkroom Depth
├─ 01 Header
│  ├─ Header Text Group
│  │  ├─ Greeting
│  │  └─ Date Climate Label
│  └─ Read Entry Button
├─ 02 Hero
│  └─ Developing Halo
│     ├─ Halo Outer Air
│     ├─ Halo Primary Arc
│     ├─ Halo Secondary Arc
│     ├─ Halo Broken Arc
│     ├─ Halo Center Value
│     └─ Halo Center Label
├─ 03 Insight
│  ├─ Primary Climate Statement
│  └─ Secondary Hint
├─ 04 Suggestions
│  ├─ Suggestion Pill / 01
│  ├─ Suggestion Pill / 02
│  └─ Suggestion Pill / 03
└─ 05 Navigation
   ├─ Nav Surface
   ├─ Nav Item / Today
   └─ Nav Item / History
```

## Wireframe

```text
┌─────────────────────────┐
│  晚上好              ○  │
│  6月4日 · 今日气候      │
│                         │
│                         │
│          ◌ ◌ ◌          │
│       ◌         ◌        │
│      ◌    60%    ◌       │
│       ◌         ◌        │
│          ◌ ◌ ◌          │
│                         │
│  娱乐内容稍微多了一点    │
│  可以轻轻打开一点边界     │
│                         │
│  科技趋势  深度阅读      │
│  国际观察                │
│                         │
│        Today  History    │
└─────────────────────────┘
```

## Layout

### Frame Auto Layout

```text
Direction: Vertical
Width: 393
Height: 852
Padding: 24 top, 20 left, 20 right, 24 bottom
Gap: 0
Alignment: Center
```

### Header

```text
Direction: Horizontal
Width: Fill
Height: 52
Gap: 12
Alignment: Top
```

### Hero

```text
Direction: Vertical
Width: Fill
Height: 390
Alignment: Center
```

### Insight

```text
Direction: Vertical
Width: Fill
Height: Hug
Gap: 8
Alignment: Left
```

### Suggestions

```text
Direction: Horizontal Wrap
Width: Fill
Height: Hug
Gap: 8
Alignment: Left
```

### Navigation

```text
Direction: Horizontal
Width: Hug
Height: 44
Padding: 6 vertical, 8 horizontal
Gap: 14
Alignment: Center
```

## Content

### Header

```text
Greeting: 晚上好
Date Climate Label: 6月4日 · 今日气候
Read Entry: icon only
```

### Hero

```text
Center Value: 60%
Center Label: 娱乐偏高
```

### Insight

```text
Primary: 娱乐内容稍微多了一点
Secondary: 可以轻轻打开一点边界
```

### Suggestions

```text
科技趋势
深度阅读
国际观察
```

### Navigation

```text
Today
History
```

## Component Instances

```text
Atmosphere Layer / Entertainment
Developing Halo / Entertainment / Static
Header / Root
Suggestion Pill / Default
Global Navigation / Today Active
```

## Sizing

```text
Read Entry Button: 40 x 40
Developing Halo: 236 x 236
Suggestion Pill: min 72 x 34
Navigation: Hug x 44
```

## Position Rules

```text
Hero remains optically centered.
Insight starts below hero, never above it.
Navigation stays bottom center.
Read Entry stays top right.
Suggestions never exceed 3 visible items.
```

## Motion

```text
Atmosphere Enter: 900ms / 0ms delay / ease out
Halo Development: 1200ms / 180ms delay / ease out cubic
Text Appearance: 480ms / 520ms delay / ease out
Suggestion Appearance: 420ms / 700ms delay / ease out
Pill Press: 120ms / 0ms delay / ease out
```

## Variants To Prepare

```text
Entertainment
Tech
Knowledge
Emotion
Empty
Updated
```

## Must Exist

```text
Atmosphere Layer
Developing Halo
Climate Snapshot
Primary Statement
Secondary Hint
Suggestion Pills
Minimal Navigation
Read Entry
```

## Can Remove

```text
Extra date detail
Extra category values
Extra explanation
Extra buttons
Secondary percentage labels
Decorative particles
Extra card surfaces
More than 3 suggestions
```

## Explicitly Removed

```text
Detailed category list
Raw percentage breakdown
Large CTA button
Multiple action icons
Decorative data labels
Background particles
Card container around hero
Secondary explanation block
```

## QA

| Risk | Score |
|---|---:|
| Dashboard Risk | 1 |
| AI SaaS Risk | 2 |
| Apple Journal Risk | 3 |
| Calm Risk | 3 |
| Arc Risk | 1 |

Recognition score without logo/name:

```text
88 / 100
```

Status:

```text
Ready for Figma build
```
