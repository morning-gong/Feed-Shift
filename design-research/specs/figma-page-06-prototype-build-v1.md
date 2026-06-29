# FeedShift Figma Page Build — 06 Prototype v1

## Page Name

`06 Prototype`

## Goal

Connect core FeedShift MVP flows for review.

## Source

`figma-assembly-prototype-v1.md`

## Flow 1: Daily Observation

```text
Today
-> Detail
-> Explore
-> Detail
-> Today
```

Required links:

- Today / Insight Block -> Detail
- Today / Suggestion Pill -> Explore
- Detail / Suggestion Pill -> Explore
- Back controls -> Previous

## Flow 2: Reading Content

```text
Today
-> Loading / Reading Content
-> Loading / Generating Snapshot
-> Today / Updated Snapshot
```

Required links:

- Today / Read Entry -> Loading / Reading Content
- Loading / Reading Content -> Loading / Generating Snapshot
- Loading / Generating Snapshot -> Today Updated

## Flow 3: Permission Missing

```text
Today
-> Settings
-> Error / Permission Denied
-> Settings
```

Required links:

- Today / Read Entry disabled -> Settings
- Settings / Accessibility Row -> Error / Permission Denied
- Error / Open Settings -> Settings

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

Required links:

- Navigation / History -> History
- History / Weekly Entry -> Weekly Reflection
- History / Scope 30 Days -> Monthly Reflection
- History / Scope Year -> Yearly Review

## Flow 5: Empty First Use

```text
Today / Empty
-> Loading / Reading Content
-> Today / Fresh Snapshot
```

Required links:

- Empty / Start Reading -> Loading / Reading Content

## Transition Defaults

```text
Screen enter: 520ms / Ease Out
Reflection enter: 560ms / Ease Out
Loading auto delay: 1200ms
Error appear: 420ms
```

## Prototype Rules

- Today and History are primary anchors.
- Detail and Explore are secondary.
- Settings is utility.
- Back always returns to prior context.
- Loading never uses spinner.
- Errors always provide recovery.

## Completion Checklist

- [ ] Daily Observation flow connected
- [ ] Reading Content flow connected
- [ ] Permission Missing flow connected
- [ ] History Review flow connected
- [ ] Empty First Use flow connected
- [ ] Prototype reviewed in presentation mode
