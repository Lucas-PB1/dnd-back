/**
 * Valida integridade das fichas no PostgreSQL.
 */
import { TARGET_CHARACTER_COUNT } from "./lib/character-generator.mjs";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

let pg;
try {
  pg = await import("pg");
} catch {
  console.error("✗ Instale pg: npm install pg");
  process.exit(1);
}

const client = new pg.default.Client({ connectionString: url });
let errors = 0;
let characterCount = 0;

function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

try {
  await client.connect();

  const { rows: pc } = await client.query(
    `SELECT id, name, level, passive_perception
     FROM rpg.player_character WHERE id = 'pc-001'`
  );
  if (!pc.length) fail("personagem pc-001 ausente");
  else if (pc[0].name !== "Personagem 001") {
    fail(`nome esperado genérico, encontrado ${pc[0].name}`);
  }

  const { rows: cntRows } = await client.query(`SELECT COUNT(*)::int AS n FROM rpg.player_character`);
  characterCount = cntRows[0].n;
  if (characterCount !== TARGET_CHARACTER_COUNT) {
    fail(`esperado ${TARGET_CHARACTER_COUNT} personagens, encontrado ${characterCount}`);
  }

  const { rows: abilityCnt } = await client.query(`
    SELECT character_id, COUNT(*)::int AS n
    FROM rpg.player_character_ability
    GROUP BY character_id
    HAVING COUNT(*) <> 6
    LIMIT 1
  `);
  if (abilityCnt.length) {
    fail(`personagem ${abilityCnt[0].character_id} com ${abilityCnt[0].n} atributos (esperado 6)`);
  }

  const { rows: orphanAbility } = await client.query(`
    SELECT 1 FROM rpg.player_character_ability pca
    LEFT JOIN rpg.phb_ability a ON a.id = pca.ability_id
    WHERE a.id IS NULL LIMIT 1
  `);
  if (orphanAbility.length) fail("orphan em player_character_ability");

  const { rows: orphan } = await client.query(`
    SELECT 1 FROM rpg.player_character_skill pcs
    LEFT JOIN rpg.phb_skill s ON s.id = pcs.skill_id
    WHERE s.id IS NULL LIMIT 1
  `);
  if (orphan.length) fail("orphan em player_character_skill");

  const { rows: summary } = await client.query(
    `SELECT * FROM rpg.v_player_character_summary WHERE id = 'pc-001'`
  );
  if (!summary.length) fail("v_player_character_summary pc-001 ausente");

  const { rows: abilitiesView } = await client.query(
    `SELECT COUNT(*)::int AS n FROM rpg.v_character_abilities WHERE character_id = 'pc-001'`
  );
  if (abilitiesView[0].n !== 6) fail("v_character_abilities pc-001 deve ter 6 linhas");

  const { rows: full } = await client.query(
    `SELECT document->>'id' AS doc_id, document->'hp'->>'current' AS doc_hp
     FROM rpg.v_player_character_full WHERE id = 'pc-001'`
  );
  if (!full.length) fail("v_player_character_full pc-001 ausente");
  else if (full[0].doc_id !== "pc-001") fail("document.id diverge do personagem");

  const { rows: legacyClassJson } = await client.query(`
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'rpg' AND table_name = 'player_character_class_option'
      AND column_name = 'json_value'
  `);
  if (legacyClassJson.length) fail("coluna json_value em class_option ainda existe — rode migration 007");

  const { rows: legacyFeatOptions } = await client.query(`
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'rpg' AND table_name = 'player_character_feat'
      AND column_name = 'options'
  `);
  if (legacyFeatOptions.length) fail("coluna options em player_character_feat ainda existe — rode migration 008");

  const { rows: miRows } = await client.query(`
    SELECT 1 FROM rpg.player_character_feat_magic_initiate
    JOIN rpg.player_character pc ON pc.id = character_id
    WHERE pc.id = 'pc-003'
  `);
  if (!miRows.length) fail("pc-003 (guide/magic-initiate) sem linha em feat_magic_initiate");

  const { rows: classSkillCnt } = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.player_character_class_skill WHERE character_id = 'pc-001'
  `);
  if (classSkillCnt[0].n < 1) fail("pc-001 sem perícias de classe em player_character_class_skill");

  const { rows: rogueExp } = await client.query(`
    SELECT COUNT(*)::int AS n
    FROM rpg.player_character_expertise pex
    JOIN rpg.player_character pc ON pc.id = pex.character_id
    JOIN rpg.phb_class c ON c.id = pc.class_id AND c.slug = 'rogue'
  `);
  if (rogueExp[0].n < 2) fail("ladinos sem Especialização em player_character_expertise");

  const { rows: pc009Exp } = await client.query(`
    SELECT COUNT(*)::int AS n FROM rpg.player_character_expertise WHERE character_id = 'pc-009'
  `);
  if (pc009Exp[0].n !== 2) {
    fail(`pc-009 (ladino) deveria ter 2 expertise, encontrado ${pc009Exp[0].n}`);
  }

  try {
    await client.query(`
      INSERT INTO rpg.player_character (
        id, name, level, edition_id, species_id, background_id, class_id, subclass_id,
        hp_max, ac_total
      ) VALUES (
        'bad-test', 'Bad', 1,
        (SELECT id FROM rpg.phb_edition WHERE slug = 'phb-2024-pt'),
        (SELECT id FROM rpg.phb_species WHERE slug = 'elf'),
        (SELECT id FROM rpg.phb_background WHERE slug = 'soldier'),
        (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
        (SELECT id FROM rpg.phb_subclass WHERE slug = 'life'),
        10, 10
      )
    `);
    fail("INSERT com subclasse errada deveria falhar");
    await client.query(`DELETE FROM rpg.player_character WHERE id = 'bad-test'`);
  } catch {
    /* esperado */
  }
} finally {
  await client.end();
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(`✓ Fichas validadas — ${characterCount} personagens, pc-001 OK`);
process.exit(0);
