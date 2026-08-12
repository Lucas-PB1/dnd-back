/**
 * Gera seed Cap. 5 Northlands — 86 itens mágicos → N029.
 * Uso: node scripts/gen-northlands-cap5-magic-item-seeds.mjs
 *
 * Fonte: docs/source/northlands-cap5-extract.json
 * Overlay opcional PT: docs/source/northlands-cap5-magic-items-pt.json
 *   { "slug": { "name": "...", "description": "...", "header": "..." } }
 */
import fs from 'fs';

const JSON_PATH = 'docs/source/northlands-cap5-extract.json';
const PT_PATH = 'docs/source/northlands-cap5-magic-items-pt.json';
const OUT = 'database/seeds/northlands-heroes/N029_phb_item_magic_northlands.sql';
const CITATION = 'northlands-heroes-2024-en:magic-and-miscellany';

const RARITY_MAP = {
  Common: { rarity: 'common', rarityLabel: 'Comum' },
  Uncommon: { rarity: 'uncommon', rarityLabel: 'Incomum' },
  Rare: { rarity: 'rare', rarityLabel: 'Raro' },
  'Very Rare': { rarity: 'very-rare', rarityLabel: 'Muito Raro' },
  Legendary: { rarity: 'legendary', rarityLabel: 'Lendário' },
  Fabled: { rarity: 'fabled', rarityLabel: 'Fabuloso' },
  Artifact: { rarity: 'artifact', rarityLabel: 'Artefato' },
};

const RARITY_VALUE_GP = {
  common: 100,
  uncommon: 400,
  rare: 4000,
  'very-rare': 40000,
  legendary: 200000,
};

const SOURCE = {
  magic: true,
  source: 'northlands-heroes',
  editionSlug: 'northlands-heroes-2024-en',
  citationSlug: CITATION,
};

function sqlStr(s) {
  if (s == null) return 'NULL';
  return `'${String(s).replace(/'/g, "''")}'`;
}

function sqlJsonb(obj) {
  return `${sqlStr(JSON.stringify(obj))}::jsonb`;
}

function formatCostGp(gp) {
  if (!Number.isFinite(gp) || gp <= 0) return null;
  return { text: `${Math.round(gp)} PO` };
}

/** Primeira linha do body = header de categoria/raridade. */
function splitHeaderBody(body) {
  const text = String(body ?? '').trim();
  const nl = text.indexOf('\n');
  if (nl < 0) return { header: text, description: '' };
  return {
    header: text.slice(0, nl).trim(),
    description: text.slice(nl).replace(/^\n+/, '').trim(),
  };
}

function parseCategory(header) {
  // "Wondrous Item, Legendary (...)" | "Weapon (Longsword), Fabled (...)"
  let depth = 0;
  for (let i = 0; i < header.length; i++) {
    const ch = header[i];
    if (ch === '(' || ch === '[') depth++;
    else if (ch === ')' || ch === ']') depth = Math.max(0, depth - 1);
    else if (ch === ',' && depth === 0) {
      return {
        category: header.slice(0, i).trim(),
        rest: header.slice(i + 1).trim(),
      };
    }
  }
  return { category: header.trim(), rest: '' };
}

function itemTypeFromCategory(category) {
  const c = category.trim();
  if (
    /^Weapon\b/i.test(c) ||
    /^Javelin\b/i.test(c) ||
    /^Ammunition\b/i.test(c) ||
    /^Arma\b/i.test(c) ||
    /^Azagaia\b/i.test(c)
  )
    return 'weapon';
  if (
    /^Armor\b/i.test(c) ||
    /^Round Shield\b/i.test(c) ||
    /^Shield\b/i.test(c) ||
    /^Armadura\b/i.test(c) ||
    /^Escudo\b/i.test(c)
  )
    return 'armor';
  if (/^Potion\b/i.test(c) || /^Po[cç][aã]o\b/i.test(c)) return 'gear';
  return 'other';
}

function isConsumable(category) {
  if (/^Potion\b/i.test(category) || /^Po[cç][aã]o\b/i.test(category))
    return true;
  if (/Ammunition|Muni[cç][aã]o/i.test(category)) return true;
  return false;
}

function costFor(rarityKey, category) {
  if (
    rarityKey === 'fabled' ||
    rarityKey === 'artifact' ||
    rarityKey === 'varies'
  ) {
    return null;
  }
  const base = RARITY_VALUE_GP[rarityKey];
  if (base == null) return null;
  if (isConsumable(category)) return formatCostGp(base / 2);
  return formatCostGp(base);
}

