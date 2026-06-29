# FeedShift Figma Screen Spec — Reflections v1

## Frames

- `Weekly Reflection / iPhone 16 Pro`
- `Monthly Reflection / iPhone 16 Pro`
- `Yearly Review / iPhone 16 Pro`

Size: `393 x 852`

## Weekly Reflection

Purpose: Summarize weekly cognitive climate.

Layer tree:

```text
Weekly Reflection
├─ 00 Atmosphere
├─ 01 Header
├─ 02 Weekly Summary
├─ 03 Pattern Reasons
├─ 04 Shift Direction
└─ 05 Return Context
```

Wireframe:

```text
┌─────────────────────────┐
│  ←  本周反思             │
│     6月1日 - 6月7日      │
│                         │
│  这一周，娱乐内容反复出现 │
│  但知识输入也在慢慢上升。 │
│                         │
│  观察到的模式             │
│  01 工作日夜晚更偏娱乐     │
│  02 周中科技内容上升       │
│  03 周末情绪内容变多       │
│                         │
│  可以尝试                 │
│  下周补充一点深度阅读      │
└─────────────────────────┘
```

## Monthly Reflection

Purpose: Summarize monthly cognitive change.

Layer tree:

```text
Monthly Reflection
├─ 00 Atmosphere
├─ 01 Header
├─ 02 Monthly Summary
├─ 03 Pattern Shifts
├─ 04 Stable Signals
├─ 05 Next Month Direction
└─ 06 Return Context
```

Wireframe:

```text
┌─────────────────────────┐
│  ←  月度反思             │
│     2026年6月             │
│                         │
│  这个月的信息气候逐渐变稳 │
│  娱乐减少，知识输入上升。 │
│                         │
│  主要变化                 │
│  01 娱乐内容从高到中       │
│  02 科技内容保持稳定       │
│  03 知识内容明显增加       │
│                         │
│  稳定信号                 │
│  深度阅读  科技观察        │
└─────────────────────────┘
```

## Yearly Review

Purpose: Present annual cognitive portrait.

Layer tree:

```text
Yearly Review
├─ 00 Atmosphere
├─ 01 Header
├─ 02 Annual Climate Portrait
├─ 03 Major Shifts
├─ 04 Lasting Signals
├─ 05 Year Memory
└─ 06 Return Context
```

Wireframe:

```text
┌─────────────────────────┐
│  ←  年度回顾             │
│     2026                 │
│                         │
│  这一年，你的信息气候     │
│  从娱乐偏高，逐渐走向     │
│  更稳定的知识输入。       │
│                         │
│  主要变化                 │
│  01 娱乐内容下降          │
│  02 科技观察稳定          │
│  03 知识输入上升          │
│                         │
│  今年留下的方向           │
│  你开始主动寻找不同视角。 │
└─────────────────────────┘
```

## Shared Layout

```text
Frame: Vertical / 393 x 852 / padding 20 x, 12 top, 40 bottom / gap 14
Header: Horizontal / Fill x 56 / gap 10
Summary: Vertical / Fill / padding 24 / gap 14
Secondary Blocks: Vertical / Fill / padding 20 / gap 12
```

## Shared Components

```text
Atmosphere Layer
Header / Reflection
Reflection Summary
Reason Row
Suggestion Pill
Back To History
```

## Explicitly Removed

```text
Charts
Scores
Badges
Rankings
Calendar grid
Raw text history
Detailed percentage tables
Multiple CTAs
```

## QA

| Screen | Dashboard | AI SaaS | Journal | Calm | Arc | Recognition |
|---|---:|---:|---:|---:|---:|---:|
| Weekly | 3 | 2 | 4 | 3 | 1 | 83 |
| Monthly | 4 | 2 | 4 | 3 | 1 | 82 |
| Yearly | 4 | 2 | 4 | 3 | 1 | 85 |

Status: Ready for Figma build.
