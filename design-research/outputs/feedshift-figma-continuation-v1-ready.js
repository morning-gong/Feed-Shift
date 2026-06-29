await figma.loadFontAsync({ family: 'Inter', style: 'Regular' });
await figma.loadFontAsync({ family: 'Inter', style: 'Medium' });
await figma.loadFontAsync({ family: 'Inter', style: 'Semi Bold' });

const createdNodeIds = [];
const mutatedNodeIds = [];
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
};

function solid(color, opacity = 1) {
  return [{ type: 'SOLID', color, opacity }];
}

function text(name, chars, w, size = 14, style = 'Regular', color = C.ink, opacity = 0.92) {
  const node = figma.createText();
  node.name = name;
  node.fontName = { family: 'Inter', style };
  node.characters = chars;
  node.fontSize = size;
  node.lineHeight = { unit: 'PERCENT', value: 132 };
  node.fills = solid(color, opacity);
  node.resize(w, Math.max(24, size * 1.55));
  node.layoutSizingHorizontal = 'FIXED';
  createdNodeIds.push(node.id);
  return node;
}

function makeBoard(name, x, y, w) {
  const node = figma.createFrame();
  node.name = name;
  node.x = x;
  node.y = y;
  node.resize(w, 100);
  node.layoutMode = 'VERTICAL';
  node.primaryAxisSizingMode = 'AUTO';
  node.counterAxisSizingMode = 'FIXED';
  node.paddingTop = 32;
  node.paddingBottom = 32;
  node.paddingLeft = 32;
  node.paddingRight = 32;
  node.itemSpacing = 18;
  node.cornerRadius = 28;
  node.fills = solid(C.panel, 0.13);
  node.strokes = solid(C.line, 0.12);
  page.appendChild(node);
  createdNodeIds.push(node.id);
  return node;
}

function row(label, value, action, widths = [260, 380, 320]) {
  const item = figma.createFrame();
  item.name = 'Spec Row';
  item.layoutMode = 'HORIZONTAL';
  item.primaryAxisSizingMode = 'AUTO';
  item.counterAxisSizingMode = 'FIXED';
  item.resize(widths.reduce((a, b) => a + b, 0) + 40, 40);
  item.itemSpacing = 20;
  item.fills = [];
  createdNodeIds.push(item.id);

  item.appendChild(text('Label', label, widths[0], 14, 'Medium', C.ink, 0.94));
  item.appendChild(text('Value', value, widths[1], 14, 'Regular', C.muted, 0.76));
  item.appendChild(text('Action', action, widths[2], 14, 'Regular', C.ink, 0.84));
  return item;
}

function sectionTitle(title, subtitle, width) {
  const group = figma.createFrame();
  group.name = 'Section Header';
  group.layoutMode = 'VERTICAL';
  group.primaryAxisSizingMode = 'AUTO';
  group.counterAxisSizingMode = 'FIXED';
  group.resize(width, 64);
  group.itemSpacing = 8;
  group.fills = [];
  createdNodeIds.push(group.id);
  group.appendChild(text('Title', title, width, 30, 'Semi Bold', C.ink, 0.95));
  group.appendChild(text('Subtitle', subtitle, width, 13, 'Regular', C.muted, 0.72));
  return group;
}

for (const node of [...page.children]) {
  if (['06 Prototype / Flow Map', '07 QA / Gate Board', 'Screen Inventory / Acceptance'].includes(node.name)) {
    removedNodeIds.push(node.id);
    node.remove();
  }
}

const proto = makeBoard('06 Prototype / Flow Map', 80, 2220, 1200);
proto.appendChild(sectionTitle('Prototype flows', 'Figma-compressed continuation of 06 Prototype page spec', 1080));
[
  ['Daily Observation', 'Today -> Detail -> Explore -> Detail -> Today', 'Connect Insight Block, Suggestion Pill, and Back controls'],
  ['Reading Content', 'Today -> Loading Reading -> Loading Snapshot -> Today Updated', 'Use 1200ms auto delays and Developing Halo, never spinner'],
  ['Permission Missing', 'Today -> Settings -> Error Permission -> Settings', 'Recovery action returns to Settings'],
  ['History Review', 'Today -> History -> Weekly / Monthly / Yearly', 'History remains the primary reflection anchor'],
  ['Empty First Use', 'Empty -> Loading Reading -> Fresh Snapshot', 'Start Reading enters calm loading, then updated Today'],
].forEach((r) => proto.appendChild(row(...r)));

const qa = makeBoard('07 QA / Gate Board', 80, 2740, 1200);
qa.appendChild(sectionTitle('QA gates', 'Visible acceptance board for every MVP screen', 1080));
[
  ['Identity Gate', 'Space, air, one focus, no dashboard, no AI SaaS', 'Reject if identity becomes generic'],
  ['Layout Gate', 'Low density, main content before detail, quiet navigation', 'Remove at least 20% or reorder hierarchy'],
  ['Component Gate', 'Sparse surfaces, no nested cards, halo not activity ring', 'Redesign the instance'],
  ['Content Gate', 'Observation first, raw data below insight, no blame', 'Rewrite copy before acceptance'],
  ['Motion Gate', 'Development feeling, no spinners, contextual transitions', 'Reduce speed or amplitude'],
  ['Risk Gate', 'Dashboard / AI SaaS / Journal / Calm / Arc risk <= 5', 'Reject if any score exceeds 5'],
  ['Recognition Gate', 'Recognizable as FeedShift in 3 seconds without brand text', 'Minimum score 80 / 100'],
  ['Reduction Gate', 'Must Exist / Can Remove / Removed documented per screen', 'Minimum 20% non-critical reduction'],
].forEach((r) => qa.appendChild(row(...r)));

const inventory = makeBoard('Screen Inventory / Acceptance', 1360, 2220, 900);
inventory.appendChild(sectionTitle('Screen acceptance inventory', 'Screen-level pass state and remaining expansion notes', 780));
[
  ['Today', 'Recognition 88 / Risks <= 5', 'Primary anchor accepted; preserve single focus'],
  ['Detail', 'Recognition 84 / Risks <= 5', 'Secondary disclosure accepted'],
  ['Explore', 'Recognition 82 / Risks <= 5', 'Supplement direction accepted; avoid filter density'],
  ['History', 'Recognition 81 / Risks <= 5', 'Review anchor accepted'],
  ['Settings', 'Recognition 82 / Risks <= 5', 'Utility accepted; never primary anchor'],
  ['Weekly Reflection', 'Recognition 83 / Risks <= 5', 'Reflection accepted'],
  ['Monthly Reflection', 'Recognition 82 / Risks <= 5', 'Reflection accepted'],
  ['Yearly Review', 'Recognition 85 / Risks <= 5', 'Review accepted'],
  ['Empty State', 'No blame / Start Reading clear', 'Accepted as first-use entry'],
  ['Loading State', 'Developing Halo / no spinner', 'Accepted with 1200ms staged advance'],
  ['Error State', 'Recoverable / no red alert', 'Accepted; recovery action required'],
].forEach((r) => inventory.appendChild(row(...r, [190, 260, 330])));

return {
  status: 'prototype-qa-acceptance-continuation-ready',
  pageId: page.id,
  createdNodeIds,
  mutatedNodeIds,
  removedNodeIds,
  createdCount: createdNodeIds.length,
  removedCount: removedNodeIds.length,
};
