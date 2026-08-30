#!/usr/bin/env node
/**
 * Auditoria Grim Hollow Cap. 2 (subclasses).
 * Uso: node scripts/audit-ghpg-cap2.mjs [apiBaseUrl]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const CITATION = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes';
const extractPath = extracts.grimHollow.cap2Subclasses;

if (!fs.existsSync(extractPath)) {
  console.error(`Extract ausente: ${extractPath}`);
  process.exit(1);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));

loadEnv();
const apiBase = (process.argv[2] ?? process.env.SMOKE_URL ?? '').replace(/\/$/, '');
const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

const expectedSubs = extract.subclasses.map((s) => s.slug).sort();
const expectedFeatures = extract.subclasses.reduce((n, s) => n + s.features.length, 0);
const expectedClassFeatures = extract.monsterHunter?.features?.length ?? 0;

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
const totalDbFeatures = dbSubs.rows.reduce((n, r) => n + r.features, 0);
const totalEconomy = dbSubs.rows.reduce((n, r) => n + r.economy_actions, 0);

console.log('=== Grim Hollow Cap. 2 — auditoria ===\n');
console.log(
  `Extract: Monster Hunter ${expectedClassFeatures} class features; ${expectedSubs.length} subclasses, ${expectedFeatures} subclass features`,
);

const mhRow = await client.query(
  `SELECT c.slug,
    (SELECT COUNT(*)::int FROM rpg.phb_class_feature f WHERE f.class_id = c.id) AS features,
    (SELECT COUNT(*)::int FROM rpg.phb_class_progression p WHERE p.class_id = c.id) AS levels
  FROM rpg.phb_class c
  JOIN rpg.phb_source_citation sc ON sc.id = c.source_citation_id
  WHERE sc.slug = $1 AND c.slug = 'monster-hunter'`,
  [CITATION],
);
if (mhRow.rows[0]) {
  const mh = mhRow.rows[0];
  console.log(
    `DB class monster-hunter: ${mh.features} features, ${mh.levels} levels (expected ${expectedClassFeatures} feat, 20 levels)`,
  );
} else {
  console.log('DB class monster-hunter: AUSENTE');
}

console.log(`DB subclasses: ${dbSlugs.length}, ${totalDbFeatures} features`);
console.log(`Missing: ${missingSubs.length ? missingSubs.join(', ') : 'nenhuma'}`);
console.log(`Features match: ${totalDbFeatures === expectedFeatures ? 'SIM' : 'NÃO'}`);
console.log(`Economy actions: ${totalEconomy} (refino de mesa — seeds C063+)`);

for (const r of dbSubs.rows) {
  console.log(`  ${r.class_slug}/${r.slug}: ${r.features} feat, img=${r.has_image ? 'ok' : '—'}, eco=${r.economy_actions}`);
}

if (apiBase) {
  const res = await fetch(
    `${apiBase}/subclasses?editionSlugs=grim-hollow-players-guide-2024-en&limit=100`,
  );
  const json = await res.json();
  const gh = (json.data ?? []).filter((s) => expectedSubs.includes(s.slug));
  console.log(`\nAPI subclasses GH cap2: ${gh.length}/${expectedSubs.length}`);
}

await client.end();
process.exit(
  missingSubs.length === 0 &&
    totalDbFeatures === expectedFeatures &&
    mhRow.rows[0]?.features === expectedClassFeatures
    ? 0
    : 1,
);
