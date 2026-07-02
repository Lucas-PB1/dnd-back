/**
 * Transforma JSON de ficha → linhas SQL (player_character + filhas).
 */
import {
  batchInsert,
  sqlBool,
  sqlInt,
  sqlJson,
  sqlRef,
  sqlStr,
} from "./sql-escape.mjs";

const EDITION_SLUG = "phb-2024-pt";

const SPECIES_CATALOG_KEYS = new Set([
  "lineageId",
  "infernalLegacyId",
  "gnomeLineageId",
  "dragonAncestryId",
  "giantAncestryId",
  "aasimarRevelationId",
]);

const SPECIES_SKILL_KEYS = new Set(["keenSensesSkillId"]);
const SPECIES_ABILITY_KEYS = new Set(["infernalCastingAbilityId", "gnomeCastingAbilityId"]);

const EQUIPMENT_SOURCE = {
  "class-starting": "class",
  "background-starting": "background",
  purchased: "purchase",
  other: "other",
};

const EQUIPMENT_SLOT = {
  mainHand: "main_hand",
  offHand: "off_hand",
  armor: "armor",
  shield: "shield",
  focus: "focus",
  other: "other",
};

function mapEquipmentSource(source) {
  return EQUIPMENT_SOURCE[source] ?? "other";
}

function mapEquipmentSlot(slot) {
  if (!slot) return "NULL";
  const mapped = EQUIPMENT_SLOT[slot] ?? slot.replace(/([A-Z])/g, "_$1").toLowerCase();
  return `${sqlStr(mapped)}::rpg.equipment_slot`;
}

