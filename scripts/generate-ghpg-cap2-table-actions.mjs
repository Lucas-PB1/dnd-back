/**
 * Gera C067 — table actions bulk para subclasses GH Cap. 2 (PHB + fora do piloto MH).
 *
 * Uso: node scripts/generate-ghpg-cap2-table-actions.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';
import { slugify } from './lib/ghpg-html-utils.mjs';
import { translateFeatureName } from './lib/ghpg-cap2-feature-names-pt.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const outFile = path.join(
  apiRoot,
  'database/seeds/combat/C067_phb_subclass_table_action_grim_hollow_cap2_bulk.sql',
);

const SKIP_SUBCLASS_SLUGS = new Set([
  'carver-guild',
  'devourer-guild',
  'occultist-guild',
  'trapper-guild',
]);

/** table_action → free_resource_slug quando a economy gasta pool. */
const RESOURCE_BY_TABLE_ACTION = {
  'consume-portion': 'devourer-portion',
  'grave-strike': 'grave-strike',
  'blood-for-blood': 'sangromancy-dice',
};

function sqlStr(s) {
  return String(s ?? '').replace(/'/g, "''");
}

function buildRows(extract) {
  const rows = [];
  const seen = new Set();

  for (const sc of extract.subclasses) {
    if (sc.classSlug === 'monster-hunter' || SKIP_SUBCLASS_SLUGS.has(sc.slug)) continue;

    for (const feat of sc.features) {
      const economies = feat.actionEconomy ?? [];
      if (!economies.length) continue;

      const featSlug = slugify(feat.name);
      const multi = economies.length > 1;

      for (const economy of economies) {
        const tableAction =
          multi && economy !== economies[0] ? `${featSlug}-${economy}` : featSlug;
        const dedupe = `${sc.slug}:${tableAction}`;
        if (seen.has(dedupe)) continue;
        seen.add(dedupe);

        const resource = RESOURCE_BY_TABLE_ACTION[tableAction] ?? null;
        rows.push({
          subclassSlug: sc.slug,
          slug: tableAction,
          name: translateFeatureName(feat.name),
          level: feat.level,
          freeResourceSlug: resource,
          alwaysSpendsPool: Boolean(resource),
        });
      }
    }
  }

  // Sangromante — economy manual (sem keywords no extract)
  for (const manual of [
    {
      subclassSlug: 'sangromancer',
      slug: 'blood-for-blood',
      name: 'Sangue por Sangue',
      level: 10,
      freeResourceSlug: 'sangromancy-dice',
      alwaysSpendsPool: true,
    },
    {
      subclassSlug: 'sangromancer',
      slug: 'red-renewal',
      name: 'Renovação Rubra',
      level: 14,
      freeResourceSlug: null,
      alwaysSpendsPool: false,
    },
  ]) {
    const dedupe = `${manual.subclassSlug}:${manual.slug}`;
    if (!seen.has(dedupe)) {
      seen.add(dedupe);
      rows.push(manual);
    }
  }

  rows.sort(
    (a, b) =>
      a.subclassSlug.localeCompare(b.subclassSlug) ||
      a.level - b.level ||
      a.slug.localeCompare(b.slug),
  );
  return rows;
}

function renderSql(rows) {
  const lines = [
    '-- Table actions — Grim Hollow Cap. 2 (bulk PHB subclasses + Sangromante)',
    `-- Gerado por generate-ghpg-cap2-table-actions.mjs — ${rows.length} ações`,
    '',
    'INSERT INTO rpg.phb_subclass_table_action (',
    '  subclass_id, slug, name, unlock_level, free_resource_slug,',
    '  always_spends_pool, rolls_pool_die, spends_only_on_success, always_pool_cost, repeat_pool_cost',
    ') VALUES',
  ];

  const values = rows.map((r, i) => {
    const comma = i < rows.length - 1 ? ',' : '';
    const resource = r.freeResourceSlug
      ? `'${sqlStr(r.freeResourceSlug)}'`
      : 'NULL';
    return `  ((SELECT id FROM rpg.phb_subclass WHERE slug = '${sqlStr(r.subclassSlug)}'), '${sqlStr(r.slug)}', '${sqlStr(r.name)}', ${r.level}, ${resource}, ${r.alwaysSpendsPool}, false, false, NULL, NULL)${comma}`;
  });

  lines.push(...values);
  lines.push(`ON CONFLICT (subclass_id, slug) DO UPDATE SET
  name = EXCLUDED.name,
  unlock_level = EXCLUDED.unlock_level,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_pool = EXCLUDED.always_spends_pool;
`);
  lines.push('');
  return `${lines.join('\n')}`;
}

const enPath = extracts.grimHollow.cap2SubclassesEn;
const extract = JSON.parse(
  fs.readFileSync(
    fs.existsSync(enPath) ? enPath : extracts.grimHollow.cap2Subclasses,
    'utf8',
  ),
);
const rows = buildRows(extract);
fs.writeFileSync(outFile, renderSql(rows), 'utf8');
console.log(`wrote ${path.relative(apiRoot, outFile)} (${rows.length} table actions)`);
