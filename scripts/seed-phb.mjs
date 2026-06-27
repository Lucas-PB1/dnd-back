/**
 * Gera database/seed-phb.sql a partir de data/phb/.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  batchInsert,
  sqlBool,
  sqlInt,
  sqlIntArray,
  sqlJson,
  sqlBackgroundPackageRef,
  sqlClassPackageRef,
  sqlRef,
  sqlStr,
  sqlTextArray,
  sqlTimestamp,
} from "./lib/sql-escape.mjs";
import {
  buildSpellSlotByLevelRows,
  SPELL_SLOT_PATTERNS,
} from "./lib/spell-slot-patterns.mjs";
import {
  buildAbilityGenerationMethods,
  buildBackgroundBoostOptions,
  buildClassFightingStyles,
  buildDruidLandTerrains,
  buildResourceDefinitions,
  buildSpeciesOptionDefs,
  buildSpeciesOptionValues,
  buildSpellSources,
} from "./lib/catalog-definitions.mjs";
import { CLERIC_DIVINE_ORDERS } from "./lib/divine-orders.mjs";
import { loadPhbCatalog } from "./lib/phb-loader.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const outFile = path.join(root, "database", "seed-phb.sql");
const manifestFile = path.join(root, "database", "seed-manifest.json");

const catalog = loadPhbCatalog(root);
const lines = [];

lines.push(`-- PHB seed — PostgreSQL v4 (slug → id interno)`);
lines.push(`-- Gerado por: npm run generate:seed-phb`);
lines.push(`BEGIN;`);
lines.push(`
TRUNCATE TABLE
  rpg.phb_subclass_prepared_spell,
  rpg.phb_subclass_feature,
  rpg.phb_spell_class,
  rpg.phb_class_skill_pool,
  rpg.phb_class_feature,
  rpg.phb_class_starting_item,
  rpg.phb_class_starting_package,
  rpg.phb_class_spellcasting,
  rpg.phb_class_weapon_proficiency,
  rpg.phb_class_armor_training,
  rpg.phb_class_primary_ability,
  rpg.phb_class_saving_throw,
  rpg.phb_class_progression,
  rpg.phb_background_starting_item,
  rpg.phb_background_starting_package,
  rpg.phb_background_ability_option,
  rpg.phb_background_skill,
  rpg.phb_species_trait,
  rpg.phb_dragon_ancestry,
  rpg.phb_infernal_legacy,
  rpg.phb_elf_lineage,
  rpg.phb_tool,
  rpg.phb_armor,
  rpg.phb_tool_category,
  rpg.phb_armor_category,
  rpg.phb_weapon,
  rpg.phb_weapon_property_link,
  rpg.phb_item,
  rpg.phb_subclass,
  rpg.phb_class,
  rpg.phb_spell_slot_by_level,
  rpg.phb_spell_slot_pattern,
  rpg.phb_background,
  rpg.phb_species,
  rpg.phb_spell,
  rpg.phb_spell_school,
  rpg.phb_feat_benefit,
  rpg.phb_feat,
  rpg.phb_feat_category,
  rpg.phb_weapon_property,
  rpg.phb_fighting_style,
  rpg.phb_skill,
  rpg.phb_ability,
  rpg.phb_language,
  rpg.phb_alignment,
  rpg.phb_source_citation,
  rpg.phb_weapon_proficiency,
  rpg.phb_class_fighting_style,
  rpg.phb_species_option_value,
  rpg.phb_species_option_def,
  rpg.phb_spell_source,
  rpg.phb_resource_definition,
  rpg.phb_divine_order,
  rpg.phb_druid_land_terrain,
  rpg.phb_background_boost_option,
  rpg.phb_ability_generation_method,
  rpg.phb_character_level
RESTART IDENTITY CASCADE;
`);

// alignments
lines.push(
  batchInsert(
    "rpg.phb_alignment",
    ["slug", "name", "abbreviation", "description"],
    catalog.alignments.map((a) => ({
      slug: sqlStr(a.id),
      name: sqlStr(a.name),
      abbreviation: sqlStr(a.abbreviation ?? null),
      description: sqlStr(a.description ?? null),
    }))
  )
);

// abilities (antes de perícias e classes)
lines.push(
  batchInsert(
    "rpg.phb_ability",
    ["slug", "name", "sort_order"],
    catalog.abilities.map((a) => ({
      slug: sqlStr(a.id),
      name: sqlStr(a.name),
      sort_order: String(a.sortOrder ?? 0),
    }))
  )
);

// languages
lines.push(
  batchInsert(
    "rpg.phb_language",
    ["slug", "name", "script", "typical_speakers", "is_rare"],
    catalog.languages.map((l) => ({
      slug: sqlStr(l.id),
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
    ["slug", "name", "ability_id", "description"],
    catalog.skills.map((s) => ({
      slug: sqlStr(s.id),
      name: sqlStr(s.name),
      ability_id: sqlRef("phb_ability", s.abilityId),
      description: sqlStr(s.exampleUses ?? null),
    }))
  )
);

// source citations (antecedentes, classes, talentos)
lines.push(
  batchInsert(
    "rpg.phb_source_citation",
    ["slug", "edition_id", "chapter", "chapter_title", "pdf_path", "pdf_pages", "extracted_at"],
    catalog.sourceCitations.map((c) => ({
      slug: sqlStr(c.slug),
      edition_id: sqlRef("phb_edition", c.editionSlug),
      chapter: sqlInt(c.chapter),
      chapter_title: sqlStr(c.chapterTitle),
      pdf_path: sqlStr(c.pdfPath),
      pdf_pages: sqlIntArray(c.pdfPages),
      extracted_at: sqlTimestamp(c.extractedAt),
    }))
  )
);

// armor categories (antes de classes — FK treinamento de armadura)
lines.push(
  batchInsert(
    "rpg.phb_armor_category",
    ["slug", "name", "don_doff", "sort_order"],
    catalog.armorCategories.map((c) => ({
      slug: sqlStr(c.id),
      name: sqlStr(c.name),
      don_doff: sqlStr(c.donDoff ?? null),
      sort_order: String(c.sortOrder ?? 0),
    }))
  )
);

// tool categories (antes de phb_tool)
lines.push(
  batchInsert(
    "rpg.phb_tool_category",
    ["slug", "name", "sort_order"],
    catalog.toolCategories.map((c) => ({
      slug: sqlStr(c.slug),
      name: sqlStr(c.name),
      sort_order: String(c.sortOrder ?? 0),
    }))
  )
);

// fighting styles
lines.push(
  batchInsert(
    "rpg.phb_fighting_style",
    ["slug", "name", "description"],
    catalog.fightingStyles.map((fs) => ({
      slug: sqlStr(fs.id),
      name: sqlStr(fs.name),
      description: sqlStr(fs.description),
    }))
  )
);

// weapon properties
lines.push(
  batchInsert(
    "rpg.phb_weapon_property",
    ["slug", "name", "description"],
    catalog.weaponProperties.map((p) => ({
      slug: sqlStr(p.id),
      name: sqlStr(p.name),
      description: sqlStr(p.description),
    }))
  )
);

// categorias de talento
lines.push(
  batchInsert(
    "rpg.phb_feat_category",
    ["slug", "name", "type_label", "sort_order"],
    catalog.featCategories.map((c) => ({
      slug: sqlStr(c.slug),
      name: sqlStr(c.name),
      type_label: sqlStr(c.typeLabel),
      sort_order: String(c.sortOrder),
    }))
  )
);

// feats
lines.push(
  batchInsert(
    "rpg.phb_feat",
    ["slug", "name", "category_id", "repeatable", "prerequisite", "source_citation_id"],
    catalog.feats.map((f) => ({
      slug: sqlStr(f.id),
      name: sqlStr(f.name),
      category_id: sqlRef("phb_feat_category", f.categorySlug),
      repeatable: sqlBool(f.repeatable),
      prerequisite: sqlStr(f.prerequisite ?? null),
      source_citation_id: f.sourceCitationSlug
        ? sqlRef("phb_source_citation", f.sourceCitationSlug)
        : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_feat_benefit",
    ["feat_id", "sort_order", "name", "description"],
    catalog.featBenefits.map((b) => ({
      feat_id: sqlRef("phb_feat", b.featId),
      sort_order: sqlInt(b.sortOrder),
      name: sqlStr(b.name),
      description: sqlStr(b.description),
    }))
  )
);

// spell schools (antes das magias)
lines.push(
  batchInsert(
    "rpg.phb_spell_school",
    ["slug", "name", "sort_order"],
    catalog.spellSchools.map((s) => ({
      slug: sqlStr(s.slug),
      name: sqlStr(s.name),
      sort_order: String(s.sortOrder),
    }))
  )
);

// spells
lines.push(
  batchInsert(
    "rpg.phb_spell",
    [
      "slug",
      "name",
      "level",
      "level_label",
      "school_id",
      "casting_time",
      "range",
      "has_verbal",
      "has_somatic",
      "has_material",
      "material_description",
      "components_label",
      "duration",
      "concentration",
      "ritual",
      "description",
      "higher_levels",
      "source_citation_id",
    ],
    catalog.spells.map((s) => ({
      slug: sqlStr(s.id),
      name: sqlStr(s.name),
      level: sqlInt(s.level),
      level_label: sqlStr(s.levelLabel),
      school_id: sqlRef("phb_spell_school", s.schoolSlug),
      casting_time: sqlStr(s.castingTime),
      range: sqlStr(s.range),
      has_verbal: sqlBool(s.hasVerbal),
      has_somatic: sqlBool(s.hasSomatic),
      has_material: sqlBool(s.hasMaterial),
      material_description: sqlStr(s.materialDescription),
      components_label: sqlStr(s.componentsLabel),
      duration: sqlStr(s.duration),
      concentration: sqlBool(s.concentration),
      ritual: sqlBool(s.ritual),
      description: sqlStr(s.description),
      higher_levels: sqlStr(s.higherLevels ?? null),
      source_citation_id: s.sourceCitationSlug
        ? sqlRef("phb_source_citation", s.sourceCitationSlug)
        : "NULL",
    }))
  )
);

// padrões de espelhos de magia (full / half / pact)
lines.push(
  batchInsert(
    "rpg.phb_spell_slot_pattern",
    ["slug", "name", "description"],
    SPELL_SLOT_PATTERNS.map((p) => ({
      slug: sqlStr(p.slug),
      name: sqlStr(p.name),
      description: sqlStr(p.description),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_spell_slot_by_level",
    ["pattern_id", "level", "circle", "slot_count"],
    buildSpellSlotByLevelRows().map((r) => ({
      pattern_id: sqlRef("phb_spell_slot_pattern", r.patternSlug),
      level: sqlInt(r.level),
      circle: sqlInt(r.circle),
      slot_count: sqlInt(r.slotCount),
    }))
  )
);

// classes
lines.push(
  batchInsert(
    "rpg.phb_weapon_proficiency",
    ["slug", "label"],
    catalog.weaponProfTerms.map((t) => ({
      slug: sqlStr(t.slug),
      label: sqlStr(t.label),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class",
    [
      "slug",
      "name",
      "tagline",
      "summary",
      "description",
      "primary_ability_label",
      "primary_ability_operator",
      "hit_die_id",
      "hp_level1_die_value",
      "hp_fixed_per_level",
      "hp_minimum_gain_per_level",
      "hp_constitution_mod_applies",
      "subclass_unlock_level",
      "subclass_label",
      "skill_choice_count",
      "skill_choice_from",
      "source_citation_id",
      "spell_slot_pattern_id",
    ],
    catalog.classes.map((c) => ({
      slug: sqlStr(c.id),
      name: sqlStr(c.name),
      tagline: sqlStr(c.tagline ?? null),
      summary: sqlStr(c.summary ?? null),
      description: sqlStr(c.description ?? null),
      primary_ability_label: sqlStr(c.primaryAbility ?? null),
      primary_ability_operator: sqlStr(c.primaryAbilityOperator),
      hit_die_id: sqlRef("phb_hit_die", c.hitDieSlug),
      hp_level1_die_value: sqlInt(c.hpLevel1DieValue),
      hp_fixed_per_level: sqlInt(c.hpFixedPerLevel),
      hp_minimum_gain_per_level: sqlInt(c.hpMinimumGainPerLevel),
      hp_constitution_mod_applies: sqlBool(c.hpConstitutionModApplies),
      subclass_unlock_level: sqlInt(c.subclassUnlockLevel ?? 3),
      subclass_label: sqlStr(c.subclassLabel ?? null),
      skill_choice_count: sqlInt(c.skillChoiceCount),
      skill_choice_from: sqlStr(c.skillChoiceFrom),
      source_citation_id: c.sourceCitationSlug
        ? sqlRef("phb_source_citation", c.sourceCitationSlug)
        : "NULL",
      spell_slot_pattern_id: c.spellSlotPatternSlug
        ? sqlRef("phb_spell_slot_pattern", c.spellSlotPatternSlug)
        : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_primary_ability",
    ["class_id", "ability_id", "sort_order"],
    catalog.classPrimaryAbilities.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      ability_id: sqlRef("phb_ability", r.abilityId),
      sort_order: String(r.sortOrder),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_armor_training",
    ["class_id", "category_id"],
    catalog.classArmorTraining.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      category_id: sqlRef("phb_armor_category", r.categorySlug),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_weapon_proficiency",
    ["class_id", "proficiency_id"],
    catalog.classWeaponProficiencies.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      proficiency_id: sqlRef("phb_weapon_proficiency", r.proficiencySlug),
    }))
  )
);

// class saving throws
lines.push(
  batchInsert(
    "rpg.phb_class_saving_throw",
    ["class_id", "ability_id"],
    catalog.classSavingThrows.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      ability_id: sqlRef("phb_ability", r.abilityId),
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
      "channel_divinity",
    ],
    catalog.classProgression.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      level: sqlInt(r.level),
      proficiency_bonus: sqlInt(r.proficiencyBonus),
      cantrips: sqlInt(r.cantrips),
      prepared_spells: sqlInt(r.preparedSpells),
      channel_divinity: sqlInt(r.channelDivinity),
    }))
  )
);

// class features — insert individually (BIGSERIAL id)
for (const f of catalog.classFeatures) {
  lines.push(
    `INSERT INTO rpg.phb_class_feature (class_id, level, name, description) VALUES (${sqlRef("phb_class", f.classId)}, ${sqlInt(f.level)}, ${sqlStr(f.name)}, ${sqlStr(f.description)}) ON CONFLICT (class_id, level, name) DO NOTHING;`
  );
}

// class skill pool
lines.push(
  batchInsert(
    "rpg.phb_class_skill_pool",
    ["class_id", "skill_id"],
    catalog.classSkillPools.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      skill_id: sqlRef("phb_skill", r.skillId),
    }))
  )
);

// spell class
lines.push(
  batchInsert(
    "rpg.phb_spell_class",
    ["spell_id", "class_id"],
    catalog.spellClassLinks.map((r) => ({
      spell_id: sqlRef("phb_spell", r.spellId),
      class_id: sqlRef("phb_class", r.classId),
    })),
    { conflict: "(spell_id, class_id)" }
  )
);

// terrenos druida (FK em magias preparadas por subclasse)
lines.push(
  batchInsert(
    "rpg.phb_druid_land_terrain",
    ["slug", "label"],
    buildDruidLandTerrains().map((t) => ({
      slug: sqlStr(t.id),
      label: sqlStr(t.label),
    })),
    { conflict: "(slug)" }
  )
);

// subclasses
lines.push(
  batchInsert(
    "rpg.phb_subclass",
    ["slug", "class_id", "name", "tagline", "summary", "description", "source_citation_id"],
    catalog.subclasses.map((s) => ({
      slug: sqlStr(s.id),
      class_id: sqlRef("phb_class", s.classId),
      name: sqlStr(s.name),
      tagline: sqlStr(s.tagline ?? null),
      summary: sqlStr(s.summary ?? null),
      description: sqlStr(s.description ?? null),
      source_citation_id: s.sourceCitationSlug
        ? sqlRef("phb_source_citation", s.sourceCitationSlug)
        : "NULL",
    }))
  )
);

for (const f of catalog.subclassFeatures) {
  lines.push(
    `INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description) VALUES (${sqlRef("phb_subclass", f.subclassId)}, ${sqlInt(f.level)}, ${sqlStr(f.name)}, ${sqlStr(f.description)}) ON CONFLICT (subclass_id, level, name) DO NOTHING;`
  );
}

// subclass prepared spells
lines.push(
  batchInsert(
    "rpg.phb_subclass_prepared_spell",
    ["subclass_id", "unlock_level", "spell_id", "terrain_id"],
    catalog.subclassPreparedSpells.map((r) => ({
      subclass_id: sqlRef("phb_subclass", r.subclassId),
      unlock_level: sqlInt(r.unlockLevel),
      spell_id: sqlRef("phb_spell", r.spellId),
      terrain_id: r.terrainId ? sqlRef("phb_druid_land_terrain", r.terrainId) : "NULL",
    })),
    { conflict: "ON CONSTRAINT uq_subclass_prepared_spell" }
  )
);

// species
lines.push(
  batchInsert(
    "rpg.phb_species",
    ["slug", "name", "creature_type", "size", "speed", "description", "source_meta"],
    catalog.species.map((s) => ({
      slug: sqlStr(s.id),
      name: sqlStr(s.name),
      creature_type: sqlStr(s.creatureType),
      size: sqlStr(s.size),
      speed: sqlStr(s.speed),
      description: sqlStr(s.description),
      source_meta: sqlJson(s.source ?? null),
    }))
  )
);

const c = catalog.speciesTraitCatalogs;

lines.push(
  batchInsert(
    "rpg.phb_elf_lineage",
    ["slug", "name", "level1_benefit", "spell_level3_id", "spell_level5_id"],
    c.elfLineages.map((r) => ({
      slug: sqlStr(r.slug),
      name: sqlStr(r.name),
      level1_benefit: sqlStr(r.level1Benefit),
      spell_level3_id: r.spellLevel3Slug ? sqlRef("phb_spell", r.spellLevel3Slug) : "NULL",
      spell_level5_id: r.spellLevel5Slug ? sqlRef("phb_spell", r.spellLevel5Slug) : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_infernal_legacy",
    ["slug", "name", "level1_benefit", "spell_level3_id", "spell_level5_id"],
    c.infernalLegacies.map((r) => ({
      slug: sqlStr(r.slug),
      name: sqlStr(r.name),
      level1_benefit: sqlStr(r.level1Benefit),
      spell_level3_id: r.spellLevel3Slug ? sqlRef("phb_spell", r.spellLevel3Slug) : "NULL",
      spell_level5_id: r.spellLevel5Slug ? sqlRef("phb_spell", r.spellLevel5Slug) : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_dragon_ancestry",
    ["slug", "name", "damage_type"],
    c.dragonAncestries.map((r) => ({
      slug: sqlStr(r.slug),
      name: sqlStr(r.name),
      damage_type: sqlStr(r.damageType),
    }))
  )
);

// species traits
for (const t of catalog.speciesTraits) {
  lines.push(
    `INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind) VALUES (${sqlRef("phb_species", t.speciesId)}, ${sqlStr(t.name)}, ${sqlStr(t.description)}, ${t.choiceKind ? `${sqlStr(t.choiceKind)}::rpg.species_choice_kind` : "NULL"}) ON CONFLICT (species_id, name) DO NOTHING;`
  );
}

// items
lines.push(
  batchInsert(
    "rpg.phb_item",
    ["slug", "item_type", "name", "cost", "weight", "description", "properties"],
    catalog.items.map((i) => ({
      slug: sqlStr(i.id),
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
    `INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, property_ids, mastery_id) VALUES (${sqlRef("phb_item", i.id)}, ${sqlStr(w.category)}, ${sqlStr(w.damage)}, ${sqlStr(w.damageType)}, ${sqlTextArray(w.propertyIds)}, ${sqlStr(w.masteryId)}) ON CONFLICT (item_id) DO NOTHING;`
  );
  for (const pid of w.propertyIds ?? []) {
    lines.push(
      `INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES (${sqlRef("phb_item", i.id)}, ${sqlRef("phb_weapon_property", pid)}) ON CONFLICT DO NOTHING;`
    );
  }
}

for (const i of catalog.items.filter((x) => x.armor)) {
  const a = i.armor;
  lines.push(
    `INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES (${sqlRef("phb_item", i.id)}, ${sqlRef("phb_armor_category", a.categoryId)}, ${sqlInt(a.acBase)}, ${sqlStr(a.acFormula)}, ${sqlInt(a.strengthReq)}, ${sqlBool(a.stealthDisadvantage)}) ON CONFLICT (item_id) DO NOTHING;`
  );
}

for (const i of catalog.items.filter((x) => x.tool)) {
  const t = i.tool;
  lines.push(
    `INSERT INTO rpg.phb_tool (item_id, category_id, use_description) VALUES (${sqlRef("phb_item", i.id)}, ${sqlRef("phb_tool_category", t.categoryId)}, ${sqlStr(t.useDescription)}) ON CONFLICT (item_id) DO NOTHING;`
  );
}

// backgrounds (FK em itens e citação de origem)
lines.push(
  batchInsert(
    "rpg.phb_background",
    [
      "slug",
      "name",
      "description",
      "feat_id",
      "source_citation_id",
      "equipment_gold_option",
      "tool_proficiency_description",
      "tool_proficiency_kind",
      "tool_item_id",
    ],
    catalog.backgrounds.map((b) => ({
      slug: sqlStr(b.id),
      name: sqlStr(b.name),
      description: sqlStr(b.description ?? null),
      feat_id: sqlRef("phb_feat", b.featId),
      source_citation_id: b.sourceCitationSlug
        ? sqlRef("phb_source_citation", b.sourceCitationSlug)
        : "NULL",
      equipment_gold_option: sqlInt(b.equipmentGoldOption),
      tool_proficiency_description: sqlStr(b.toolProficiencyDescription),
      tool_proficiency_kind: sqlStr(b.toolProficiencyKind),
      tool_item_id: b.toolItemId ? sqlRef("phb_item", b.toolItemId) : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_ability_option",
    ["background_id", "ability_id", "sort_order"],
    catalog.backgroundAbilityOptions.map((r) => ({
      background_id: sqlRef("phb_background", r.backgroundId),
      ability_id: sqlRef("phb_ability", r.abilityId),
      sort_order: String(r.sortOrder),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_skill",
    ["background_id", "skill_id"],
    catalog.backgroundSkills.map((r) => ({
      background_id: sqlRef("phb_background", r.backgroundId),
      skill_id: sqlRef("phb_skill", r.skillId),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_starting_package",
    ["background_id", "slug", "label", "gold", "sort_order"],
    catalog.backgroundStartingPackages.map((r) => ({
      background_id: sqlRef("phb_background", r.backgroundId),
      slug: sqlStr(r.packageSlug),
      label: sqlStr(r.label),
      gold: sqlInt(r.gold),
      sort_order: String(r.sortOrder),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_starting_item",
    ["package_id", "item_id", "choice_text", "quantity", "sort_order"],
    catalog.backgroundStartingItems.map((r) => ({
      package_id: sqlBackgroundPackageRef(r.backgroundId, r.packageSlug),
      item_id: r.itemId ? sqlRef("phb_item", r.itemId) : "NULL",
      choice_text: sqlStr(r.choiceText),
      quantity: sqlInt(r.quantity),
      sort_order: String(r.sortOrder),
    }))
  )
);

// classe — conjuração e equipamento inicial (FK em itens)
lines.push(
  batchInsert(
    "rpg.phb_class_spellcasting",
    ["class_id", "casting_type", "ability_id", "focus_label", "focus_item_id", "ritual"],
    catalog.classSpellcasting.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      casting_type: sqlStr(r.castingType),
      ability_id: r.abilityId ? sqlRef("phb_ability", r.abilityId) : "NULL",
      focus_label: sqlStr(r.focusLabel),
      focus_item_id: r.focusItemId ? sqlRef("phb_item", r.focusItemId) : "NULL",
      ritual: sqlBool(r.ritual),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_starting_package",
    ["class_id", "slug", "label", "sort_order"],
    catalog.classStartingPackages.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      slug: sqlStr(r.packageSlug),
      label: sqlStr(r.label),
      sort_order: String(r.sortOrder),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_starting_item",
    ["package_id", "item_id", "choice_text", "gold_amount", "quantity", "sort_order"],
    catalog.classStartingItems.map((r) => ({
      package_id: sqlClassPackageRef(r.classId, r.packageSlug),
      item_id: r.itemId ? sqlRef("phb_item", r.itemId) : "NULL",
      choice_text: sqlStr(r.choiceText),
      gold_amount: sqlInt(r.goldAmount),
      quantity: sqlInt(r.quantity),
      sort_order: String(r.sortOrder),
    }))
  )
);

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
  abilityMethods: buildAbilityGenerationMethods(),
  backgroundBoosts: buildBackgroundBoostOptions(),
  terrains: buildDruidLandTerrains(),
  classFightingStyles: buildClassFightingStyles(),
  divineOrders: CLERIC_DIVINE_ORDERS,
};

lines.push(
  batchInsert(
    "rpg.phb_ability_generation_method",
    ["slug", "name", "description"],
    v3.abilityMethods.map((m) => ({
      slug: sqlStr(m.id),
      name: sqlStr(m.name),
      description: sqlStr(m.description),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_background_boost_option",
    ["slug", "label"],
    v3.backgroundBoosts.map((b) => ({ slug: sqlStr(b.id), label: sqlStr(b.label) }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_resource_definition",
    ["slug", "name", "scope", "species_id", "class_id", "min_level"],
    v3.resources.map((r) => ({
      slug: sqlStr(r.id),
      name: sqlStr(r.name),
      scope: `${sqlStr(r.scope)}::rpg.resource_scope`,
      species_id: r.speciesId ? sqlRef("phb_species", r.speciesId) : "NULL",
      class_id: r.classId ? sqlRef("phb_class", r.classId) : "NULL",
      min_level: sqlInt(r.minLevel),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_spell_source",
    ["slug", "label", "origin_type", "class_id", "subclass_id", "species_id", "feat_id"],
    v3.spellSources.map((s) => ({
      slug: sqlStr(s.id),
      label: sqlStr(s.label),
      origin_type: `${sqlStr(s.originType)}::rpg.spell_source_origin`,
      class_id: s.classId ? sqlRef("phb_class", s.classId) : "NULL",
      subclass_id: s.subclassId ? sqlRef("phb_subclass", s.subclassId) : "NULL",
      species_id: s.speciesId ? sqlRef("phb_species", s.speciesId) : "NULL",
      feat_id: s.featId ? sqlRef("phb_feat", s.featId) : "NULL",
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_species_option_def",
    ["species_id", "option_key", "value_type"],
    v3.speciesOptionDefs.map((d) => ({
      species_id: sqlRef("phb_species", d.speciesId),
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
      species_id: sqlRef("phb_species", v.speciesId),
      option_key: sqlStr(v.optionKey),
      value_id: sqlStr(v.valueId),
      label: sqlStr(v.label),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_divine_order",
    ["slug", "name", "description"],
    v3.divineOrders.map((o) => ({
      slug: sqlStr(o.slug),
      name: sqlStr(o.name),
      description: sqlStr(o.description),
    }))
  )
);

lines.push(
  batchInsert(
    "rpg.phb_class_fighting_style",
    ["class_id", "fighting_style_id"],
    v3.classFightingStyles.map((r) => ({
      class_id: sqlRef("phb_class", r.classId),
      fighting_style_id: sqlRef("phb_fighting_style", r.fightingStyleId),
    }))
  )
);

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