function mapRarity(item) {
  const header = splitHeaderBody(item.body).header;
  if (/Rarity varies|Raridade varia/i.test(header)) {
    return { rarity: 'varies', rarityLabel: 'Raridade Variável' };
  }
  const raw = (item.rarity ?? '').trim();
  const mapped = RARITY_MAP[raw];
  if (mapped) return mapped;
  const { rest } = parseCategory(header);
  for (const [k, v] of Object.entries(RARITY_MAP)) {
    if (new RegExp(`\\b${k}\\b`, 'i').test(rest)) return v;
  }
  return { rarity: 'unknown', rarityLabel: raw || null };
}

function buildProperties(item, header, category, rarityInfo) {
  const requiresAttunement = Boolean(
    item.requiresAttunement ||
      /Requires Attunement|Requer Sintonia/i.test(header),
  );
  const props = {
    ...SOURCE,
    category,
    rarity: rarityInfo.rarity,
    rarityLabel: rarityInfo.rarityLabel,
    requiresAttunement,
    header,
  };
  const attuneNote = header.match(/\(Requer Sintonia[^)]*\)/i)?.[0];
  if (attuneNote) {
    props.attunement = attuneNote.replace(/^\(|\)$/g, '');
  } else if (requiresAttunement) {
    props.attunement = 'Requer Sintonia';
  }

  const subtype = category.match(/\((.+)\)/) || category.match(/\[(.+)\]/);
  if (subtype) {
    if (/^Weapon\b|^Arma\b|^Javelin\b|^Azagaia\b/i.test(category)) {
      props.weaponSubtype = subtype[1];
    }
    if (/^Armor\b|^Armadura\b/i.test(category)) {
      props.armorSubtype = subtype[1];
    }
    if (/^Potion\b|^Po[cç][aã]o\b/i.test(category)) {
      props.potionSubtype = subtype[1];
    }
  }
  if (/^Round Shield\b|^Escudo Redondo\b/i.test(category)) {
    props.armorSubtype = 'Escudo Redondo';
  }
  if (/^Javelin\b|^Azagaia\b/i.test(category) && !props.weaponSubtype) {
    props.weaponSubtype = 'Azagaia';
  }
  return props;
}

function loadPt() {
  if (!fs.existsSync(PT_PATH)) return {};
  return JSON.parse(fs.readFileSync(PT_PATH, 'utf8'));
}

const data = JSON.parse(fs.readFileSync(JSON_PATH, 'utf8'));
const items = data.magicItems ?? [];
const pt = loadPt();
const ptCount = Object.keys(pt).length;

const lines = [];
lines.push('-- Itens mágicos Northlands Cap. 5 (Magic and Miscellany)');
lines.push(
  `-- Gerado por scripts/gen-northlands-cap5-magic-item-seeds.mjs — ${
    ptCount
      ? `textos PT (overlay ${PT_PATH}, ${ptCount} slugs)`
      : 'textos EN da fonte; overlay PT opcional'
  }.`,
);
lines.push(`-- Fonte: ${CITATION}`);
lines.push('');

let emitted = 0;
for (const item of items) {
  const { header: headerEn, description: descEn } = splitHeaderBody(item.body);
  const { category: categoryEn } = parseCategory(headerEn);
  const rarityInfo = mapRarity(item);
  const overlay = pt[item.slug] ?? {};
  const name = overlay.name ?? item.name;
  const description = overlay.description ?? descEn;
  const header = overlay.header ?? headerEn;
  const { category } = parseCategory(header);
  const itemType = itemTypeFromCategory(categoryEn);
  const cost = costFor(rarityInfo.rarity, categoryEn);
  const props = buildProperties(item, header, category, rarityInfo);

  lines.push(`INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  ${sqlStr(item.slug)},
  ${sqlStr(itemType)}::rpg.item_type,
  ${sqlStr(name)},
  ${cost ? sqlJsonb(cost) : 'NULL'},
  NULL,
  ${sqlStr(description)},
  ${sqlJsonb(props)}
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
`);
  emitted += 1;
}

fs.writeFileSync(OUT, lines.join('\n'));
console.log('wrote', OUT, 'items', emitted, ptCount ? `(PT ${ptCount})` : '(EN)');