export function buildCharacterRows(char) {
  const ag = char.abilityGeneration ?? {};
  const hp = char.hp ?? {};
  const ac = char.armorClass ?? {};
  const sp = char.startingPackages ?? {};

  const main = {
    id: sqlStr(char.id),
    name: sqlStr(char.name),
    level: sqlInt(char.level),
    edition_id: sqlRef("phb_edition", EDITION_SLUG),
    species_id: sqlRef("phb_species", char.speciesId),
    background_id: sqlRef("phb_background", char.backgroundId),
    class_id: sqlRef("phb_class", char.classId),
    subclass_id: char.subclassId ? sqlRef("phb_subclass", char.subclassId) : "NULL",
    alignment_id: char.alignmentId ? sqlRef("phb_alignment", char.alignmentId) : "NULL",
    ability_method_id: ag.methodId
      ? sqlRef("phb_ability_generation_method", ag.methodId)
      : "NULL",
    background_boost_id: ag.backgroundBoostId
      ? sqlRef("phb_background_boost_option", ag.backgroundBoostId)
      : "NULL",
    class_starting_option: sqlStr(sp.classOption ?? null),
    background_starting_option: sqlStr(sp.backgroundOption ?? null),
    hp_current: sqlInt(hp.current ?? 0),
    hp_max: sqlInt(hp.max),
    hp_temp: sqlInt(hp.temp ?? 0),
    ac_total: sqlInt(ac.total),
    ac_base: sqlInt(ac.base ?? 10),
    ac_dex_bonus: sqlInt(ac.dexBonus ?? 0),
    ac_shield_bonus: sqlInt(ac.shieldBonus ?? 0),
    ac_fighting_style_bonus: sqlInt(ac.fightingStyleBonus ?? 0),
    ac_other_bonus: sqlInt(ac.otherBonus ?? 0),
    passive_perception: sqlInt(char.passivePerception),
    notes: sqlStr(char.notes ?? null),
  };

  const abilities = Object.entries(char.abilities ?? {}).map(([slug, score]) => ({
    character_id: sqlStr(char.id),
    ability_id: sqlRef("phb_ability", slug),
    score: sqlInt(score),
  }));

  const languages = (char.languageIds ?? []).map((langId) => ({
    character_id: sqlStr(char.id),
    language_id: sqlRef("phb_language", langId),
  }));

  const skills = (char.skillProficiencies ?? []).map((s) => ({
    character_id: sqlStr(char.id),
    skill_id: sqlRef("phb_skill", s.skillId),
    source: `${sqlStr(s.source)}::rpg.skill_source`,
  }));

  const saves = (char.savingThrowProficiencies ?? []).map((ab) => ({
    character_id: sqlStr(char.id),
    ability_id: sqlRef("phb_ability", ab),
  }));

  const featMagicInitiate = [];
  const featAsi = [];
  const ASI_MODE_SQL = {
    "single+2": "single_plus_2",
    "double+1": "double_plus_1",
    "single+1": "single_plus_1",
  };

  const feats = (char.feats ?? []).map((f) => {
    const { featId, source, unlockLevel = 1, magicInitiate, asi, featSpells, castingAbilityId, resilient, ritualCaster, elementalAdept, ...rest } = f;
    if (magicInitiate) {
      featMagicInitiate.push({
        character_id: sqlStr(char.id),
        feat_id: sqlRef("phb_feat", featId),
        source: `${sqlStr(source)}::rpg.feat_source`,
        unlock_level: sqlInt(unlockLevel),
        spell_list_class_id: sqlRef("phb_class", magicInitiate.spellListClassId),
        casting_ability_id: sqlRef("phb_ability", magicInitiate.castingAbilityId),
      });
    }
    if (asi) {
      featAsi.push({
        character_id: sqlStr(char.id),
        feat_id: sqlRef("phb_feat", featId),
        source: `${sqlStr(source)}::rpg.feat_source`,
        unlock_level: sqlInt(unlockLevel),
        mode: `${sqlStr(ASI_MODE_SQL[asi.mode])}::rpg.feat_asi_mode`,
        ability_id_1: sqlRef("phb_ability", asi.abilityIds[0]),
        ability_id_2: asi.abilityIds[1] ? sqlRef("phb_ability", asi.abilityIds[1]) : "NULL",
      });
    }
    if (Object.keys(rest).length) {
      throw new Error(`feat ${featId} com opções não mapeadas: ${Object.keys(rest).join(", ")}`);
    }
    return {
      character_id: sqlStr(char.id),
      feat_id: sqlRef("phb_feat", featId),
      source: `${sqlStr(source)}::rpg.feat_source`,
      unlock_level: sqlInt(unlockLevel),
    };
  });

  const equipment = (char.equipment ?? []).map((e) => ({
    character_id: sqlStr(char.id),
    item_id: sqlRef("phb_item", e.itemId),
    quantity: sqlInt(e.quantity ?? 1),
    source: `${sqlStr(mapEquipmentSource(e.source))}::rpg.equipment_source`,
    equipped: sqlBool(Boolean(e.equipped)),
    slot: mapEquipmentSlot(e.slot),
  }));

  const masteries = (char.weaponMasteryWeaponIds ?? []).map((weaponSlug) => ({
    character_id: sqlStr(char.id),
    weapon_id: sqlRef("phb_item", weaponSlug),
  }));

  const expertise = (char.expertise ?? []).map((skillId) => ({
    character_id: sqlStr(char.id),
    skill_id: sqlRef("phb_skill", skillId),
  }));

  const spellList = [];
  const sc = char.spellcasting;
  if (sc) {
    for (const [sourceSlug, spellIds] of Object.entries(sc.cantrips ?? {})) {
      for (const spellId of spellIds) {
        spellList.push({
          character_id: sqlStr(char.id),
          spell_id: sqlRef("phb_spell", spellId),
          list_type: "'known'::rpg.spell_list_type",
          source_id: sqlRef("phb_spell_source", sourceSlug),
        });
      }
    }
    for (const [sourceSlug, spellIds] of Object.entries(sc.prepared ?? {})) {
      for (const spellId of spellIds) {
        spellList.push({
          character_id: sqlStr(char.id),
          spell_id: sqlRef("phb_spell", spellId),
          list_type: "'prepared'::rpg.spell_list_type",
          source_id: sqlRef("phb_spell_source", sourceSlug),
        });
      }
    }
    for (const [sourceSlug, spellIds] of Object.entries(sc.spellbook ?? {})) {
      for (const spellId of spellIds) {
        spellList.push({
          character_id: sqlStr(char.id),
          spell_id: sqlRef("phb_spell", spellId),
          list_type: "'known'::rpg.spell_list_type",
          source_id: sqlRef("phb_spell_source", sourceSlug),
        });
      }
    }
  }

  const spellSlots = [];
  if (sc?.slotsMax) {
    for (const [circle, max] of Object.entries(sc.slotsMax)) {
      spellSlots.push({
        character_id: sqlStr(char.id),
        circle: sqlInt(circle),
        slots_max: sqlInt(max),
        slots_used: sqlInt(sc.slotsUsed?.[circle] ?? 0),
      });
    }
  }

  const resources = Object.entries(char.resources ?? {}).map(([key, val]) => ({
    character_id: sqlStr(char.id),
    resource_id: sqlRef("phb_resource_definition", key),
    max_value: sqlInt(val.max),
    remaining: sqlInt(val.remaining),
  }));

  const speciesOptions = [];
  for (const [key, value] of Object.entries(char.speciesChoices ?? {})) {
    const row = {
      character_id: sqlStr(char.id),
      species_id: sqlRef("phb_species", char.speciesId),
      option_key: sqlStr(key),
      catalog_value_id: "NULL",
      skill_id: "NULL",
      ability_id: "NULL",
      json_value: "NULL",
    };
    if (SPECIES_CATALOG_KEYS.has(key)) {
      row.catalog_value_id = sqlStr(value);
    } else if (SPECIES_SKILL_KEYS.has(key)) {
      row.skill_id = sqlRef("phb_skill", value);
    } else if (SPECIES_ABILITY_KEYS.has(key)) {
      row.ability_id = sqlRef("phb_ability", value);
    } else {
      row.json_value = sqlJson(value);
    }
    speciesOptions.push(row);
  }

  const classOptions = [];
  const classSkills = [];
  for (const [key, value] of Object.entries(char.classChoices ?? {})) {
    if (key === "skillIds") {
      for (const skillId of value ?? []) {
        classSkills.push({
          character_id: sqlStr(char.id),
          skill_id: sqlRef("phb_skill", skillId),
        });
      }
      continue;
    }
    const row = {
      character_id: sqlStr(char.id),
      class_id: sqlRef("phb_class", char.classId),
      option_key: sqlStr(key),
      catalog_value_id: "NULL",
      fighting_style_id: "NULL",
      terrain_id: "NULL",
    };
    if (key === "divineOrder") {
      row.catalog_value_id = sqlStr(value);
    } else if (key === "fightingStyleId") {
      row.fighting_style_id = sqlRef("phb_fighting_style", value);
    } else if (key === "landTerrainId") {
      row.terrain_id = sqlRef("phb_druid_land_terrain", value);
    } else {
      throw new Error(`classChoices.${key} não mapeado para coluna relacional`);
    }
    classOptions.push(row);
  }

  const subclassOptions = [];
  if (char.subclassId) {
    for (const [key, value] of Object.entries(char.subclassChoices ?? {})) {
      subclassOptions.push({
        character_id: sqlStr(char.id),
        subclass_id: sqlRef("phb_subclass", char.subclassId),
        option_key: sqlStr(key),
        catalog_value_id: sqlStr(value),
        ability_id: "NULL",
      });
    }
  }

  return {
    main,
    abilities,
    languages,
    skills,
    saves,
    feats,
    featMagicInitiate,
    featAsi,
    equipment,
    masteries,
    expertise,
    spellList,
    spellSlots,
    resources,
    speciesOptions,
    classOptions,
    classSkills,
    subclassOptions,
  };
}

export { batchInsert };
