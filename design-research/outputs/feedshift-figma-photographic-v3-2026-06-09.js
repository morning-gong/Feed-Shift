await figma.loadFontAsync({ family: 'Inter', style: 'Regular' });
await figma.loadFontAsync({ family: 'Inter', style: 'Medium' });
await figma.loadFontAsync({ family: 'Inter', style: 'Semi Bold' });

const createdNodeIds = [];
const removedNodeIds = [];
const page = figma.root.children.find((p) => p.name === '02 Product Screens');
if (!page) throw new Error('02 Product Screens page not found');
await figma.setCurrentPageAsync(page);

const H = {
  climate: '7ff3d74333f3b0b112b41ca2349274b1ffd6248c',
  ecosystems: 'f55f2d81a26ab6174bd2b108ab733e4d5397a341',
  philosophy: 'e21d9bf90e8778dafdb3ca78f16a00272f2eab0e',
  science: 'df1f08e1bed327c35c86d97fd0544b5dc4072cbc',
  history: '76d4e26caebe5111bf09b2953fd62111dc89a345',
  economics: 'ec2129d18b19af158935cc704c0300064a05a536',
  technology: '9d7da56a65e401b11c0c37f95c9d77bf8fc770ed',
  society: '099377b0943f77053c095c9d165510e167691d19',
  map: '452fa8088a690f94c912a2d189e02d64bca9a1c2',
  reflection: '3d94328671aea25618c9b309e2455771e22ab81e',
};

function rgb(hex) {
  return { r: parseInt(hex.slice(0, 2), 16) / 255, g: parseInt(hex.slice(2, 4), 16) / 255, b: parseInt(hex.slice(4, 6), 16) / 255 };
}
const C = {
  ink: rgb('F7F1E8'),
  paper: rgb('EFE8DE'),
  charcoal: rgb('111412'),
  line: rgb('F7F1E8'),
  black: rgb('050605'),
  gold: rgb('C4A06B'),
};
const solid = (c, opacity = 1) => [{ type: 'SOLID', color: c, opacity }];
const image = (hash, opacity = 1) => [{ type: 'IMAGE', scaleMode: 'FILL', imageHash: hash, opacity }];
function keep(n) { createdNodeIds.push(n.id); return n; }
function rect(p, name, x, y, w, h, fills, radius = 0) {
  const n = figma.createRectangle();
  n.name = name; n.x = x; n.y = y; n.resize(w, h); n.cornerRadius = radius; n.fills = fills;
  p.appendChild(n); return keep(n);
}
function text(p, name, chars, x, y, w, size, style = 'Regular', color = C.ink, opacity = 0.94) {
  const n = figma.createText();
  n.name = name; n.fontName = { family: 'Inter', style }; n.characters = chars; n.fontSize = size;
  n.lineHeight = { unit: 'PERCENT', value: 128 }; n.fills = solid(color, opacity);
  n.resize(w, Math.max(24, size * 1.6)); n.x = x; n.y = y; p.appendChild(n); return keep(n);
}
function ellipse(p, name, x, y, w, h, color, opacity) {
  const n = figma.createEllipse();
  n.name = name; n.x = x; n.y = y; n.resize(w, h); n.fills = solid(color, opacity); p.appendChild(n); return keep(n);
}
function photoFrame(name, x, y, w, h, hash, dark = true) {
  const f = figma.createFrame();
  f.name = name; f.x = x; f.y = y; f.resize(w, h); f.cornerRadius = w > 500 ? 24 : 32; f.clipsContent = true;
  f.fills = solid(dark ? C.black : C.paper, 1); page.appendChild(f); keep(f);
  rect(f, '00 Photography / Real Background', 0, 0, w, h, image(hash), 0);
  rect(f, '00 Photography / Dark Vignette', 0, 0, w, h, solid(C.black, dark ? 0.38 : 0.06), 0);
  rect(f, '00 Photography / Bottom Reading Veil', 0, h * 0.5, w, h * 0.5, solid(dark ? C.black : C.paper, dark ? 0.42 : 0.46), 0);
  return f;
}
function nav(p, active, y = 782) {
  ['Today', 'Eco', 'Archive', 'Reflect', 'Settings'].forEach((l, i) => {
    const x = 30 + i * 70;
    ellipse(p, 'Nav Dot / ' + l, x, y, 16, 16, C.ink, l === active ? 0.92 : 0.26);
    text(p, 'Nav Label / ' + l, l, x - 10, y + 26, 50, 9, 'Regular', C.ink, l === active ? 0.9 : 0.54);
  });
}
function glass(p, name, x, y, w, h, opacity = 0.12) {
  const g = rect(p, name, x, y, w, h, solid(C.ink, opacity), 14);
  g.strokes = solid(C.line, 0.18); g.strokeWeight = 1; return g;
}

