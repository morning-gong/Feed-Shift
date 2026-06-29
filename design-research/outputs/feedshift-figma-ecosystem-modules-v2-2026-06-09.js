// FeedShift Ecosystem Modules UI v2
// Target: FeedShift MVP UI v1 copy / Product Screens page
// Strategy: Color follows ecosystem. Aesthetic follows FeedShift.

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
  return { r: parseInt(h.slice(0, 2), 16) / 255, g: parseInt(h.slice(2, 4), 16) / 255, b: parseInt(h.slice(4, 6), 16) / 255 };
}
function solid(color, opacity = 1) { return [{ type: 'SOLID', color, opacity }]; }

const C = {
  ink: rgb('F7F1E8'),
  paper: rgb('EFE8DE'),
  charcoal: rgb('111412'),
  muted: rgb('BDB5A8'),
  line: rgb('F7F1E8'),
  black: rgb('050605'),
  philosophy: rgb('B08A58'),
  science: rgb('6F93A3'),
  history: rgb('8A6E4A'),
  economics: rgb('78929B'),
  technology: rgb('738890'),
  society: rgb('B77743'),
  moss: rgb('51664B'),
};

function push(node) { createdNodeIds.push(node.id); return node; }
function rect(parent, name, x, y, w, h, color, opacity = 1, radius = 0) {
  const n = figma.createRectangle();
  n.name = name; n.x = x; n.y = y; n.resize(w, h); n.cornerRadius = radius; n.fills = solid(color, opacity);
  parent.appendChild(n); return push(n);
}
function ellipse(parent, name, x, y, w, h, color, opacity = 1) {
  const n = figma.createEllipse();
  n.name = name; n.x = x; n.y = y; n.resize(w, h); n.fills = solid(color, opacity);
  parent.appendChild(n); return push(n);
}
function line(parent, name, x, y, w, color = C.line, opacity = 0.22) {
  const n = figma.createLine();
  n.name = name; n.x = x; n.y = y; n.resize(w, 0); n.strokes = solid(color, opacity); n.strokeWeight = 1;
  parent.appendChild(n); return push(n);
}
function text(parent, name, chars, x, y, w, size, style = 'Regular', color = C.ink, opacity = 0.92) {
  const n = figma.createText();
  n.name = name; n.fontName = { family: 'Inter', style }; n.characters = chars; n.fontSize = size;
  n.lineHeight = { unit: 'PERCENT', value: 132 }; n.fills = solid(color, opacity);
  n.resize(w, Math.max(24, size * 1.65)); n.x = x; n.y = y; parent.appendChild(n); return push(n);
}
function photoField(parent, theme, dark = true) {
  rect(parent, '00 Photography Field / Base Tone', 0, 0, 393, 852, dark ? C.black : C.paper, 1);
  ellipse(parent, '00 Photography Field / Atmospheric Light', -80, 70, 470, 360, theme, dark ? 0.22 : 0.34);
  ellipse(parent, '00 Photography Field / Lower Air', 120, 450, 360, 360, theme, dark ? 0.12 : 0.18);
  rect(parent, '00 Photography Field / Depth Veil', 0, 520, 393, 332, dark ? C.black : C.paper, dark ? 0.64 : 0.36);
  for (let i = 0; i < 6; i++) line(parent, '00 Photography Field / Quiet Trace', 48 + i * 28, 190 + i * 42, 150, C.line, dark ? 0.035 : 0.08);
}
function nav(parent, active) {
  const labels = ['Today', 'Eco', 'Archive', 'Reflect', 'Settings'];
  labels.forEach((l, i) => {
    const x = 30 + i * 70;
    ellipse(parent, 'Nav Icon / ' + l, x, 782, 18, 18, C.ink, l === active ? 0.9 : 0.28);
    text(parent, 'Nav Label / ' + l, l, x - 10, 808, 48, 9, 'Regular', C.ink, l === active ? 0.92 : 0.52);
  });
}
function phone(name, x, y, theme, dark = true) {
  const f = figma.createFrame();
  f.name = name; f.x = x; f.y = y; f.resize(393, 852); f.cornerRadius = 32; f.clipsContent = true; f.fills = solid(dark ? C.black : C.paper, 1);
  page.appendChild(f); push(f); photoField(f, theme, dark); return f;
}
function chip(parent, label, x, y, w, dark = true) {
  const r = rect(parent, 'Chip / Surface', x, y, w, 34, dark ? C.ink : C.charcoal, dark ? 0.08 : 0.07, 17);
  r.strokes = solid(dark ? C.line : C.charcoal, dark ? 0.14 : 0.12); r.strokeWeight = 1;
  text(parent, 'Chip / Label', label, x + 14, y + 8, w - 28, 11, 'Medium', dark ? C.ink : C.charcoal, dark ? 0.84 : 0.72);
}
function issueCard(parent, eco, title, subtitle, x, y, w, h, color) {
  const c = rect(parent, 'Issue Card / ' + eco, x, y, w, h, color, 0.42, 10);
  c.strokes = solid(C.line, 0.12); c.strokeWeight = 1;
  ellipse(parent, 'Issue Card / Light ' + eco, x - 40, y - 20, w + 70, h * 0.8, C.ink, 0.06);
  text(parent, 'Issue Card / Eco', eco, x + 14, y + 18, w - 28, 10, 'Medium', C.ink, 0.68);
  text(parent, 'Issue Card / Title', title, x + 14, y + h - 82, w - 28, 24, 'Regular', C.ink, 0.95);
  text(parent, 'Issue Card / Subtitle', subtitle, x + 14, y + h - 38, w - 28, 11, 'Regular', C.ink, 0.72);
}

