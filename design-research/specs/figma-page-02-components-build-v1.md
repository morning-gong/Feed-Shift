# FeedShift Figma Page Build — 02 Components v1

## Page Name

`02 Components`

## Goal

Build reusable components before creating screens.

## Page Layout

```text
02 Components
├─ 01 Atmosphere Layer
├─ 02 Developing Halo
├─ 03 Header
├─ 04 Climate Snapshot
├─ 05 Insight Block
├─ 06 Rows
├─ 07 Pills
├─ 08 Reflection
├─ 09 Settings
├─ 10 Navigation
└─ 11 System States
```

## Global Component Frame

Each component group:

```text
Width: 1200
Height: Hug
Auto layout: Vertical
Padding: 32
Gap: 24
Radius: 28
```

Each component group includes:

```text
Title
Usage
Base component
Variants
Rules
```

## 01 Atmosphere Layer

Component:

```text
Atmosphere Layer
```

Size:

```text
393 x 852
```

Layers:

```text
Photography Base
Air Overlay
Light Veil
Darkroom Depth
```

Variants:

```text
Entertainment
Tech
Knowledge
Emotion
Neutral
```

Rules:

```text
No pure gradient as final background.
No decorative particles.
No high-saturation tech look.
```

## 02 Developing Halo

Component:

```text
Developing Halo
```

Sizes:

```text
Default: 236 x 236
Small: 64 x 64
Large: 160 x 160
Empty: 96 x 96
```

Layers:

```text
Halo Outer Air
Halo Primary Arc
Halo Secondary Arc
Halo Broken Arc
Halo Center Value
Halo Center Label
```

Properties:

```text
Climate: Entertainment / Tech / Knowledge / Emotion / Balanced / Empty
Mode: Static / Developing
Size: Small / Default / Large / Empty
```

Rules:

```text
Never closed circle.
Never activity ring.
Never loading spinner.
Never chart-first.
```

## 03 Header

Component:

```text
Header
```

Size:

```text
Fill x 56
```

Auto layout:

```text
Direction: Horizontal
Gap: 10
Alignment: Center
```

Properties:

```text
Type: Root / Back / Reflection / Settings
Action: None / Read / Refresh
```

Slots:

```text
Back Control optional
Title
Subtitle
Action optional
```

## 04 Climate Snapshot

Component:

```text
Climate Snapshot
```

Auto layout:

```text
Direction: Vertical
Width: Fill
Gap: 10
```

Properties:

```text
State: Fresh / Existing / Unclear / Empty
Climate: Entertainment / Tech / Knowledge / Emotion / Balanced
```

Slots:

```text
Developing Halo
Primary Statement
Secondary Hint
```

## 05 Insight Block

Component:

```text
Insight Block
```

Auto layout:

```text
Direction: Vertical
Width: Fill
Gap: 8
```

Slots:

```text
Primary Statement
Secondary Hint
```

Variants:

```text
One-line
Two-line
Empty
```

## 06 Rows

### Reason Row

```text
Height: 32-36
Direction: Horizontal
Gap: 12
Variants: Short / Long
```

### Structure Row

```text
Height: 30
Direction: Horizontal
Gap: 10
Variants: Top / Secondary / Low Signal
```

### Timeline Row

```text
Height: 38
Direction: Horizontal
Gap: 12
Variants: Default / Selected / Pressed
```

## 07 Pills

### Suggestion Pill

```text
Height: 34
Min width: 72
Padding: 14 horizontal
Radius: 999
Variants: Default / Pressed / Disabled
```

Rules:

```text
Max 3 visible on Today.
Do not make pills look like filters.
No dense tag walls.
```

## 08 Reflection

Component:

```text
Reflection Summary
```

Auto layout:

```text
Direction: Vertical
Width: Fill
Padding: 24
Gap: 14
```

Properties:

```text
Type: Weekly / Monthly / Yearly
State: Default / Empty
```

Slots:

```text
Summary Statement
Climate Label
Micro or Large Halo
```

## 09 Settings

### Setting Group

```text
Direction: Vertical
Width: Fill
Padding: 20
Gap: 12
```

### Setting Row

```text
Height: 44
Direction: Horizontal
Alignment: Center
Variants: Default / Pressed / Disabled / Destructive
```

## 10 Navigation

Component:

```text
Global Navigation
```

Size:

```text
Height: 44
Width: Hug
```

Auto layout:

```text
Direction: Horizontal
Padding: 6 vertical, 8 horizontal
Gap: 14
Alignment: Center
```

Variants:

```text
Today Active
History Active
Hidden
```

Rules:

```text
Only Today and History.
No Explore tab.
No Settings tab.
No badges.
```

## 11 System States

Components:

```text
Empty State
Loading State
Error State
```

Shared structure:

```text
Atmosphere Layer
Developing Halo
Statement
Recovery Action optional
```

Rules:

```text
No spinner.
No red alert.
No sad icon.
No technical error text.
```

## Acceptance Checklist

- [ ] Atmosphere Layer has 5 variants.
- [ ] Developing Halo has climate, mode, and size variants.
- [ ] Header supports root and back contexts.
- [ ] Climate Snapshot uses Developing Halo.
- [ ] Rows are reusable and not page-specific.
- [ ] Suggestion Pill has default, pressed, disabled.
- [ ] Global Navigation has only Today and History.
- [ ] System states use Developing Halo.
- [ ] No component looks like dashboard UI.
- [ ] No component looks like AI SaaS UI.

## Next Page

After components are complete:

```text
03 Screens / P0
```
