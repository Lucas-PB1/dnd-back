import fs from 'node:fs';
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();
const client = createPgClient(process.env.DATABASE_URL);
await client.connect();

const files = [
  'database/seeds/valda/V001_phb_subclass.sql',
  'database/seeds/valda/V002_phb_subclass_feature.sql',
  'database/seeds/valda/V003_phb_species.sql',
  'database/seeds/valda/V004_phb_species_trait.sql',
  'database/seeds/valda/V005_phb_species_option_def.sql',
  'database/seeds/valda/V006_phb_species_option_value.sql',
  'database/seeds/valda/V007_phb_feat.sql',
  'database/seeds/valda/V008_phb_feat_benefit.sql',
  'database/seeds/valda/V009_phb_spell.sql',
  'database/seeds/valda/V010_phb_spell_class.sql',
  'database/seeds/valda/V011_phb_item.sql',
];

try {
  for (const f of files) {
    if (!fs.existsSync(f)) {
      console.log(`skip missing ${f}`);
      continue;
    }
    process.stdout.write(`${f}... `);
    await client.query(fs.readFileSync(f, 'utf8'));
    console.log('ok');
  }

  const species = await client.query(`
    SELECT s.slug, s.creature_type, s.size, s.speed,
           COUNT(DISTINCT t.id)::int AS traits,
           COUNT(DISTINCT d.option_key)::int AS option_keys
    FROM rpg.phb_species s
    LEFT JOIN rpg.phb_species_trait t ON t.species_id = s.id
    LEFT JOIN rpg.phb_species_option_def d ON d.species_id = s.id
    WHERE s.slug IN ('geppettin', 'mandrake')
    GROUP BY s.slug, s.creature_type, s.size, s.speed
    ORDER BY s.slug
  `);
  console.table(species.rows);

  const feats = await client.query(`
    SELECT f.slug, f.name, f.prerequisite, COUNT(b.id)::int AS benefits
    FROM rpg.phb_feat f
    LEFT JOIN rpg.phb_feat_benefit b ON b.feat_id = f.id
    WHERE f.source_citation_id = (
      SELECT id FROM rpg.phb_source_citation
      WHERE slug = 'valda-spire-2024-en:player-pack'
    )
    GROUP BY f.slug, f.name, f.prerequisite
    ORDER BY f.slug
  `);
  console.table(feats.rows);

  const spells = await client.query(`
    SELECT s.slug, s.level, s.level_label, sch.slug AS school,
           s.concentration, s.ritual, COUNT(sc.class_id)::int AS classes
    FROM rpg.phb_spell s
    JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
    LEFT JOIN rpg.phb_spell_class sc ON sc.spell_id = s.id
    WHERE s.source_citation_id = (
      SELECT id FROM rpg.phb_source_citation
      WHERE slug = 'valda-spire-2024-en:player-pack'
    )
    GROUP BY s.slug, s.level, s.level_label, sch.slug, s.concentration, s.ritual
    ORDER BY s.level, s.slug
  `);
  console.table(spells.rows);

  const items = await client.query(`
    SELECT slug, item_type, name,
           properties->>'rarity' AS rarity,
           (properties->>'requiresAttunement')::boolean AS attunement
    FROM rpg.phb_item
    WHERE properties->>'source' = 'valda-spire-player-pack'
    ORDER BY slug
  `);
  console.table(items.rows);
} finally {
  await client.end();
}
