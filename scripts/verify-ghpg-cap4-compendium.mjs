#!/usr/bin/env node
/**
 * Smoke do compêndio GH Cap. 4: feats PT, pré-requisitos, antecedentes ↔ origin feat, opção sangromântica.
 * Uso: node scripts/verify-ghpg-cap4-compendium.mjs
 */
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';

loadEnv();
const cap4 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap4Feats, 'utf8'));
const cap3 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap3Backgrounds, 'utf8'));

const client = createPgClient(process.env.DATABASE_URL ?? process.env.SUPABASE_DATABASE_URL);
await client.connect();

let ok = true;
const ghCitation = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats';
const ghBgCitation = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds';

const { rows: feats } = await client.query(
  `SELECT f.slug, f.name,
    (SELECT COUNT(*)::int FROM rpg.phb_feat_benefit b WHERE b.feat_id = f.id) AS benefit_count,
  r.minimum_level IS NOT NULL AS has_requirement
  FROM rpg.phb_feat f
  JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
  LEFT JOIN rpg.phb_feat_requirement r ON r.feat_id = f.id
  WHERE sc.slug = $1
  ORDER BY f.slug`,
  [ghCitation],
);

const expectedSlugs = new Set(cap4.feats.map((f) => f.slug));
const dbSlugs = new Set(feats.map((f) => f.slug));
const missing = [...expectedSlugs].filter((s) => !dbSlugs.has(s));
const extra = [...dbSlugs].filter((s) => !expectedSlugs.has(s));

if (missing.length || extra.length) {
  ok = false;
  console.error('✗ slug mismatch', { missing, extra });
} else {
  console.log(`✓ feats GH: ${feats.length}/41 slugs alinhados ao extract`);
}

const enNames = feats.filter((f) => !/[ãçáéíóúâêô]/i.test(f.name) && f.slug !== 'advanced-weapon-proficiency');
if (enNames.length > 10) {
  console.warn(`  aviso: ${enNames.length} nomes sem acento PT (heurística)`);
}

const originFeats = cap3.backgrounds.map((b) => b.feat?.slug).filter(Boolean);
const { rows: bgLinks } = await client.query(
  `SELECT f.slug AS feat_slug, b.slug AS background_slug
   FROM rpg.phb_background b
   JOIN rpg.phb_feat f ON f.id = b.feat_id
   JOIN rpg.phb_source_citation sc ON sc.id = b.source_citation_id
   WHERE sc.slug = $1`,
  [ghBgCitation],
);
const linkedFeats = new Set(bgLinks.map((r) => r.feat_slug));
const missingOrigin = originFeats.filter((slug) => !linkedFeats.has(slug));
if (missingOrigin.length) {
  ok = false;
  console.error('✗ origin feats sem phb_background.feat_id:', missingOrigin);
} else {
  console.log(`✓ antecedentes GH: ${bgLinks.length} links feat_id`);
}

const { rows: sangromanticOption } = await client.query(
  `SELECT 1 FROM rpg.phb_option_def od
   JOIN rpg.phb_feat f ON f.id = od.owner_id
   WHERE f.slug = 'sangromantic-initiate'
     AND od.scope = 'feat'
     AND od.option_key = 'bloodMagicSpell'
     AND od.spell_school_slugs @> ARRAY['sangromancia']::text[]`,
);
if (sangromanticOption.length === 0) {
  ok = false;
  console.error('✗ sangromantic-initiate sem opção bloodMagicSpell (aplique J047)');
} else {
  console.log('✓ sangromantic-initiate: opção bloodMagicSpell');
}

const structuredCount = feats.filter((f) => f.has_requirement).length;
console.log(`  pré-requisitos estruturados: ${structuredCount}/${feats.length}`);

await client.end();
process.exit(ok ? 0 : 1);
