# FeedShift Figma Assembly Index v1

## Purpose

This is the single entry point for building FeedShift MVP UI in Figma.

Use this order strictly.

## Build Sequence

### 01 Tokens

File:

`figma-assembly-tokens-v1.md`

Build:

- Spacing
- Radius
- Opacity
- Depth
- Motion
- Layout

Do not start components before tokens are created.

### 02 Components

File:

`figma-assembly-components-v1.md`

Build:

- Atmosphere Layer
- Developing Halo
- Header
- Climate Snapshot
- Insight Block
- Suggestion Pill
- Reason Row
- Structure Row
- Timeline Row
- Reflection Summary
- Setting Group
- Global Navigation
- Empty State
- Loading State
- Error State

Do not start screens before core components exist.

### 03 Screens

File:

`figma-assembly-screens-v1.md`

Build P0:

- Today
- Detail
- Explore
- History
- Settings

Build Reflection:

- Weekly Reflection
- Monthly Reflection
- Yearly Review

Build Today first.

### 04 States

File:

`figma-assembly-states-v1.md`

Build:

- Empty States
- Loading States
- Error States

No spinner.  
No red alert.  
No technical stack text.

### 05 Prototype

File:

`figma-assembly-prototype-v1.md`

Build flows:

- Daily Observation
- Reading Content
- Permission Missing
- History Review
- Empty First Use

Today and History are the only primary anchors.

### 06 QA

File:

`figma-assembly-qa-v1.md`

Every screen must pass:

- Identity Gate
- Layout Gate
- Component Gate
- Content Gate
- Motion Gate
- Risk Gate
- Recognition Gate
- Reduction Gate

Reject any screen with risk score above 5.

## Figma Page Tree

```text
00 Foundation
01 Tokens
02 Components
03 Screens / P0
04 Screens / Reflection
05 States
06 Prototype
07 QA
08 Archive
```

## Acceptance Criteria

A screen is accepted only if:

- It is low density.
- It has one visual focus.
- It uses Climate Snapshot as the core object where relevant.
- It avoids dashboard structure.
- It avoids AI SaaS structure.
- It passes Recognition Test above 80.
- It removes at least 20% non-critical elements.

## Current Status

Ready for Figma build.
