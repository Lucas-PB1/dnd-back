import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();

const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

const checks = [
  [
    'edition',
    "SELECT slug FROM rpg.phb_edition WHERE slug = 'grim-hollow-players-guide-2024-en'",
  ],
  [
    'advanced_weapons',
    `SELECT count(*)::int AS n FROM rpg.phb_weapon w
     JOIN rpg.phb_item i ON i.id = w.item_id
     WHERE w.category = 'advanced'`,
  ],
  [
    'catchpole',
    `SELECT w.category, i.name, i.image_url FROM rpg.phb_weapon w
     JOIN rpg.phb_item i ON i.id = w.item_id WHERE i.slug = 'catchpole'`,
  ],
  [
    'feat',
    "SELECT slug FROM rpg.phb_feat WHERE slug = 'advanced-weapon-proficiency'",
  ],
  [
    'proficiency',
    "SELECT slug, label FROM rpg.v_phb_weapon_proficiency WHERE slug = 'armas-avancadas'",
  ],
  [
    'smoke_bomb_image',
    "SELECT image_url FROM rpg.phb_item WHERE slug = 'smoke-bomb'",
  ],
];

let ok = true;
for (const [label, sql] of checks) {
  const result = await client.query(sql);
  const pass = result.rows.length > 0;
  if (!pass) ok = false;
  console.log(`${pass ? '✓' : '✗'} ${label}:`, result.rows);
}

await client.end();
process.exit(ok ? 0 : 1);