for (const n of [...page.children]) {
  if (n.name.startsWith('09 Photographic Modules /') || n.name.endsWith('/ photographic v3') || /^feedshift-v3-/.test(n.name)) {
    removedNodeIds.push(n.id);
    n.remove();
  }
}
['2022:2','2022:3','2022:4','2022:5','2022:6','2023:2','2023:3','2023:4','2023:5','2023:6'].forEach(async () => {});

const x0 = 80, y0 = 8900, gap = 433;
const board = figma.createFrame();
board.name = '09 Photographic Modules / Direction Board';
board.x = x0; board.y = y0; board.resize(1772, 168); board.cornerRadius = 24;
board.layoutMode = 'VERTICAL'; board.primaryAxisSizingMode = 'AUTO'; board.counterAxisSizingMode = 'FIXED';
board.paddingTop = 28; board.paddingBottom = 28; board.paddingLeft = 34; board.paddingRight = 34; board.itemSpacing = 8;
board.fills = solid(C.paper, 0.1); board.strokes = solid(C.line, 0.16); page.appendChild(board); keep(board);
text(board, 'Title', '09 Photographic Modules / v3', 0, 0, 1500, 30, 'Semi Bold');
text(board, 'Rule', 'This version uses real photographic backgrounds from the approved reference. Tones vary by module; FeedShift aesthetic stays unified through cinematic depth, restrained type, glass controls, and single-focus layouts.', 0, 0, 1500, 14, 'Regular', C.ink, 0.72);