for (const node of [...page.children]) {
  if (node.name.startsWith('08 Ecosystem Modules /') || node.name.endsWith('/ v2')) {
    removedNodeIds.push(node.id);
    node.remove();
  }
}

const board = figma.createFrame();
board.name = '08 Ecosystem Modules / Strategy Board';
board.x = 80; board.y = 5740; board.resize(1700, 230); board.cornerRadius = 28;
board.layoutMode = 'VERTICAL'; board.primaryAxisSizingMode = 'AUTO'; board.counterAxisSizingMode = 'FIXED';
board.paddingTop = 30; board.paddingBottom = 30; board.paddingLeft = 34; board.paddingRight = 34; board.itemSpacing = 10;
board.fills = solid(C.paper, 0.08); board.strokes = solid(C.line, 0.12);
page.appendChild(board); push(board);
text(board, 'Title', '08 Ecosystem Modules / UI Direction v2', 0, 0, 1500, 30, 'Semi Bold', C.ink, 0.96);
text(board, 'Principle', 'Color follows ecosystem. Aesthetic follows FeedShift. Today is Climate, categories are Ecosystems, content is Issue, history is Archive, reflection is Observation Log.', 0, 0, 1500, 14, 'Regular', C.muted, 0.78);
text(board, 'Unified Elements', 'Unified: cinematic photography, low-density serif-like rhythm, quiet icons, soft glass controls, slow developing motion, single focus. Variable: tone, imagery, reading posture, module theme.', 0, 0, 1500, 14, 'Regular', C.muted, 0.72);

