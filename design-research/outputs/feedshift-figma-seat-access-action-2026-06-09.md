# FeedShift Figma Seat / Access Action - 2026-06-09

## Goal

Add the current MCP account to the plan that owns `FeedShift MVP UI v1` and give it a writable seat.

Target account:

```text
cobdenhoyle90@outlook.com
```

Target file:

```text
FeedShift MVP UI v1
fileKey: nRQsjQuviY9B4iQdEDaxsJ
```

## Current State

Figma MCP `whoami` reports:

- `cobdenhoyle90's team`: student tier, View seat
- `Morning`: student tier, View seat

This account is not currently a writable Full or Dev seat for the target file.

## Automation Attempt

Chrome control was attempted so Codex could use the user's logged-in Figma admin session.

Blocked because:

- Chrome extension backend is not available.
- Standard Chrome user data directory was not found:
  `C:\Users\lenovo\AppData\Local\Google\Chrome\User Data`
- Codex Chrome native host registry key is missing:
  `HKCU\Software\Google\Chrome\NativeMessagingHosts\com.openai.codexextension`

Codex must not repair the native host or bypass this with other scripting.

## Required Manual Action

In the Figma admin/owner account that owns the target file:

1. Open the target file:
   `https://www.figma.com/design/nRQsjQuviY9B4iQdEDaxsJ`
2. Confirm which team/project owns the file.
3. Open that team or organization's admin settings.
4. Invite or add:
   `cobdenhoyle90@outlook.com`
5. Assign a writable seat:
   - Prefer `Full` seat for design editing.
   - `Dev` seat may improve MCP limits, but may not be enough for canvas design editing depending on Figma plan behavior.
6. Confirm file access is not restricted to a different team/project.
7. Return to Codex and run `whoami` again.

## Resume Check

After the seat is changed, rerun:

```text
whoami
```

Expected result:

```text
seat_type: full
```

or another writable seat type for the team that owns `nRQsjQuviY9B4iQdEDaxsJ`.

Then rerun the saved continuation script:

```text
E:\FeedShiftDev\projects\feedshift\design-research\outputs\feedshift-figma-continuation-v1-ready.js
```
