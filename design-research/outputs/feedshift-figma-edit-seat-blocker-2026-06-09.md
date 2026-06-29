# FeedShift Figma Edit Seat Blocker - 2026-06-09

## Target

- File: FeedShift MVP UI v1
- fileKey: nRQsjQuviY9B4iQdEDaxsJ

## Current MCP Account

```text
cobdenhoyle90@outlook.com
```

`whoami`:

```text
cobdenhoyle90's team: Full, student tier, seat_type expert
Morning: Collab, student tier, seat_type collaborator
```

## Latest Write Attempt

After the user reported that file permission was changed to `can edit`, the continuation script was rerun.

Figma MCP still rejected the first write operation:

```text
Error: in createFrame: Can't call "createFrame" in read-only mode
Figma Debug UUID: 54fd86ba-dd88-4ca9-98f9-11ef78a7e21b
```

## Interpretation

The file is readable, but the Plugin/MCP execution context remains read-only.

Most likely cause:

```text
The target file belongs to the Morning team, where cobdenhoyle90@outlook.com is still a Collab seat.
```

File-level `can edit` alone may not be enough for MCP/plugin design writes if the account is not a Full/Dev seat in the file's owning team.

## Required Fix

Use one of these:

1. In the file's owning team, change `cobdenhoyle90@outlook.com` from `Collab` to `Full`.
2. Move or duplicate `FeedShift MVP UI v1` into `cobdenhoyle90's team`, where the account already has a Full seat.
3. Authenticate MCP as an account that is already a Full/Dev seat in the file's owning team.

## Resume Command

After the seat/team ownership is fixed, rerun:

```text
E:\FeedShiftDev\projects\feedshift\design-research\outputs\feedshift-figma-continuation-v1-ready.js
```

Expected result:

```text
status: prototype-qa-acceptance-continuation-built
```
