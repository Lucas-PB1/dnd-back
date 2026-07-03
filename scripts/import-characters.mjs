/**
 * Gera database/seed-characters.sql a partir do catálogo PHB (sem data/characters/*.json).
 * IDs: pc-001 … pc-N | N = TARGET_CHARACTER_COUNT
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { batchInsert, buildCharacterRows } from "./lib/character-import.mjs";
import {
  buildAllBlueprints,
  buildCharacter,
  TARGET_CHARACTER_COUNT,
} from "./lib/character-generator.mjs";
import { validateCharacterRules } from "./character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const outFile = path.join(root, "database", "seed-characters.sql");

function genericIdentity(index) {
  const n = index + 1;
  return {
    id: `pc-${String(n).padStart(3, "0")}`,
    name: `Personagem ${String(n).padStart(3, "0")}`,
  };
}

const blueprints = buildAllBlueprints();
if (blueprints.length !== TARGET_CHARACTER_COUNT) {
  console.error(
    `✗ ${blueprints.length} blueprints — esperado ${TARGET_CHARACTER_COUNT}. Ajuste character-generator.mjs`
  );
  process.exit(1);
}

const characters = blueprints.map((bp, i) => {
  const { id, name } = genericIdentity(i);
  return buildCharacter({ ...bp, id, name });
});

const ruleFailures = [];
for (const char of characters) {
  const result = validateCharacterRules(char);
  if (!result.ok) {
    ruleFailures.push({ id: char.id, ...result });
  }
}
if (ruleFailures.length) {
  console.error(`✗ ${ruleFailures.length} ficha(s) falharam validação de regras antes do SQL:`);
  for (const f of ruleFailures.slice(0, 20)) {
    console.error(`  ${f.id} [${f.validator}] ${f.reason}`);
  }
  process.exit(1);
}

const lines = [];
lines.push(`-- Fichas — PostgreSQL v5 (player_character + filhas)`);
lines.push(`-- Gerado por: npm run generate:seed-characters`);
lines.push(`-- ${characters.length} personagens (IDs genéricos pc-001…, sem JSON)`);
lines.push(`BEGIN;`);
lines.push(`SELECT set_config('rpg.skip_sync', '1', true);`);
lines.push(`
TRUNCATE TABLE
  rpg.player_character_subclass_option,
  rpg.player_character_class_skill,
  rpg.player_character_class_option,
  rpg.player_character_species_option,
  rpg.player_character_resource,
  rpg.player_character_spell_slot,
  rpg.player_character_spell_list,
  rpg.player_character_expertise,
  rpg.player_character_weapon_mastery,
  rpg.player_character_equipment,
  rpg.player_character_feat_asi,
  rpg.player_character_feat_magic_initiate,
  rpg.player_character_feat,
  rpg.player_character_saving_throw,
  rpg.player_character_tool,
  rpg.player_character_skill,
  rpg.player_character_ability,
  rpg.player_character_language,
  rpg.player_character
CASCADE;
`);

const all = {
  main: [],
  abilities: [],
  languages: [],
  skills: [],
  tools: [],
  saves: [],
  feats: [],
  featAsi: [],
  featMagicInitiate: [],
  equipment: [],
  masteries: [],
  expertise: [],
  spellList: [],
  spellSlots: [],
  resources: [],
  speciesOptions: [],
  classOptions: [],
  classSkills: [],
  subclassOptions: [],
};

for (const char of characters) {
  const rows = buildCharacterRows(char);
  all.main.push(rows.main);
  all.abilities.push(...rows.abilities);
  all.languages.push(...rows.languages);
  all.skills.push(...rows.skills);
  all.tools.push(...rows.tools);
  all.saves.push(...rows.saves);
  all.feats.push(...rows.feats);
  all.featAsi.push(...rows.featAsi);
  all.featMagicInitiate.push(...rows.featMagicInitiate);
  all.equipment.push(...rows.equipment);
  all.masteries.push(...rows.masteries);
  all.expertise.push(...rows.expertise);
  all.spellList.push(...rows.spellList);
  all.spellSlots.push(...rows.spellSlots);
  all.resources.push(...rows.resources);
  all.speciesOptions.push(...rows.speciesOptions);
  all.classOptions.push(...rows.classOptions);
  all.classSkills.push(...rows.classSkills);
  all.subclassOptions.push(...rows.subclassOptions);
}

lines.push(
  batchInsert(
    "rpg.player_character",
    [
      "id",
      "name",
      "level",
      "edition_id",
      "species_id",
      "background_id",
      "class_id",
      "subclass_id",
      "alignment_id",
      "ability_method_id",
      "background_boost_id",
      "class_starting_option",
      "background_starting_option",
      "hp_current",
      "hp_max",
      "hp_temp",
      "ac_total",
      "ac_base",
      "ac_dex_bonus",
      "ac_shield_bonus",
      "ac_fighting_style_bonus",
      "ac_other_bonus",
      "passive_perception",
      "notes",
    ],
    all.main
  )
);

if (all.abilities.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_ability",
      ["character_id", "ability_id", "score"],
      all.abilities
    )
  );
}
if (all.languages.length) {
  lines.push(batchInsert("rpg.player_character_language", ["character_id", "language_id"], all.languages));
}
if (all.skills.length) {
  lines.push(batchInsert("rpg.player_character_skill", ["character_id", "skill_id", "source"], all.skills));
}
if (all.tools.length) {
  lines.push(batchInsert("rpg.player_character_tool", ["character_id", "item_id", "source", "is_background_proficiency"], all.tools));
}
if (all.saves.length) {
  lines.push(
    batchInsert("rpg.player_character_saving_throw", ["character_id", "ability_id"], all.saves)
  );
}
if (all.feats.length) {
  lines.push(
    batchInsert("rpg.player_character_feat", ["character_id", "feat_id", "source", "unlock_level"], all.feats)
  );
}
if (all.featAsi.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_feat_asi",
      ["character_id", "feat_id", "source", "unlock_level", "mode", "ability_id_1", "ability_id_2"],
      all.featAsi
    )
  );
}
if (all.featMagicInitiate.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_feat_magic_initiate",
      ["character_id", "feat_id", "source", "unlock_level", "spell_list_class_id", "casting_ability_id"],
      all.featMagicInitiate
    )
  );
}
if (all.equipment.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_equipment",
      ["character_id", "item_id", "quantity", "source", "equipped", "slot"],
      all.equipment
    )
  );
}
if (all.masteries.length) {
  lines.push(
    batchInsert("rpg.player_character_weapon_mastery", ["character_id", "weapon_id"], all.masteries)
  );
}
if (all.expertise.length) {
  lines.push(batchInsert("rpg.player_character_expertise", ["character_id", "skill_id"], all.expertise));
}
if (all.spellList.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_spell_list",
      ["character_id", "spell_id", "list_type", "source_id"],
      all.spellList
    )
  );
}
if (all.spellSlots.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_spell_slot",
      ["character_id", "circle", "slots_max", "slots_used"],
      all.spellSlots
    )
  );
}
if (all.resources.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_resource",
      ["character_id", "resource_id", "max_value", "remaining"],
      all.resources
    )
  );
}
if (all.speciesOptions.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_species_option",
      [
        "character_id",
        "species_id",
        "option_key",
        "catalog_value_id",
        "skill_id",
        "ability_id",
        "json_value",
      ],
      all.speciesOptions
    )
  );
}
if (all.classOptions.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_class_option",
      [
        "character_id",
        "class_id",
        "option_key",
        "catalog_value_id",
        "fighting_style_id",
        "terrain_id",
      ],
      all.classOptions
    )
  );
}
if (all.classSkills.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_class_skill",
      ["character_id", "skill_id"],
      all.classSkills
    )
  );
}
if (all.subclassOptions.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_subclass_option",
      ["character_id", "subclass_id", "option_key", "catalog_value_id", "ability_id"],
      all.subclassOptions
    )
  );
}

lines.push(`COMMIT;`);

const sql = `${lines.filter(Boolean).join("\n\n")}\n`;
fs.writeFileSync(outFile, sql, "utf8");
console.log(`✓ ${path.relative(root, outFile)} — ${characters.length} personagens (pc-001…)`);
