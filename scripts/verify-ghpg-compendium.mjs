#!/usr/bin/env node
/**
 * Verifica alinhamento compêndio ↔ dados GH Cap. 2 (DB + API opcional).
 * Uso: node scripts/verify-ghpg-compendium.mjs [apiBaseUrl]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION = `${EDITION}:chapter-2-character-classes`;
const extractPath = extracts.grimHollow.cap2SubclassesEn;

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const expectedSubs = extract.subclasses.map((s) => s.slug).sort();
const expectedFeatures = extract.subclasses.reduce((n, s) => n + s.features.length, 0);

loadEnv();
const apiBase = (process.argv[2] ?? process.env.SMOKE_URL ?? '').replace(/\/$/, '');
const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

let ok = true;
const fail = (msg) => {
  console.log(`✗ ${msg}`);
  ok = false;
};
const pass = (msg) => console.log(`✓ ${msg}`);

console.log('=== Compêndio GH Cap. 2 — verificação ===\n');

const edition = await client.query(
  `SELECT slug, label, book, language FROM rpg.phb_edition WHERE slug = $1`,
  [EDITION],
);
if (!edition.rows[0]) {
  fail(`edição ausente: ${EDITION}`);
} else if (edition.rows[0].language !== 'pt') {
  fail(`edição language=${edition.rows[0].language} (esperado pt)`);
} else {
  pass(`edição ${EDITION} (${edition.rows[0].label})`);
}

const subs = await client.query(
  `SELECT subclass_slug, subclass_name, tagline, summary, edition_slug, image_url, class_slug
   FROM rpg.v_phb_subclass
   WHERE edition_slug = $1
   ORDER BY class_slug, subclass_slug`,
  [EDITION],
);

if (subs.rows.length !== expectedSubs.length) {
  fail(`v_phb_subclass: ${subs.rows.length} subclasses (esperado ${expectedSubs.length})`);
} else {
  pass(`v_phb_subclass: ${expectedSubs.length} subclasses`);
}

const dbSlugs = subs.rows.map((r) => r.subclass_slug).sort();
for (const slug of expectedSubs) {
  if (!dbSlugs.includes(slug)) fail(`subclasse ausente na view: ${slug}`);
}
for (const row of subs.rows) {
  if (!row.image_url) fail(`${row.subclass_slug}: sem image_url`);
  if (!row.tagline?.trim() && !row.summary?.trim()) {
    fail(`${row.subclass_slug}: tagline e summary vazios`);
  }
}
if (subs.rows.every((r) => r.image_url)) {
  pass(`imagens: ${subs.rows.length}/${subs.rows.length}`);
}

let mechTotal = 0;
for (const sc of extract.subclasses) {
  const mech = await client.query(
    `SELECT COUNT(*)::int AS n FROM rpg.v_phb_subclass_mechanics WHERE subclass_slug = $1`,
    [sc.slug],
  );
  const n = mech.rows[0].n;
  mechTotal += n;
  if (n !== sc.features.length) {
    fail(`${sc.slug}: mechanics ${n}/${sc.features.length} features`);
  }
}
if (mechTotal === expectedFeatures) {
  pass(`mechanics: ${mechTotal} features (${expectedFeatures} esperadas)`);
}

const mh = await client.query(
  `SELECT slug, name FROM rpg.phb_class WHERE slug = 'monster-hunter'`,
);
if (!mh.rows[0]) fail('classe monster-hunter ausente');
else pass(`classe ${mh.rows[0].name}`);

const mhSubs = subs.rows.filter((r) => r.class_slug === 'monster-hunter');
if (mhSubs.length !== 4) fail(`guildas MH: ${mhSubs.length} (esperado 4)`);
else pass('guildas MH: 4');

const pngDir = path.join(__dirname, '../public/catalog/subclasses');
let pngCount = 0;
if (fs.existsSync(pngDir)) {
  pngCount = fs.readdirSync(pngDir).filter((f) => f.endsWith('.png')).length;
}
if (pngCount < expectedSubs.length) {
  fail(`PNG em public/catalog/subclasses: ${pngCount}/${expectedSubs.length}`);
} else {
  pass(`PNG locais: ${pngCount}`);
}

await client.end();

if (apiBase) {
  console.log(`\nAPI ${apiBase}`);
  const checks = [
    [
      `/editions`,
      (j) => (j.data ?? j).some?.((e) => e.slug === EDITION) ?? (j.data ?? []).some((e) => e.slug === EDITION),
    ],
    [
      `/subclasses?editionSlugs=${EDITION}&limit=50`,
      (j) => (j.data?.length ?? 0) === expectedSubs.length,
    ],
    [
      `/subclasses/carver-guild`,
      (j) => j.slug === 'carver-guild' && Boolean(j.imageUrl),
    ],
    [
      `/subclasses/carver-guild/mechanics?limit=50`,
      (j) => (j.data?.length ?? 0) === 6,
    ],
    [
      `/classes/monster-hunter/subclasses?editionSlugs=${EDITION}`,
      (j) => (j.data?.length ?? 0) === 4,
    ],
  ];

  for (const [route, check] of checks) {
    try {
      const res = await fetch(`${apiBase}${route}`);
      const json = await res.json();
      const good = res.ok && check(json);
      console.log(`${good ? '✓' : '✗'} ${route}`);
      ok &&= good;
    } catch (e) {
      fail(`API ${route}: ${e.message}`);
    }
  }
} else {
  console.log('\n(API omitida — passe URL ou defina SMOKE_URL)');
}

process.exit(ok ? 0 : 1);
