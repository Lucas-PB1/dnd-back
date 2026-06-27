/**
 * Gera database/seed-characters.sql a partir de data/characters/*.json
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { batchInsert, sqlBool, sqlInt, sqlJson, sqlStr } from "./lib/sql-escape.mjs";
import { loadCharacters } from "./lib/phb-loader.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const outFile = path.join(root, "database", "seed-characters.sql");
const manifestFile = path.join(root, "database", "seed-manifest.json");

const characters = loadCharacters(root);
const lines = [];

function mapSpeciesOption(doc, optionKey, optionValue) {
  const row = {
    character_id: sqlStr(doc.id),
    species_id: sqlStr(doc.speciesId),
    option_key: sqlStr(optionKey),
    catalog_value_id: "NULL",
    skill_id: "NULL",
    ability_id: "NULL",
    json_value: "NULL",
  };
  if (optionKey.endsWith("SkillId")) {
    row.skill_id = sqlStr(optionValue);
  } else if (optionKey.endsWith("CastingAbilityId")) {
    row.ability_id = `${sqlStr(optionValue)}::rpg.ability_id`;
  } else if (Array.isArray(optionValue)) {
    row.json_value = sqlJson(optionValue);
  } else {
    row.catalog_value_id = sqlStr(optionValue);
  }
  return row;
}

function mapClassOption(doc, optionKey, optionValue) {
  const row = {
    character_id: sqlStr(doc.id),
    class_id: sqlStr(doc.classId),
    option_key: sqlStr(optionKey),
    catalog_value_id: "NULL",
    fighting_style_id: "NULL",
    terrain_id: "NULL",
    json_value: "NULL",
  };
  if (optionKey === "fightingStyleId") {
    row.fighting_style_id = sqlStr(optionValue);
  } else if (optionKey === "landTerrainId") {
    row.terrain_id = sqlStr(optionValue);
  } else if (optionKey === "divineOrder") {
    row.catalog_value_id = sqlStr(optionValue);
  } else if (Array.isArray(optionValue)) {
    row.json_value = sqlJson(optionValue);
  } else {
    row.catalog_value_id = sqlStr(optionValue);
  }
  return row;
}

lines.push(`-- Personagens — PostgreSQL v3`);
lines.push(`-- Gerado por: npm run generate:seed-characters`);
lines.push(`BEGIN;`);
lines.push(`SELECT set_config('rpg.skip_sync', '1', true);`);

lines.push(`
TRUNCATE TABLE
  rpg.player_character_class_option,
  rpg.player_character_species_option,
  rpg.player_character_resource,
  rpg.player_character_spell_slot,
  rpg.player_character_spell_list,
  rpg.player_character_expertise,
  rpg.player_character_weapon_mastery,
  rpg.player_character_equipment,
  rpg.player_character_feat,
  rpg.player_character_saving_throw,
  rpg.player_character_skill,
  rpg.player_character_language,
  rpg.player_character
CASCADE;
`);

const pcRows = [];
const langRows = [];
const skillRows = [];
const saveRows = [];
const featRows = [];
const equipRows = [];
const masteryRows = [];
const expertiseRows = [];
const spellListRows = [];
const spellSlotRows = [];
const resourceRows = [];
const speciesOptRows = [];
const classOptRows = [];

for (const doc of characters) {
  const sheet = { ...doc };
  delete sheet.$schema;

  const ab = doc.abilities;
  pcRows.push({
    id: sqlStr(doc.id),
    name: sqlStr(doc.name),
    level: sqlInt(doc.level),
    edition_id: sqlStr("phb-2024-pt"),
    species_id: sqlStr(doc.speciesId),
    background_id: sqlStr(doc.backgroundId),
    class_id: sqlStr(doc.classId),
    subclass_id: doc.subclassId ? sqlStr(doc.subclassId) : "NULL",
    alignment_id: sqlStr(doc.alignmentId),
    ability_method_id: sqlStr(doc.abilityGeneration.methodId),
    background_boost_id: doc.abilityGeneration.backgroundBoostId
      ? sqlStr(doc.abilityGeneration.backgroundBoostId)
      : "NULL",
    ability_generation: sqlJson(doc.abilityGeneration),
    forca: sqlInt(ab.forca),
    destreza: sqlInt(ab.destreza),
    constituicao: sqlInt(ab.constituicao),
    inteligencia: sqlInt(ab.inteligencia),
    sabedoria: sqlInt(ab.sabedoria),
    carisma: sqlInt(ab.carisma),
    hp_current: sqlInt(doc.hp.current),
    hp_max: sqlInt(doc.hp.max),
    hp_temp: sqlInt(doc.hp.temp ?? 0),
    ac_total: sqlInt(doc.armorClass.total),
    ac_detail: sqlJson(doc.armorClass),
    passive_perception: sqlInt(doc.passivePerception ?? null),
    starting_packages: sqlJson(doc.startingPackages ?? null),
    sheet: sqlJson(sheet),
    notes: "NULL",
  });

  for (const languageId of doc.languageIds ?? []) {
    langRows.push({ character_id: sqlStr(doc.id), language_id: sqlStr(languageId) });
  }

  for (const sp of doc.skillProficiencies ?? []) {
    skillRows.push({
      character_id: sqlStr(doc.id),
      skill_id: sqlStr(sp.skillId),
      source: `${sqlStr(sp.source)}::rpg.skill_source`,
    });
  }

  for (const abilityId of doc.savingThrowProficiencies ?? []) {
    saveRows.push({
      character_id: sqlStr(doc.id),
      ability_id: `${sqlStr(abilityId)}::rpg.ability_id`,
    });
  }

  for (const feat of doc.feats ?? []) {
    const { featId, source, ...options } = feat;
    featRows.push({
      character_id: sqlStr(doc.id),
      feat_id: sqlStr(featId),
      source: `${sqlStr(source)}::rpg.feat_source`,
      options: sqlJson(Object.keys(options).length ? options : null),
    });
  }

  for (const item of doc.equipment ?? []) {
    equipRows.push({
      character_id: sqlStr(doc.id),
      item_id: sqlStr(item.itemId),
      quantity: sqlInt(item.quantity ?? 1),
      source: `${sqlStr(item.source)}::rpg.equipment_source`,
      equipped: sqlBool(item.equipped ?? false),
      slot: item.slot ? `${sqlStr(item.slot)}::rpg.equipment_slot` : "NULL",
    });
  }

  for (const weaponId of doc.weaponMasteryWeaponIds ?? []) {
    masteryRows.push({
      character_id: sqlStr(doc.id),
      weapon_id: sqlStr(weaponId),
    });
  }

  for (const skillId of doc.expertise ?? []) {
    expertiseRows.push({
      character_id: sqlStr(doc.id),
      skill_id: sqlStr(skillId),
    });
  }

  if (doc.spellcasting) {
    for (const listType of ["cantrips", "prepared"]) {
      const bySource = doc.spellcasting[listType] ?? {};
      for (const [sourceKey, spellIds] of Object.entries(bySource)) {
        for (const spellId of spellIds) {
          spellListRows.push({
            character_id: sqlStr(doc.id),
            spell_id: sqlStr(spellId),
            list_type: `${sqlStr(listType === "cantrips" ? "cantrip" : "prepared")}::rpg.spell_list_type`,
            source_id: sqlStr(sourceKey),
          });
        }
      }
    }
    for (const [circle, max] of Object.entries(doc.spellcasting.slotsMax ?? {})) {
      const used = doc.spellcasting.slotsUsed?.[circle] ?? 0;
      spellSlotRows.push({
        character_id: sqlStr(doc.id),
        circle: sqlInt(circle),
        slots_max: sqlInt(max),
        slots_used: sqlInt(used),
      });
    }
  }

  for (const [resourceKey, val] of Object.entries(doc.resources ?? {})) {
    resourceRows.push({
      character_id: sqlStr(doc.id),
      resource_id: sqlStr(resourceKey),
      max_value: sqlInt(val.max),
      remaining: sqlInt(val.remaining),
    });
  }

  for (const [optionKey, optionValue] of Object.entries(doc.speciesChoices ?? {})) {
    speciesOptRows.push(mapSpeciesOption(doc, optionKey, optionValue));
  }

  for (const [optionKey, optionValue] of Object.entries(doc.classChoices ?? {})) {
    classOptRows.push(mapClassOption(doc, optionKey, optionValue));
  }
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
      "ability_generation",
      "forca",
      "destreza",
      "constituicao",
      "inteligencia",
      "sabedoria",
      "carisma",
      "hp_current",
      "hp_max",
      "hp_temp",
      "ac_total",
      "ac_detail",
      "passive_perception",
      "starting_packages",
      "sheet",
      "notes",
    ],
    pcRows,
    { conflict: "(id)", updates: ["name", "level", "sheet", "hp_current", "hp_max", "ac_total"] }
  )
);

if (langRows.length) {
  lines.push(batchInsert("rpg.player_character_language", ["character_id", "language_id"], langRows));
}
if (skillRows.length) {
  lines.push(batchInsert("rpg.player_character_skill", ["character_id", "skill_id", "source"], skillRows));
}
if (saveRows.length) {
  lines.push(
    batchInsert("rpg.player_character_saving_throw", ["character_id", "ability_id"], saveRows)
  );
}
if (featRows.length) {
  lines.push(
    batchInsert("rpg.player_character_feat", ["character_id", "feat_id", "source", "options"], featRows)
  );
}
if (equipRows.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_equipment",
      ["character_id", "item_id", "quantity", "source", "equipped", "slot"],
      equipRows
    )
  );
}
if (masteryRows.length) {
  lines.push(
    batchInsert("rpg.player_character_weapon_mastery", ["character_id", "weapon_id"], masteryRows)
  );
}
if (expertiseRows.length) {
  lines.push(
    batchInsert("rpg.player_character_expertise", ["character_id", "skill_id"], expertiseRows)
  );
}
if (spellListRows.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_spell_list",
      ["character_id", "spell_id", "list_type", "source_id"],
      spellListRows
    )
  );
}
if (spellSlotRows.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_spell_slot",
      ["character_id", "circle", "slots_max", "slots_used"],
      spellSlotRows
    )
  );
}
if (resourceRows.length) {
  lines.push(
    batchInsert(
      "rpg.player_character_resource",
      ["character_id", "resource_id", "max_value", "remaining"],
      resourceRows
    )
  );
}
if (speciesOptRows.length) {
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
      speciesOptRows
    )
  );
}
if (classOptRows.length) {
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
        "json_value",
      ],
      classOptRows
    )
  );
}

lines.push("SELECT set_config('rpg.skip_sync', '0', true);");
lines.push("COMMIT;");

const sql = `${lines.filter(Boolean).join("\n\n")}\n`;
fs.writeFileSync(outFile, sql, "utf8");

const manifest = fs.existsSync(manifestFile)
  ? JSON.parse(fs.readFileSync(manifestFile, "utf8"))
  : {};
manifest.generatedAt = new Date().toISOString();
manifest.characters = {
  count: characters.length,
  languages: langRows.length,
  skills: skillRows.length,
  spellLists: spellListRows.length,
  resources: resourceRows.length,
};
manifest.files = { ...manifest.files, seedCharacters: path.relative(root, outFile) };
fs.writeFileSync(manifestFile, `${JSON.stringify(manifest, null, 2)}\n`, "utf8");

console.log(`✓ ${path.relative(root, outFile)} — ${characters.length} personagens`);
console.log(`  projeções: ${langRows.length} idiomas, ${skillRows.length} perícias, ${spellListRows.length} magias`);
