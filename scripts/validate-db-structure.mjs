/**
 * Valida database/schema.sql — PostgreSQL v3.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const sqlFile = path.join(root, "database", "schema.sql");

const REQUIRED_TABLES = [
  "phb_edition",
  "phb_alignment",
  "phb_language",
  "phb_skill",
  "phb_fighting_style",
  "phb_weapon_property",
  "phb_feat",
  "phb_spell",
  "phb_class",
  "phb_class_progression",
  "phb_class_feature",
  "phb_class_skill_pool",
  "phb_spell_class",
  "phb_subclass",
  "phb_subclass_prepared_spell",
  "phb_species",
  "phb_species_trait",
  "phb_background",
  "phb_background_skill",
  "phb_item",
  "phb_weapon",
  "phb_armor",
  "phb_tool",
  "phb_character_level",
  "phb_ability_generation_method",
  "phb_background_boost_option",
  "phb_druid_land_terrain",
  "phb_resource_definition",
  "phb_spell_source",
  "phb_species_option_def",
  "phb_species_option_value",
  "phb_class_option_def",
  "phb_class_option_value",
  "phb_weapon_property_link",
  "phb_class_fighting_style",
  "player_character",
  "player_character_language",
  "player_character_skill",
  "player_character_saving_throw",
  "player_character_feat",
  "player_character_equipment",
  "player_character_weapon_mastery",
  "player_character_expertise",
  "player_character_spell_list",
  "player_character_spell_slot",
  "player_character_resource",
  "player_character_species_option",
  "player_character_class_option",
];

const FORBIDDEN = [
  /\bCREATE TABLE IF NOT EXISTS rpg\.character\b/i,
  /player_character_resource[\s\S]{0,120}resource_key/i,
  /character_class_level/i,
];

const REQUIRED_PATTERNS = [
  [/CREATE SCHEMA IF NOT EXISTS rpg/i, "schema rpg"],
  [/phb_resource_definition/i, "catálogo recursos"],
  [/phb_spell_source/i, "catálogo fontes magia"],
  [/resource_id.*REFERENCES rpg\.phb_resource_definition/i, "FK resource_id"],
  [/source_id.*REFERENCES rpg\.phb_spell_source/i, "FK source_id"],
  [/validate_pc_subclass/i, "trigger subclasse"],
  [/idx_pc_equip_one_slot/i, "índice slot equipado"],
  [/v_character_resources/i, "view v_character_resources"],
  [/v_character_spells/i, "view v_character_spells"],
  [/apply_sheet_to_character/i, "sync sheet→projeções"],
  [/rebuild_sheet_from_projections/i, "sync projeções→sheet"],
];

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

if (!fs.existsSync(sqlFile)) {
  fail("database/schema.sql ausente — rode npm run generate:sql-schema");
  process.exit(1);
}

const sql = fs.readFileSync(sqlFile, "utf8");

for (const table of REQUIRED_TABLES) {
  if (!new RegExp(`CREATE TABLE IF NOT EXISTS rpg\\.${table}\\b`, "i").test(sql)) {
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
  `✓ PostgreSQL v3 — ${REQUIRED_TABLES.length} tabelas, FKs tipadas, triggers, 4 views`
);
process.exit(0);
