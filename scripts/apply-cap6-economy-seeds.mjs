#!/usr/bin/env node
/** Aplica J061 + C078 e verifica smoke SQL Cap. 6 economy. */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();
const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida.');
  process.exit(1);
}

const files = [
  'database/seeds/grim-hollow/J061_phb_resource_ghpg_cap6_transformations.sql',
  'database/seeds/combat/C078_phb_feat_economy_ghpg_cap6_transformations.sql',
];

const client = createPgClient(url);
await client.connect();

try {
  for (const rel of files) {
    const fp = path.join(rootDir, rel);
    process.stdout.write(`Applying ${rel}... `);
    await client.query(fs.readFileSync(fp, 'utf8'));
    console.log('ok');
  }

  process.stdout.write('REFRESH mv_phb_class_economy_action... ');
  await client.query(
    'REFRESH MATERIALIZED VIEW CONCURRENTLY rpg.mv_phb_class_economy_action',
  );
  console.log('ok');

  const resources = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.phb_resource_definition
    WHERE slug LIKE '%-uses' AND feat_id IN (
      SELECT id FROM rpg.phb_feat WHERE slug LIKE 'gh-transformation-%'
    )`);
  const actions = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.phb_class_economy_action e
    JOIN rpg.phb_feat f ON f.id = e.feat_id
    WHERE f.slug LIKE 'gh-transformation-%'`);
  const infernal = await client.query(`
    SELECT e.action_id, e.table_action, e.resource_slug, f.slug AS feat_slug
    FROM rpg.phb_class_economy_action e
    JOIN rpg.phb_feat f ON f.id = e.feat_id
    WHERE e.table_action = 'gh-transformation-fiend/infernal-smite'`);
  const grants = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.phb_resource_grant gr
    JOIN rpg.phb_feat f ON f.id = gr.owner_id AND gr.owner_kind = 'feat'
    WHERE f.slug LIKE 'gh-transformation-%'`);

  console.log('\n--- smoke Cap. 6 economy ---');
  console.log('Resources (-uses):', resources.rows[0].n, '(expected 44)');
  console.log('Resource grants:', grants.rows[0].n, '(expected 44)');
  console.log('Economy actions:', actions.rows[0].n, '(expected 44)');
  console.log('Infernal smite:', infernal.rows[0] ?? 'MISSING');

  const ok =
    resources.rows[0].n === 44 &&
    grants.rows[0].n === 44 &&
    actions.rows[0].n === 44 &&
    infernal.rows[0]?.resource_slug === 'infernal-smite-uses';

  if (!ok) {
    console.error('\nSmoke FAILED');
    process.exit(1);
  }
  console.log('\nSmoke OK');
} finally {
  await client.end();
}
