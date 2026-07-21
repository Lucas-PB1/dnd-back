#!/usr/bin/env node
/**
 * Smoke: catálogo de opções de talento após db:setup.
 * Uso: node scripts/smoke-feat-options-catalog.mjs
 */
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida.');
  process.exit(1);
}

const client = createPgClient(url);
await client.connect();

try {
  console.log(`Smoke feat options → ${maskDatabaseUrl(url)}\n`);

  const counts = await client.query(`
    SELECT
      (SELECT COUNT(*)::int FROM rpg.phb_feat) AS feats,
      (SELECT COUNT(*)::int FROM rpg.phb_feat_option_def) AS option_defs,
      (SELECT COUNT(DISTINCT feat_id)::int FROM rpg.phb_feat_option_def) AS feats_with_options
  `);

  const row = counts.rows[0];
  console.log(`Talentos PHB: ${row.feats}`);
  console.log(`Option defs: ${row.option_defs}`);
  console.log(`Talentos com ≥1 opção: ${row.feats_with_options}`);

  const samples = await client.query(`
    SELECT f.slug, COUNT(d.option_key)::int AS keys
    FROM rpg.phb_feat f
    JOIN rpg.phb_feat_option_def d ON d.feat_id = f.id
    WHERE f.slug IN ('artisan', 'musician', 'weapon-master', 'ritual-caster', 'resilient')
    GROUP BY f.slug
    ORDER BY f.slug
  `);

  console.log('\nAmostra (smoke Lote 2 + ritual + resilient):');
  for (const s of samples.rows) {
    console.log(`  ${s.slug}: ${s.keys} option key(s)`);
  }

  const missing = await client.query(`
    SELECT f.slug
    FROM rpg.phb_feat f
    LEFT JOIN rpg.phb_feat_option_def d ON d.feat_id = f.id
    WHERE f.slug IN ('artisan', 'musician', 'weapon-master')
    GROUP BY f.slug
    HAVING COUNT(d.option_key) = 0
  `);

  if (missing.rows.length > 0) {
    console.error('\nFALHA: faltam opções para', missing.rows.map((r) => r.slug).join(', '));
    process.exit(1);
  }

  const championStyle = await client.query(`
    SELECT value_type::text AS value_type
    FROM rpg.phb_subclass_option_def
    WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion')
      AND option_key = 'additionalFightingStyle'
  `);

  if (championStyle.rows[0]?.value_type !== 'fighting_style') {
    console.error('\nFALHA: Campeão additionalFightingStyle não é fighting_style');
    process.exit(1);
  }

  console.log('\nCampeão L7: additionalFightingStyle → fighting_style ✓');
  console.log('\nSmoke OK.');
} finally {
  await client.end();
}
