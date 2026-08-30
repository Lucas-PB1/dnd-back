/**
 * Gera seeds de combate C066+ (economy actions) para subclasses GH Cap. 2
 * fora do piloto Caçador de Monstros (C063–C065).
 *
 * Requer: docs/source/extracts/grim-hollow/cap2-subclasses.json
 * Uso: node scripts/generate-ghpg-cap2-combat-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';
import { slugify } from './lib/ghpg-html-utils.mjs';
import { translateGhpgProse } from './lib/ghpg-mechanical-glossary.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const extractPath = extracts.grimHollow.cap2Subclasses;
const outFile = path.join(
  apiRoot,
  'database/seeds/combat/C066_phb_class_economy_action_grim_hollow_cap2_bulk.sql',
);

/** Subclasses com economy curada manualmente em C063/C064. */
const SKIP_SUBCLASS_SLUGS = new Set([
  'carver-guild',
  'devourer-guild',
  'occultist-guild',
  'trapper-guild',
]);

const CLASS_SORT_BASE = {
  barbarian: 300,
  bard: 310,
  cleric: 320,
  druid: 330,
  fighter: 340,
  monk: 350,
  paladin: 360,
  ranger: 370,
  rogue: 380,
  sorcerer: 390,
  warlock: 400,
  wizard: 410,
};

const ECONOMY_ORDER = { reaction: 1, bonus: 2, action: 3, free: 4 };

const ECONOMY_PREFIX = {
  bonus: 'AB',
  reaction: 'Reação',
  action: 'Ação',
  free: 'Livre',
};

const ECONOMY_SUFFIX = {
  bonus: ' (AB)',
  reaction: ' (Reação)',
  action: ' (Ação)',
  free: ' (Livre)',
};

function sqlStr(s) {
  return String(s ?? '').replace(/'/g, "''");
}

function firstSentence(text, max = 140) {
  const t = String(text ?? '').replace(/\s+/g, ' ').trim();
  const m = t.match(/^(.+?[.!?])(?:\s|$)/);
  const sentence = (m ? m[1] : t).trim();
  return sentence.length > max ? `${sentence.slice(0, max - 1)}…` : sentence;
}

function buildSummary(economy, description) {
  const prefix = ECONOMY_PREFIX[economy] ?? economy;
  const body = firstSentence(description, 120);
  return `${prefix}: ${body}`.slice(0, 200);
}

function buildActionId(classSlug, subclassSlug, featSlug, economy, used) {
  let base = `gh-${classSlug}-${subclassSlug}-${featSlug}`;
  if (economy !== 'action') base += `-${economy}`;
  let id = base;
  let n = 2;
  while (used.has(id)) {
    id = `${base}-${n}`;
    n += 1;
  }
  used.add(id);
  return id;
}

function buildRows(extract) {
  const rows = [];
  const usedIds = new Set();

  for (const sc of extract.subclasses) {
    if (sc.classSlug === 'monster-hunter' || SKIP_SUBCLASS_SLUGS.has(sc.slug)) continue;

    for (const feat of sc.features) {
      const economies = feat.actionEconomy ?? [];
      if (!economies.length) continue;

      const featSlug = slugify(feat.name);
      const namePt = translateGhpgProse(feat.name);
      const descPt = translateGhpgProse(feat.description);
      const multi = economies.length > 1;

      for (const economy of economies) {
        const displayName =
          multi && economy !== economies[0]
            ? `${namePt}${ECONOMY_SUFFIX[economy] ?? ` (${economy})`}`
            : namePt;
        const tableAction =
          multi && economy !== economies[0] ? `${featSlug}-${economy}` : featSlug;
        const sortBase = CLASS_SORT_BASE[sc.classSlug] ?? 500;
        const sortOrder =
          sortBase + feat.level * 5 + (ECONOMY_ORDER[economy] ?? 9);

        rows.push({
          actionId: buildActionId(sc.classSlug, sc.slug, featSlug, economy, usedIds),
          classSlug: sc.classSlug,
          subclassSlug: sc.slug,
          name: displayName,
          economy,
          level: feat.level,
          summary: buildSummary(economy, descPt),
          description: descPt,
          tableAction,
          sortOrder,
        });
      }
    }
  }

  rows.sort(
    (a, b) =>
      a.sortOrder - b.sortOrder ||
      a.subclassSlug.localeCompare(b.subclassSlug) ||
      a.level - b.level,
  );
  return rows;
}

function renderSql(rows) {
  const lines = [
    '-- Economy actions — Grim Hollow Cap. 2 (bulk: 36 subclasses PHB)',
    `-- Gerado por generate-ghpg-cap2-combat-seeds.mjs — ${rows.length} ações`,
    '',
    'INSERT INTO rpg.phb_class_economy_action (',
    '  action_id, class_id, subclass_id, name, economy, unlock_level,',
    '  resource_slug, free_resource_slug, always_spends_resource,',
    '  summary, description, table_action, spend_amount, sort_order',
    ') VALUES',
  ];

  const valueLines = rows.map((r, i) => {
    const comma = i < rows.length - 1 ? ',' : '';
    return `(
  '${sqlStr(r.actionId)}',
  (SELECT id FROM rpg.phb_class WHERE slug = '${sqlStr(r.classSlug)}'),
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${sqlStr(r.subclassSlug)}'),
  '${sqlStr(r.name)}',
  '${r.economy}'::rpg.action_economy_bucket,
  ${r.level},
  NULL,
  NULL,
  false,
  '${sqlStr(r.summary)}',
  '${sqlStr(r.description)}',
  '${sqlStr(r.tableAction)}',
  NULL,
  ${r.sortOrder}
)${comma}`;
  });

  lines.push(...valueLines);
  lines.push(`ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  sort_order = EXCLUDED.sort_order;
`);
  lines.push('');
  return `${lines.join('\n')}`;
}

if (!fs.existsSync(extractPath)) {
  console.error(`Extract ausente: ${extractPath}`);
  process.exit(1);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const rows = buildRows(extract);
fs.writeFileSync(outFile, renderSql(rows), 'utf8');
console.log(`wrote ${path.relative(apiRoot, outFile)} (${rows.length} economy actions)`);
