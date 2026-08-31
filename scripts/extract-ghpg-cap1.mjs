/**
 * Extrai Cap. 1 (Heritages & Traits) do Grim Hollow Player's Guide.
 * Uso: node scripts/extract-ghpg-cap1.mjs
 */
import fs from 'fs';
import path from 'path';
import { extracts, scrap, scrapes, findScrapeHtml } from './lib/docs-source.mjs';
import { canonicalAnchorId } from './lib/ghpg-cap1-anchor.mjs';

const outPath = extracts.grimHollow.cap1Heritages;

const htmlPath =
  findScrapeHtml(scrapes.grimHollow, 'Chapter 1') ??
  findScrapeHtml(scrap.grimHollow, 'Chapter 1');

if (!htmlPath) {
  console.error(
    'HTML Cap. 1 GHPG não encontrado em docs/source/_scrapes/grim-hollow nem docs/source/scrap',
  );
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
  common: 'Variante comum',
  rare: 'Variante rara',
  eldritch: 'Variante eldritch',
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
  const singular =
    TRADITIONAL_TRAIT_SIDEBAR_ID[heritageName] ?? heritageName.replace(/s$/, '');
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
      groups[key].push({
        anchorId: canonicalAnchorId(lm[1]),
        name: stripTags(lm[2]),
      });
    }
    const plainLi = chunk.matchAll(/<li>\s*<a[^>]*#([^"]+)"[^>]*>([\s\S]*?)<\/a>/gi);
    for (const lm of plainLi) {
      const anchorId = canonicalAnchorId(lm[1]);
      const name = stripTags(lm[2]);
      if (!groups[key].some((t) => t.anchorId === anchorId)) {
        groups[key].push({ anchorId, name });
      }
    }
  }

  return groups;
}

function mergeTraitMapEntries(traitMap) {
  const merged = new Map();
  for (const entry of traitMap.values()) {
    const key = canonicalAnchorId(entry.anchorId);
    const existing = merged.get(key);
    if (!existing) {
      merged.set(key, { ...entry, anchorId: key });
      continue;
    }
    if (entry.description.length > existing.description.length) {
      merged.set(key, { ...entry, anchorId: key });
    }
  }
  return merged;
}
function parseTraitDefinitions() {
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
    void name;
    void paragraphs;
    void category;
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
      benefitBase: null,
      benefitImproved: null,
      maxTakes: null,
      takeMode: 'stack',
    });
  }

  for (const pm of html.matchAll(/<a[^>]*#([A-Za-z]+(?:Combat|Exploration|Roleplaying))"[^>]*>([^<]+)<\/a>\s*→\s*([^<]+)/gi)) {
    const raw = pm[1];
    const entry =
      traitMap.get(raw) ??
      [...traitMap.values()].find((t) => canonicalAnchorId(t.anchorId) === canonicalAnchorId(raw));
    if (entry) entry.improvedName = stripTags(pm[3]);
  }

  const merged = mergeTraitMapEntries(traitMap);
  for (const entry of merged.values()) {
    enrichTraitMetadata(entry);
  }

  return [...merged.values()].sort((a, b) => a.name.localeCompare(b.name));
}

function splitBenefitParagraphs(description) {
  const parts = String(description ?? '')
    .split(/\n\n+/)
    .map((p) => p.trim())
    .filter(Boolean);
  return {
    benefitBase: parts[0] ?? '',
    benefitImproved: parts.length > 1 ? parts.slice(1).join('\n\n') : null,
  };
}

function inferMaxTakes(description, improvedName) {
  const text = String(description ?? '');
  if (/take this trait multiple times/i.test(text)) return null;
  if (/take this trait twice/i.test(text) || improvedName) return 2;
  return 1;
}

function inferTakeMode(description) {
  const text = String(description ?? '');
  if (/take this trait multiple times/i.test(text)) {
    if (/new tool each time|new breath weapon each time|each time you take/i.test(text)) {
      return 'choice_each_take';
    }
  }
  return 'stack';
}

function enrichTraitMetadata(entry) {
  const { benefitBase, benefitImproved } = splitBenefitParagraphs(entry.description);
  entry.benefitBase = benefitBase;
  entry.benefitImproved = benefitImproved;
  entry.maxTakes = inferMaxTakes(entry.description, entry.improvedName);
  entry.takeMode = inferTakeMode(entry.description);
}

function feetToMeters(text) {
  return text.replace(/(\d+)\s*feet/gi, (_, n) => {
    const m = (Number(n) * 0.3).toFixed(1).replace(/\.0$/, '');
    return `${m} m`;
  });
}

