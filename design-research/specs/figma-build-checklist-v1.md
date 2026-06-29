# FeedShift Figma Build Checklist v1

## 00 File Setup

- [ ] Create Figma file: `FeedShift MVP UI v1`
- [ ] Create page: `00 Foundation`
- [ ] Create page: `01 Tokens`
- [ ] Create page: `02 Components`
- [ ] Create page: `03 Screens / P0`
- [ ] Create page: `04 Screens / Reflection`
- [ ] Create page: `05 States`
- [ ] Create page: `06 Prototype`
- [ ] Create page: `07 QA`
- [ ] Create page: `08 Archive`

## 01 Tokens

- [ ] Create spacing tokens
- [ ] Create radius tokens
- [ ] Create opacity tokens
- [ ] Create depth tokens
- [ ] Create motion tokens
- [ ] Create layout tokens
- [ ] Add token notes from `figma-assembly-tokens-v1.md`

Acceptance:

- [ ] All tokens use consistent names
- [ ] No page-specific token
- [ ] No color-first decision

## 02 Components

- [ ] Build `Atmosphere Layer`
- [ ] Build `Developing Halo`
- [ ] Build `Header`
- [ ] Build `Climate Snapshot`
- [ ] Build `Insight Block`
- [ ] Build `Suggestion Pill`
- [ ] Build `Reason Row`
- [ ] Build `Structure Row`
- [ ] Build `Timeline Row`
- [ ] Build `Reflection Summary`
- [ ] Build `Setting Group`
- [ ] Build `Global Navigation`
- [ ] Build `Empty State`
- [ ] Build `Loading State`
- [ ] Build `Error State`

Acceptance:

- [ ] Components use Auto Layout where applicable
- [ ] Components use variants
- [ ] Components do not contain page-specific copy
- [ ] Developing Halo does not look like loading
- [ ] Global Navigation only includes Today and History

## 03 P0 Screens

### Today

- [ ] Build Atmosphere Layer
- [ ] Build Header
- [ ] Build Developing Halo hero
- [ ] Build Climate Snapshot
- [ ] Build Insight Block
- [ ] Build Suggestion Entry
- [ ] Build Global Navigation
- [ ] Run recognition test

### Detail

- [ ] Build Header
- [ ] Build Snapshot Summary
- [ ] Build Reason Layers
- [ ] Build Structure Glimpse
- [ ] Build Suggestion Bridge
- [ ] Run dashboard risk test

### Explore

- [ ] Build Header
- [ ] Build Exploration Statement
- [ ] Build Topic Path
- [ ] Build Reason Block
- [ ] Build Return Context
- [ ] Run recommendation-list risk test

### History

- [ ] Build Header
- [ ] Build Time Scope
- [ ] Build Climate Timeline
- [ ] Build Snapshot Preview
- [ ] Build Reflection Entry
- [ ] Build Global Navigation
- [ ] Run calendar/dashboard risk test

### Settings

- [ ] Build Header
- [ ] Build Permission Group
- [ ] Build Data Group
- [ ] Build Privacy Group
- [ ] Build About Group
- [ ] Run utility-tool risk test

## 04 Reflection Screens

### Weekly Reflection

- [ ] Build Weekly Summary
- [ ] Build Pattern Reasons
- [ ] Build Shift Direction
- [ ] Build Return Context
- [ ] Run Journal risk test

### Monthly Reflection

- [ ] Build Monthly Summary
- [ ] Build Pattern Shifts
- [ ] Build Stable Signals
- [ ] Build Next Month Direction
- [ ] Run report risk test

### Yearly Review

- [ ] Build Annual Climate Portrait
- [ ] Build Major Shifts
- [ ] Build Lasting Signals
- [ ] Build Year Memory
- [ ] Run annual-report risk test

## 05 States

- [ ] Build No Snapshot empty state
- [ ] Build No History empty state
- [ ] Build No Permission empty state
- [ ] Build Reading Content loading state
- [ ] Build Generating Snapshot loading state
- [ ] Build Permission Denied error state
- [ ] Build No Text Detected error state
- [ ] Build Read Failed error state

Acceptance:

- [ ] No spinner
- [ ] No red alert
- [ ] No sad icon
- [ ] No technical error text

## 06 Prototype

- [ ] Link Today -> Detail
- [ ] Link Detail -> Explore
- [ ] Link Today -> Loading / Reading Content
- [ ] Link Loading / Reading Content -> Loading / Generating Snapshot
- [ ] Link Loading / Generating Snapshot -> Today Updated
- [ ] Link Today -> History
- [ ] Link History -> Weekly Reflection
- [ ] Link History -> Monthly Reflection
- [ ] Link History -> Yearly Review
- [ ] Link Today -> Settings
- [ ] Link errors back to recovery actions

Acceptance:

- [ ] Today and History are the only primary anchors
- [ ] Back always returns to previous context
- [ ] Loading uses Developing Halo

## 07 QA

- [ ] Run Identity Gate
- [ ] Run Layout Gate
- [ ] Run Component Gate
- [ ] Run Content Gate
- [ ] Run Motion Gate
- [ ] Run Risk Gate
- [ ] Run Recognition Gate
- [ ] Run Reduction Gate

Final acceptance:

- [ ] No risk score above 5
- [ ] Recognition score above 80
- [ ] At least 20% non-critical elements removed
- [ ] Ready for handoff
