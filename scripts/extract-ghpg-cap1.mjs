/**
 * Extrai Cap. 1 (Heritages & Traits) do Grim Hollow Player's Guide.
 * Uso: node scripts/extract-ghpg-cap1.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const grimDir = path.join(apiRoot, 'docs/source/new/grim');
const outPath = path.join(apiRoot, 'docs/source/ghpg-cap1-heritages-extract.json');

const htmlPath = fs
  .readdirSync(grimDir)
  .filter((n) => n.includes('Chapter 1') && n.endsWith('.html'))
  .map((n) => path.join(grimDir, n))[0];

if (!htmlPath) {
  console.error('HTML Cap. 1 GHPG não encontrado em docs/source/new/grim');
  process.exit(1);
}

const html = fs.readFileSync(htmlPath, 'utf8');
const filesDir = `${path.basename(htmlPath)}_files`;

function decodeHtml(value) {
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&nbsp;/g, ' ');
}

function stripTags(fragment) {
  return decodeHtml(fragment.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim());
}

function slugify(name) {
  return name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

const HERITAGE_SECTIONS = [
  { category: 'common', headingId: 'CommonHeritages', names: ['Dragonborn', 'Dwarves', 'Elves', 'Gnomes', 'Halflings', 'Humans'] },
  { category: 'rare', headingId: 'RareHeritages', names: ['Dreamer', 'Grudgel', 'Laneshi', 'Ogresh'] },
  {
    category: 'eldritch',
    headingId: 'EldritchHeritages',
    names: ['Accursed', 'Arisen', 'Dhampir', 'Disembodied', 'Downcast', 'Wechselkind', 'Wulven'],
  },
];

const HERITAGE_SLUG = {
  Dragonborn: 'gh-dragonborn',
  Dwarves: 'gh-dwarf',
  Elves: 'gh-elf',
  Gnomes: 'gh-gnome',
  Halflings: 'gh-halfling',
  Humans: 'gh-human',
  Dreamer: 'gh-dreamer',
  Grudgel: 'gh-grudgel',
  Laneshi: 'gh-laneshi',
  Ogresh: 'gh-ogresh',
  Accursed: 'gh-accursed',
  Arisen: 'gh-arisen',
  Dhampir: 'gh-dhampir',
  Disembodied: 'gh-disembodied',
  Downcast: 'gh-downcast',
  Wechselkind: 'gh-wechselkind',
  Wulven: 'gh-wulven',
};

const HERITAGE_PT = {
  Dragonborn: 'Draconato',
  Dwarves: 'Anão',
  Elves: 'Elfo',
  Gnomes: 'Gnomo',
  Halflings: 'Halfling',
  Humans: 'Humano',
  Dreamer: 'Sonhador',
  Grudgel: 'Rancoroso',
  Laneshi: 'Laneshi',
  Ogresh: 'Ogrês',
  Accursed: 'Amaldiçoado',
  Arisen: 'Reerguido',
  Dhampir: 'Dhampir',
  Disembodied: 'Desencarnado',
  Downcast: 'Relegado',
  Wechselkind: 'Wechselkind',
  Wulven: 'Wulven',
};

const CATEGORY_PT = {
  common: 'Herança comum',
  rare: 'Herança rara',
  eldritch: 'Herança eldritch',
};

function extractBetween(htmlText, startRe, endRe) {
  const start = htmlText.search(startRe);
  if (start < 0) return '';
  const slice = htmlText.slice(start);
  const end = slice.search(endRe);
  return end < 0 ? slice : slice.slice(0, end);
}

const HERITAGE_HTML_ID = {
  Dragonborn: 'Dragonborn',
  Dwarves: 'Dwarves',
  Elves: 'Elves',
  Gnomes: 'Gnomes',
  Halflings: 'Halflings',
  Humans: 'Humans',
  Dreamer: 'Dreamers',
  Grudgel: 'Grudgels',
  Laneshi: 'Laneshi',
  Ogresh: 'Ogresh',
  Accursed: 'Accursed',
  Arisen: 'Arisen',
  Dhampir: 'Dhampir',
  Disembodied: 'Disembodied',
  Downcast: 'Downcast',
  Wechselkind: 'Wechselkind',
  Wulven: 'Wulven',
};

function extractHeritageBlock(name) {
  const id = HERITAGE_HTML_ID[name] ?? name;
  const startRe = new RegExp(`<h4[^>]*id="${id}"`, 'i');
  const start = html.search(startRe);
  if (start < 0) return '';
  const afterStart = start + 1;
  const rest = html.slice(afterStart);
  const endRe = /<h4[^>]*id="|<h3[^>]*id="(Common|Rare|Eldritch)Heritages"|<h2[^>]*id="HeritageTraits"/i;
  const end = rest.search(endRe);
  return end < 0 ? rest : html.slice(start, afterStart + end);
}

function extractImageFile(block) {
  const m = block.match(/href="\.\/[^"]*_files\/([^"?]+\.(?:png|jpg|jpeg|webp))"/i);
  return m ? m[1] : null;
}

function extractParagraphs(block) {
  const paras = [];
  for (const m of block.matchAll(/<p[^>]*>([\s\S]*?)<\/p>/gi)) {
    const text = stripTags(m[1]);
    if (text && !text.startsWith('—')) paras.push(text);
  }
  return paras;
}

function extractBaseTraits(block, singularName) {
  const baseId = `${singularName.replace(/s$/, '')}BaseTraits`;
  const altIds = [
    `${singularName}BaseTraits`,
    baseId,
    singularName === 'Dwarves' ? 'DwarfBaseTraits' : null,
    singularName === 'Elves' ? 'ElfBaseTraits' : null,
    singularName === 'Gnomes' ? 'GnomeBaseTraits' : null,
    singularName === 'Halflings' ? 'HalflingBaseTraits' : null,
    singularName === 'Humans' ? 'HumanBaseTraits' : null,
  ].filter(Boolean);

  let section = '';
  for (const id of altIds) {
    const re = new RegExp(`<h5[^>]*id="${id}"[\\s\\S]*?(?=<h4|<h5[^>]*id="Traditional|<aside class="grim--rules-sidebar" id="Traditional)`, 'i');
    const m = block.match(re);
    if (m) {
      section = m[0];
      break;
    }
  }

  const traits = [];
  for (const m of section.matchAll(/<p[^>]*>([\s\S]*?)<\/p>/gi)) {
    const text = stripTags(m[1]);
    if (!text) continue;
    const label = text.match(/^([A-Za-z][^.]+)\./);
    if (label) {
      traits.push({ name: label[1].trim(), description: text });
    } else if (!text.includes('folk of Etharis') && text.length > 20) {
      traits.push({ name: 'Visão geral', description: text });
    }
  }
  return traits;
}

function parseTraditionalSidebar(block, heritageName) {
  const singular = heritageName.replace(/s$/, '');
  const re = new RegExp(
    `<aside class="grim--rules-sidebar" id="Traditional${singular}Traits"[\\s\\S]*?</aside>`,
    'i',
  );
  const m = block.match(re);
  if (!m) return { combat: [], exploration: [], roleplaying: [] };

  const aside = m[0];
  const groups = { combat: [], exploration: [], roleplaying: [] };
  let current = 'combat';
  const liRe = /<li>\s*<a[^>]*#([^"]+)"[^>]*>([^<]+)<\/a>/gi;
  for (const part of aside.split(/<(strong|h\d)/i)) {
    if (/Combat Traits/i.test(part)) current = 'combat';
    else if (/Exploration Traits/i.test(part)) current = 'exploration';
    else if (/Roleplaying Traits/i.test(part)) current = 'roleplaying';
  }

  const asideLower = aside.toLowerCase();
  const sections = [
    { key: 'combat', marker: 'combat traits' },
    { key: 'exploration', marker: 'exploration traits' },
    { key: 'roleplaying', marker: 'roleplaying traits' },
  ];

  for (const { key, marker } of sections) {
    const idx = asideLower.indexOf(marker);
    if (idx < 0) continue;
    const nextMarkers = sections
      .filter((s) => s.marker !== marker)
      .map((s) => asideLower.indexOf(s.marker, idx + 1))
      .filter((n) => n > idx);
    const end = nextMarkers.length ? Math.min(...nextMarkers) : aside.length;
    const chunk = aside.slice(idx, end);
    for (const lm of chunk.matchAll(liRe)) {
      groups[key].push({ anchorId: lm[1], name: stripTags(lm[2]) });
    }
    const plainLi = chunk.matchAll(/<li>\s*<a[^>]*#([^"]+)"[^>]*>([\s\S]*?)<\/a>/gi);
    for (const lm of plainLi) {
      const name = stripTags(lm[2]);
      if (!groups[key].some((t) => t.anchorId === lm[1])) {
        groups[key].push({ anchorId: lm[1], name });
      }
    }
  }

  return groups;
}

function parseTraitDefinitions() {
  const traits = [];
  const traitSection = extractBetween(html, /<h2[^>]*id="TraitListList"/i, /<div id="comp-next-nav"/i);
  const headingRe = /<h4[^>]*id="([^"]+)"[^>]*>[\s\S]*?<\/h4>([\s\S]*?)(?=<h4[^>]*id="|$)/gi;

  for (const m of traitSection.matchAll(headingRe)) {
    const anchorId = m[1];
    const body = m[2];
    const nameMatch = body.match(/<strong><em>([^<]+)<\/em><\/strong>/);
    const name = nameMatch ? stripTags(nameMatch[1]) : anchorId.replace(/(Combat|Exploration|Roleplaying)$/, '');
    const paragraphs = [];
    for (const pm of body.matchAll(/<p[^>]*>([\s\S]*?)<\/p>/gi)) {
      const text = stripTags(pm[1]);
      if (text) paragraphs.push(text);
    }
    let category = 'combat';
    if (anchorId.endsWith('Exploration')) category = 'exploration';
    else if (anchorId.endsWith('Roleplaying')) category = 'roleplaying';
  }

  const allTraitRe =
    /<h[34][^>]*id="([A-Za-z]+(?:Combat|Exploration|Roleplaying))"[^>]*>[\s\S]*?<\/h[34]>([\s\S]*?)(?=<h[34][^>]*id="[A-Za-z]+(?:Combat|Exploration|Roleplaying)"|<h2[^>]*id="|$)/gi;
  const traitMap = new Map();

  for (const m of html.matchAll(allTraitRe)) {
    const anchorId = m[1];
    const body = m[2];
    const nameMatch = body.match(/<strong><em>([^<]+)<\/em><\/strong>/);
    const name = nameMatch ? stripTags(nameMatch[1]) : anchorId.replace(/(Combat|Exploration|Roleplaying)$/, '');
    const paragraphs = [];
    for (const pm of body.matchAll(/<p[^>]*>([\s\S]*?)<\/p>/gi)) {
      const text = stripTags(pm[1]);
      if (text) paragraphs.push(text);
    }
    let category = 'combat';
    if (anchorId.endsWith('Exploration')) category = 'exploration';
    else if (anchorId.endsWith('Roleplaying')) category = 'roleplaying';

    traitMap.set(anchorId, {
      anchorId,
      slug: slugify(name),
      name,
      category,
      description: paragraphs.join('\n\n'),
      improvedName: null,
    });
  }

  for (const pm of html.matchAll(/<a[^>]*#([A-Za-z]+(?:Combat|Exploration|Roleplaying))"[^>]*>([^<]+)<\/a>\s*→\s*([^<]+)/gi)) {
    const entry = traitMap.get(pm[1]);
    if (entry) entry.improvedName = stripTags(pm[3]);
  }

  return [...traitMap.values()].sort((a, b) => a.name.localeCompare(b.name));
}

function feetToMeters(text) {
  return text.replace(/(\d+)\s*feet/gi, (_, n) => {
    const m = (Number(n) * 0.3).toFixed(1).replace(/\.0$/, '');
    return `${m} m`;
  });
}

function localizeBaseTrait(text) {
  let t = feetToMeters(text);
  t = t.replace(/\bMedium\b/g, 'Médio');
  t = t.replace(/\bSmall\b/g, 'Pequeno');
  t = t.replace(/\bLarge\b/g, 'Grande');
  return t;
}

const heritages = [];
for (const section of HERITAGE_SECTIONS) {
  for (const name of section.names) {
    const block = extractHeritageBlock(name);
    if (!block) {
      console.warn(`Bloco não encontrado: ${name}`);
      continue;
    }
    const paras = extractParagraphs(block);
    const baseTraits = extractBaseTraits(block, name).map((t) => ({
      ...t,
      description: localizeBaseTrait(t.description),
    }));
    const traditional = parseTraditionalSidebar(block, name);
    const imageFile = extractImageFile(block);

    let size = 'Médio';
    let speed = '9 m';
    for (const t of baseTraits) {
      if (/^Size/i.test(t.name)) size = localizeBaseTrait(t.description.replace(/^Size\.\s*/i, ''));
      if (/^Speed/i.test(t.name)) speed = localizeBaseTrait(t.description.replace(/^Speed\.\s*/i, ''));
    }

    heritages.push({
      slug: HERITAGE_SLUG[name],
      nameEn: name.replace(/s$/, name === 'Humans' ? 'Humans' : ''),
      namePt: HERITAGE_PT[name],
      category: section.category,
      categoryLabelPt: CATEGORY_PT[section.category],
      description: paras.join('\n\n'),
      size,
      speed,
      baseTraits,
      traditionalTraits: traditional,
      imageFile,
    });
  }
}

const traits = parseTraitDefinitions();

const output = {
  source: path.basename(htmlPath),
  extractedAt: new Date().toISOString(),
  heritageCount: heritages.length,
  traitCount: traits.length,
  heritages,
  traits,
};

fs.writeFileSync(outPath, `${JSON.stringify(output, null, 2)}\n`, 'utf8');
console.log(`Wrote ${outPath}`);
console.log(`Heritages: ${heritages.length}, traits: ${traits.length}`);
