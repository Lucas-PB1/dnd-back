import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();
const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

const queries = {
  feathren_migration: `SELECT version FROM rpg.schema_migration
    WHERE version IN (
      '010_types/013_species_choice_kind_feathren.sql',
      '020_tables/T087_catalog_image_url_species_subclass.sql',
      '060_views/V066_v_phb_species_granted_spell_feathren.sql'
    )`,
  feathren_species: `SELECT slug, image_url FROM rpg.phb_species WHERE slug = 'feathren'`,
  gsb_subclass: `SELECT slug, image_url FROM rpg.phb_subclass WHERE slug = 'path-of-the-glacier'`,
  grim_catchpole: `SELECT i.slug FROM rpg.phb_item i
    JOIN rpg.phb_weapon w ON w.item_id = i.id WHERE i.slug = 'catchpole' AND w.category = 'advanced'`,
};

for (const [label, sql] of Object.entries(queries)) {
  const result = await client.query(sql);
  console.log(label + ':', JSON.stringify(result.rows));
}

await client.end();
