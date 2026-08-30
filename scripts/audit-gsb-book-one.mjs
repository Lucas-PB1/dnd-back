#!/usr/bin/env node
/**
 * Auditoria Griffon's Saddlebag Book One Part II.
 * Uso: node scripts/audit-gsb-book-one.mjs [apiBaseUrl]
 */
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiBase = (process.argv[2] ?? process.env.SMOKE_URL ?? '').replace(/\/$/, '');
const CITATION = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options';

const extract = JSON.parse(
  fs.readFileSync(
    path.join(__dirname, '../docs/source/extracts/griffons-saddlebag/book-one-part-ii.json'),
    'utf8',
  ),
);

loadEnv();
const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

const expectedSubs = extract.subclasses.map((s) => s.slug).sort();
const expectedFeatures = extract.subclasses.reduce((n, s) => n + s.features.length, 0);

const dbSubs = await client.query(
  `SELECT s.slug, c.slug AS class_slug,
    (SELECT COUNT(*)::int FROM rpg.phb_subclass_feature f WHERE f.subclass_id = s.id) AS features,
    (SELECT COUNT(*)::int FROM rpg.phb_class_economy_action e WHERE e.subclass_id = s.id) AS economy_actions,
    s.image_url IS NOT NULL AS has_image
  FROM rpg.phb_subclass s
  JOIN rpg.phb_class c ON c.id = s.class_id
  JOIN rpg.phb_source_citation sc ON sc.id = s.source_citation_id
  WHERE sc.slug = $1
  ORDER BY c.slug, s.slug`,
  [CITATION],
);

const dbSlugs = dbSubs.rows.map((r) => r.slug).sort();
const missingSubs = expectedSubs.filter((s) => !dbSlugs.includes(s));
const extraSubs = dbSlugs.filter((s) => !expectedSubs.includes(s));
const totalDbFeatures = dbSubs.rows.reduce((n, r) => n + r.features, 0);
const totalEconomy = dbSubs.rows.reduce((n, r) => n + r.economy_actions, 0);
const EXPECTED_ECONOMY_BY_SUBCLASS = {
  'path-of-the-glacier': 5,
  'college-of-choreography': 3,
  'astral-domain': 3,
  'the-unbroken-circle': 1,
  'couatl-herald': 4,
  'warrior-of-the-celestial': 3,
  'oath-of-the-hearth': 2,
  'winter-trapper': 2,
  'runetagger': 4,
  'frost-sorcery': 3,
  'astral-griffon-patron': 3,
  'materializer': 4,
};
const EXPECTED_ECONOMY_TOTAL = Object.values(EXPECTED_ECONOMY_BY_SUBCLASS).reduce(
  (n, v) => n + v,
  0,
);

const fe = await client.query(
  `SELECT sp.slug,
    (SELECT COUNT(*)::int FROM rpg.phb_species_trait t WHERE t.species_id = sp.id) AS traits,
    (SELECT COUNT(*)::int FROM rpg.v_phb_species_trait_choices v WHERE v.species_slug = sp.slug) AS trait_choices,
    sp.image_url IS NOT NULL AS has_image
  FROM rpg.phb_species sp
  WHERE sp.slug = 'feathren'
    AND sp.source_meta->>'citationSlug' = $1`,
  [CITATION],
);

const spells = await client.query(
  `SELECT COUNT(*)::int AS n FROM rpg.phb_spell sp
   JOIN rpg.phb_source_citation sc ON sc.id = sp.source_citation_id
   WHERE sc.slug = $1`,
  [CITATION],
);

const prepared = await client.query(
  `SELECT COUNT(*)::int AS n FROM rpg.phb_subclass_prepared_spell pps
   JOIN rpg.phb_subclass s ON s.id = pps.subclass_id
   JOIN rpg.phb_source_citation sc ON sc.id = s.source_citation_id
   WHERE sc.slug = $1`,
  [CITATION],
);

const actionFeatures = [];
for (const sc of extract.subclasses) {
  for (const f of sc.features) {
    const d = f.description.toLowerCase();
    if (
      /bonus action|magic action|reaction|as an action|no action required|action economy/.test(
        d,
      )
    ) {
      actionFeatures.push({ subclass: sc.slug, level: f.level, name: f.name });
    }
  }
}

console.log('=== Griffon\'s Saddlebag Book One — auditoria ===\n');
console.log(`Extract: ${expectedSubs.length} subclasses, ${expectedFeatures} features`);
console.log(`DB:      ${dbSlugs.length} subclasses, ${totalDbFeatures} features`);
console.log(`Missing subclasses: ${missingSubs.length ? missingSubs.join(', ') : 'nenhuma'}`);
console.log(`Extra subclasses:     ${extraSubs.length ? extraSubs.join(', ') : 'nenhuma'}`);
console.log(`Features match: ${totalDbFeatures === expectedFeatures ? 'SIM' : 'NÃO'}`);
console.log(`Feathren: traits=${fe.rows[0]?.traits ?? 0} choices=${fe.rows[0]?.trait_choices ?? 0} image=${fe.rows[0]?.has_image ? 'sim' : 'não'}`);
console.log(`Extract avian/feline tables: ${extract.species.avianAncestry.length}/${extract.species.felineAncestry.length} (vazio no JSON; opções estão em R007)`);
console.log(`Spells GSB: ${spells.rows[0].n} (R008 tem 15)`);
console.log(`Prepared spell links: ${prepared.rows[0].n}`);
console.log(`\nEconomy actions (phb_class_economy_action): ${totalEconomy}/${EXPECTED_ECONOMY_TOTAL}`);
if (totalEconomy < EXPECTED_ECONOMY_TOTAL) {
  console.log('  ⚠ incompleto — seeds R010–R011 + C057–C062');
}
console.log(`Features com texto de economia de ação no extract: ${actionFeatures.length}`);

console.log('\nPor subclasse:');
for (const r of dbSubs.rows) {
  const expected = EXPECTED_ECONOMY_BY_SUBCLASS[r.slug] ?? 0;
  const ecoOk = r.economy_actions === expected;
  const flag = ecoOk ? '' : ` ⚠ economy ${r.economy_actions}/${expected}`;
  console.log(`  ${r.class_slug}/${r.slug}: ${r.features} feat, img=${r.has_image ? 'ok' : '—'}${flag}`);
}

if (apiBase) {
  console.log(`\nAPI ${apiBase}`);
  const res = await fetch(
    `${apiBase}/subclasses?editionSlugs=griffons-saddlebag-book-one-2024-en&limit=50`,
  );
  const json = await res.json();
  const apiCount = json.data?.length ?? 0;
  console.log(`  subclasses: ${apiCount} ${apiCount === 12 ? '✓' : '✗'}`);
}

await client.end();
const economyOk = dbSubs.rows.every(
  (r) => r.economy_actions === (EXPECTED_ECONOMY_BY_SUBCLASS[r.slug] ?? 0),
);
process.exit(
  missingSubs.length === 0 &&
    totalDbFeatures === expectedFeatures &&
    (fe.rows[0]?.traits ?? 0) >= 5 &&
    economyOk
    ? 0
    : 1,
);
