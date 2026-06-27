/**
 * Catálogo tipado v3 — recursos, fontes de magia, opções espécie/classe.
 * Fonte: character-rules.mjs + data/phb/
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  AASIMAR_REVELATIONS,
  DRAGON_ANCESTRIES,
  ELF_LINEAGE_SPELLS,
  GIANT_ANCESTRIES,
  GNOME_LINEAGES,
  TIEFLING_LEGACIES,
} from "../character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "..", "data/phb");

function readJson(rel) {
  return JSON.parse(fs.readFileSync(path.join(phb, rel), "utf8"));
}

export function buildResourceDefinitions() {
  const species = [
    { id: "breathWeapon", name: "Sopro Dracônico", speciesId: "dragonborn" },
    { id: "dragonFlight", name: "Voo Dracônico", speciesId: "dragonborn", minLevel: 5 },
    { id: "giantAncestry", name: "Ancestralidade Gigante", speciesId: "goliath" },
    { id: "largeForm", name: "Forma Grande", speciesId: "goliath", minLevel: 5 },
    { id: "adrenalineSurge", name: "Surto de Adrenalina", speciesId: "orc" },
    { id: "relentlessEndurance", name: "Persistência Implacável", speciesId: "orc" },
    { id: "healingHands", name: "Mãos Curativas", speciesId: "aasimar" },
    { id: "celestialRevelation", name: "Revelação Celestial", speciesId: "aasimar", minLevel: 3 },
    { id: "stonecunning", name: "Percepção de Pedra", speciesId: "dwarf" },
  ];
  const classes = [
    { id: "rage", name: "Fúria", classId: "barbarian" },
    { id: "channelDivinity", name: "Canalizar Divindade", classId: "cleric" },
    { id: "focusPoints", name: "Pontos de Foco", classId: "monk" },
  ];
  return [
    ...species.map((r) => ({
      id: r.id,
      name: r.name,
      scope: "species",
      speciesId: r.speciesId,
      classId: null,
      minLevel: r.minLevel ?? 1,
    })),
    ...classes.map((r) => ({
      id: r.id,
      name: r.name,
      scope: "class",
      speciesId: null,
      classId: r.classId,
      minLevel: 1,
    })),
  ];
}

export function buildSpellSources() {
  const sources = [
    { id: "class", label: "Lista de classe", originType: "class" },
    { id: "magic-initiate", label: "Iniciado em Magia", originType: "feat", featId: "magic-initiate" },
    { id: "elf-lineage", label: "Linhagem Élfica", originType: "species", speciesId: "elf" },
    { id: "infernal-legacy", label: "Legado Ínfero", originType: "species", speciesId: "tiefling" },
    { id: "tiefling-presence", label: "Presença Tiferina", originType: "species", speciesId: "tiefling" },
    { id: "gnome-lineage", label: "Linhagem Gnômica", originType: "species", speciesId: "gnome" },
    { id: "aasimar-light", label: "Luz Aasimar", originType: "species", speciesId: "aasimar" },
  ];

  const subclassesDir = path.join(phb, "subclasses");
  for (const file of fs.readdirSync(subclassesDir)) {
    if (!file.endsWith(".json")) continue;
    const sub = readJson(`subclasses/${file}`);
    if (sub.preparedSpellSourceKey) {
      sources.push({
        id: sub.preparedSpellSourceKey,
        label: sub.name,
        originType: "subclass",
        subclassId: sub.id,
        classId: sub.classId,
      });
    }
  }

  const seen = new Set();
  return sources.filter((s) => {
    if (seen.has(s.id)) return false;
    seen.add(s.id);
    return true;
  });
}

export function buildSpeciesOptionDefs() {
  return [
    { speciesId: "elf", optionKey: "lineageId", valueType: "catalog" },
    { speciesId: "elf", optionKey: "keenSensesSkillId", valueType: "skill" },
    { speciesId: "tiefling", optionKey: "infernalLegacyId", valueType: "catalog" },
    { speciesId: "tiefling", optionKey: "infernalCastingAbilityId", valueType: "ability" },
    { speciesId: "gnome", optionKey: "gnomeLineageId", valueType: "catalog" },
    { speciesId: "gnome", optionKey: "gnomeCastingAbilityId", valueType: "ability" },
    { speciesId: "dragonborn", optionKey: "dragonAncestryId", valueType: "catalog" },
    { speciesId: "goliath", optionKey: "giantAncestryId", valueType: "catalog" },
    { speciesId: "aasimar", optionKey: "aasimarRevelationId", valueType: "catalog" },
  ];
}

export function buildSpeciesOptionValues() {
  const rows = [];
  const add = (speciesId, optionKey, valueId, label) =>
    rows.push({ speciesId, optionKey, valueId, label: label ?? valueId });

  for (const id of Object.keys(ELF_LINEAGE_SPELLS)) {
    add("elf", "lineageId", id, id);
  }
  for (const id of TIEFLING_LEGACIES) add("tiefling", "infernalLegacyId", id, id);
  for (const id of GNOME_LINEAGES) add("gnome", "gnomeLineageId", id, id);
  for (const id of DRAGON_ANCESTRIES) add("dragonborn", "dragonAncestryId", id, id);
  for (const id of GIANT_ANCESTRIES) add("goliath", "giantAncestryId", id, id);
  for (const id of AASIMAR_REVELATIONS) add("aasimar", "aasimarRevelationId", id, id);

  return rows;
}

export function buildClassOptionDefs() {
  return [
    { classId: "cleric", optionKey: "divineOrder", valueType: "catalog" },
    { classId: "cleric", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "fighter", optionKey: "fightingStyleId", valueType: "fighting_style" },
    { classId: "paladin", optionKey: "fightingStyleId", valueType: "fighting_style" },
    { classId: "ranger", optionKey: "fightingStyleId", valueType: "fighting_style" },
    { classId: "druid", optionKey: "landTerrainId", valueType: "terrain" },
    { classId: "barbarian", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "bard", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "rogue", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "wizard", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "sorcerer", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "warlock", optionKey: "skillIds", valueType: "skill_list" },
    { classId: "monk", optionKey: "skillIds", valueType: "skill_list" },
  ];
}

export function buildClassOptionValues() {
  return [
    { classId: "cleric", optionKey: "divineOrder", valueId: "protector", label: "Protetor" },
    { classId: "cleric", optionKey: "divineOrder", valueId: "thaumaturge", label: "Taumaturgo" },
  ];
}

export function buildAbilityGenerationMethods() {
  return readJson("creation/ability-generation.json").methods.map((m) => ({
    id: m.id,
    name: m.name,
    description: m.description,
  }));
}

export function buildBackgroundBoostOptions() {
  return readJson("creation/ability-generation.json").backgroundBoost.options.map((o) => ({
    id: o.id,
    label: o.label,
  }));
}

export function buildDruidLandTerrains() {
  const land = readJson("subclasses/druid-land.json");
  return (land.landTerrainIds ?? []).map((id) => ({
    id,
    label: id,
  }));
}

export function buildClassFightingStyles() {
  const doc = readJson("classes/fighting-styles.json");
  const rows = [];
  for (const classId of doc.classesWithFightingStyle) {
    for (const styleId of doc.standardStyleIds) {
      rows.push({ classId, fightingStyleId: styleId });
    }
    for (const styleId of doc.classAlternativeStyleIds?.[classId] ?? []) {
      rows.push({ classId, fightingStyleId: styleId });
    }
  }
  return rows;
}
