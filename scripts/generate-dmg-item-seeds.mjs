/**
 * Reextrai Cap.7 A–Z e gera seed SQL rpg.phb_item (pack dmg).
 * Uso: node scripts/generate-dmg-item-seeds.mjs
 * Fonte: docs/source/extracts/dmg/items-az.txt
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const txtPath = extracts.dmg.itemsAzTxt;
const outJson = extracts.dmg.itemsAz;
const outIndex = extracts.dmg.itemsAzIndex;
const outSql = path.join(__dirname, '../database/seeds/dmg/D010_phb_item.sql');

const CATEGORY_PREFIX =
  /^(Arma|Armadura|Item Maravilhoso|Anel|Bast[aã]o|Cajado|Varinha|Po[cç][aã]o|Pergaminho|Baralho|[OÓ]leo|Escudo|Muni[cç][aã]o)\b/i;

const RARITY_RE =
  /^(Comum|Incomum|Raro|Muito Raro|Muito Rara|Lend[aá]rio|Artefato|Raridade Vari[aá]vel|Raridade Varia)\b/i;

const RARITY_MAP = {
  comum: { rarity: 'common', rarityLabel: 'Comum' },
  incomum: { rarity: 'uncommon', rarityLabel: 'Incomum' },
  raro: { rarity: 'rare', rarityLabel: 'Raro' },
  'muito raro': { rarity: 'very-rare', rarityLabel: 'Muito Raro' },
  'muito rara': { rarity: 'very-rare', rarityLabel: 'Muito Raro' },
  lendário: { rarity: 'legendary', rarityLabel: 'Lendário' },
  lendario: { rarity: 'legendary', rarityLabel: 'Lendário' },
  artefato: { rarity: 'artifact', rarityLabel: 'Artefato' },
  'raridade variável': {
    rarity: 'varies',
    rarityLabel: 'Raridade Variável',
  },
  'raridade varia': { rarity: 'varies', rarityLabel: 'Raridade Variável' },
};

/** DMG 2024 — Magic Item Rarities and Values (valor sugerido). */
const RARITY_VALUE_GP = {
  common: 100,
  uncommon: 400,
  rare: 4000,
  'very-rare': 40000,
  legendary: 200000,
};

const CONSUMABLE_CATEGORY_RE =
  /^(Po[cç][aã]o|[OÓ]leo|Muni[cç][aã]o|Pergaminho)\b/i;

function isConsumableMagicItem(category, name) {
  if (CONSUMABLE_CATEGORY_RE.test(category ?? '')) return true;
  // Ex.: "Arma (Qualquer Munição), …"
  if (/Muni[cç][aã]o/i.test(category ?? '')) return true;
  if (/^municao-/i.test(name ?? '')) return true;
  return false;
}

const SOURCE = {
  magic: true,
  source: 'dmg-2024-pt',
  editionSlug: 'dmg-2024-pt',
  citationSlug: 'dmg-2024-pt:ch7:itens-magicos',
};

function isHeaderLine(line) {
  const t = line.trim();
  if (!CATEGORY_PREFIX.test(t)) return false;
  // "Anel Afastador…" (nome) vs "Anel, Lendário" / "Arma (Adaga), Raro"
  const afterPrefix = t.replace(CATEGORY_PREFIX, '').trim();
  if (!afterPrefix.startsWith('(') && !afterPrefix.startsWith(',')) return false;
  // precisa de raridade reconhecível em algum ponto após a 1ª vírgola de categoria
  const parts = splitCategoryAndRest(t);
  return parts != null && RARITY_RE.test(parts.rarityToken);
}

function splitCategoryAndRest(header) {
  // Encontra a vírgula que separa categoria da raridade, respeitando parênteses.
  let depth = 0;
  for (let i = 0; i < header.length; i++) {
    const ch = header[i];
    if (ch === '(') depth++;
    else if (ch === ')') depth = Math.max(0, depth - 1);
    else if (ch === ',' && depth === 0) {
      const category = header.slice(0, i).trim();
      const rest = header.slice(i + 1).trim();
      const rarityToken = rest.split(/[,(]/)[0].trim();
      return { category, rest, rarityToken };
    }
  }
  return null;
}

function parseHeader(header) {
  const parts = splitCategoryAndRest(header);
  if (!parts) {
    return {
      category: header.trim(),
      rarity: 'unknown',
      rarityLabel: null,
      requiresAttunement: /sintoniza/i.test(header),
      attunement: null,
    };
  }
  const key = parts.rarityToken
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/\s+/g, ' ')
    .trim();
  // remap after stripping accents
  const rarityKey =
    {
      comum: 'comum',
      incomum: 'incomum',
      raro: 'raro',
      'muito raro': 'muito raro',
      'muito rara': 'muito rara',
      lendario: 'lendario',
      artefato: 'artefato',
      'raridade variavel': 'raridade variável',
      'raridade varia': 'raridade varia',
    }[key] ?? key;

  const mapped = RARITY_MAP[rarityKey] ?? {
    rarity: 'unknown',
    rarityLabel: parts.rarityToken,
  };

  const requiresAttunement = /sintoniza/i.test(parts.rest);
  const attunementMatch = parts.rest.match(/\(Requer[^)]+\)/i);
  return {
    category: parts.category,
    ...mapped,
    requiresAttunement,
    attunement: attunementMatch
      ? attunementMatch[0].replace(/^\(|\)$/g, '')
      : requiresAttunement
        ? 'Requer Sintonização'
        : null,
  };
}

