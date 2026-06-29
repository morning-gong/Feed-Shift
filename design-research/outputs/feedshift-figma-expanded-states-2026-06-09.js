await figma.loadFontAsync({ family: 'Inter', style: 'Regular' });
await figma.loadFontAsync({ family: 'Inter', style: 'Medium' });
await figma.loadFontAsync({ family: 'Inter', style: 'Semi Bold' });

const createdNodeIds = [];
const removedNodeIds = [];

const page = figma.root.children.find((p) => p.name === '02 Product Screens');
if (!page) throw new Error('02 Product Screens page not found');
await figma.setCurrentPageAsync(page);

function rgb(hex) {
  const h = hex.replace('#', '');
  return {
    r: parseInt(h.slice(0, 2), 16) / 255,
    g: parseInt(h.slice(2, 4), 16) / 255,
    b: parseInt(h.slice(4, 6), 16) / 255,
  };
}

const C = {
  ink: rgb('F5F1E8'),
  muted: rgb('AFA99C'),
  bg: rgb('171613'),
  panel: rgb('242119'),
  line: rgb('F5F1E8'),
  amber: rgb('D8B36A'),
  moss: rgb('8FA978'),
  rose: rgb('C58C83'),
  teal: rgb('7FAEA2'),
};

function solid(color, opacity = 1) {
  return [{ type: 'SOLID', color, opacity }];
}

function addText(parent, name, chars, x, y, w, size, style = 'Regular', color = C.ink, opacity = 0.9) {
  const t = figma.createText();
  t.name = name;
  t.fontName = { family: 'Inter', style };
  t.characters = chars;
  t.fontSize = size;
  t.lineHeight = { unit: 'PERCENT', value: 136 };
  t.fills = solid(color, opacity);
  t.resize(w, Math.max(24, size * 1.6));
  t.x = x;
  t.y = y;
  parent.appendChild(t);
  createdNodeIds.push(t.id);
  return t;
}

function addRect(parent, name, x, y, w, h, color, opacity, radius = 0) {
  const r = figma.createRectangle();
  r.name = name;
  r.x = x;
  r.y = y;
  r.resize(w, h);
  r.fills = solid(color, opacity);
  r.cornerRadius = radius;
  parent.appendChild(r);
  createdNodeIds.push(r.id);
  return r;
}

function addEllipse(parent, name, x, y, w, h, color, opacity, strokeOpacity = 0) {
  const e = figma.createEllipse();
  e.name = name;
  e.x = x;
  e.y = y;
  e.resize(w, h);
  e.fills = solid(color, opacity);
  e.strokes = strokeOpacity ? solid(C.line, strokeOpacity) : [];
  e.strokeWeight = strokeOpacity ? 1 : 0;
  parent.appendChild(e);
  createdNodeIds.push(e.id);
  return e;
}

function addAction(parent, label, x, y, w = 154) {
  const a = addRect(parent, 'Recovery Action / Surface', x, y, w, 40, C.ink, 0.08, 20);
  a.strokes = solid(C.line, 0.13);
  a.strokeWeight = 1;
  addText(parent, 'Recovery Action / Label', label, x + 18, y + 10, w - 36, 13, 'Medium', C.ink, 0.88);
}

