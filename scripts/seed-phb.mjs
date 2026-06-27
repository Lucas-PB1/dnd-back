/**
 * Gera database/seed-phb.sql a partir de data/phb/.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  batchInsert,
  sqlAbilityArray,
  sqlBool,
  sqlInt,
  sqlJson,
  sqlStr,
  sqlTextArray,
} from "./lib/sql-escape.mjs";
import { loadPhbCatalog } from "./lib/phb-loader.mjs";
import {
  buildAbilityGenerationMethods,
  buildBackgroundBoostOptions,
  buildClassFightingStyles,
  buildClassOptionDefs,
  buildClassOptionValues,
  buildDruidLandTerrains,
  buildResourceDefinitions,
  buildSpeciesOptionDefs,
  buildSpeciesOptionValues,
  buildSpellSources,
} from "./lib/catalog-definitions.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const outFile = path.join(root, "database", "seed-phb.sql");
const manifestFile = path.join(root, "database", "seed-manifest.json");

const catalog = loadPhbCatalog(root);
const lines = [];

lines.push(`-- PHB seed — PostgreSQL v3`);
lines.push(`-- Gerado por: npm run generate:seed-phb`);
lines.push(`BEGIN;`);
lines.push(`SELECT set_config('rpg.skip_sync', '1', true);`);
lines.push(`
-- Limpa catálogo (personagens devem ser reimportados depois)
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
  rpg.player_character,
  rpg.phb_subclass_prepared_spell,
  rpg.phb_spell_class,
  rpg.phb_class_skill_pool,
  rpg.phb_class_feature,
  rpg.phb_class_progression,
  rpg.phb_background_skill,
  rpg.phb_species_trait,
  rpg.phb_tool,
  rpg.phb_armor,
  rpg.phb_armor_category,
  rpg.phb_weapon,
  rpg.phb_item,
  rpg.phb_subclass,
  rpg.phb_class,
  rpg.phb_background,
  rpg.phb_species,
  rpg.phb_spell,
  rpg.phb_feat,
  rpg.phb_weapon_property,
  rpg.phb_fighting_style,
  rpg.phb_skill,
  rpg.phb_language,
  rpg.phb_alignment,
  rpg.phb_class_fighting_style,
  rpg.phb_weapon_property_link,
  rpg.phb_class_option_value,
  rpg.phb_class_option_def,
  rpg.phb_species_option_value,
  rpg.phb_species_option_def,
  rpg.phb_spell_source,
  rpg.phb_resource_definition,
  rpg.phb_druid_land_terrain,
  rpg.phb_background_boost_option,
  rpg.phb_ability_generation_method,
  rpg.phb_character_level
CASCADE;
`);

// alignments
lines.push(
  batchInsert(
    "rpg.phb_alignment",
    ["id", "name", "abbreviation", "description"],
    catalog.alignments.map((a) => ({
      id: sqlStr(a.id),
      name: sqlStr(a.name),
      abbreviation: sqlStr(a.abbreviation ?? null),
      description: sqlStr(a.description ?? null),
    }))
  )
);

// languages
lines.push(
  batchInsert(
    "rpg.phb_language",
    ["id", "name", "script", "typical_speakers", "is_rare"],
    catalog.languages.map((l) => ({
      id: sqlStr(l.id),
      name: sqlStr(l.name),
      script: sqlStr(l.script ?? null),
      typical_speakers: sqlStr(l.origin ?? l.typicalSpeakers ?? null),
      is_rare: sqlBool(l.category === "rare"),
    }))
  )
);

// skills
lines.push(
  batchInsert(
    "rpg.phb_skill",
    ["id", "name", "ability_id", "description"],
    catalog.skills.map((s) => ({
      id: sqlStr(s.id),
      name: sqlStr(s.name),
      ability_id: `${sqlStr(s.abilityId)}::rpg.ability_id`,
      description: sqlStr(s.exampleUses ?? null),
    }))
  )
);

// fighting styles
lines.push(
  batchInsert(
    "rpg.phb_fighting_style",
    ["id", "name", "description"],
    catalog.fightingStyles.map((fs) => ({
      id: sqlStr(fs.id),
      name: sqlStr(fs.name),
      description: sqlStr(fs.description),
    }))
  )
);

// weapon properties
lines.push(
  batchInsert(
    "rpg.phb_weapon_property",
    ["id", "name", "description"],
    catalog.weaponProperties.map((p) => ({
      id: sqlStr(p.id),
      name: sqlStr(p.name),
      description: sqlStr(p.description),
    }))
  )
);

// feats
lines.push(
  batchInsert(
    "rpg.phb_feat",
    ["id", "name", "category", "repeatable", "prerequisite", "benefits", "source_meta"],
    catalog.feats.map((f) => ({
      id: sqlStr(f.id),
      name: sqlStr(f.name),
      category: sqlStr(f.category),
      repeatable: sqlBool(f.repeatable),
      prerequisite: sqlStr(f.prerequisite ?? null),
      benefits: sqlJson(f.benefits ?? null),
      source_meta: sqlJson(f.source ?? null),
    }))
  )
);

// spells
lines.push(
  batchInsert(
    "rpg.phb_spell",
    [
      "id",
      "name",
      "level",
      "level_label",
      "school",
      "casting_time",
      "range",
      "components",
      "duration",
      "concentration",
      "ritual",
      "description",
      "higher_levels",
      "source_meta",
    ],
    catalog.spells.map((s) => ({
      id: sqlStr(s.id),
      name: sqlStr(s.name),
      level: sqlInt(s.level),
      level_label: sqlStr(s.levelLabel),
      school: sqlStr(s.school),
      casting_time: sqlStr(s.castingTime),
      range: sqlStr(s.range),
      components: sqlJson(s.components),
      duration: sqlStr(s.duration),
      concentration: sqlBool(s.concentration),
      ritual: sqlBool(s.ritual),
      description: sqlStr(s.description),
      higher_levels: sqlStr(s.higherLevels ?? null),
      source_meta: sqlJson(s.source ?? null),
    }))
  )
);

// classes
lines.push(
  batchInsert(
    "rpg.phb_class",
    [
      "id",
      "name",
      "tagline",
      "summary",
      "description",
      "primary_ability",
      "primary_ability_id",
      "hit_die",
      "hit_points",
      "saving_throw_ids",
      "subclass_unlock_level",
      "subclass_label",
      "skill_choices",
      "armor_training",
      "weapon_proficiencies",
      "starting_equipment",
      "spellcasting",
      "source_meta",
    ],
    catalog.classes.map((c) => ({
      id: sqlStr(c.id),
      name: sqlStr(c.name),
      tagline: sqlStr(c.tagline ?? null),
      summary: sqlStr(c.summary ?? null),
      description: sqlStr(c.description ?? null),
      primary_ability: sqlStr(c.primaryAbility ?? null),
      primary_ability_id: c.primaryAbilityId
        ? `${sqlStr(c.primaryAbilityId)}::rpg.ability_id`
        : "NULL",
      hit_die: sqlStr(c.hitDie),
      hit_points: sqlJson(c.hitPoints ?? null),
      saving_throw_ids: sqlAbilityArray(c.savingThrowIds),
      subclass_unlock_level: sqlInt(c.subclassUnlockLevel ?? 3),
      subclass_label: sqlStr(c.subclassLabel ?? null),
      skill_choices: sqlJson(c.skillChoices ?? null),
      armor_training: sqlJson(c.armorTraining ?? null),
      weapon_proficiencies: sqlJson(c.weaponProficiencies ?? null),
      starting_equipment: sqlJson(c.startingEquipment ?? null),
      spellcasting: sqlJson(c.spellcasting ?? null),
      source_meta: sqlJson(c.source ?? null),
    }))
  )
);

// class progression
lines.push(
  batchInsert(
    "rpg.phb_class_progression",
    [
      "class_id",
      "level",
      "proficiency_bonus",
      "cantrips",
      "prepared_spells",
      "spell_slots",
      "channel_divinity",
    ],
    catalog.classProgression.map((r) => ({
      class_id: sqlStr(r.classId),
      level: sqlInt(r.level),
      proficiency_bonus: sqlInt(r.proficiencyBonus),
      cantrips: sqlInt(r.cantrips),
      prepared_spells: sqlInt(r.preparedSpells),
      spell_slots: sqlJson(r.spellSlots),
      channel_divinity: sqlInt(r.channelDivinity),
    }))
  )
);

// class features — insert individually (BIGSERIAL id)
for (const f of catalog.classFeatures) {
  lines.push(
    `INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES (${sqlStr(f.classId)}, ${sqlInt(f.level)}, ${sqlStr(f.name)}, ${sqlStr(f.description)}) ON CONFLICT (class_id, level, name) DO NOTHING;`
  );
}

// class skill pool
lines.push(
  batchInsert(
    "rpg.phb_class_skill_pool",
    ["class_id", "skill_id"],
    catalog.classSkillPools.map((r) => ({
      class_id: sqlStr(r.classId),
      skill_id: sqlStr(r.skillId),
    }))
  )
);

// spell class
lines.push(
  batchInsert(
    "rpg.phb_spell_class",
    ["spell_id", "class_id"],
    catalog.spellClassLinks.map((r) => ({
      spell_id: sqlStr(r.spellId),
      class_id: sqlStr(r.classId),
    })),
    { conflict: "(spell_id, class_id)" }
  )
);

// subclasses
lines.push(
  batchInsert(
    "rpg.phb_subclass",
    [
      "id",
      "class_id",
      "name",
      "tagline",
      "summary",
      "description",
      "prepared_spell_source_key",
      "prepared_spells_by_level",
      "prepared_spells_by_terrain",
      "source_meta",
    ],
    catalog.subclasses.map((s) => ({
      id: sqlStr(s.id),
      class_id: sqlStr(s.classId),
      name: sqlStr(s.name),
      tagline: sqlStr(s.tagline ?? null),
      summary: sqlStr(s.summary ?? null),
      description: sqlStr(s.description ?? null),
      prepared_spell_source_key: sqlStr(s.preparedSpellSourceKey ?? null),
      prepared_spells_by_level: sqlJson(s.preparedSpellsByLevel ?? null),
      prepared_spells_by_terrain: sqlJson(s.preparedSpellsByTerrain ?? null),
      source_meta: sqlJson(s.source ?? null),
    }))
  )
);

// subclass prepared spells
lines.push(
  batchInsert(
    "rpg.phb_subclass_prepared_spell",
    ["subclass_id", "unlock_level", "spell_id", "terrain_id"],
    catalog.subclassPreparedSpells.map((r) => ({
      subclass_id: sqlStr(r.subclassId),
      unlock_level: sqlInt(r.unlockLevel),
      spell_id: sqlStr(r.spellId),
      terrain_id: sqlStr(r.terrainId ?? ""),
    })),
    { conflict: "(subclass_id, unlock_level, spell_id, terrain_id)" }
  )
);

// species
lines.push(
  batchInsert(
    "rpg.phb_species",
    ["id", "name", "creature_type", "size", "speed", "description", "source_meta"],
    catalog.species.map((s) => ({
      id: sqlStr(s.id),
      name: sqlStr(s.name),
      creature_type: sqlStr(s.creatureType),
      size: sqlStr(s.size),
      speed: sqlStr(s.speed),
      description: sqlStr(s.description),
      source_meta: sqlJson(s.source ?? null),
    }))
  )
);

// species traits
for (const t of catalog.speciesTraits) {
  lines.push(
    `INSERT INTO rpg.phb_species_trait (species_id, name, description, trait_table) VALUES (${sqlStr(t.speciesId)}, ${sqlStr(t.name)}, ${sqlStr(t.description)}, ${sqlJson(t.traitTable)}) ON CONFLICT (species_id, name) DO NOTHING;`
  );
}

// backgrounds
lines.push(
  batchInsert(
    "rpg.phb_background",
    ["id", "name", "description", "feat_id", "ability_options", "equipment", "source_meta"],
    catalog.backgrounds.map((b) => ({
      id: sqlStr(b.id),
      name: sqlStr(b.name),
      description: sqlStr(b.description ?? null),
      feat_id: sqlStr(b.featId),
      ability_options: sqlAbilityArray(b.abilityOptions),
      equipment: sqlJson(b.equipment ?? null),
      source_meta: sqlJson(b.source ?? null),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_skill",
    ["background_id", "skill_id"],
    catalog.backgroundSkills.map((r) => ({
      background_id: sqlStr(r.backgroundId),
      skill_id: sqlStr(r.skillId),
    }))
  )
);

// armor categories (rules.json)
lines.push(
  batchInsert(
    "rpg.phb_armor_category",
    ["id", "name", "don_doff", "sort_order"],
    catalog.armorCategories.map((c) => ({
      id: sqlStr(c.id),
      name: sqlStr(c.name),
      don_doff: sqlStr(c.donDoff ?? null),
      sort_order: String(c.sortOrder ?? 0),
    }))
  )
);

// items
lines.push(
  batchInsert(
    "rpg.phb_item",
    ["id", "item_type", "name", "cost", "weight", "description", "properties"],
    catalog.items.map((i) => ({
      id: sqlStr(i.id),
      item_type: `${sqlStr(i.itemType)}::rpg.item_type`,
      name: sqlStr(i.name),
      cost: sqlJson(i.cost),
      weight: sqlStr(i.weight),
      description: sqlStr(i.description),
      properties: sqlJson(i.properties),
    }))
  )
);

for (const i of catalog.items.filter((x) => x.weapon)) {
  const w = i.weapon;
  lines.push(
    `INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, property_ids, mastery_id) VALUES (${sqlStr(i.id)}, ${sqlStr(w.category)}, ${sqlStr(w.damage)}, ${sqlStr(w.damageType)}, ${sqlTextArray(w.propertyIds)}, ${sqlStr(w.masteryId)}) ON CONFLICT (item_id) DO NOTHING;`
  );
  for (const pid of w.propertyIds ?? []) {
    lines.push(
      `INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES (${sqlStr(i.id)}, ${sqlStr(pid)}) ON CONFLICT DO NOTHING;`
    );
  }
}

for (const i of catalog.items.filter((x) => x.armor)) {
  const a = i.armor;
  lines.push(
    `INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES (${sqlStr(i.id)}, ${sqlStr(a.categoryId)}, ${sqlInt(a.acBase)}, ${sqlStr(a.acFormula)}, ${sqlInt(a.strengthReq)}, ${sqlBool(a.stealthDisadvantage)}) ON CONFLICT (item_id) DO NOTHING;`
  );
}

for (const i of catalog.items.filter((x) => x.tool)) {
  const t = i.tool;
  lines.push(
    `INSERT INTO rpg.phb_tool (item_id, category, use_description) VALUES (${sqlStr(i.id)}, ${sqlStr(t.category)}, ${sqlStr(t.useDescription)}) ON CONFLICT (item_id) DO NOTHING;`
  );
}

// character levels
lines.push(
  batchInsert(
    "rpg.phb_character_level",
    ["level", "proficiency_bonus", "xp_threshold"],
    catalog.characterLevels.map((l) => ({
      level: sqlInt(l.level),
      proficiency_bonus: sqlInt(l.proficiencyBonus),
      xp_threshold: sqlInt(l.xp),
    })),
    { conflict: "(level)", updates: ["proficiency_bonus", "xp_threshold"] }
  )
);

const v3 = {
  resources: buildResourceDefinitions(),
  spellSources: buildSpellSources(),
  speciesOptionDefs: buildSpeciesOptionDefs(),
  speciesOptionValues: buildSpeciesOptionValues(),
  classOptionDefs: buildClassOptionDefs(),
  classOptionValues: buildClassOptionValues(),
  abilityMethods: buildAbilityGenerationMethods(),
  backgroundBoosts: buildBackgroundBoostOptions(),
  terrains: buildDruidLandTerrains(),
  classFightingStyles: buildClassFightingStyles(),
};

lines.push(
  batchInsert(
    "rpg.phb_ability_generation_method",
    ["id", "name", "description"],
    v3.abilityMethods.map((m) => ({
      id: sqlStr(m.id),
      name: sqlStr(m.name),
      description: sqlStr(m.description),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_boost_option",
    ["id", "label"],
    v3.backgroundBoosts.map((b) => ({ id: sqlStr(b.id), label: sqlStr(b.label) }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_druid_land_terrain",
    ["id", "label"],
    v3.terrains.map((t) => ({ id: sqlStr(t.id), label: sqlStr(t.label) }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_resource_definition",
    ["id", "name", "scope", "species_id", "class_id", "min_level"],
    v3.resources.map((r) => ({
      id: sqlStr(r.id),
      name: sqlStr(r.name),
      scope: `${sqlStr(r.scope)}::rpg.resource_scope`,
      species_id: r.speciesId ? sqlStr(r.speciesId) : "NULL",
      class_id: r.classId ? sqlStr(r.classId) : "NULL",
      min_level: sqlInt(r.minLevel),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_spell_source",
    ["id", "label", "origin_type", "class_id", "subclass_id", "species_id", "feat_id"],
    v3.spellSources.map((s) => ({
      id: sqlStr(s.id),
      label: sqlStr(s.label),
      origin_type: `${sqlStr(s.originType)}::rpg.spell_source_origin`,
      class_id: s.classId ? sqlStr(s.classId) : "NULL",
      subclass_id: s.subclassId ? sqlStr(s.subclassId) : "NULL",
      species_id: s.speciesId ? sqlStr(s.speciesId) : "NULL",
      feat_id: s.featId ? sqlStr(s.featId) : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_species_option_def",
    ["species_id", "option_key", "value_type"],
    v3.speciesOptionDefs.map((d) => ({
      species_id: sqlStr(d.speciesId),
      option_key: sqlStr(d.optionKey),
      value_type: `${sqlStr(d.valueType)}::rpg.option_value_type`,
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_species_option_value",
    ["species_id", "option_key", "value_id", "label"],
    v3.speciesOptionValues.map((v) => ({
      species_id: sqlStr(v.speciesId),
      option_key: sqlStr(v.optionKey),
      value_id: sqlStr(v.valueId),
      label: sqlStr(v.label),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_option_def",
    ["class_id", "option_key", "value_type"],
    v3.classOptionDefs.map((d) => ({
      class_id: sqlStr(d.classId),
      option_key: sqlStr(d.optionKey),
      value_type: `${sqlStr(d.valueType)}::rpg.option_value_type`,
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_option_value",
    ["class_id", "option_key", "value_id", "label"],
    v3.classOptionValues.map((v) => ({
      class_id: sqlStr(v.classId),
      option_key: sqlStr(v.optionKey),
      value_id: sqlStr(v.valueId),
      label: sqlStr(v.label),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_fighting_style",
    ["class_id", "fighting_style_id"],
    v3.classFightingStyles.map((r) => ({
      class_id: sqlStr(r.classId),
      fighting_style_id: sqlStr(r.fightingStyleId),
    }))
  )
);

lines.push("SELECT set_config('rpg.skip_sync', '0', true);");
lines.push("COMMIT;");

const sql = `${lines.filter(Boolean).join("\n\n")}\n`;
fs.mkdirSync(path.dirname(outFile), { recursive: true });
fs.writeFileSync(outFile, sql, "utf8");

const manifest = {
  generatedAt: new Date().toISOString(),
  phb: catalog.counts,
  files: { seedPhb: path.relative(root, outFile) },
};
fs.writeFileSync(manifestFile, `${JSON.stringify(manifest, null, 2)}\n`, "utf8");

console.log(`✓ ${path.relative(root, outFile)} (${sql.split("\n").length} linhas)`);
for (const [k, v] of Object.entries(catalog.counts)) {
  console.log(`  ${k}: ${v}`);
}
