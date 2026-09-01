#!/usr/bin/env node
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import { CAP4_ECONOMY_P0, CAP4_FEAT_RESOURCES } from './lib/ghpg-cap4-economy-config.mjs';

loadEnv();
const client = createPgClient(process.env.DATABASE_URL ?? process.env.SUPABASE_DATABASE_URL);
await client.connect();

const { rows: economyRows } = await client.query(`
  SELECT a.action_id, f.slug AS feat_slug, a.economy::text, a.resource_slug
  FROM rpg.phb_class_economy_action a
  JOIN rpg.phb_feat f ON f.id = a.feat_id
  WHERE a.action_id LIKE 'feat-gh-%'
  ORDER BY a.sort_order
`);

const { rows: resourceRows } = await client.query(`
  SELECT rd.slug, f.slug AS feat_slug
  FROM rpg.phb_resource_definition rd
  JOIN rpg.phb_feat f ON f.id = rd.feat_id
  WHERE rd.slug IN ('fortunes-fortitude', 'lightning-immediate-response', 'iron-gut-quick-recover')
`);

const expectedActions = new Set(CAP4_ECONOMY_P0.map((r) => r.actionId));
const dbActions = new Set(economyRows.map((r) => r.action_id));
const missingActions = [...expectedActions].filter((id) => !dbActions.has(id));
const expectedResources = new Set(CAP4_FEAT_RESOURCES.map((r) => r.slug));
const dbResources = new Set(resourceRows.map((r) => r.slug));
const missingResources = [...expectedResources].filter((s) => !dbResources.has(s));

console.log(`Economy GH Cap.4: ${economyRows.length}/${CAP4_ECONOMY_P0.length}`);
for (const row of economyRows) {
  console.log(`  ${row.action_id} (${row.feat_slug}, ${row.economy})`);
}
console.log(`Resources: ${resourceRows.length}/${CAP4_FEAT_RESOURCES.length}`);

if (missingActions.length) console.error('Missing actions:', missingActions);
if (missingResources.length) console.error('Missing resources:', missingResources);

await client.end();
process.exit(missingActions.length || missingResources.length ? 1 : 0);
