import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';

loadEnv();

const targets = [
  { label: 'local', url: process.env.DATABASE_URL },
  { label: 'supabase', url: process.env.SUPABASE_DATABASE_URL },
].filter((t) => t.url);

const sql = fs.readFileSync(
  path.join(rootDir, 'database/seeds/phb/S070_phb_item_gear_descriptions.sql'),
  'utf8',
);

for (const target of targets) {
  console.log(`→ ${target.label} ${maskDatabaseUrl(target.url)}`);
  const client = createPgClient(target.url);
  await client.connect();
  try {
    await client.query(sql);
    const row = await client.query(
      `SELECT left(description, 120) AS d FROM rpg.phb_item WHERE slug = 'kit-de-assaltante'`,
    );
    console.log('  kit:', row.rows[0]?.d);
  } finally {
    await client.end();
  }
}
