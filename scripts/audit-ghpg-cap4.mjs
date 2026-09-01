#!/usr/bin/env node
/**
 * Auditoria Grim Hollow Cap. 4 (Character Feats).
 * Compara extract JSON ↔ seed J014 ↔ banco Supabase.
 *
 * Uso: node scripts/audit-ghpg-cap4.mjs
 */
import fs from 'fs';
import path from 'path';
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import { extracts, apiRoot } from './lib/docs-source.mjs';

const CITATION = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats';
const AWP_SLUG = 'advanced-weapon-proficiency';
const extractPath = extracts.grimHollow.cap4Feats;
const seedPath = path.join(
  apiRoot,
  'database/seeds/grim-hollow/J014_phb_feat_ghpg_cap4.sql',
);
const awpSeedPath = path.join(
  apiRoot,
  'database/seeds/grim-hollow/J004_phb_feat_advanced_weapon.sql',
);

if (!fs.existsSync(extractPath)) {
  console.error(`Extract ausente: ${extractPath}`);
  process.exit(1);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const seedSql = fs.readFileSync(seedPath, 'utf8');

/** Slugs no INSERT de phb_feat do J014 */
function parseSeedFeatSlugs(sql) {
  const slugs = [];
  for (const m of sql.matchAll(
    /INSERT INTO rpg\.phb_feat \(slug, name, category[\s\S]*?VALUES\s*([\s\S]*?);\s*INSERT INTO rpg\.phb_feat_benefit/,
  )) {
    for (const row of m[1].matchAll(/'([a-z0-9-]+)',\s*\n\s*'[^']*',\s*\n\s*'([^']+)'/g)) {
      slugs.push({ slug: row[1], category: row[2] });
    }
  }
  // fallback: all slug lines in first INSERT block
  if (!slugs.length) {
    const block = sql.split('INSERT INTO rpg.phb_feat_benefit')[0];
    for (const m of block.matchAll(
      /^\s*'([a-z0-9-]+)',\s*$/gm,
    )) {
      slugs.push({ slug: m[1] });
    }
  }
  return slugs;
}

function parseSeedBenefitCounts(sql) {
  const map = new Map();
  for (const m of sql.matchAll(
    /phb_feat WHERE slug = '([^']+)'\)\s*,\s*(\d+)\s*,/g,
  )) {
    const slug = m[1];
    const order = Number(m[2]);
    map.set(slug, Math.max(map.get(slug) ?? 0, order));
  }
  return map;
}

const seedSlugs = [...new Set(
  [...seedSql.matchAll(/INSERT INTO rpg\.phb_feat \(slug[\s\S]*?'([a-z0-9-]+)',\s*\n/g)].map((m) => m[1]),
)];
// More reliable: match feat slug tuples in VALUES
const seedFeatRows = [];
for (const m of seedSql.matchAll(
  /\(\s*\n\s*'([a-z0-9-]+)',\s*\n\s*'([^']*(?:''[^']*)*)',\s*\n\s*'([^']+)',\s*\n\s*(TRUE|FALSE)/g,
)) {
  seedFeatRows.push({
    slug: m[1],
    name: m[2].replace(/''/g, "'"),
    category: m[3],
    repeatable: m[4] === 'TRUE',
  });
}

const seedBenefitCounts = parseSeedBenefitCounts(seedSql);
const awpSeedSql = fs.existsSync(awpSeedPath) ? fs.readFileSync(awpSeedPath, 'utf8') : '';
const awpSeedBenefitCounts = parseSeedBenefitCounts(awpSeedSql);

function expectedBenefitCount(feat) {
  return feat.benefits.length + (feat.intro ? 1 : 0);
}

function seedBenefitCountFor(slug) {
  if (slug === AWP_SLUG) return awpSeedBenefitCounts.get(slug) ?? null;
  return seedBenefitCounts.get(slug) ?? null;
}

loadEnv();
const client = createPgClient(process.env.DATABASE_URL ?? process.env.SUPABASE_DATABASE_URL);
await client.connect();

const dbFeats = await client.query(
  `SELECT f.slug, f.name, f.category, f.repeatable, f.prerequisite,
    (SELECT COUNT(*)::int FROM rpg.phb_feat_benefit b WHERE b.feat_id = f.id) AS benefits,
    EXISTS (
      SELECT 1
      FROM rpg.phb_background bg
      WHERE bg.feat_id = f.id
    ) AS linked_background
  FROM rpg.phb_feat f
  JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
  WHERE sc.slug = $1
  ORDER BY f.category, f.slug`,
  [CITATION],
);

const extractSlugs = extract.feats.map((f) => f.slug).sort();
const dbSlugs = dbFeats.rows.map((r) => r.slug).sort();
const seedSlugList = seedFeatRows.map((r) => r.slug).sort();

const missingInDb = extractSlugs.filter((s) => !dbSlugs.includes(s));
const extraInDb = dbSlugs.filter((s) => !extractSlugs.includes(s));
const missingInSeed = extractSlugs
  .filter((s) => s !== AWP_SLUG)
  .filter((s) => !seedSlugList.includes(s));
const extraInSeed = seedSlugList.filter((s) => !extractSlugs.includes(s));

const benefitMismatches = [];
const dbBenefitDrift = [];
for (const feat of extract.feats) {
  const expectedBenefits = expectedBenefitCount(feat);
  const seedCount = seedBenefitCountFor(feat.slug);
  const dbRow = dbFeats.rows.find((r) => r.slug === feat.slug);
  const dbCount = dbRow?.benefits ?? 0;
  if (seedCount !== expectedBenefits) {
    benefitMismatches.push({
      slug: feat.slug,
      extract: expectedBenefits,
      seed: seedCount ?? null,
      db: dbCount,
    });
  } else if (dbCount !== expectedBenefits) {
    dbBenefitDrift.push({
      slug: feat.slug,
      extract: expectedBenefits,
      seed: seedCount ?? null,
      db: dbCount,
    });
  }
}

const categoryMismatches = [];
for (const feat of extract.feats) {
  const seed = seedFeatRows.find((r) => r.slug === feat.slug);
  const db = dbFeats.rows.find((r) => r.slug === feat.slug);
  if (seed && seed.category !== feat.category) {
    categoryMismatches.push({ slug: feat.slug, extract: feat.category, seed: seed.category });
  }
  if (db && db.category !== feat.category) {
    categoryMismatches.push({ slug: feat.slug, extract: feat.category, db: db.category });
  }
}

const enInDbNames = dbFeats.rows.filter((r) => /^[A-Za-z]/.test(r.name) && !r.name.includes('ã') && !r.name.includes('ç'));
const benefitsEn = await client.query(
  `SELECT COUNT(*)::int AS n
   FROM rpg.phb_feat_benefit b
   JOIN rpg.phb_feat f ON f.id = b.feat_id
   JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
   WHERE sc.slug = $1
     AND (b.description ~* 'you (gain|have|can)' OR b.name = 'Visão geral' AND b.description ~* 'You ')`,
  [CITATION],
);

const outJson = path.join(path.dirname(extractPath), '_audit-cap4-coverage.json');
const outTsv = path.join(path.dirname(extractPath), '_audit-cap4-per-feat.tsv');

const rows = extract.feats.map((f) => {
  const db = dbFeats.rows.find((r) => r.slug === f.slug);
  const expectedBenefits = expectedBenefitCount(f);
  const status =
    !db ? 'MISSING_DB' :
    db.benefits !== expectedBenefits ? 'DB_DRIFT' :
    db.category !== f.category ? 'CATEGORY' :
    'OK';
  return {
    slug: f.slug,
    category: f.category,
    benefitsExtract: expectedBenefits,
    benefitsDb: db?.benefits ?? 0,
    prerequisite: f.prerequisite ?? '',
    actionEconomy: (f.actionEconomy ?? []).join(','),
    linkedBackground: db?.linked_background ?? false,
    status,
  };
});

fs.writeFileSync(outJson, `${JSON.stringify({
  generatedAt: new Date().toISOString(),
  htmlFile: extract.source?.htmlFile,
  extractCount: extract.featCount,
  byCategory: extract.byCategory,
  seedCount: seedFeatRows.length,
  dbCount: dbFeats.rows.length,
  missingInDb,
  extraInDb,
  missingInSeed,
  extraInSeed,
  benefitMismatches,
  dbBenefitDrift,
  categoryMismatches,
  enNamesInDb: enInDbNames.length,
  benefitsLikelyEn: benefitsEn.rows[0]?.n ?? 0,
  rows,
}, null, 2)}\n`);

fs.writeFileSync(
  outTsv,
  ['slug\tcategory\tbenefits\tprerequisite\tactionEconomy\tbackground\tstatus\n',
    ...rows.map((r) =>
      [r.slug, r.category, `${r.benefitsDb}/${r.benefitsExtract}`, r.prerequisite, r.actionEconomy, r.linkedBackground ? 'yes' : 'no', r.status].join('\t'),
    ),
  ].join(''),
);

console.log('=== Grim Hollow Cap. 4 — auditoria de talentos ===\n');
console.log(`HTML: ${extract.source?.htmlFile}`);
console.log(`Extract: ${extract.featCount}`, extract.byCategory);
console.log(`Seed J014: ${seedFeatRows.length} feats`);
console.log(`DB: ${dbFeats.rows.length} feats\n`);

console.log(`Missing DB: ${missingInDb.length ? missingInDb.join(', ') : 'nenhum'}`);
console.log(`Extra DB: ${extraInDb.length ? extraInDb.join(', ') : 'nenhum'}`);
console.log(`Missing seed: ${missingInSeed.length ? missingInSeed.join(', ') : 'nenhum'}`);
console.log(`Slug seed ≠ extract: ${extraInSeed.filter((s) => !extractSlugs.includes(s)).concat(missingInSeed).filter((v, i, a) => a.indexOf(v) === i).join(', ') || 'nenhum'}`);
console.log(`Benefit mismatches (extract↔seed): ${benefitMismatches.length}`);
console.log(`DB drift (seed ok, DB desatualizado): ${dbBenefitDrift.length}`);
console.log(`Pré-requisitos no extract: ${extract.feats.filter((f) => f.prerequisite).length}/${extract.featCount}`);
console.log(`Category mismatches: ${categoryMismatches.length}`);
console.log(`Nomes ainda EN no DB: ${enInDbNames.length}/${dbFeats.rows.length}`);
console.log(`Benefícios provavelmente EN: ${benefitsEn.rows[0]?.n ?? 0}`);
console.log(`\nArtefatos: ${outJson}`);
console.log(`           ${outTsv}`);

const problems = rows.filter((r) => r.status !== 'OK');
if (problems.length) {
  console.log('\n--- Pendências DB ---');
  for (const p of problems) {
    console.log(`  ${p.slug}: ${p.status} (benefícios ${p.benefitsDb}/${p.benefitsExtract})`);
  }
}

if (benefitMismatches.length) {
  console.log('\n--- Pendências extract↔seed ---');
  for (const p of benefitMismatches) {
    console.log(`  ${p.slug}: extract ${p.extract}, seed ${p.seed ?? '—'}, db ${p.db}`);
  }
}

if (dbBenefitDrift.length) {
  console.log('\n--- Drift DB (aplicar seeds) ---');
  for (const p of dbBenefitDrift) {
    console.log(`  ${p.slug}: db ${p.db}, esperado ${p.extract}`);
  }
}

for (const r of dbFeats.rows) {
  const byCat = r.category.padEnd(16);
  console.log(`  ${byCat} ${r.slug}: ${r.benefits} benefícios, bg=${r.linked_background ? 'sim' : '—'}`);
}

await client.end();
process.exit(
  missingInDb.length === 0 &&
    missingInSeed.length === 0 &&
    benefitMismatches.length === 0 &&
    categoryMismatches.length === 0
    ? 0
    : 1,
);