function makeState(spec, x, y) {
  const frame = figma.createFrame();
  frame.name = spec.name;
  frame.x = x;
  frame.y = y;
  frame.resize(393, 852);
  frame.cornerRadius = 34;
  frame.clipsContent = true;
  frame.fills = solid(C.bg, 1);
  page.appendChild(frame);
  createdNodeIds.push(frame.id);

  addRect(frame, '00 Atmosphere / Base', 0, 0, 393, 852, C.bg, 1);
  addEllipse(frame, '00 Atmosphere / Distant Air', -92, 72, 420, 420, spec.tint, 0.08);
  addEllipse(frame, '00 Atmosphere / Low Air', 118, 488, 360, 360, C.panel, 0.4);
  addRect(frame, '00 Atmosphere / Darkroom Depth', 0, 610, 393, 242, C.bg, 0.5);

  addText(frame, '01 Header / State Group', spec.group, 24, 42, 220, 13, 'Medium', C.muted, 0.72);
  addText(frame, '01 Header / Context', spec.context, 24, 66, 260, 13, 'Regular', C.muted, 0.62);

  addEllipse(frame, '02 Focus / Outer Air', 86, 206, 222, 222, spec.tint, spec.kind === 'loading' ? 0.11 : 0.075, 0.08);
  addEllipse(frame, '02 Focus / Developing Halo', 122, 242, 150, 150, spec.tint, 0.035, 0.22);
  addEllipse(frame, '02 Focus / Inner Quiet', 158, 278, 78, 78, C.bg, 0.58, 0.08);
  addText(frame, '02 Focus / Mark', spec.mark, 168, 303, 58, 22, 'Semi Bold', C.ink, 0.86);

  addText(frame, '03 Statement / Primary', spec.primary, 36, 494, 321, 25, 'Semi Bold', C.ink, 0.94);
  addText(frame, '03 Statement / Secondary', spec.secondary, 36, 556, 321, 15, 'Regular', C.muted, 0.78);

  if (spec.note) addText(frame, '04 Gentle Next Step', spec.note, 36, 646, 305, 13, 'Regular', C.muted, 0.66);
  if (spec.actions) {
    addAction(frame, spec.actions[0], 36, 648, spec.actions[0].length > 10 ? 168 : 136);
    if (spec.actions[1]) addAction(frame, spec.actions[1], 220, 648, 96);
  }

  addText(frame, '99 QA Rule', spec.rule, 36, 768, 310, 11, 'Regular', C.muted, 0.48);
  return frame.id;
}

const existing = new Set(page.children.map((n) => n.name));
const specs = [
  {
    name: 'Empty / No Snapshot / iPhone 16 Pro',
    group: 'Empty State',
    context: 'First observation has not formed',
    primary: '今天的气候还没有形成',
    secondary: '读取一次内容后，这里会出现第一张 Climate Snapshot。',
    note: '下一步保持轻，只出现一个读取入口。',
    mark: 'Air',
    tint: C.moss,
    kind: 'empty',
    rule: 'No sad icon. No dashboard placeholder. One focus only.',
  },
  {
    name: 'Empty / No History / iPhone 16 Pro',
    group: 'Empty State',
    context: 'History requires several observed days',
    primary: '还没有足够的历史',
    secondary: '连续几天之后，变化的方向会在这里慢慢显影。',
    note: '不制造空数据表，只保留时间感。',
    mark: 'Days',
    tint: C.teal,
    kind: 'empty',
    rule: 'No chart shell. No calendar grid. Air before information.',
  },
  {
    name: 'Empty / No Permission / iPhone 16 Pro',
    group: 'Empty State',
    context: 'Accessibility reading is not enabled',
    primary: '读取服务还没有开启',
    secondary: '开启后，FeedShift 才能观察页面文字的气候。',
    actions: ['前往设置'],
    mark: 'Open',
    tint: C.amber,
    kind: 'empty',
    rule: 'No blame. No warning color. Recovery is quiet and direct.',
  },
  {
    name: 'Loading / Reading Content / iPhone 16 Pro',
    group: 'Loading State',
    context: 'Reading visible page text',
    primary: '正在读取页面文字',
    secondary: '先让内容被看见，再让判断慢一点出现。',
    note: 'Motion note: Halo breathing 1800ms, Air shift 3600ms.',
    mark: 'Read',
    tint: C.teal,
    kind: 'loading',
    rule: 'No spinner. No progress bar. No percentage.',
  },
  {
    name: 'Loading / Generating Snapshot / iPhone 16 Pro',
    group: 'Loading State',
    context: 'Forming the climate snapshot',
    primary: '正在让信息气候显影',
    secondary: '结构会先浮出水面，结论随后出现。',
    note: 'Motion note: Development, not AI thinking.',
    mark: 'Form',
    tint: C.moss,
    kind: 'loading',
    rule: 'No AI SaaS copy. No skeleton card. No loading ring.',
  },
  {
    name: 'Error / Permission Denied / iPhone 16 Pro',
    group: 'Error State',
    context: 'Reading service cannot access text',
    primary: '读取服务没有开启',
    secondary: '可以前往设置重新开启，然后回到今天继续观察。',
    actions: ['打开设置', '返回'],
    mark: 'Set',
    tint: C.amber,
    kind: 'error',
    rule: 'No red alert. No modal-first error. Calm recovery.',
  },
  {
    name: 'Error / No Text Detected / iPhone 16 Pro',
    group: 'Error State',
    context: 'This page has no readable text',
    primary: '这次没有读到文字',
    secondary: '可以换一个页面，或者稍后再读取一次。',
    actions: ['重新读取'],
    mark: 'Text',
    tint: C.rose,
    kind: 'error',
    rule: 'No technical stack text. No blame language.',
  },
  {
    name: 'Error / Read Failed / iPhone 16 Pro',
    group: 'Error State',
    context: 'Reading stopped before completion',
    primary: '这次读取没有完成',
    secondary: '稍后再试一次，今天的气候不会因此丢失。',
    actions: ['再试一次'],
    mark: 'Try',
    tint: C.rose,
    kind: 'error',
    rule: 'No panic state. Error stays recoverable.',
  },
];

