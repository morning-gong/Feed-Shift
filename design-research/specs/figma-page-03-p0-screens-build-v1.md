# FeedShift Figma Page Build — 03 Screens / P0 v1

## Page Name

`03 Screens / P0`

## Goal

Build the MVP core screens from reusable components.

## Frames

All frames:

```text
Size: 393 x 852
Device: iPhone 16 Pro
Auto layout: Vertical
Padding: screen-specific
```

## Build Order

1. Today
2. Detail
3. Explore
4. History
5. Settings

## Today

Source spec:

`figma-screen-today-v1.md`

Layer order:

```text
00 Atmosphere
01 Header
02 Hero / Developing Halo
03 Insight
04 Suggestions
05 Navigation
```

Acceptance:

- One visual focus.
- Developing Halo is dominant.
- Suggestions max 3.
- Navigation only Today and History.

## Detail

Source spec:

`figma-screen-detail-v1.md`

Layer order:

```text
00 Atmosphere
01 Header
02 Snapshot Summary
03 Reason Layers
04 Structure Glimpse
05 Suggestion Bridge
```

Acceptance:

- Explanation first.
- No full chart.
- No raw text.
- Structure is secondary.

## Explore

Source spec:

`figma-screen-explore-v1.md`

Layer order:

```text
00 Atmosphere
01 Header
02 Exploration Statement
03 Topic Path
04 Reason Block
05 Return Context
```

Acceptance:

- Looks like one recommendation, not a feed.
- No topic cards.
- No related list.
- No CTA overload.

## History

Source spec:

`figma-screen-history-v1.md`

Layer order:

```text
00 Atmosphere
01 Header
02 Time Scope
03 Climate Timeline
04 Snapshot Preview
05 Reflection Entry
06 Navigation
```

Acceptance:

- Timeline, not calendar grid.
- No chart view.
- Snapshot preview is secondary focus.
- Reflection entry is calm.

## Settings

Source spec:

`figma-screen-settings-v1.md`

Layer order:

```text
00 Atmosphere
01 Header
02 Permission Group
03 Data Group
04 Privacy Group
05 About Group
```

Acceptance:

- Utility is quiet.
- No account/profile system.
- No theme settings.
- No advanced/debug group.

## P0 QA

Run for each frame:

```text
Dashboard Risk <= 5
AI SaaS Risk <= 5
Recognition >= 80
At least 20% non-critical elements removed
```

## Prototype Connections

```text
Today -> Detail
Today -> Explore
Detail -> Explore
Today -> History
Today -> Settings
```

## Completion Checklist

- [ ] Today built
- [ ] Detail built
- [ ] Explore built
- [ ] History built
- [ ] Settings built
- [ ] P0 QA passed
- [ ] P0 prototype links added
