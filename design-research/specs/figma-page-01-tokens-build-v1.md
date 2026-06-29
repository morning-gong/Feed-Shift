# FeedShift Figma Page Build — 01 Tokens v1

## Page Name

`01 Tokens`

## Goal

Create the reusable base values before components or screens.

## Page Layout

```text
01 Tokens
├─ 01 Spacing
├─ 02 Radius
├─ 03 Opacity
├─ 04 Depth
├─ 05 Motion
├─ 06 Layout
└─ 07 Usage Rules
```

## Frame Setup

Create seven horizontal frames.

```text
Frame width: 1200
Frame height: Hug
Gap between frames: 80
Page background: neutral dark
```

Each token frame:

```text
Auto layout: Vertical
Padding: 32
Gap: 20
Width: 1200
Corner radius: 28
```

## 01 Spacing Frame

Title:

```text
Spacing
```

Token rows:

| Name | Value | Usage |
|---|---:|---|
| space-4 | 4 | micro gap |
| space-8 | 8 | pill gap |
| space-10 | 10 | compact row |
| space-12 | 12 | row gap |
| space-14 | 14 | section gap |
| space-18 | 18 | medium gap |
| space-20 | 20 | screen side padding |
| space-24 | 24 | primary padding |
| space-34 | 34 | hero gap |

Visual sample:

Create one horizontal sample line per token.

```text
Label / spacing block / value
```

## 02 Radius Frame

Title:

```text
Radius
```

Token rows:

| Name | Value | Usage |
|---|---:|---|
| radius-secondary | 22 | secondary surface |
| radius-primary | 28 | primary surface |
| radius-pill | 999 | pills and navigation |

Visual sample:

```text
3 rectangles, same size, different radius
```

## 03 Opacity Frame

Title:

```text
Opacity
```

Token rows:

| Name | Value | Usage |
|---|---:|---|
| text-primary | 92% | main text |
| text-secondary | 66% | body text |
| text-tertiary | 42% | labels |
| surface-primary | 14% | main surface |
| surface-secondary | 9% | secondary surface |
| surface-subtle | 8% | embedded surface |
| border-default | 14% | borders |
| halo-air | 20% | halo atmosphere |

Visual sample:

```text
Stacked opacity swatches on dark base
```

## 04 Depth Frame

Title:

```text
Depth
```

Token rows:

| Name | Layer | Usage |
|---|---:|---|
| z0-atmosphere | 0 | background |
| z1-surface | 1 | surfaces |
| z2-halo | 2 | Developing Halo |
| z3-text | 3 | text |
| z4-interaction | 4 | controls |

Visual sample:

```text
5 overlapping transparent panels
```

## 05 Motion Frame

Title:

```text
Motion
```

Token rows:

| Name | Value | Usage |
|---|---:|---|
| motion-fast | 120ms | press |
| motion-medium | 360ms | reveal |
| motion-screen | 520ms | screen enter |
| motion-hero | 900ms | atmosphere enter |
| motion-developing | 1200ms | halo development |
| motion-living | 1800ms+ | breathing |

Easing:

```text
Default: Ease Out
Hero: Ease Out Cubic
Living: Linear subtle loop
```

## 06 Layout Frame

Title:

```text
Layout
```

Token rows:

| Name | Value |
|---|---:|
| mobile-width | 393 |
| mobile-height | 852 |
| min-width | 360 |
| max-phone-width | 480 |
| content-padding-x | 20 |
| grid-columns | 4 |
| grid-gutter | 12 |
| content-width | 353 |

Visual sample:

```text
iPhone 16 Pro frame with 4-column overlay
```

## 07 Usage Rules Frame

Title:

```text
Usage Rules
```

Rules:

```text
1. Space before interface.
2. Air before information.
3. One screen, one focus.
4. No nested cards.
5. No dashboard layout.
6. No AI SaaS structure.
7. Details are progressively disclosed.
8. Loading uses Developing Halo.
```

## Acceptance Checklist

- [ ] All seven token frames exist.
- [ ] Every token has name, value, usage.
- [ ] Visual samples exist for spacing, radius, opacity, depth, layout.
- [ ] No color palette is introduced here.
- [ ] No component is created on this page.
- [ ] Tokens match `figma-assembly-tokens-v1.md`.

## Next Page

After this page is complete:

```text
02 Components
```
