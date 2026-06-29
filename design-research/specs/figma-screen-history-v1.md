# FeedShift Figma Screen Spec — History v1

## Frame

Name: `History / iPhone 16 Pro`  
Size: `393 x 852`

## Purpose

Review climate changes over time.

## Layer Tree

```text
History / iPhone 16 Pro
├─ 00 Atmosphere
├─ 01 Header
│  ├─ Screen Title
│  └─ Scope Description
├─ 02 Time Scope
│  ├─ Scope Label
│  └─ Scope Selector
├─ 03 Climate Timeline
│  ├─ Timeline Track
│  ├─ Timeline Row / 01
│  ├─ Timeline Row / 02
│  ├─ Timeline Row / 03
│  └─ Timeline Row / 04
├─ 04 Snapshot Preview
│  ├─ Preview Label
│  ├─ Snapshot Statement
│  └─ Snapshot Hint
├─ 05 Reflection Entry
│  ├─ Reflection Label
│  └─ Entry Indicator
└─ 06 Navigation
   ├─ Nav Surface
   ├─ Nav Item / Today
   └─ Nav Item / History
```

## Wireframe

```text
┌─────────────────────────┐
│  历史                    │
│  最近 7 天的认知气候      │
│                         │
│  本周                    │
│  6/1   ◌  娱乐偏高        │
│  6/2   ◌  娱乐偏高        │
│  6/3   ◌  科技探索        │
│  6/4   ◌  学习探索        │
│                         │
│  最近一次                │
│  今天的信息结构更均衡      │
│  知识输入有所上升          │
│                         │
│  查看本周反思  →          │
│                         │
│        Today  History    │
└─────────────────────────┘
```

## Layout

```text
Frame: Vertical / 393 x 852 / padding 24 top, 20 x, 24 bottom / gap 18
Header: Vertical / Fill / gap 4
Time Scope: Horizontal / Fill x 38 / gap 10
Timeline: Vertical / Fill / padding 20 / gap 10
Timeline Row: Horizontal / Fill x 38 / gap 12
Snapshot Preview: Vertical / Fill / padding 22 / gap 10
Reflection Entry: Horizontal / Fill x 52 / padding 18 x / gap 12
```

## Content

```text
Title: 历史
Scope Description: 最近 7 天的认知气候
Scope Label: 本周
Timeline 01: 6/1 / 娱乐偏高
Timeline 02: 6/2 / 娱乐偏高
Timeline 03: 6/3 / 科技探索
Timeline 04: 6/4 / 学习探索
Preview Label: 最近一次
Snapshot Statement: 今天的信息结构更均衡
Snapshot Hint: 知识输入有所上升
Reflection Entry: 查看本周反思
```

## Component Instances

```text
Atmosphere Layer / Neutral
Timeline Row / Default
Timeline Row / Selected
Climate Snapshot / Existing
Global Navigation / History Active
```

## Variants To Prepare

```text
7 days
30 days
Year
Empty history
Selected snapshot
Reflection available
Reflection locked
```

## Must Exist

```text
Header
Time Scope
Climate Timeline
Snapshot Preview
Reflection Entry
Navigation
Atmosphere Layer
```

## Explicitly Removed

```text
Calendar grid
Chart view
Category legend
Raw text preview
Search field
Filter menu
Multiple trend cards
Detailed date metadata
```

## QA

| Risk | Score |
|---|---:|
| Dashboard Risk | 4 |
| AI SaaS Risk | 2 |
| Apple Journal Risk | 3 |
| Calm Risk | 2 |
| Arc Risk | 2 |

Recognition score:

```text
81 / 100
```

Status: Ready for Figma build.
