import fs from 'node:fs';
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();
const client = createPgClient(process.env.DATABASE_URL);
await client.connect();

const files = [
  'database/migrations/050_data/D019_valda_gunslinger_citation.sql',
  'database/seeds/valda-gunslinger/G001_phb_class.sql',
  'database/seeds/valda-gunslinger/G002_phb_class_primary_ability.sql',
  'database/seeds/valda-gunslinger/G003_phb_class_saving_throw.sql',
  'database/seeds/valda-gunslinger/G004_phb_class_armor_training.sql',
  'database/seeds/valda-gunslinger/G005_phb_class_weapon_proficiency.sql',
  'database/seeds/valda-gunslinger/G006_phb_class_skill_pool.sql',
  'database/seeds/valda-gunslinger/G007_phb_class_progression.sql',
  'database/seeds/valda-gunslinger/G008_phb_class_feature.sql',
  'database/seeds/valda-gunslinger/G009_phb_subclass.sql',
  'database/seeds/valda-gunslinger/G010_phb_subclass_feature.sql',
  'database/seeds/valda-gunslinger/G011_phb_weapon_property.sql',
  'database/seeds/valda-gunslinger/G011b_phb_weapon_mastery.sql',
  'database/seeds/valda-gunslinger/G012_phb_firearm.sql',
  'database/seeds/valda-gunslinger/G013_phb_ammunition.sql',
  'database/seeds/valda-gunslinger/G014_phb_feat.sql',
  'database/seeds/valda-gunslinger/G015_phb_feat_benefit.sql',
  'database/seeds/valda-gunslinger/G016_phb_spell.sql',
  'database/seeds/valda-gunslinger/G017_phb_spell_class.sql',
  'database/seeds/valda-gunslinger/G018_phb_class_starting_equipment.sql',
  'database/seeds/valda-gunslinger/G019_gunslinger_playable.sql',
  'database/seeds/valda-gunslinger/G020_phb_class_fighting_style.sql',
  'database/seeds/valda-gunslinger/G021_third_spell_slot_pattern.sql',
  'database/seeds/valda-gunslinger/G022_phb_subclass_spellcasting.sql',
  'database/seeds/valda-gunslinger/G023_phb_subclass_progression.sql',
  'database/seeds/valda-gunslinger/G024_phb_subclass_prepared_spell.sql',
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

  const klass = await client.query(`
    SELECT c.slug, c.name, c.subclass_label, c.skill_choice_count,
           c.weapon_mastery_eligibility::text AS mastery_eligibility,
           hd.slug AS hit_die,
           COUNT(DISTINCT f.id)::int AS features,
           COUNT(DISTINCT sc.id)::int AS subclasses
    FROM rpg.phb_class c
    JOIN rpg.phb_hit_die hd ON hd.id = c.hit_die_id
    LEFT JOIN rpg.phb_class_feature f ON f.class_id = c.id
    LEFT JOIN rpg.phb_subclass sc ON sc.class_id = c.id
    WHERE c.slug = 'gunslinger'
    GROUP BY c.slug, c.name, c.subclass_label, c.skill_choice_count,
             c.weapon_mastery_eligibility, hd.slug
  `);
  console.table(klass.rows);

  const catalog = await client.query(`
    SELECT
      (SELECT COUNT(*)::int FROM rpg.phb_item WHERE properties->>'source' = 'valda-gunslinger') AS valda_items,
      (SELECT COUNT(*)::int FROM rpg.phb_feat WHERE slug IN ('marksman-s-luck', 'gun-mage-adept')) AS feats,
      (SELECT COUNT(*)::int FROM rpg.phb_spell WHERE source_citation_id = (
        SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger'
      )) AS spells,
      (SELECT COUNT(*)::int FROM rpg.phb_class_fighting_style cfs
       JOIN rpg.phb_class c ON c.id = cfs.class_id WHERE c.slug = 'gunslinger') AS fighting_styles,
      (SELECT weapon_mastery FROM rpg.phb_class_progression cp
       JOIN rpg.phb_class c ON c.id = cp.class_id
       WHERE c.slug = 'gunslinger' AND cp.level = 1) AS mastery_l1,
      (SELECT fixed_max FROM rpg.phb_class_resource cr
       JOIN rpg.phb_class c ON c.id = cr.class_id
       JOIN rpg.phb_resource_definition rd ON rd.id = cr.resource_id
       WHERE c.slug = 'gunslinger' AND rd.slug = 'risk' AND cr.unlock_level = 2) AS risk_max_l2
  `);
  console.table(catalog.rows);

  const subclasses = await client.query(`
    SELECT sc.slug, sc.name, COUNT(sf.id)::int AS features
    FROM rpg.phb_subclass sc
    LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = sc.id
    WHERE sc.class_id = (SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger')
    GROUP BY sc.slug, sc.name
    ORDER BY sc.slug
  `);
  console.table(subclasses.rows);
} finally {
  await client.end();
}