const HERITAGE_TRADITIONAL_FALLBACK = {
  Dwarves: {
    combat: [
      { anchorId: 'DamageResistanceCombat', name: 'Damage Resistance' },
      { anchorId: 'ToughnessCombat', name: 'Toughness' },
      { anchorId: 'WeaponAptitudeCombat', name: 'Weapon Aptitude' },
    ],
    exploration: [
      { anchorId: 'DarkvisionExploration', name: 'Darkvision' },
      { anchorId: 'PoisonResilienceExploration', name: 'Poison Resilience' },
      { anchorId: 'SteadyExploration', name: 'Steady' },
    ],
    roleplaying: [
      { anchorId: 'ArtisanalFocusRoleplaying', name: 'Artisanal Focus' },
      { anchorId: 'CraftersEyeRoleplaying', name: "Crafter's Eye" },
    ],
  },
  Elves: {
    combat: [
      { anchorId: 'AwakenedMindCombat', name: 'Awakened Mind' },
      { anchorId: 'FocusedMindCombat', name: 'Focused Mind' },
      { anchorId: 'WeaponAptitudeCombat', name: 'Weapon Aptitude' },
    ],
    exploration: [
      { anchorId: 'DarkvisionExploration', name: 'Darkvision' },
      { anchorId: 'MeditativeRestExploration', name: 'Meditative Rest' },
      { anchorId: 'ShroudoftheWildExploration', name: 'Shroud of the Wild' },
    ],
    roleplaying: [
      { anchorId: 'InbornPerceptionRoleplaying', name: 'Inborn Perception' },
      {
        anchorId: 'MagicalSavvyRoleplaying',
        name: 'Magical Savvy (any cantrip)',
      },
    ],
  },
};

const TRADITIONAL_TRAIT_SIDEBAR_ID = {
  Dragonborn: 'Dragonborn',
  Dwarves: 'Dwarf',
  Elves: 'Elf',
  Gnomes: 'Gnome',
  Halflings: 'Halfling',
  Humans: 'Human',
  Dreamer: 'Dreamer',
  Grudgel: 'Grudgel',
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

const HERITAGE_NAME_EN = {
  Dragonborn: 'Dragonborn',
  Dwarves: 'Dwarf',
  Elves: 'Elf',
  Gnomes: 'Gnome',
  Halflings: 'Halfling',
  Humans: 'Human',
  Dreamer: 'Dreamer',
  Grudgel: 'Grudgel',
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

function poundsToKg(text) {
  return text
    .replace(/averaging almost (\d+) pounds/gi, (_, n) => {
      const kg = Number(n) * 0.5;
      return `com cerca de ${kg} kg em média`;
    })
    .replace(/average about (\d+) pounds/gi, (_, n) => {
      const kg = Number(n) * 0.5;
      return `cerca de ${kg} kg em média`;
    })
    .replace(/about (\d+) pounds/gi, (_, n) => {
      const kg = Number(n) * 0.5;
      return `cerca de ${kg} kg`;
    })
    .replace(/(\d+)\s*pounds?/gi, (_, n) => {
      const kg = Number(n) * 0.5;
      return `${kg} kg`;
    });
}

function localizeBaseTrait(text) {
  let t = feetToMeters(text);
  t = poundsToKg(t);
  t = t.replace(/\bMedium\b/g, 'Médio');
  t = t.replace(/\bSmall\b/g, 'Pequeno');
  t = t.replace(/\bLarge\b/g, 'Grande');
  t = t.replace(/\b5 feet\b/gi, '1,5 m');
  t = t.replace(/\b4 and 5 feet\b/gi, '1,2 m a 1,5 m');
  t = t.replace(/\bunder 5\b/gi, 'menos de 1,5 m');
  t = t.replace(/\bover 6 feet\b/gi, 'mais de 1,8 m');
  t = t.replace(/\b30 feet\b/gi, '9 m');
  t = t.replace(/\b5 feet\b/gi, '1,5 m');
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
    const traditionalRaw = parseTraditionalSidebar(block, name);
    const fallback = HERITAGE_TRADITIONAL_FALLBACK[name];
    const traditionalTotal =
      (traditionalRaw.combat?.length ?? 0) +
      (traditionalRaw.exploration?.length ?? 0) +
      (traditionalRaw.roleplaying?.length ?? 0);
    const traditional =
      traditionalTotal === 0 && fallback ? fallback : traditionalRaw;
    const imageFile = extractImageFile(block);

    let size = 'Médio';
    let speed = '9 m';
    for (const t of baseTraits) {
      if (/^Size/i.test(t.name)) size = localizeBaseTrait(t.description.replace(/^Size\.\s*/i, ''));
      if (/^Speed/i.test(t.name)) speed = localizeBaseTrait(t.description.replace(/^Speed\.\s*/i, ''));
    }

    heritages.push({
      slug: HERITAGE_SLUG[name],
      nameEn: HERITAGE_NAME_EN[name] ?? name,
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
