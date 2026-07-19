import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

const target = process.argv.includes('--supabase') ? 'supabase' : 'local';
const url =
  target === 'supabase'
    ? process.env.SUPABASE_DATABASE_URL
    : process.env.DATABASE_URL;

if (!url) {
  console.error(`URL não definida para target=${target}`);
  process.exit(1);
}

const files = [
  'database/migrations/060_views/V032_v_phb_armor_cost_weight.sql',
  'database/seeds/phb/S070_phb_item_gear_descriptions.sql',
  'database/seeds/phb/S071_phb_weapon_properties_enrich.sql',
];

console.log(`→ ${maskDatabaseUrl(url)}`);
const client = createPgClient(url);
await client.connect();

try {
  for (const rel of files) {
    const full = path.join(rootDir, rel);
    process.stdout.write(`${rel}... `);
    await client.query(fs.readFileSync(full, 'utf8'));
    if (rel.includes('V032')) {
      await client.query(
        `INSERT INTO rpg.schema_migration(version) VALUES ($1) ON CONFLICT DO NOTHING`,
        ['060_views/V032_v_phb_armor_cost_weight'],
      );
    }
    console.log('ok');
  }
} finally {
  await client.end();
}
