# FeedShift Figma Assembly States v1

## Page

05 States

## Empty States

### No Snapshot

Structure:

- Atmosphere Layer
- Empty Halo
- Empty Statement
- Gentle Next Step

Copy:

- "还没有形成今日气候"
- "读取一次内容后会在这里显影"

### No History

Copy:

- "还没有足够的历史"
- "连续几天后，这里会出现变化"

### No Permission

Copy:

- "读取服务还没有开启"
- "开启后才能观察页面文字"

Rules:

- No illustration.
- No sad icon.
- No dashboard placeholder.

## Loading States

### Reading Content

Structure:

- Atmosphere Layer
- Developing Halo
- One-line status

Copy:

- "正在读取页面文字"

### Generating Snapshot

Copy:

- "正在让信息气候显影"

Rules:

- No spinner.
- No progress bar.
- No percentage.
- No AI thinking language.

Motion:

- Halo breathing: 1800ms loop
- Air shift: 3600ms loop

## Error States

### Permission Denied

Copy:

- "读取服务没有开启"
- "可以前往设置重新开启"

Actions:

- Open Settings
- Back

### No Text Detected

Copy:

- "这次没有读取到文字"
- "可以换一个页面再试一次"

Actions:

- Read Again

### Read Failed

Copy:

- "这次读取没有完成"
- "稍后再试一次"

Actions:

- Retry

Rules:

- No red alert.
- No blame language.
- No technical stack text.
- No modal-first error.