function itemTypeFromCategory(category) {
  if (/^Arma\b/i.test(category)) return 'weapon';
  if (/^Armadura\b/i.test(category) || /^Escudo\b/i.test(category))
    return 'armor';
  // Alinha com S031 (Poção de Cura já existe como gear)
  if (/^Po[cç][aã]o\b/i.test(category)) return 'gear';
  return 'other';
}

function formatCostGp(gp) {
  if (!Number.isFinite(gp) || gp <= 0) return null;
  return { text: `${Math.round(gp)} PO` };
}

/**
 * Valor sugerido DMG por raridade.
 * Consumível (poção/óleo/munição/pergaminho nomeado): metade.
 * Artefato / raridade variável / desconhecida / +1|+2|+3: sem preço.
 */
function costForMagicItem(parsed, name, header) {
  const rarity = parsed.rarity;
  if (rarity === 'artifact' || rarity === 'varies' || rarity === 'unknown') {
    return null;
  }
  const headerText = header ?? '';
  if (/\+\s*1.+\+\s*2.+\+\s*3/i.test(headerText) || /\+\s*1.+\+\s*2.+\+\s*3/i.test(name ?? '')) {
    return null;
  }

  const category = parsed.category ?? '';
  if (/^Pergaminho M[aá]gico\b/i.test(name ?? '')) {
    // Sem nível único no catálogo A–Z → null (PHB já tem truque/1º a 2× scribe)
    return null;
  }

  const base = RARITY_VALUE_GP[rarity];
  if (base == null) return null;

  if (isConsumableMagicItem(category, name)) {
    return formatCostGp(base / 2);
  }
  return formatCostGp(base);
}

function slugify(name) {
  return name
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/[''`]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .replace(/-{2,}/g, '-');
}

function sqlString(value) {
  if (value == null) return 'NULL';
  return `'${String(value).replace(/'/g, "''")}'`;
}

function sqlJsonb(obj) {
  return `${sqlString(JSON.stringify(obj))}::jsonb`;
}

function looksLikeCaption(line, itemNames) {
  const t = line.trim();
  if (!t || !t.includes(',')) return false;
  const parts = t.split(',').map((p) => p.trim()).filter(Boolean);
  if (parts.length < 2) return false;
  let hits = 0;
  for (const p of parts) {
    const base = p.replace(/\s*\([^)]*\)\s*$/, '').trim();
    if (itemNames.has(base) || itemNames.has(p)) hits++;
  }
  return hits >= 2;
}

function extractItems(lines) {
  const headerIndexes = [];
  for (let i = 0; i < lines.length; i++) {
    if (isHeaderLine(lines[i])) headerIndexes.push(i);
  }

  const items = [];
  for (let h = 0; h < headerIndexes.length; h++) {
    const hi = headerIndexes[h];
    const header = lines[hi].trim();
    // nome = última linha não vazia antes do header
    let nameIdx = hi - 1;
    while (nameIdx >= 0 && !lines[nameIdx].trim()) nameIdx--;
    if (nameIdx < 0) continue;
    const name = lines[nameIdx].trim();
    if (isHeaderLine(name)) continue;
    if (name.startsWith('♻️') || name.startsWith('??')) continue;
    if (name === 'Itens Mágicos A-Z') continue;
    // evita pegar células de tabela curtas demais / só números
    if (/^\d/.test(name) || name.length < 2) continue;

    // corpo: tudo entre header+1 e o nome do próximo item
    const bodyEnd =
      h + 1 < headerIndexes.length ? headerIndexes[h + 1] - 1 : lines.length;
    const descriptionLines = lines.slice(hi + 1, bodyEnd);

    items.push({
      name,
      header,
      description: descriptionLines.join('\n').trim(),
    });
  }

  const names = new Set(items.map((i) => i.name));
  for (const it of items) {
    const descLines = it.description.split('\n');
    while (
      descLines.length &&
      looksLikeCaption(descLines[descLines.length - 1], names)
    ) {
      descLines.pop();
    }
    it.description = descLines.join('\n').trim();
  }

  return items;
}