for (const node of [...page.children]) {
  if (specs.some((s) => s.name === node.name) || node.name === '05 States / Expanded Variants Board') {
    removedNodeIds.push(node.id);
    node.remove();
  }
}

const board = figma.createFrame();
board.name = '05 States / Expanded Variants Board';
board.x = 80;
board.y = 3600;
board.resize(1700, 146);
board.layoutMode = 'VERTICAL';
board.primaryAxisSizingMode = 'AUTO';
board.counterAxisSizingMode = 'FIXED';
board.paddingTop = 28;
board.paddingBottom = 28;
board.paddingLeft = 32;
board.paddingRight = 32;
board.itemSpacing = 8;
board.cornerRadius = 26;
board.fills = solid(C.panel, 0.13);
board.strokes = solid(C.line, 0.12);
page.appendChild(board);
createdNodeIds.push(board.id);

const title = figma.createText();
title.name = 'Title';
title.fontName = { family: 'Inter', style: 'Semi Bold' };
title.characters = '05 States / Expanded Variants';
title.fontSize = 30;
title.lineHeight = { unit: 'PERCENT', value: 128 };
title.fills = solid(C.ink, 0.95);
title.resize(1500, 42);
board.appendChild(title);
createdNodeIds.push(title.id);

const sub = figma.createText();
sub.name = 'Acceptance Summary';
sub.fontName = { family: 'Inter', style: 'Regular' };
sub.characters = 'Eight required MVP states built from the frozen FeedShift rules: space first, single focus, no dashboard, no AI SaaS, no spinner, no red alert.';
sub.fontSize = 13;
sub.lineHeight = { unit: 'PERCENT', value: 136 };
sub.fills = solid(C.muted, 0.72);
sub.resize(1500, 26);
board.appendChild(sub);
createdNodeIds.push(sub.id);

const startX = 80;
const startY = 3840;
const gapX = 433;
const gapY = 930;
specs.forEach((spec, i) => {
  makeState(spec, startX + (i % 4) * gapX, startY + Math.floor(i / 4) * gapY);
});

return {
  status: 'expanded-states-built',
  createdNodeIds,
  removedNodeIds,
  stateCount: specs.length,
  boardName: board.name,
  fileKey: 'Xn4xyi22SmzjadPmCvIZzz',
};
