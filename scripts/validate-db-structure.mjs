/**
 * Valida database/schema.sql — PostgreSQL v4 (catálogo BIGINT + slug).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const sqlFile = path.join(root, "database", "schema.sql");

const REQUIRED_TABLES = [
  "phb_edition",
  "phb_source_citation",
  "phb_ability",
  "phb_alignment",
  "phb_language",
  "phb_skill",
  "phb_fighting_style",
  "phb_weapon_property",
  "phb_feat_category",
  "phb_feat",
  "phb_feat_benefit",
  "phb_spell_school",
  "phb_spell",
  "phb_hit_die",
  "phb_weapon_proficiency",
  "phb_spell_slot_pattern",
  "phb_spell_slot_by_level",
  "phb_class",
  "phb_class_progression",
  "phb_class_feature",
  "phb_class_skill_pool",
  "phb_spell_class",
  "phb_subclass",
  "phb_subclass_feature",
  "phb_subclass_prepared_spell",
  "phb_subclass_option_def",
  "phb_subclass_option_value",
  "phb_subclass_resource",
  "phb_species",
  "phb_species_trait",
  "phb_elf_lineage",
  "phb_infernal_legacy",
  "phb_dragon_ancestry",
  "phb_background",
  "phb_background_skill",
  "phb_background_ability_option",
  "phb_background_starting_package",
  "phb_background_starting_item",
  "phb_class_primary_ability",
  "phb_class_armor_training",
  "phb_class_weapon_proficiency",
  "phb_class_spellcasting",
  "phb_class_starting_package",
  "phb_class_starting_item",
  "phb_class_saving_throw",
  "phb_item",
  "phb_weapon",
  "phb_weapon_mastery",
  "phb_armor_category",
  "phb_armor",
  "phb_tool_category",
  "phb_tool",
  "phb_character_level",
  "phb_ability_generation_method",
  "phb_background_boost_option",
  "phb_druid_land_terrain",
  "phb_resource_definition",
  "phb_spell_source",
  "phb_species_option_def",
  "phb_species_option_value",
  "phb_divine_order",
  "phb_weapon_property_link",
  "phb_class_fighting_style",
  "player_character",
  "player_character_language",
  "player_character_ability",
  "player_character_skill",
  "player_character_tool",
  "player_character_saving_throw",
  "player_character_feat",
  "player_character_feat_asi",
  "player_character_feat_magic_initiate",
  "player_character_equipment",
  "player_character_weapon_mastery",
  "player_character_expertise",
  "player_character_spell_list",
  "player_character_spell_slot",
  "player_character_resource",
  "player_character_species_option",
  "player_character_class_option",
  "player_character_subclass_option",
  "player_character_class_skill",
];

const FORBIDDEN = [
  /\bCREATE TABLE IF NOT EXISTS rpg\.character\b/i,
  /character_class_level/i,
  /CREATE TYPE rpg\.ability_id AS ENUM/i,
  /phb_class[\s\S]{0,400}skill_choices JSONB/i,
  /phb_class_progression[\s\S]{0,200}spell_slots JSONB/i,
  /phb_feat[\s\S]{0,300}benefits JSONB/i,
  /phb_feat[\s\S]{0,300}source_meta JSONB/i,
  /phb_feat[\s\S]{0,200}category TEXT/i,
  /CREATE TABLE rpg\.phb_tool[\s\S]{0,200}\bcategory TEXT/i,
  /phb_class_option_def/i,
  /phb_class_option_value/i,
  /phb_species_trait[\s\S]{0,200}trait_table JSONB/i,
  /phb_spell[\s\S]{0,400}components JSONB/i,
  /phb_spell[\s\S]{0,300}source_meta JSONB/i,
  /phb_spell[\s\S]{0,250}\bschool TEXT/i,
  /CREATE TABLE rpg\.phb_subclass[\s\S]{0,300}source_meta JSONB/i,
  /CREATE TABLE rpg\.phb_subclass[\s\S]{0,300}prepared_spells_by_level JSONB/i,
  /CREATE TABLE rpg\.phb_subclass[\s\S]{0,200}prepared_spell_source_key/i,
  /CREATE TABLE rpg\.phb_subclass_prepared_spell[\s\S]{0,200}terrain_slug TEXT/i,
  /phb_weapon[\s\S]{0,200}property_ids/i,
  /phb_weapon[\s\S]{0,200}mastery_id TEXT/i,
  /phb_weapon[\s\S]{0,200}category TEXT/i,
  /phb_class_spellcasting[\s\S]{0,200}casting_type TEXT/i,
  /idx_phb_spell_slug/i,
  /idx_phb_class_slug/i,
  /idx_phb_item_slug/i,
  /CREATE TABLE rpg\.player_character[\s\S]{0,800}\bforca\s+INTEGER/i,
  /idx_spell_level\b/i,
  /^\s*DROP SCHEMA/im,
];

const REQUIRED_PATTERNS = [
  [/CREATE SCHEMA IF NOT EXISTS rpg/i, "schema prod-safe"],
  [/slug TEXT NOT NULL UNIQUE/i, "coluna slug UNIQUE"],
  [/id BIGSERIAL PRIMARY KEY/i, "PK BIGSERIAL"],
  [/phb_resource_definition/i, "catálogo recursos"],
  [/phb_spell_source/i, "catálogo fontes magia"],
  [/phb_ability/i, "catálogo atributos"],
  [/phb_source_citation/i, "citações de origem"],
  [/phb_background_starting_item/i, "equipamento inicial antecedente"],
  [/v_phb_class_equipment/i, "view v_phb_class_equipment"],
  [/v_phb_background_equipment/i, "view v_phb_background_equipment"],
  [/phb_class_saving_throw/i, "salvaguardas de classe"],
  [/v_phb_background/i, "view v_phb_background"],
  [/v_phb_armor/i, "view v_phb_armor"],
  [/v_spell_by_class/i, "view v_spell_by_class"],
  [/v_class_spell_slots/i, "view v_class_spell_slots"],
  [/v_phb_feat/i, "view v_phb_feat"],
  [/v_phb_class_skill_choice/i, "view v_phb_class_skill_choice"],
  [/phb_feat_benefit/i, "benefícios de talento normalizados"],
  [/phb_divine_order/i, "ordem divina do clérigo"],
  [/v_phb_subclass/i, "view v_phb_subclass"],
  [/v_phb_spell/i, "view v_phb_spell"],
  [/phb_subclass_feature/i, "características de subclasse normalizadas"],
  [/v_phb_subclass_prepared_spell/i, "view v_phb_subclass_prepared_spell"],
  [/phb_spell_school/i, "escolas de magia normalizadas"],
  [/school_id/i, "FK escola de magia"],
  [/phb_elf_lineage/i, "linhagens élficas normalizadas"],
  [/spell_slot_pattern_id/i, "FK padrão de espelhos na classe"],
  [/gin_trgm_ops/i, "índices GIN trgm para autocomplete"],
  [/phb_weapon_property_link/i, "propriedades de arma via junction"],
  [/spell_source_origin_fk/i, "CHECK origem polimórfica spell_source"],
  [/spell_source_subclass_fk/i, "FK composta subclass ∈ class"],
  [/UNIQUE \(class_id, id\)/i, "subclass composta para FK"],
  [/phb_weapon_mastery/i, "catálogo maestrias de arma"],
  [/rpg\.weapon_category/i, "ENUM categoria de arma"],
  [/rpg\.casting_type/i, "ENUM tipo de conjuração"],
  [/uq_resource_species/i, "unicidade recurso por espécie"],
  [/class_list/i, "origem class_list para lista de classe"],
  [/rpg\.set_updated_at/i, "função auditoria updated_at"],
  [/created_at TIMESTAMPTZ/i, "colunas created_at"],
  [/tr_phb_spell_updated_at/i, "trigger updated_at em phb_spell"],
  [/idx_phb_spell_level_school/i, "índice composto level+school"],
  [/idx_class_skill_pool_skill/i, "índice inverso skill pool"],
  [/mv_spell_by_class/i, "materialized view magias por classe"],
  [/idx_mv_spell_by_class/i, "índice único MV spell_by_class"],
  [/v_player_character_runtime/i, "view runtime combate"],
  [/v_player_character_full/i, "view ficha completa"],
  [/character_document/i, "função documento ficha"],
  [/recalculate_character_ac/i, "recálculo CA por equipamento"],
  [/v_character_abilities/i, "view atributos personagem"],
  [/player_character_feat_magic_initiate/i, "iniciado em magia normalizado"],
  [/player_character_ability/i, "atributos normalizados com FK phb_ability"],
  [/validate_pc_subclass/i, "trigger validação subclasse"],
  [/rpg\.skill_source/i, "ENUM skill_source"],
];

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

const migrationFile = path.join(root, "database", "migrations", "001_initial_catalog.sql");
const devResetFile = path.join(root, "database", "dev-reset.sql");

if (!fs.existsSync(migrationFile)) {
  fail("database/migrations/001_initial_catalog.sql ausente — rode npm run generate:sql-schema");
}

if (!fs.existsSync(devResetFile)) {
  fail("database/dev-reset.sql ausente — rode npm run generate:sql-schema");
}

if (fs.existsSync(migrationFile)) {
  const mig = fs.readFileSync(migrationFile, "utf8");
  if (/^\s*DROP SCHEMA/im.test(mig)) {
    fail("migration 001 não deve conter DROP SCHEMA");
  }
}

if (fs.existsSync(devResetFile)) {
  const dev = fs.readFileSync(devResetFile, "utf8");
  if (!/DROP SCHEMA IF EXISTS rpg CASCADE/i.test(dev)) {
    fail("dev-reset.sql deve conter DROP SCHEMA IF EXISTS rpg CASCADE");
  }
}

if (!fs.existsSync(sqlFile)) {
  fail("database/schema.sql ausente — rode npm run generate:sql-schema");
  process.exit(1);
}

const sql = fs.readFileSync(sqlFile, "utf8");

for (const table of REQUIRED_TABLES) {
  if (!new RegExp(`CREATE TABLE rpg\\.${table}\\b`, "i").test(sql)) {
    fail(`tabela ausente: rpg.${table}`);
  }
}

for (const pattern of FORBIDDEN) {
  if (pattern.test(sql)) {
    fail(`padrão proibido (legado): ${pattern}`);
  }
}

for (const [pattern, label] of REQUIRED_PATTERNS) {
  if (!pattern.test(sql)) {
    fail(`obrigatório ausente: ${label}`);
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(
  `✓ PostgreSQL v4 — ${REQUIRED_TABLES.length} tabelas catálogo, BIGINT+slug, 12 views`
);
process.exit(0);
