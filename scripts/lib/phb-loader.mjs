/** Carrega catálogo PHB de data/phb/ para seed SQL. */
import fs from "fs";
import path from "path";
import { CLASS_PROGRESSION } from "../class-progression-data.mjs";
import { extractClassCatalog } from "./class-normalize.mjs";
import {
  buildSpeciesTraitCatalogs,
  choiceKindForTrait,
} from "./species-trait-catalogs.mjs";
import { FEAT_CATEGORIES } from "./feat-categories.mjs";
import { CLASS_SPELL_SLOT_PATTERN } from "./spell-slot-patterns.mjs";
import { collectSourceCitations, sourceCitationSlug } from "./source-citations.mjs";
import { SPELL_SCHOOL_SLUG_BY_NAME, SPELL_SCHOOLS } from "./spell-schools.mjs";
import { TOOL_CATEGORIES, toolCategorySlug, categorySlugFromName } from "./tool-categories.mjs";

const ABILITY_PT = {
  Força: "forca",
  Destreza: "destreza",
  Constituição: "constituicao",
  Inteligência: "inteligencia",
  Sabedoria: "sabedoria",
  Carisma: "carisma",
};

function parseStrengthReq(value) {
  if (value == null) return null;
  if (typeof value === "number") return value;
  const m = String(value).match(/\d+/);
  return m ? Number(m[0]) : null;
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

function listJson(dir) {
  return fs
    .readdirSync(dir)
    .filter((f) => f.endsWith(".json"))
    .map((f) => path.join(dir, f));
}

export function loadPhbCatalog(root) {
  const phb = path.join(root, "data/phb");

  const alignments = readJson(path.join(phb, "creation/alignments.json")).alignments;
  const languages = readJson(path.join(phb, "creation/languages.json")).languages;
  const skillsIndex = readJson(path.join(phb, "skills/index.json"));
  const abilities = skillsIndex.abilities.map((a, i) => ({ ...a, sortOrder: i + 1 }));
  const skills = listJson(path.join(phb, "skills"))
    .filter((f) => !f.includes(`${path.sep}rules${path.sep}`) && !f.endsWith(`${path.sep}index.json`))
    .map((f) => readJson(f));

  const featsIndex = readJson(path.join(phb, "feats/index.json")).feats;
  const featsRaw = featsIndex.map(({ id }) => readJson(path.join(phb, "feats", `${id}.json`)));
  const feats = featsRaw.map((f) => ({
    id: f.id,
    name: f.name,
    categorySlug: f.category,
    repeatable: f.repeatable,
    prerequisite: f.prerequisite ?? null,
    sourceCitationSlug: sourceCitationSlug(f.source),
  }));

  const featBenefits = [];
  for (const f of featsRaw) {
    for (let i = 0; i < (f.benefits ?? []).length; i++) {
      const b = f.benefits[i];
      featBenefits.push({
        featId: f.id,
        sortOrder: i + 1,
        name: b.name ?? null,
        description: b.description,
      });
    }
  }

  const spellIndex = readJson(path.join(phb, "spells/index.json"));
  const spellsRaw = spellIndex.spells.map(({ file }) => readJson(path.join(phb, "spells", file)));
  const spells = spellsRaw.map((s) => ({
    id: s.id,
    name: s.name,
    level: s.level,
    levelLabel: s.levelLabel,
    schoolSlug: SPELL_SCHOOL_SLUG_BY_NAME[s.school],
    castingTime: s.castingTime,
    range: s.range,
    hasVerbal: s.components.verbal,
    hasSomatic: s.components.somatic,
    hasMaterial: s.components.material,
    materialDescription: s.components.materialDescription ?? null,
    componentsLabel: s.components.text,
    duration: s.duration,
    concentration: s.concentration,
    ritual: s.ritual,
    description: s.description,
    higherLevels: s.higherLevels ?? null,
    sourceCitationSlug: sourceCitationSlug(s.source),
  }));

  const index = readJson(path.join(phb, "index.json"));
  const classesRaw = index.classes.map(({ file }) => readJson(path.join(phb, file)));
  const classCatalog = extractClassCatalog(classesRaw);
  const classes = classCatalog.classesNorm.map((c) => ({
    ...c,
    sourceCitationSlug: sourceCitationSlug(c.source),
    spellSlotPatternSlug: CLASS_SPELL_SLOT_PATTERN[c.id] ?? null,
  }));
  const subclassesRaw = index.classes.flatMap(({ subclasses: subs }) =>
    subs.map(({ file }) => readJson(path.join(phb, file)))
  );
  const subclasses = subclassesRaw.map((s) => ({
    id: s.id,
    classId: s.classId,
    name: s.name,
    tagline: s.tagline ?? null,
    summary: s.summary ?? null,
    description: s.description ?? null,
    sourceCitationSlug: sourceCitationSlug(s.source),
  }));

  const subclassFeatures = [];
  for (const sub of subclassesRaw) {
    for (const feat of sub.features ?? []) {
      subclassFeatures.push({
        subclassId: sub.id,
        level: feat.level,
        name: feat.name,
        description: feat.description,
      });
    }
  }

  const speciesIndex = readJson(path.join(phb, "species/index.json"));
  const species = speciesIndex.species.map(({ file }) =>
    readJson(path.join(phb, "species", file))
  );

  const bgIndex = readJson(path.join(phb, "backgrounds/index.json"));
  const backgrounds = bgIndex.backgrounds.map(({ file }) =>
    readJson(path.join(phb, "backgrounds", file))
  );

  const weaponsDoc = readJson(path.join(phb, "weapons/weapons.json"));
  const armorDoc = readJson(path.join(phb, "armor/armor.json"));
  const armorRules = readJson(path.join(phb, "armor/rules.json"));
  const armorCategories = (armorRules.categories ?? []).map((c, i) => ({
    ...c,
    sortOrder: i + 1,
  }));
  const gearDoc = readJson(path.join(phb, "equipment/gear/adventuring-gear.json"));
  const artisanTools = readJson(path.join(phb, "equipment/tools/artisan.json")).tools ?? [];
  const otherTools = readJson(path.join(phb, "equipment/tools/other.json")).tools ?? [];

  const weaponProperties = readJson(path.join(phb, "weapons/properties.json")).weaponProperties;
  const characterLevels = readJson(path.join(phb, "rules/character-advancement.json")).levels;

  const fightingStylesDoc = readJson(path.join(phb, "classes/fighting-styles.json"));
  const styleIds = new Set([
    ...fightingStylesDoc.standardStyleIds,
    ...Object.values(fightingStylesDoc.classAlternativeStyleIds ?? {}).flat(),
  ]);
  const fightingStyles = [...styleIds].map((id) => {
    const featPath = path.join(phb, "feats", `${id}.json`);
    let name = id;
    let description = id;
    if (fs.existsSync(featPath)) {
      const feat = readJson(featPath);
      name = feat.name;
      description = feat.benefits?.map((b) => b.description).join(" ") ?? feat.name;
    } else if (id === "blessed-warrior") {
      name = "Combatente Abençoado";
      description = "Estilo de luta alternativo do Paladino (PHB 2024).";
    } else if (id === "druidic-warrior") {
      name = "Combatente Druídico";
      description = "Estilo de luta alternativo do Guardião (PHB 2024).";
    }
    return {
      id,
      name,
      description,
      classes: fightingStylesDoc.classesWithFightingStyle.filter((cid) => {
        const alt = fightingStylesDoc.classAlternativeStyleIds?.[cid] ?? [];
        return fightingStylesDoc.standardStyleIds.includes(id) || alt.includes(id);
      }),
    };
  });

  const spellClassLinks = [];
  const byClassDir = path.join(phb, "spells/by-class");
  for (const file of fs.readdirSync(byClassDir)) {
    if (file === "index.json") continue;
    const doc = readJson(path.join(byClassDir, file));
    for (const ids of Object.values(doc.byLevel ?? {})) {
      for (const entry of ids) {
        const spellId = typeof entry === "string" ? entry : entry.id;
        spellClassLinks.push({ spellId, classId: doc.classId });
      }
    }
  }

  const subclassPreparedSpells = [];
  for (const sub of subclassesRaw) {
    if (sub.preparedSpellsByLevel) {
      for (const [lvl, spellIds] of Object.entries(sub.preparedSpellsByLevel)) {
        for (const spellId of spellIds) {
          subclassPreparedSpells.push({
            subclassId: sub.id,
            unlockLevel: Number(lvl),
            spellId,
            terrainId: null,
          });
        }
      }
    }
    if (sub.preparedSpellsByTerrain) {
      for (const [terrainId, byLevel] of Object.entries(sub.preparedSpellsByTerrain)) {
        for (const [lvl, spellIds] of Object.entries(byLevel)) {
          for (const spellId of spellIds) {
            subclassPreparedSpells.push({
              subclassId: sub.id,
              unlockLevel: Number(lvl),
              spellId,
              terrainId,
            });
          }
        }
      }
    }
  }

  const items = [];
  const addItem = (row) => {
    if (!items.some((i) => i.id === row.id)) items.push(row);
  };

  for (const w of weaponsDoc.weapons) {
    addItem({
      id: w.id,
      itemType: "weapon",
      name: w.name,
      cost: w.cost ? { text: w.cost } : null,
      weight: w.weight ?? null,
      description: null,
      properties: { propertyIds: w.propertyIds, masteryId: w.masteryId, range: w.range },
      weapon: {
        category: w.category,
        damage: w.damage,
        damageType: w.damageType,
        propertyIds: w.propertyIds,
        masteryId: w.masteryId,
      },
    });
  }

  for (const a of armorDoc.items) {
    addItem({
      id: a.id,
      itemType: "armor",
      name: a.name,
      cost: a.cost ? { text: a.cost } : null,
      weight: a.weight ?? null,
      description: null,
      properties: { acFormula: a.acFormula, propertyIds: a.propertyIds },
      armor: {
        categoryId: a.category,
        acBase: a.acFormula?.base ?? null,
        acFormula: a.ac,
        strengthReq: parseStrengthReq(a.strength),
        stealthDisadvantage: Boolean(a.stealthDisadvantage),
      },
    });
  }

  for (const g of gearDoc.items) {
    const itemType = g.id.startsWith("foco-") ? "focus" : "gear";
    addItem({
      id: g.id,
      itemType,
      name: g.name,
      cost: g.cost ? { text: g.cost } : null,
      weight: g.weight ?? null,
      description: g.description ?? null,
      properties: null,
    });
  }

  for (const t of [...artisanTools, ...otherTools]) {
    addItem({
      id: t.id,
      itemType: "tool",
      name: t.name,
      cost: t.cost ? { text: t.cost } : null,
      weight: t.weight ?? null,
      description: t.useObject ?? t.description ?? null,
      properties: {
        attribute: t.attribute ?? null,
        crafting: t.crafting ?? null,
        variants: t.variants ?? null,
      },
      tool: {
        categoryId: toolCategorySlug(t.id),
        useDescription: t.useObject ?? null,
      },
    });
  }

  const classProgression = [];
  const classFeatures = [];
  const classSkillPools = [];

  for (const cls of classes) {
    for (const skillId of cls.skillChoices?.skillIds ?? []) {
      classSkillPools.push({ classId: cls.id, skillId });
    }
    for (const feat of cls.features ?? []) {
      classFeatures.push({
        classId: cls.id,
        level: feat.level,
        name: feat.name,
        description: feat.description,
      });
    }
    const prog = CLASS_PROGRESSION[cls.id];
    if (prog) {
      for (const row of prog.levels) {
        classProgression.push({
          classId: cls.id,
          level: row.level,
          proficiencyBonus: row.proficiencyBonus,
          cantrips: row.cantrips ?? null,
          preparedSpells: row.preparedSpells ?? null,
          channelDivinity: row.channelDivinity ?? null,
        });
      }
    }
  }

  const speciesTraitCatalogs = buildSpeciesTraitCatalogs(species);

  const speciesTraits = [];
  for (const sp of species) {
    for (const trait of sp.traits ?? []) {
      speciesTraits.push({
        speciesId: sp.id,
        name: trait.name,
        description: trait.description,
        choiceKind: choiceKindForTrait(sp.id, trait.name),
      });
    }
  }

  const backgroundSkills = [];
  const backgroundAbilityOptions = [];
  const backgroundStartingPackages = [];
  const backgroundStartingItems = [];
  const backgroundsNorm = backgrounds.map((bg) => {
    const abilitySlugs = (bg.abilityOptions ?? []).map((name) => ABILITY_PT[name] ?? name);
    abilitySlugs.forEach((abilityId, sortOrder) => {
      backgroundAbilityOptions.push({
        backgroundId: bg.id,
        abilityId,
        sortOrder: sortOrder + 1,
      });
    });
    for (const skillId of bg.skillIds ?? []) {
      backgroundSkills.push({ backgroundId: bg.id, skillId });
    }
    for (const [pkgIndex, pkg] of (bg.equipment?.packages ?? []).entries()) {
      backgroundStartingPackages.push({
        backgroundId: bg.id,
        packageSlug: pkg.id,
        label: pkg.label,
        gold: pkg.gold ?? null,
        sortOrder: pkgIndex + 1,
      });
      let itemOrder = 0;
      for (const entry of pkg.items ?? []) {
        itemOrder += 1;
        if (entry.id) {
          backgroundStartingItems.push({
            backgroundId: bg.id,
            packageSlug: pkg.id,
            itemId: entry.id,
            quantity: entry.quantity ?? 1,
            choiceText: null,
            sortOrder: itemOrder,
          });
        } else if (entry.choice) {
          backgroundStartingItems.push({
            backgroundId: bg.id,
            packageSlug: pkg.id,
            itemId: null,
            quantity: 1,
            choiceText: entry.choice,
            sortOrder: itemOrder,
          });
        }
      }
    }
    const tool = bg.toolProficiency ?? {};
    const toolCategorySlugValue =
      tool.kind === "choice" ? categorySlugFromName(tool.category) : null;
    return {
      ...bg,
      abilityOptions: abilitySlugs,
      featId: bg.feat?.id ?? null,
      sourceCitationSlug: sourceCitationSlug(bg.source),
      equipmentGoldOption: bg.equipment?.goldOption ?? null,
      toolProficiencyDescription: tool.description ?? null,
      toolProficiencyKind: tool.kind ?? null,
      toolItemId: tool.itemId ?? null,
      toolCategorySlug: toolCategorySlugValue,
    };
  });

  const sourceCitations = collectSourceCitations(
    backgrounds,
    classesRaw,
    featsRaw,
    spellsRaw,
    subclassesRaw
  );

  const classSavingThrows = [];
  for (const cls of classes) {
    for (const abilityId of cls.savingThrowIds ?? []) {
      classSavingThrows.push({ classId: cls.id, abilityId });
    }
  }

  return {
    alignments,
    abilities,
    languages,
    skills,
    feats,
    featBenefits,
    featCategories: FEAT_CATEGORIES,
    spellSchools: SPELL_SCHOOLS,
    spells,
    classes,
    classPrimaryAbilities: classCatalog.classPrimaryAbilities,
    classArmorTraining: classCatalog.classArmorTraining,
    classWeaponProficiencies: classCatalog.classWeaponProficiencies,
    classStartingPackages: classCatalog.classStartingPackages,
    classStartingItems: classCatalog.classStartingItems,
    classSpellcasting: classCatalog.classSpellcasting,
    weaponProfTerms: classCatalog.weaponProfTerms,
    subclasses,
    subclassFeatures,
    species,
    backgrounds: backgroundsNorm,
    backgroundSkills,
    backgroundAbilityOptions,
    backgroundStartingPackages,
    backgroundStartingItems,
    sourceCitations,
    classSavingThrows,
    items,
    armorCategories,
    toolCategories: TOOL_CATEGORIES,
    weaponProperties,
    fightingStyles,
    characterLevels,
    spellClassLinks,
    subclassPreparedSpells,
    classProgression,
    classFeatures,
    classSkillPools,
    speciesTraits,
    speciesTraitCatalogs,
    counts: {
      alignments: alignments.length,
      abilities: abilities.length,
      languages: languages.length,
      skills: skills.length,
      feats: feats.length,
      featBenefits: featBenefits.length,
      spells: spells.length,
      classes: classes.length,
      subclasses: subclasses.length,
      subclassFeatures: subclassFeatures.length,
      species: species.length,
      backgrounds: backgrounds.length,
      sourceCitations: sourceCitations.length,
      backgroundStartingPackages: backgroundStartingPackages.length,
      backgroundStartingItems: backgroundStartingItems.length,
      items: items.length,
      armorCategories: armorCategories.length,
      toolCategories: TOOL_CATEGORIES.length,
      spellClassLinks: spellClassLinks.length,
      subclassPreparedSpells: subclassPreparedSpells.length,
    },
  };
}
