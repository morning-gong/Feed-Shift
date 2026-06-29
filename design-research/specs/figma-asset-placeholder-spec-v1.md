# FeedShift Figma Asset Placeholder Spec v1

## Purpose

Define image and atmosphere placeholders for Figma production.

This file does not select final photography.

## Asset Groups

```text
01 Atmosphere Base
02 Climate State Placeholders
03 Reflection Backgrounds
04 System State Backgrounds
05 Replacement Rules
```

## 01 Atmosphere Base

Use one placeholder component:

```text
Atmosphere Placeholder
```

Size:

```text
393 x 852
```

Layers:

```text
Base Image Placeholder
Air Overlay
Light Veil
Darkroom Depth
```

Placeholder visual:

```text
Low-detail dark spatial block
No final photo
No decorative gradient
No AI orb
```

## 02 Climate State Placeholders

Create 4 placeholders.

### Entertainment

Label:

```text
Atmosphere / Entertainment Placeholder
```

Usage:

```text
Today
Detail
Explore
```

Required quality:

```text
Warm low-light spatial image
Soft reflected light
No commercial subject
```

### Tech

Label:

```text
Atmosphere / Tech Placeholder
```

Required quality:

```text
Cool spatial light
Glass or optical depth
No cyberpunk
No dashboard
```

### Knowledge

Label:

```text
Atmosphere / Knowledge Placeholder
```

Required quality:

```text
Stable natural light
Quiet interior or spatial depth
No school/study stock image
```

### Emotion

Label:

```text
Atmosphere / Emotion Placeholder
```

Required quality:

```text
Soft low-contrast light
Interior air
No therapy/calm cliché
```

## 03 Reflection Backgrounds

Create 3 placeholders.

```text
Atmosphere / Weekly Placeholder
Atmosphere / Monthly Placeholder
Atmosphere / Yearly Placeholder
```

Rules:

```text
Weekly: closer, more immediate
Monthly: more stable, wider space
Yearly: deeper, more distant
```

Do not use:

```text
Calendar imagery
Charts
Seasonal cliché
Achievement imagery
```

## 04 System State Backgrounds

Create 3 placeholders.

```text
Atmosphere / Empty Placeholder
Atmosphere / Loading Placeholder
Atmosphere / Error Placeholder
```

Rules:

```text
Empty: quiet, low signal
Loading: developing air
Error: calm recovery
```

Do not use:

```text
Warning red
Sad illustration
Blank gray
Spinner art
```

## 05 Replacement Rules

When replacing placeholders with final assets:

```text
1. Keep the same crop ratio.
2. Keep center safe area open for halo and text.
3. Avoid strong subject in the middle.
4. Preserve darkroom depth.
5. Preserve realistic light source.
6. Avoid high saturation.
7. Avoid stock-photo clarity.
8. Avoid AI wallpaper artifacts.
9. Test with Today screen first.
10. Run Recognition Gate again.
```

## Safe Area

Central halo safe area:

```text
x: 72-321
y: 210-480
```

Text safe area:

```text
x: 20-353
y: 520-700
```

Avoid high-contrast image detail in these areas.

## Acceptance Checklist

- [ ] 4 climate placeholders created
- [ ] 3 reflection placeholders created
- [ ] 3 system state placeholders created
- [ ] All placeholders use 393 x 852 frame
- [ ] No placeholder looks like dashboard
- [ ] No placeholder looks like AI SaaS
- [ ] Recognition Gate remains above 80 after replacement
