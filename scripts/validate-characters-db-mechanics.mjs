/**
 * Valida fichas contra mecânicas de subclasse no catálogo PostgreSQL.
 */
import { TARGET_CHARACTER_COUNT } from "./lib/character-generator.mjs";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const pg = await import("pg");
const client = new pg.default.Client({ connectionString: url });
let errors = 0;

function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

try {
  await client.connect();

  const { rows: cnt } = await client.query(`SELECT COUNT(*)::int AS n FROM rpg.player_character`);
  if (cnt[0].n !== TARGET_CHARACTER_COUNT) {
    fail(`esperado ${TARGET_CHARACTER_COUNT} personagens, encontrado ${cnt[0].n}`);
  }

  // Magias de subclasse faltando (catálogo → ficha)
  const { rows: missingSpells } = await client.query(`
    SELECT pc.id, c.slug AS class_slug, s.slug AS subclass_slug, sp.slug AS spell_slug,
           ss.slug AS source_slug, ps.unlock_level
    FROM rpg.player_character pc
    JOIN rpg.phb_class c ON c.id = pc.class_id
    JOIN rpg.phb_subclass s ON s.id = pc.subclass_id
    JOIN rpg.phb_subclass_prepared_spell ps ON ps.subclass_id = s.id
      AND ps.unlock_level <= pc.level
    JOIN rpg.phb_spell sp ON sp.id = ps.spell_id
    JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id AND ss.origin_type = 'subclass'
    LEFT JOIN rpg.phb_druid_land_terrain t ON t.id = ps.terrain_id
    LEFT JOIN rpg.player_character_class_option pco ON pco.character_id = pc.id
      AND pco.option_key = 'landTerrainId'
    LEFT JOIN rpg.phb_druid_land_terrain pct ON pct.id = pco.terrain_id
    LEFT JOIN rpg.player_character_spell_list psl ON psl.character_id = pc.id
      AND psl.spell_id = ps.spell_id
      AND psl.list_type = 'prepared'::rpg.spell_list_type
      AND psl.source_id = ss.id
    WHERE pc.level >= 3
      AND (ps.terrain_id IS NULL OR pct.slug = t.slug)
      AND psl.character_id IS NULL
    LIMIT 5
  `);
  if (missingSpells.length) {
    for (const r of missingSpells) {
      fail(
        `${r.id} ${r.class_slug}/${r.subclass_slug} L${r.unlock_level}: magia ${r.spell_slug} (${r.source_slug}) ausente`
      );
    }
    const { rows: total } = await client.query(`
      SELECT COUNT(*)::int AS n FROM (
        SELECT pc.id
        FROM rpg.player_character pc
        JOIN rpg.phb_subclass s ON s.id = pc.subclass_id
        JOIN rpg.phb_subclass_prepared_spell ps ON ps.subclass_id = s.id AND ps.unlock_level <= pc.level
        JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id AND ss.origin_type = 'subclass'
        LEFT JOIN rpg.player_character_class_option pco ON pco.character_id = pc.id AND pco.option_key = 'landTerrainId'
        LEFT JOIN rpg.phb_druid_land_terrain pct ON pct.id = pco.terrain_id
        LEFT JOIN rpg.player_character_spell_list psl ON psl.character_id = pc.id
          AND psl.spell_id = ps.spell_id AND psl.list_type = 'prepared'::rpg.spell_list_type AND psl.source_id = ss.id
        WHERE pc.level >= 3 AND (ps.terrain_id IS NULL OR pct.id = ps.terrain_id) AND psl.character_id IS NULL
      ) x
    `);
    if (total[0].n > missingSpells.length) {
      fail(`… e mais ${total[0].n - missingSpells.length} magia(s) de subclasse ausentes`);
    }
  }

  // Recursos de subclasse faltando
  const { rows: missingRes } = await client.query(`
    SELECT pc.id, s.slug AS subclass_slug, rd.slug AS resource_slug
    FROM rpg.player_character pc
    JOIN rpg.phb_subclass s ON s.id = pc.subclass_id
    JOIN rpg.phb_subclass_resource psr ON psr.subclass_id = s.id AND psr.unlock_level <= pc.level
    JOIN rpg.phb_resource_definition rd ON rd.id = psr.resource_id
    LEFT JOIN rpg.player_character_resource pcr ON pcr.character_id = pc.id AND pcr.resource_id = rd.id
    WHERE pcr.character_id IS NULL
    LIMIT 5
  `);
  if (missingRes.length) {
    for (const r of missingRes) {
      fail(`${r.id} ${r.subclass_slug}: recurso ${r.resource_slug} ausente`);
    }
  }

  // Opções de subclasse faltando
  const { rows: missingOpt } = await client.query(`
    SELECT pc.id, s.slug AS subclass_slug, sod.option_key
    FROM rpg.player_character pc
    JOIN rpg.phb_subclass s ON s.id = pc.subclass_id
    JOIN rpg.phb_subclass_option_def sod ON sod.subclass_id = s.id AND sod.unlock_level <= pc.level
    LEFT JOIN rpg.player_character_subclass_option pso ON pso.character_id = pc.id AND pso.option_key = sod.option_key
    WHERE pso.character_id IS NULL
    LIMIT 5
  `);
  if (missingOpt.length) {
    for (const r of missingOpt) {
      fail(`${r.id} ${r.subclass_slug}: opção ${r.option_key} ausente`);
    }
  }

  // Traços classificados no catálogo
  const { rows: unclassified } = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.phb_subclass_feature WHERE feature_kind IS NULL
  `);
  if (unclassified[0].n > 0) {
    fail(`${unclassified[0].n} traço(s) de subclasse sem feature_kind`);
  }

  const { rows: kindStats } = await client.query(`
    SELECT feature_kind, COUNT(*)::int AS n
    FROM rpg.phb_subclass_feature
    GROUP BY feature_kind ORDER BY feature_kind
  `);
  console.log("  traços por kind:", kindStats.map((r) => `${r.feature_kind}=${r.n}`).join(", "));
} finally {
  await client.end();
}

if (errors) {
  console.error(`\n${errors} falha(s) de mecânicas.`);
  process.exit(1);
}

console.log("✓ Mecânicas de subclasse validadas no PostgreSQL");
process.exit(0);
