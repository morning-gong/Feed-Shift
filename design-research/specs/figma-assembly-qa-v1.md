# FeedShift Figma Assembly QA v1

## Page

07 QA

## Purpose

Use this checklist before any Figma screen is accepted.

## Identity Gate

### Q1

Does the screen first present space?

Fail: reject.

### Q2

Is there visible air or atmosphere?

Fail: reject.

### Q3

Is there one clear visual focus?

Fail: reduce until one focus remains.

### Q4

Does it avoid dashboard structure?

Fail: reject.

### Q5

Does it avoid AI SaaS structure?

Fail: reject.

## Layout Gate

### Q6

Is the screen low density?

Fail: remove at least 20% of visible elements.

### Q7

Is the main content visible before secondary detail?

Fail: reorder hierarchy.

### Q8

Are details progressively disclosed?

Fail: move detail to secondary screen or lower section.

### Q9

Is navigation quiet?

Fail: reduce navigation prominence.

## Component Gate

### Q10

Are surfaces used sparingly?

Fail: remove extra cards.

### Q11

Are there nested cards?

Fail: reject.

### Q12

Does any halo look like loading or activity rings?

Fail: redraw.

### Q13

Do pills look like filters?

Fail: soften and reduce count.

## Content Gate

### Q14

Is the first statement a judgment, not a report title?

Fail: rewrite.

### Q15

Is raw data hidden below insight?

Fail: reorder.

### Q16

Does copy avoid blame?

Fail: rewrite.

## Motion Gate

### Q17

Does motion feel like development, not animation?

Fail: slow down and reduce amplitude.

### Q18

Are there spinners?

Fail: replace with Developing Halo.

### Q19

Are transitions calm and contextual?

Fail: replace jump cuts.

## Risk Gate

Score each 0-10.

| Risk | Max Allowed |
|---|---:|
| Dashboard Risk | 5 |
| AI SaaS Risk | 5 |
| Apple Journal Risk | 5 |
| Calm Risk | 5 |
| Arc Risk | 5 |

If any score is above 5: reject and redesign.

## Recognition Gate

Remove:

- Logo
- Product name
- Brand text

Then score:

```text
Can this be recognized as FeedShift in 3 seconds?
```

Minimum passing score:

```text
80 / 100
```

If below 80: redesign.

## Reduction Gate

Every accepted screen must list:

- Must Exist
- Can Remove
- Removed

Minimum removal:

```text
20% of non-critical elements
```

If nothing can be removed, the screen is likely too dense.
