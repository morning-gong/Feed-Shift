# FeedShift Figma Assembly Prototype v1

## Page

06 Prototype

## Prototype Goals

- Validate Today -> Detail -> Explore.
- Validate Today -> Read -> Analysis result.
- Validate Today -> History -> Reflection.
- Validate Settings access.
- Validate system states.

## Flow 1: Daily Observation

```text
Today
-> Detail
-> Explore
-> Detail
-> Today
```

Hotspots:

- Today / Insight Block -> Detail
- Today / Suggestion Pill -> Explore
- Detail / Suggestion Pill -> Explore
- Back controls -> Previous screen

Transition:

- Type: Smart Animate where possible
- Duration: 520ms
- Easing: Ease Out

## Flow 2: Reading Content

```text
Today
-> Loading / Reading Content
-> Loading / Generating Snapshot
-> Today / Updated Snapshot
```

Hotspots:

- Today / Read Entry -> Loading / Reading Content
- Loading / Reading Content auto advances
- Loading / Generating Snapshot auto advances

Transition:

- Reading auto delay: 1200ms
- Generating auto delay: 1200ms
- Enter Today Updated: 520ms

## Flow 3: Permission Missing

```text
Today
-> Settings
-> Error / Permission Denied
-> Settings
```

Hotspots:

- Today / Read Entry disabled state -> Settings
- Settings / Accessibility Row -> Error / Permission Denied
- Error / Open Settings -> Settings

Transition:

- Screen enter: 520ms
- Error appear: 420ms

## Flow 4: History Review

```text
Today
-> History
-> Weekly Reflection
-> History
-> Monthly Reflection
-> History
-> Yearly Review
```

Hotspots:

- Navigation / History -> History
- History / Weekly Entry -> Weekly Reflection
- History / Scope 30 Days -> Monthly Reflection
- History / Scope Year -> Yearly Review

Transition:

- Screen enter: 520ms
- Reflection enter: 560ms

## Flow 5: Empty First Use

```text
Today / Empty
-> Loading / Reading Content
-> Today / Fresh Snapshot
```

Hotspots:

- Empty / Start Reading -> Loading / Reading Content

Transition:

- Empty to loading: 420ms
- Loading to Today: 520ms

## Prototype Rules

- No modal-first navigation.
- No jump cuts between core screens.
- Back always returns to prior context.
- Detail and Explore are secondary screens.
- Today and History are primary anchors.
- Settings never becomes a primary anchor.
- Loading uses Developing Halo, never spinner.
- Errors stay calm and recoverable.
