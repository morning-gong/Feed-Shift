# FeedShift Figma Page Build — 07 QA v1

## Page Name

`07 QA`

## Goal

Create a visible QA board inside Figma.

## Source

`figma-assembly-qa-v1.md`

## QA Board Structure

```text
07 QA
├─ Identity Gate
├─ Layout Gate
├─ Component Gate
├─ Content Gate
├─ Motion Gate
├─ Risk Gate
├─ Recognition Gate
└─ Reduction Gate
```

## Identity Gate

Questions:

- Does the screen first present space?
- Is there visible air or atmosphere?
- Is there one clear visual focus?
- Does it avoid dashboard structure?
- Does it avoid AI SaaS structure?

Fail action:

```text
Reject
```

## Layout Gate

Questions:

- Is the screen low density?
- Is the main content visible before secondary detail?
- Are details progressively disclosed?
- Is navigation quiet?

Fail action:

```text
Remove or reorder
```

## Component Gate

Questions:

- Are surfaces used sparingly?
- Are there nested cards?
- Does halo avoid loading/activity ring appearance?
- Do pills avoid filter appearance?

Fail action:

```text
Redesign component instance
```

## Content Gate

Questions:

- Is the first statement an observation?
- Is raw data below insight?
- Does copy avoid blame?

Fail action:

```text
Rewrite
```

## Motion Gate

Questions:

- Does motion feel like development?
- Are spinners absent?
- Are transitions calm?

Fail action:

```text
Reduce speed, amplitude, or replace pattern
```

## Risk Gate

Score every screen:

```text
Dashboard Risk
AI SaaS Risk
Apple Journal Risk
Calm Risk
Arc Risk
```

Reject if any score:

```text
> 5
```

## Recognition Gate

Remove:

```text
Logo
Product name
Brand text
```

Minimum score:

```text
80 / 100
```

## Reduction Gate

Each screen must include:

```text
Must Exist
Can Remove
Removed
```

Minimum reduction:

```text
20% non-critical elements
```

## Completion Checklist

- [ ] QA board built
- [ ] Every screen reviewed
- [ ] All risks <= 5
- [ ] All recognition scores >= 80
- [ ] Reduction documented per screen
