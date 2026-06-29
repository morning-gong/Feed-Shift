# FeedShift Figma Screen Spec — Settings v1

## Frame

Name: `Settings / iPhone 16 Pro`  
Size: `393 x 852`

## Purpose

Manage permission and data control.

## Layer Tree

```text
Settings / iPhone 16 Pro
├─ 00 Atmosphere
├─ 01 Header
│  ├─ Screen Title
│  └─ Scope Description
├─ 02 Permission Group
│  ├─ Accessibility Row
│  └─ Permission Hint
├─ 03 Data Group
│  ├─ Local Records Row
│  └─ Clear Text Row
├─ 04 Privacy Group
│  └─ Local Processing Note
└─ 05 About Group
   └─ Version Row
```

## Wireframe

```text
┌─────────────────────────┐
│  设置                    │
│  控制读取、隐私与数据      │
│                         │
│  读取权限                │
│  无障碍服务     已开启     │
│                         │
│  数据                    │
│  本地记录       管理       │
│  清除读取文本    →         │
│                         │
│  隐私                    │
│  只在本机处理             │
│                         │
│  关于                    │
│  FeedShift MVP           │
└─────────────────────────┘
```

## Layout

```text
Frame: Vertical / 393 x 852 / padding 24 top, 20 x, 40 bottom / gap 14
Header: Vertical / Fill / gap 4
Group: Vertical / Fill / padding 20 / gap 12
Row: Horizontal / Fill x 44 / center aligned
```

## Content

```text
Title: 设置
Description: 控制读取、隐私与数据
Group 01: 读取权限
Row: 无障碍服务 / 已开启
Group 02: 数据
Row: 本地记录 / 管理
Row: 清除读取文本
Group 03: 隐私
Note: 只在本机处理
Group 04: 关于
Row: FeedShift MVP
```

## Component Instances

```text
Atmosphere Layer / Neutral
Header / Root
Setting Group / Default
Setting Row / Default
Setting Row / Destructive
```

## Variants To Prepare

```text
Permission on
Permission off
Data empty
Data available
Destructive confirm
```

## Must Exist

```text
Permission
Data
Privacy
About
Atmosphere Layer
```

## Explicitly Removed

```text
Profile
Account
Notifications
Themes
Advanced settings
Debug rows
Marketing links
```

## QA

| Risk | Score |
|---|---:|
| Dashboard Risk | 1 |
| AI SaaS Risk | 1 |
| Apple Journal Risk | 2 |
| Calm Risk | 1 |
| Arc Risk | 2 |

Recognition score:

```text
82 / 100
```

Status: Ready for Figma build.