function buildProperties(it, parsed) {
  const props = {
    ...SOURCE,
    magic: true,
    category: parsed.category,
    rarity: parsed.rarity,
    rarityLabel: parsed.rarityLabel,
    requiresAttunement: parsed.requiresAttunement,
    header: it.header,
  };
  if (parsed.attunement) props.attunement = parsed.attunement;

  const subtype = parsed.category.match(/\((.+)\)/);
  if (subtype) {
    if (/^Arma\b/i.test(parsed.category)) props.weaponSubtype = subtype[1];
    if (/^Armadura\b/i.test(parsed.category)) props.armorSubtype = subtype[1];
  }
  return props;
}

function main() {
  const lines = fs.readFileSync(txtPath, 'utf8').split(/\r?\n/);
  const items = extractItems(lines);

  const slugCounts = new Map();
  const rows = items.map((it) => {
    const parsed = parseHeader(it.header);
    let slug = slugify(it.name);
    const n = (slugCounts.get(slug) ?? 0) + 1;
    slugCounts.set(slug, n);
    if (n > 1) slug = `${slug}-${n}`;

    return {
      slug,
      item_type: itemTypeFromCategory(parsed.category),
      name: it.name,
      header: it.header,
      description: it.description || null,
      properties: buildProperties(it, parsed),
      cost: costForMagicItem(parsed, it.name, it.header),
      parsed,
    };
  });

  fs.writeFileSync(
    outJson,
    JSON.stringify(
      {
        source: 'DMG 2024 Cap.7 Itens Mágicos A-Z',
        count: rows.length,
        items: rows.map((r) => ({
          slug: r.slug,
          name: r.name,
          header: r.header,
          description: r.description,
        })),
      },
      null,
      2,
    ),
    'utf8',
  );

  const md = [
    '# Itens Mágicos A–Z (DMG 2024)',
    '',
    `Total: **${rows.length}** itens`,
    '',
    '| # | Slug | Nome | Tipo / Raridade |',
    '|---|------|------|-----------------|',
    ...rows.map(
      (r, idx) =>
        `| ${idx + 1} | \`${r.slug}\` | ${r.name} | ${r.header.replace(/\|/g, '/')} |`,
    ),
    '',
  ].join('\n');
  fs.writeFileSync(outIndex, md, 'utf8');

  fs.mkdirSync(path.dirname(outSql), { recursive: true });
  const blocks = [
    '-- Seed DMG 2024 — Itens Mágicos A–Z (Cap. 7)',
    '-- Gerado por scripts/generate-dmg-item-seeds.mjs — não editar à mão',
    `-- Fonte: comunidade DMG 2024 PT; ${rows.length} itens`,
    '-- cost: tabela DMG raridade→PO (consumível ×½; artefato/varies/+1|+2|+3 = NULL)',
    '',
  ];

  for (const r of rows) {
    blocks.push(`INSERT INTO rpg.phb_item (
  slug, item_type, name, cost, weight, description, properties
)
VALUES (
  ${sqlString(r.slug)},
  ${sqlString(r.item_type)}::rpg.item_type,
  ${sqlString(r.name)},
  ${r.cost ? sqlJsonb(r.cost) : 'NULL'},
  NULL,
  ${sqlString(r.description)},
  ${sqlJsonb(r.properties)}
)
ON CONFLICT (slug) DO UPDATE SET
  item_type = EXCLUDED.item_type,
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;
`);
  }

  fs.writeFileSync(outSql, blocks.join('\n'), 'utf8');

  const unknown = rows.filter((r) => r.parsed.rarity === 'unknown');
  const withCost = rows.filter((r) => r.cost != null);
  const withoutCost = rows.filter((r) => r.cost == null);
  console.log('items', rows.length);
  console.log('with cost', withCost.length);
  console.log('without cost', withoutCost.length);
  console.log('unknown rarity', unknown.length);
  if (unknown.length) {
    console.log(
      unknown
        .slice(0, 15)
        .map((u) => `${u.name} | ${u.header}`)
        .join('\n'),
    );
  }
  if (withoutCost.length) {
    console.log(
      'no cost sample:\n' +
        withoutCost
          .slice(0, 20)
          .map((u) => `${u.slug} | ${u.parsed.rarity} | ${u.header}`)
          .join('\n'),
    );
  }
  console.log('wrote', outSql);
}

main();