const y1 = 6060, x0 = 80, gap = 433;
const today = phone('Today / Climate / v2', x0, y1, C.science, true);
text(today, 'Brand', 'FeedShift', 24, 30, 180, 16, 'Semi Bold');
text(today, 'Sub', 'Cognitive Climate Observatory', 24, 54, 240, 11, 'Regular', C.ink, 0.62);
text(today, 'Time', '06:32', 24, 118, 140, 18);
text(today, 'Date', 'Tuesday, June 10', 24, 146, 180, 12, 'Regular', C.ink, 0.72);
text(today, 'Eyebrow', \"TODAY'S CLIMATE\", 24, 340, 180, 10, 'Medium', C.ink, 0.68);
text(today, 'Climate Name', 'Scattered\\nWinds', 24, 378, 270, 38, 'Regular');
text(today, 'Climate Sentence', 'Thoughts arrived quickly.\\nFew stayed.', 24, 502, 250, 15);
chip(today, 'Observe Today', 119, 642, 150, true); nav(today, 'Today');

const eco = phone('Ecosystems / Gallery / v2', x0 + gap, y1, C.charcoal, true);
text(eco, 'Title', 'Ecosystems', 24, 30, 220, 23, 'Semi Bold');
text(eco, 'Subtitle', 'Choose a perspective to explore.', 24, 62, 260, 12, 'Regular', C.ink, 0.72);
const ecos = [
  ['Philosophy', '思辨', C.philosophy], ['Science', '观察', C.science], ['History', '档案', C.history],
  ['Economics', '气候', C.economics], ['Technology', '信号', C.technology], ['Society', '人间', C.society],
];
ecos.forEach((e, i) => issueCard(eco, e[0], e[1], 'Issue No.' + (23 + i), 24 + (i % 2) * 174, 106 + Math.floor(i / 2) * 168, 156, 150, e[2]));
nav(eco, 'Eco');

const philosophy = phone('Philosophy Issue / Cover / v2', x0 + gap * 2, y1, C.philosophy, true);
text(philosophy, 'Top', 'Philosophy · Issue No.23', 24, 32, 220, 12, 'Medium');
text(philosophy, 'Title', 'Slow\\nThinking', 24, 126, 270, 40, 'Regular');
text(philosophy, 'Question', 'What remains when\\ncertainty disappears?', 24, 246, 250, 16);
line(philosophy, 'Read Progress', 24, 704, 300, C.line, 0.42);
text(philosophy, 'Meta', '1,284 words · 8 min read', 24, 728, 200, 11, 'Regular', C.ink, 0.62);
nav(philosophy, 'Eco');

const read = phone('Issue / Reading / v2', x0 + gap * 3, y1, C.philosophy, false);
text(read, 'Header', 'Philosophy\\nIssue No.23', 24, 32, 180, 11, 'Medium', C.charcoal, 0.66);
text(read, 'Title', 'On Doubt', 24, 132, 270, 36, 'Regular', C.charcoal, 0.96);
text(read, 'Subtitle', 'Exploring the fertile ground\\nwhere questions grow.', 24, 206, 275, 15, 'Regular', C.charcoal, 0.74);
text(read, 'Body', 'Doubt is not the opposite of knowledge, but its companion. It keeps the mind open, the senses awake, and the heart humble.\\n\\nIn a world that chases certainty, doubt is a form of courage.', 24, 300, 312, 14, 'Regular', C.charcoal, 0.78);
rect(read, 'Quote Surface', 40, 540, 300, 96, C.charcoal, 0.08, 12);
text(read, 'Quote', 'The highest expression\\nof thought is not knowing.', 62, 568, 250, 17, 'Regular', C.charcoal, 0.86);
line(read, 'Progress', 24, 744, 300, C.charcoal, 0.18);

const y2 = 6990;
const science = phone('Science Observatory / v2', x0, y2, C.science, true);
text(science, 'Title', 'Science Observatory', 24, 32, 240, 17, 'Semi Bold');
text(science, 'Name', 'Observation', 24, 124, 280, 38, 'Regular');
text(science, 'Sentence', 'Everything repeats,\\nbut never exactly.', 24, 224, 260, 15);
['Climate', 'Biology', 'Physics', 'Society'].forEach((l, i) => { rect(science, 'Pattern Row', 24, 430 + i * 58, 310, 44, C.ink, 0.055, 10); text(science, 'Pattern Label', l, 72, 443 + i * 58, 180, 13); ellipse(science, 'Pattern Dot', 42, 443 + i * 58, 18, 18, C.science, 0.65); });
nav(science, 'Eco');

const econ = phone('Economics Currents / v2', x0 + gap, y2, C.economics, true);
text(econ, 'Title', 'Economic\\nClimate', 24, 118, 280, 36, 'Regular');
text(econ, 'Sentence', 'The world moves\\nlike an ocean.', 24, 220, 260, 15);
['Flows', 'Resources', 'People', 'Capital', 'Ideas'].forEach((l, i) => { text(econ, 'Flow Label', l, 40, 420 + i * 52, 120, 12); line(econ, 'Flow Trace', 150, 430 + i * 52, 150, C.ink, 0.28); ellipse(econ, 'Flow Point', 210 + i * 12, 424 + i * 52, 8, 8, C.economics, 0.8); });
nav(econ, 'Eco');

const tech = phone('Technology Signals / v2', x0 + gap * 2, y2, C.technology, true);
text(tech, 'Title', 'Emerging\\nSignals', 24, 118, 280, 36, 'Regular');
text(tech, 'Sentence', 'Weak today,\\nstrong tomorrow.', 24, 220, 260, 15);
['Brain Computer Interface', 'Affective Computing', 'Energy New Paradigm'].forEach((l, i) => { rect(tech, 'Signal Row', 24, 464 + i * 70, 314, 54, C.ink, 0.055, 10); text(tech, 'Signal Label', l, 52, 476 + i * 70, 210, 12); text(tech, 'Signal Strength', (12 + i * 5) + '%', 278, 476 + i * 70, 40, 12); });
nav(tech, 'Eco');

const society = phone('Society Stories / v2', x0 + gap * 3, y2, C.society, true);
text(society, 'Title', 'Lives in\\nMotion', 24, 118, 280, 36, 'Regular');
text(society, 'Sentence', 'One story.\\nOne city.\\nOne perspective.', 24, 238, 250, 15);
['In Nairobi', 'The Night Shift', 'Small Business'].forEach((l, i) => { rect(society, 'Story Row', 24, 496 + i * 64, 314, 50, C.ink, 0.06, 10); text(society, 'Story Title', l, 52, 508 + i * 64, 210, 13); });
nav(society, 'Eco');

const y3 = 7920;
const archive = phone('Archive / Climate Archive / v2', x0, y3, C.science, true);
text(archive, 'Title', 'Climate Archive', 24, 32, 220, 21, 'Semi Bold');
text(archive, 'Sub', 'Your climate timeline.', 24, 62, 220, 12, 'Regular', C.ink, 0.66);
['Jun 10  Scattered Winds', 'Jun 9   Echo Chamber', 'Jun 8   Reactive Storm', 'Jun 7   Focused Curiosity', 'Jun 6   Open Horizon'].forEach((l, i) => { rect(archive, 'Archive Row', 24, 118 + i * 84, 330, 68, i % 2 ? C.charcoal : C.science, i % 2 ? 0.45 : 0.28, 10); text(archive, 'Archive Label', l, 44, 140 + i * 84, 230, 14); });
nav(archive, 'Archive');

const reflection = phone('Reflection / Observation Log / v2', x0 + gap, y3, C.paper, false);
text(reflection, 'Title', 'Reflection', 24, 32, 220, 21, 'Semi Bold', C.charcoal);
text(reflection, 'Sub', 'Looking back to move forward.', 24, 62, 260, 12, 'Regular', C.charcoal, 0.62);
text(reflection, 'Hero', 'You wandered often.\\nBut returned to depth\\nthree times.', 24, 138, 310, 28, 'Regular', C.charcoal, 0.94);
text(reflection, 'Range', 'June 2 - June 8, 2025', 24, 300, 240, 12, 'Regular', C.charcoal, 0.62);
['Most Frequent\\nScattered Winds\\n4 days', 'Rarest\\nOpen Horizon\\n1 day', 'Most Stable Day\\nThursday\\nFocused Curiosity'].forEach((l, i) => { rect(reflection, 'Reflection Metric', 24 + i * 108, 392, 96, 116, C.charcoal, 0.07, 10); text(reflection, 'Metric Text', l, 36 + i * 108, 410, 72, 11, 'Regular', C.charcoal, 0.8); });
chip(reflection, 'Open Full Reflection', 24, 666, 260, false);

const map = figma.createFrame();
map.name = 'Cognitive Map / Desktop Module / v2'; map.x = x0 + gap * 2; map.y = y3; map.resize(826, 520); map.cornerRadius = 26; map.clipsContent = true; map.fills = solid(C.black, 1);
page.appendChild(map); push(map);
photoField(map, C.technology, true);
text(map, 'Title', 'Cognitive Map', 32, 32, 260, 26, 'Semi Bold');
text(map, 'Sub', 'Your cognitive climate is always changing.', 32, 72, 320, 13, 'Regular', C.ink, 0.68);
ellipse(map, 'You', 310, 250, 42, 42, C.ink, 0.84);
text(map, 'You Label', 'You', 316, 264, 60, 12, 'Medium', C.black, 0.9);
ecos.forEach((e, i) => { const a = i * Math.PI / 3; const cx = 330 + Math.cos(a) * 185; const cy = 270 + Math.sin(a) * 120; ellipse(map, 'Ecosystem Node / ' + e[0], cx, cy, 88, 88, e[2], 0.24); text(map, 'Node Label', e[0] + '\\n' + e[1], cx + 16, cy + 25, 70, 12); line(map, 'Orbit Link', 350, 270, Math.max(60, Math.abs(cx - 330)), C.line, 0.08); });
rect(map, 'Drift Alert Panel', 610, 86, 176, 250, C.ink, 0.07, 14);
text(map, 'Drift Alert', 'Drift Alert\\n\\nYou are drifting\\ntowards Technology.\\n\\nRecent Focus\\nTechnology 61%\\nScience 18%\\nEconomics 11%', 630, 108, 132, 13, 'Regular', C.ink, 0.78);
chip(map, 'Explore Now', 630, 292, 126, true);

return {
  status: 'ecosystem-modules-v2-built',
  createdNodeIds,
  removedNodeIds,
  topLevelAdded: [
    '08 Ecosystem Modules / Strategy Board',
    'Today / Climate / v2',
    'Ecosystems / Gallery / v2',
    'Philosophy Issue / Cover / v2',
    'Issue / Reading / v2',
    'Science Observatory / v2',
    'Economics Currents / v2',
    'Technology Signals / v2',
    'Society Stories / v2',
    'Archive / Climate Archive / v2',
    'Reflection / Observation Log / v2',
    'Cognitive Map / Desktop Module / v2'
  ]
};