const t = photoFrame('Today / Climate / photographic v3', x0, y0 + 260, 393, 852, H.climate);
text(t, 'Brand', 'FeedShift', 24, 30, 180, 17, 'Semi Bold');
text(t, 'Sub', 'Cognitive Climate Observatory', 24, 55, 230, 11, 'Regular', C.ink, 0.68);
text(t, 'Clock', '06:32', 24, 126, 150, 18);
text(t, 'Date', 'Tuesday, June 10', 24, 154, 190, 12, 'Regular', C.ink, 0.74);
text(t, 'Eyebrow', \"TODAY'S CLIMATE\", 24, 342, 190, 10, 'Medium', C.ink, 0.72);
text(t, 'Title', 'Scattered\\nWinds', 24, 382, 290, 39);
text(t, 'Line', 'Thoughts arrived quickly.\\nFew stayed.', 24, 510, 240, 15);
glass(t, 'Observe Control', 124, 645, 146, 50, 0.15);
text(t, 'Observe Label', 'Observe Today', 150, 660, 110, 12, 'Medium');
nav(t, 'Today');

const e = photoFrame('Ecosystems / Gallery / photographic v3', x0 + gap, y0 + 260, 393, 852, H.ecosystems);
rect(e, '00 Deepen Gallery', 0, 0, 393, 852, solid(C.black, 0.52));
text(e, 'Title', 'Ecosystems', 24, 32, 230, 23, 'Semi Bold');
text(e, 'Sub', 'Choose a perspective to explore.', 24, 64, 260, 12, 'Regular', C.ink, 0.75);
[
  ['Philosophy', '思辨', H.philosophy], ['Science', '观察', H.science], ['History', '档案', H.history],
  ['Economics', '气候', H.economics], ['Technology', '信号', H.technology], ['Society', '人间', H.society],
].forEach((item, i) => {
  const x = 24 + (i % 2) * 174, y = 112 + Math.floor(i / 2) * 165;
  rect(e, 'Ecosystem Cover / ' + item[0], x, y, 156, 146, image(item[2]), 10);
  rect(e, 'Ecosystem Cover / Veil', x, y, 156, 146, solid(C.black, 0.28), 10);
  text(e, 'Ecosystem Label', item[0] + '\\n' + item[1], x + 12, y + 86, 120, 19);
});
nav(e, 'Eco');

const p = photoFrame('Philosophy Field / photographic v3', x0 + gap * 2, y0 + 260, 826, 520, H.philosophy);
text(p, 'Section', 'Philosophy Field\\n思辨场域', 32, 28, 240, 13, 'Medium');
text(p, 'Title', 'Slow Thinking', 32, 128, 330, 40);
text(p, 'Line', 'A field of questions,\\nnot answers.', 32, 198, 260, 16);
glass(p, 'Question Space', 32, 318, 360, 138, 0.12);
text(p, 'Question', 'What remains\\nwhen certainty disappears?', 52, 340, 280, 26);
text(p, 'Quiet Mode', 'Enter Quiet Mode', 650, 30, 140, 12, 'Medium');

const y1 = y0 + 870;
[
  ['Science Observatory / photographic v3', H.science, 'Observation', 'Everything repeats.\\nBut never exactly.', 'Patterns', ['Climate', 'Biology', 'Physics']],
  ['History Archive / photographic v3', H.history, 'Archive Room', 'Every era leaves\\nits climate behind.', 'Recent Archives', ['Turning Points', 'Long Transition', 'Memory Trace']],
  ['Economics Currents / photographic v3', H.economics, 'Current Flow', 'The world moves\\nlike an ocean.', 'Flows', ['Resources', 'People', 'Capital']],
  ['Technology Signals / photographic v3', H.technology, 'Emerging\\nSignals', 'Weak today,\\nstrong tomorrow.', 'Weak Signals', ['Brain Interface', 'Affective Computing', 'Energy Paradigm']],
  ['Society Stories / photographic v3', H.society, 'Lives in\\nMotion', 'One story.\\nOne city.\\nOne perspective.', 'Recent Stories', ['In Nairobi', 'The Night Shift', 'Small Business']],
].forEach((s, i) => {
  const f = photoFrame(s[0], x0 + i * gap, y1, 393, 852, s[1]);
  text(f, 'Module', s[0].split(' / ')[0], 24, 34, 230, 15, 'Semi Bold');
  text(f, 'Title', s[2], 24, 130, 290, 36);
  text(f, 'Sentence', s[3], 24, 232, 260, 15);
  glass(f, 'Module Panel', 24, 514, 314, 160, 0.11);
  text(f, 'Panel Title', s[4], 42, 532, 180, 11, 'Medium');
  s[5].forEach((r, idx) => text(f, 'Panel Row', r, 48, 566 + idx * 36, 220, 12));
  nav(f, 'Eco');
});

const y2 = y1 + 930;
const map = photoFrame('Cognitive Map / photographic v3', x0, y2, 826, 520, H.map);
rect(map, 'Map Depth Veil', 0, 0, 826, 520, solid(C.black, 0.42));
text(map, 'Title', 'Cognitive Map', 32, 32, 280, 26, 'Semi Bold');
text(map, 'Sub', 'You are here. Your cognitive climate is always changing.', 32, 72, 420, 13, 'Regular', C.ink, 0.7);
ellipse(map, 'You Glow', 350, 250, 54, 54, C.gold, 0.5);
text(map, 'You', 'You', 363, 268, 80, 12, 'Medium');
['Philosophy', 'Science', 'History', 'Economics', 'Technology'].forEach((n, i) => {
  const x = 190 + (i % 3) * 160, y = 170 + Math.floor(i / 3) * 145;
  ellipse(map, 'Node / ' + n, x, y, 94, 58, C.ink, 0.08);
  text(map, 'Node Text', n, x + 18, y + 18, 90, 12);
});
glass(map, 'Drift Panel', 610, 80, 170, 260, 0.11);
text(map, 'Drift Text', 'Drift Alert\\n\\nYou are drifting\\ntowards Technology.\\n\\nSuggestion\\nOpen your horizon.', 630, 102, 130, 13, 'Regular', C.ink, 0.78);

const archive = photoFrame('Archive Museum / photographic v3', x0 + 866, y2, 826, 520, H.history);
rect(archive, 'Archive Warm Veil', 0, 0, 826, 520, solid(C.black, 0.36));
text(archive, 'Title', 'Cognitive Museum', 32, 32, 300, 26, 'Semi Bold');
text(archive, 'Sub', 'Your journey through ideas and perspectives.', 32, 72, 380, 13, 'Regular', C.ink, 0.72);
[
  ['On Doubt', H.philosophy], ['Observation 018', H.science], ['Turning Points', H.history], ['Shifting Currents', H.economics], ['Human + Machine', H.technology], ['Lives in Motion', H.society],
].forEach((c, i) => {
  const x = 32 + i * 128;
  rect(archive, 'Museum Card / ' + c[0], x, 150, 112, 250, image(c[1]), 10);
  rect(archive, 'Museum Card / Veil', x, 150, 112, 250, solid(C.black, 0.28), 10);
  text(archive, 'Museum Card Title', c[0], x + 10, 316, 90, 15);
});

const ref = photoFrame('Reflection Log / photographic v3', x0, y2 + 590, 826, 320, H.reflection, false);
rect(ref, 'Paper Wash', 0, 0, 826, 320, solid(C.paper, 0.56));
text(ref, 'Title', 'Reflection\\n反思', 34, 36, 200, 18, 'Semi Bold', C.charcoal);
text(ref, 'Hero', 'You wandered often.\\nBut returned to depth\\nthree times.', 34, 118, 320, 29, 'Regular', C.charcoal);
glass(ref, 'Reflection Stats', 470, 44, 290, 210, 0.5);
text(ref, 'Stats', 'Most Frequent Climate\\nScattered Winds · 4 days\\n\\nRarest Climate\\nOpen Horizon · 1 day\\n\\nMost Stable Day\\nThursday', 492, 66, 230, 13, 'Regular', C.charcoal, 0.84);

return { status: 'photographic-v3-built', createdNodeIds, removedNodeIds, imageHashes: H };
