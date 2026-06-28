/**
 * Blueprints e build de fichas a partir do catálogo PHB (sem I/O).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  AASIMAR_REVELATIONS,
  DRAGON_ANCESTRIES,
  GIANT_ANCESTRIES,
  GNOME_LINEAGES,
  TIEFLING_LEGACIES,
  allSpeciesCantripIds,
  expectedArmorClass,
  expectedChannelDivinity,
  expectedClassCantrips,
  expectedFocusPoints,
  expectedMaxHpForCharacter,
  expectedPassivePerception,
  expectedPreparedCount,
  expectedRageUses,
  expectedSpeciesResources,
  expectedSpellSlots,
  expectedSubclassPrepared,
  expectedWeaponMasterySlots,
  isSpellcaster,
  loadBackground,
  loadClass,
  speciesSpellEntries,
} from "../character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..", "..");
const phb = path.join(root, "data/phb");

const STANDARD_ARRAY = [15, 14, 13, 12, 10, 8];
const ABILITY_PT = {
  Força: "forca",
  Destreza: "destreza",
  Constituição: "constituicao",
  Inteligência: "inteligencia",
  Sabedoria: "sabedoria",
  Carisma: "carisma",
};

const CASTING_ABILITIES = ["inteligencia", "sabedoria", "carisma"];

const SPECIES_LEVELS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

const EQUIP = {
  heavyDefense: {
    items: [
      { itemId: "chain-mail", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "longsword", source: "class-starting", equipped: true, slot: "mainHand" },
      { itemId: "shield", source: "class-starting", equipped: true, slot: "shield" },
    ],
    style: "defense",
  },
  heavyNoStyle: {
    items: [
      { itemId: "chain-mail", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "longsword", source: "class-starting", equipped: true, slot: "mainHand" },
      { itemId: "shield", source: "class-starting", equipped: true, slot: "shield" },
    ],
  },
  leather: {
    items: [
      { itemId: "leather", source: "class-starting", equipped: true, slot: "armor" },
    ],
  },
  leatherRogue: {
    items: [
      { itemId: "leather", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "shortsword", source: "class-starting", equipped: true, slot: "mainHand" },
    ],
  },
  leatherWarlock: {
    items: [
      { itemId: "leather", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "sickle", source: "class-starting", equipped: true, slot: "mainHand" },
    ],
  },
  caster: {
    items: [{ itemId: "foco-arcano", source: "class-starting", equipped: true, slot: "focus" }],
  },
  unarmored: {
    items: [{ itemId: "greataxe", source: "class-starting", equipped: true, slot: "mainHand" }],
  },
  leatherShield: {
    items: [
      { itemId: "leather", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "shield", source: "class-starting", equipped: true, slot: "shield" },
      { itemId: "sickle", source: "class-starting", equipped: true, slot: "mainHand" },
    ],
  },
  clericKit: {
    items: [
      { itemId: "leather", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "shield", source: "class-starting", equipped: true, slot: "shield" },
      { itemId: "mace", source: "class-starting", equipped: true, slot: "mainHand" },
    ],
  },
  monkKit: {
    items: [
      { itemId: "shortsword", source: "class-starting", equipped: true, slot: "mainHand" },
    ],
  },
  rangerKit: {
    items: [
      { itemId: "leather", source: "class-starting", equipped: true, slot: "armor" },
      { itemId: "longbow", source: "class-starting", equipped: true, slot: "mainHand" },
    ],
    style: "archery",
  },
};

const PHB_INDEX = JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8"));
const SPECIES_INDEX = JSON.parse(fs.readFileSync(path.join(phb, "species/index.json"), "utf8"));
const BG_INDEX = JSON.parse(fs.readFileSync(path.join(phb, "backgrounds/index.json"), "utf8"));
const ALIGNMENTS = JSON.parse(
  fs.readFileSync(path.join(phb, "creation/alignments.json"), "utf8")
).alignments.map((a) => a.id);
const FIGHTING_STYLES = JSON.parse(
  fs.readFileSync(path.join(phb, "classes/fighting-styles.json"), "utf8")
);

const ELF_LINEAGES = ["high-elf", "drow", "wood-elf"];
const ELF_KEEN = ["insight", "perception", "survival"];
const LAND_TERRAINS = ["arid", "polar", "temperate", "tropical"];

const MI_BG_CLASS = { acolyte: "cleric", guide: "druid", sage: "wizard" };

const CLASS_CONFIG = {
  barbarian: {
    equip: "unarmored",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    mastery: ["greataxe", "handaxe", "javelin"],
  },
  bard: {
    equip: "leather",
    priority: ["carisma", "destreza", "constituicao", "inteligencia", "sabedoria", "forca"],
    mastery: ["longsword", "shortbow", "rapier"],
  },
  cleric: {
    equip: "clericKit",
    priority: ["sabedoria", "constituicao", "forca", "carisma", "destreza", "inteligencia"],
    mastery: [],
  },
  druid: {
    equip: "leatherShield",
    priority: ["sabedoria", "constituicao", "destreza", "inteligencia", "forca", "carisma"],
    mastery: [],
  },
  fighter: {
    equip: "heavyDefense",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    mastery: ["longsword", "light-crossbow", "spear", "javelin"],
  },
  monk: {
    equip: "monkKit",
    priority: ["destreza", "sabedoria", "constituicao", "forca", "inteligencia", "carisma"],
    mastery: [],
  },
  paladin: {
    equip: "heavyDefense",
    priority: ["forca", "carisma", "constituicao", "sabedoria", "destreza", "inteligencia"],
    mastery: ["longsword", "javelin", "light-crossbow"],
  },
  ranger: {
    equip: "rangerKit",
    priority: ["destreza", "sabedoria", "constituicao", "forca", "inteligencia", "carisma"],
    mastery: ["longbow", "shortsword", "rapier"],
  },
  rogue: {
    equip: "leatherRogue",
    priority: ["destreza", "inteligencia", "constituicao", "carisma", "sabedoria", "forca"],
    mastery: ["rapier", "shortbow", "dagger"],
  },
  sorcerer: {
    equip: "caster",
    priority: ["carisma", "constituicao", "destreza", "sabedoria", "inteligencia", "forca"],
    mastery: [],
  },
  warlock: {
    equip: "leatherWarlock",
    priority: ["carisma", "constituicao", "destreza", "inteligencia", "sabedoria", "forca"],
    mastery: [],
  },
  wizard: {
    equip: "caster",
    priority: ["inteligencia", "constituicao", "destreza", "sabedoria", "carisma", "forca"],
    mastery: [],
  },
};

/** Fichas curadas com casos de borda (estilos alternativos, MI, etc.). */
const CORE_BLUEPRINTS = [
  {
    id: "thorn",
    name: "Thorn",
    level: 3,
    speciesId: "elf",
    speciesChoices: { lineageId: "wood-elf", keenSensesSkillId: "survival" },
    backgroundId: "farmer",
    classId: "druid",
    subclassId: "land",
    classChoices: { skillIds: ["perception"], landTerrainId: "temperate" },
    alignmentId: "neutral-good",
    boostId: "three-plus-one",
    priority: ["sabedoria", "constituicao", "destreza", "inteligencia", "forca", "carisma"],
    equip: "leatherShield",
    mastery: [],
  },
  {
    id: "kael",
    name: "Kael",
    level: 1,
    speciesId: "human",
    backgroundId: "noble",
    classId: "paladin",
    classChoices: {
      skillIds: ["religion", "insight"],
      fightingStyleId: "blessed-warrior",
    },
    alignmentId: "lawful-good",
    boostId: "two-and-one",
    priority: ["carisma", "forca", "constituicao", "sabedoria", "destreza", "inteligencia"],
    equip: "heavyNoStyle",
    blessedCantrips: ["chama-sagrada", "orientacao"],
    mastery: ["longsword", "javelin"],
  },
  {
    id: "serra",
    name: "Serra",
    level: 1,
    speciesId: "halfling",
    backgroundId: "guide",
    classId: "ranger",
    classChoices: {
      skillIds: ["survival", "nature", "perception"],
      fightingStyleId: "druidic-warrior",
    },
    alignmentId: "chaotic-good",
    boostId: "three-plus-one",
    priority: ["sabedoria", "destreza", "constituicao", "forca", "inteligencia", "carisma"],
    equip: "rangerKit",
    blessedCantrips: ["fagulha-estelar", "orientacao"],
    mastery: ["longbow", "shortsword"],
  },
  {
    id: "bjorn",
    name: "Bjorn",
    level: 1,
    speciesId: "goliath",
    speciesChoices: { giantAncestryId: "hill" },
    backgroundId: "soldier",
    classId: "barbarian",
    classChoices: { skillIds: ["athletics", "intimidation"] },
    alignmentId: "chaotic-neutral",
    boostId: "three-plus-one",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    equip: "unarmored",
    mastery: ["greataxe", "handaxe"],
  },
  {
    id: "lyra",
    name: "Lyra",
    level: 1,
    speciesId: "tiefling",
    speciesChoices: {
      infernalLegacyId: "infernal",
      infernalCastingAbilityId: "carisma",
    },
    backgroundId: "entertainer",
    classId: "bard",
    classChoices: { skillIds: ["performance", "persuasion"] },
    alignmentId: "chaotic-neutral",
    boostId: "two-and-one",
    priority: ["carisma", "destreza", "constituicao", "inteligencia", "sabedoria", "forca"],
    equip: "leather",
    mastery: [],
  },
  {
    id: "mira",
    name: "Mira",
    level: 1,
    speciesId: "gnome",
    speciesChoices: { gnomeLineageId: "rock-gnome", gnomeCastingAbilityId: "inteligencia" },
    backgroundId: "sage",
    classId: "wizard",
    classChoices: { skillIds: ["arcana", "investigation"] },
    alignmentId: "true-neutral",
    boostId: "three-plus-one",
    priority: ["inteligencia", "constituicao", "destreza", "sabedoria", "carisma", "forca"],
    equip: "caster",
    mastery: [],
  },
  {
    id: "zara",
    name: "Zara",
    level: 1,
    speciesId: "dragonborn",
    speciesChoices: { dragonAncestryId: "red" },
    backgroundId: "noble",
    classId: "sorcerer",
    classChoices: { skillIds: ["arcana", "persuasion"] },
    alignmentId: "lawful-evil",
    boostId: "two-and-one",
    priority: ["carisma", "constituicao", "destreza", "sabedoria", "inteligencia", "forca"],
    equip: "caster",
    mastery: [],
  },
  {
    id: "pact",
    name: "Vex",
    level: 1,
    speciesId: "tiefling",
    speciesChoices: {
      infernalLegacyId: "chthonic",
      infernalCastingAbilityId: "carisma",
    },
    backgroundId: "charlatan",
    classId: "warlock",
    classChoices: { skillIds: ["deception", "arcana"] },
    alignmentId: "neutral-evil",
    boostId: "three-plus-one",
    priority: ["carisma", "constituicao", "destreza", "inteligencia", "sabedoria", "forca"],
    equip: "leatherWarlock",
    mastery: [],
  },
  {
    id: "finn",
    name: "Finn",
    level: 1,
    speciesId: "halfling",
    backgroundId: "criminal",
    classId: "rogue",
    classChoices: { skillIds: ["stealth", "perception", "investigation", "deception"] },
    alignmentId: "chaotic-neutral",
    boostId: "three-plus-one",
    priority: ["destreza", "inteligencia", "constituicao", "carisma", "sabedoria", "forca"],
    equip: "leatherRogue",
    mastery: ["rapier", "shortbow"],
  },
  {
    id: "kenji",
    name: "Kenji",
    level: 1,
    speciesId: "human",
    backgroundId: "wanderer",
    classId: "monk",
    classChoices: { skillIds: ["acrobatics", "insight"] },
    alignmentId: "lawful-neutral",
    boostId: "three-plus-one",
    priority: ["destreza", "sabedoria", "constituicao", "forca", "inteligencia", "carisma"],
    equip: "monkKit",
    skilledSkills: ["athletics", "stealth", "religion"],
    mastery: [],
  },
  {
    id: "helga",
    name: "Helga",
    level: 3,
    speciesId: "dwarf",
    backgroundId: "artisan",
    classId: "cleric",
    subclassId: "war",
    classChoices: { divineOrder: "protector", skillIds: ["religion", "insight"] },
    alignmentId: "lawful-good",
    boostId: "three-plus-one",
    priority: ["forca", "sabedoria", "constituicao", "carisma", "destreza", "inteligencia"],
    equip: "clericKit",
    mastery: [],
  },
  {
    id: "raven",
    name: "Raven",
    level: 3,
    speciesId: "elf",
    speciesChoices: { lineageId: "drow", keenSensesSkillId: "perception" },
    backgroundId: "wanderer",
    classId: "ranger",
    subclassId: "gloom-stalker",
    classChoices: {
      skillIds: ["stealth", "survival", "investigation"],
      fightingStyleId: "dueling",
    },
    alignmentId: "true-neutral",
    boostId: "two-and-one",
    priority: ["destreza", "sabedoria", "constituicao", "inteligencia", "carisma", "forca"],
    equip: "rangerKit",
    mastery: ["shortsword", "longbow"],
  },
  {
    id: "garruk",
    name: "Garruk",
    level: 3,
    speciesId: "human",
    backgroundId: "soldier",
    classId: "paladin",
    subclassId: "devotion",
    classChoices: {
      skillIds: ["athletics", "intimidation"],
      fightingStyleId: "defense",
    },
    alignmentId: "lawful-good",
    boostId: "three-plus-one",
    priority: ["forca", "carisma", "constituicao", "sabedoria", "destreza", "inteligencia"],
    equip: "heavyDefense",
    mastery: ["longsword", "javelin"],
  },
  {
    id: "celeste",
    name: "Celeste",
    level: 3,
    speciesId: "aasimar",
    speciesChoices: { aasimarRevelationId: "celestial-wings" },
    backgroundId: "acolyte",
    classId: "warlock",
    subclassId: "celestial",
    classChoices: { skillIds: ["religion", "arcana"] },
    alignmentId: "neutral-good",
    boostId: "two-and-one",
    priority: ["carisma", "sabedoria", "constituicao", "inteligencia", "destreza", "forca"],
    equip: "leatherWarlock",
    magicInitiate: {
      cantripIds: ["luz", "taumaturgia"],
      preparedSpellId: "curar-ferimentos",
      castingAbilityId: "sabedoria",
    },
    mastery: [],
  },
  {
    id: "bronwyn",
    name: "Bronwyn",
    level: 4,
    speciesId: "human",
    backgroundId: "guard",
    classId: "fighter",
    classChoices: {
      skillIds: ["athletics", "intimidation"],
      fightingStyleId: "great-weapon-fighting",
    },
    alignmentId: "lawful-neutral",
    boostId: "three-plus-one",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    equip: {
      items: [
        { itemId: "chain-mail", source: "class-starting", equipped: true, slot: "armor" },
        { itemId: "longsword", source: "class-starting", equipped: true, slot: "mainHand" },
        { itemId: "greataxe", source: "purchased", equipped: false },
      ],
    },
    skilledSkills: ["perception", "survival", "insight"],
    mastery: ["greataxe", "longsword", "light-crossbow", "javelin"],
  },
  {
    id: "pip",
    name: "Pip",
    level: 3,
    speciesId: "halfling",
    backgroundId: "entertainer",
    classId: "bard",
    subclassId: "valor",
    classChoices: { skillIds: ["performance", "acrobatics"] },
    alignmentId: "chaotic-good",
    boostId: "two-and-one",
    priority: ["carisma", "destreza", "constituicao", "sabedoria", "inteligencia", "forca"],
    equip: "leather",
    mastery: ["longsword", "shortbow"],
  },
  {
    id: "nova",
    name: "Nova",
    level: 3,
    speciesId: "dragonborn",
    speciesChoices: { dragonAncestryId: "gold" },
    backgroundId: "hermit",
    classId: "sorcerer",
    subclassId: "draconic",
    classChoices: { skillIds: ["arcana", "religion"] },
    alignmentId: "chaotic-neutral",
    boostId: "three-plus-one",
    priority: ["carisma", "constituicao", "destreza", "sabedoria", "inteligencia", "forca"],
    equip: "caster",
    mastery: [],
  },
  {
    id: "oak",
    name: "Oak",
    level: 1,
    speciesId: "dwarf",
    backgroundId: "farmer",
    classId: "druid",
    classChoices: { skillIds: ["animal-handling", "nature"] },
    alignmentId: "true-neutral",
    boostId: "three-plus-one",
    priority: ["sabedoria", "constituicao", "forca", "destreza", "inteligencia", "carisma"],
    equip: "leatherShield",
    mastery: [],
  },
  {
    id: "orin",
    name: "Orin",
    level: 2,
    speciesId: "orc",
    backgroundId: "soldier",
    classId: "fighter",
    classChoices: {
      skillIds: ["athletics", "intimidation"],
      fightingStyleId: "defense",
    },
    alignmentId: "chaotic-good",
    boostId: "three-plus-one",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    equip: "heavyDefense",
    mastery: ["longsword", "javelin"],
  },
  {
    id: "sylvara",
    name: "Sylvara",
    level: 5,
    speciesId: "elf",
    speciesChoices: { lineageId: "high-elf", keenSensesSkillId: "perception" },
    backgroundId: "sage",
    classId: "wizard",
    subclassId: "evoker",
    classChoices: { skillIds: ["arcana", "history"] },
    alignmentId: "true-neutral",
    boostId: "three-plus-one",
    priority: ["inteligencia", "constituicao", "destreza", "sabedoria", "carisma", "forca"],
    equip: "caster",
    mastery: [],
  },
  {
    id: "seed-extra-01",
    name: "Extra 01",
    level: 1,
    speciesId: "orc",
    backgroundId: "farmer",
    classId: "barbarian",
    classChoices: { skillIds: ["athletics", "intimidation"] },
    alignmentId: "true-neutral",
    boostId: "three-plus-one",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    equip: "unarmored",
    mastery: ["greataxe", "handaxe"],
  },
  {
    id: "seed-extra-02",
    name: "Extra 02",
    level: 1,
    speciesId: "dwarf",
    backgroundId: "guard",
    classId: "fighter",
    classChoices: { skillIds: ["athletics", "perception"], fightingStyleId: "defense" },
    alignmentId: "lawful-neutral",
    boostId: "three-plus-one",
    priority: ["forca", "constituicao", "destreza", "sabedoria", "carisma", "inteligencia"],
    equip: "heavyDefense",
    mastery: ["longsword", "javelin"],
  },
];

/** Total alvo de fichas (core + matriz + sweeps + preservadas). */
const TARGET_CHARACTER_COUNT = 300;

function autoMagicInitiate(backgroundId) {
  const spellListClassId = MI_BG_CLASS[backgroundId];
  if (!spellListClassId) return null;
  const list = loadSpellList(spellListClassId);
  const cantripIds = (list.byLevel["0"] ?? []).slice(0, 2).map((s) => s.id);
  const preparedSpellId = (list.byLevel["1"] ?? [])[0]?.id;
  if (!preparedSpellId || cantripIds.length < 2) return null;
  const castingAbilityId =
    spellListClassId === "wizard"
      ? "inteligencia"
      : spellListClassId === "cleric" || spellListClassId === "druid"
        ? "sabedoria"
        : "carisma";
  return { cantripIds, preparedSpellId, castingAbilityId };
}

function pickClassSkills(classId, seed, count) {
  const cls = loadClass(classId);
  const pool = classSkillPool(cls);
  const picked = [];
  for (let i = 0; i < pool.length && picked.length < count; i++) {
    const skillId = pool[(seed + i * 3) % pool.length];
    if (!picked.includes(skillId)) picked.push(skillId);
  }
  return picked;
}

function pickFightingStyle(classId, seed) {
  if (!FIGHTING_STYLES.classesWithFightingStyle.includes(classId)) return null;
  if (classId === "paladin" && seed % 6 === 0) return "blessed-warrior";
  if (classId === "ranger" && seed % 6 === 1) return "druidic-warrior";
  const styles = FIGHTING_STYLES.standardStyleIds;
  return styles[seed % styles.length];
}

function pickBlessedCantrips(spellClassId) {
  const list = loadSpellList(spellClassId);
  return (list.byLevel["0"] ?? []).slice(0, 2).map((s) => s.id);
}

function defaultSpeciesChoices(speciesId, seed) {
  const casting = CASTING_ABILITIES[seed % CASTING_ABILITIES.length];
  switch (speciesId) {
    case "elf":
      return {
        lineageId: ELF_LINEAGES[seed % ELF_LINEAGES.length],
        keenSensesSkillId: ELF_KEEN[seed % ELF_KEEN.length],
      };
    case "tiefling":
      return {
        infernalLegacyId: TIEFLING_LEGACIES[seed % TIEFLING_LEGACIES.length],
        infernalCastingAbilityId: casting,
      };
    case "gnome":
      return {
        gnomeLineageId: GNOME_LINEAGES[seed % GNOME_LINEAGES.length],
        gnomeCastingAbilityId: casting,
      };
    case "dragonborn":
      return { dragonAncestryId: DRAGON_ANCESTRIES[seed % DRAGON_ANCESTRIES.length] };
    case "goliath":
      return { giantAncestryId: GIANT_ANCESTRIES[seed % GIANT_ANCESTRIES.length] };
    case "aasimar":
      return { aasimarRevelationId: AASIMAR_REVELATIONS[seed % AASIMAR_REVELATIONS.length] };
    default:
      return undefined;
  }
}

function matrixBlueprint(speciesId, level, matrixSeed, usedIds) {
  const classEntry = PHB_INDEX.classes[matrixSeed % PHB_INDEX.classes.length];
  const classId = classEntry.id;
  const cfg = CLASS_CONFIG[classId];
  const id = `sp-${speciesId}-l${String(level).padStart(2, "0")}`;
  if (usedIds.has(id)) return null;

  const unlock = loadClass(classId).subclassUnlockLevel ?? 3;
  let subclassId = null;
  if (level >= unlock && classEntry.subclasses.length) {
    subclassId = classEntry.subclasses[(matrixSeed + level) % classEntry.subclasses.length].id;
  }

  const classChoices = {
    skillIds: pickClassSkills(classId, matrixSeed, loadClass(classId).skillChoices?.count ?? 0),
  };

  if (classId === "cleric") {
    classChoices.divineOrder = matrixSeed % 2 === 0 ? "protector" : "thaumaturge";
  }

  const style = pickFightingStyle(classId, matrixSeed);
  if (style) classChoices.fightingStyleId = style;

  if (classId === "druid" && subclassId === "land") {
    classChoices.landTerrainId = LAND_TERRAINS[matrixSeed % LAND_TERRAINS.length];
  }

  const speciesChoices = defaultSpeciesChoices(speciesId, matrixSeed);

  const bp = {
    id,
    name: `${speciesId} L${level}`,
    level,
    speciesId,
    speciesChoices,
    backgroundId: BG_INDEX.backgrounds[(matrixSeed * 5 + 2) % BG_INDEX.backgrounds.length].id,
    classId,
    subclassId,
    classChoices,
    alignmentId: ALIGNMENTS[matrixSeed % ALIGNMENTS.length],
    boostId: matrixSeed % 3 === 0 ? "two-and-one" : "three-plus-one",
    priority: cfg.priority,
    equip: cfg.equip,
    mastery: cfg.mastery,
  };

  if (style === "blessed-warrior") {
    bp.blessedCantrips = pickBlessedCantrips("cleric");
  } else if (style === "druidic-warrior") {
    bp.blessedCantrips = pickBlessedCantrips("druid");
  }

  const mi = autoMagicInitiate(bp.backgroundId);
  if (mi) bp.magicInitiate = mi;

  ensureLandTerrain(bp);
  return bp;
}

function ancestrySweepBlueprints(usedIds) {
  const blueprints = [];
  const sweepLevels = [1, 5, 17];
  const sweeps = [
    { speciesId: "elf", key: "lineageId", values: ELF_LINEAGES, prefix: "elf-lin" },
    { speciesId: "tiefling", key: "infernalLegacyId", values: TIEFLING_LEGACIES, prefix: "tf-leg" },
    { speciesId: "gnome", key: "gnomeLineageId", values: GNOME_LINEAGES, prefix: "gn-lin" },
    { speciesId: "goliath", key: "giantAncestryId", values: GIANT_ANCESTRIES, prefix: "go-ant" },
    { speciesId: "dragonborn", key: "dragonAncestryId", values: DRAGON_ANCESTRIES, prefix: "db-ant" },
    { speciesId: "aasimar", key: "aasimarRevelationId", values: AASIMAR_REVELATIONS, prefix: "aa-rev" },
  ];

  for (const sweep of sweeps) {
    for (const value of sweep.values) {
      for (const level of sweepLevels) {
        if (sweep.speciesId === "aasimar" && level < 3) continue;
        const id = `sw-${sweep.prefix}-${value}-l${String(level).padStart(2, "0")}`;
        if (usedIds.has(id)) continue;

        const matrixSeed = id.length * 7 + level;
        const classId = PHB_INDEX.classes[matrixSeed % PHB_INDEX.classes.length].id;
        const cfg = CLASS_CONFIG[classId];
        const classEntry = PHB_INDEX.classes.find((c) => c.id === classId);
        const unlock = loadClass(classId).subclassUnlockLevel ?? 3;
        let subclassId = null;
        if (level >= unlock && classEntry.subclasses.length) {
          subclassId = classEntry.subclasses[matrixSeed % classEntry.subclasses.length].id;
        }

        const speciesChoices = {
          ...defaultSpeciesChoices(sweep.speciesId, matrixSeed),
          [sweep.key]: value,
        };
        if (sweep.speciesId === "tiefling") {
          speciesChoices.infernalLegacyId = value;
          speciesChoices.infernalCastingAbilityId =
            speciesChoices.infernalCastingAbilityId ?? "carisma";
        }
        if (sweep.speciesId === "gnome") {
          speciesChoices.gnomeLineageId = value;
          speciesChoices.gnomeCastingAbilityId = speciesChoices.gnomeCastingAbilityId ?? "inteligencia";
        }
        if (sweep.speciesId === "elf") {
          speciesChoices.lineageId = value;
          speciesChoices.keenSensesSkillId = speciesChoices.keenSensesSkillId ?? "perception";
        }

        blueprints.push({
          id,
          name: `${sweep.prefix} ${value} L${level}`,
          level,
          speciesId: sweep.speciesId,
          speciesChoices,
          backgroundId: BG_INDEX.backgrounds[matrixSeed % BG_INDEX.backgrounds.length].id,
          classId,
          subclassId,
          classChoices: {
            skillIds: pickClassSkills(classId, matrixSeed, loadClass(classId).skillChoices?.count ?? 0),
          },
          alignmentId: ALIGNMENTS[matrixSeed % ALIGNMENTS.length],
          boostId: "three-plus-one",
          priority: cfg.priority,
          equip: cfg.equip,
          mastery: cfg.mastery,
        });
        ensureLandTerrain(blueprints[blueprints.length - 1]);
        usedIds.add(id);
      }
    }
  }

  return blueprints;
}

function speciesMatrixBlueprints(usedIds) {
  const blueprints = [];
  const speciesList = SPECIES_INDEX.species.map((s) => s.id);

  for (const speciesId of speciesList) {
    for (const level of SPECIES_LEVELS) {
      const matrixSeed = speciesList.indexOf(speciesId) * 100 + level;
      const bp = matrixBlueprint(speciesId, level, matrixSeed, usedIds);
      if (bp) {
        blueprints.push(bp);
        usedIds.add(bp.id);
      }
    }
  }

  return blueprints;
}

function buildAllBlueprints() {
  const used = new Set();
  const blueprints = [];

  for (const bp of CORE_BLUEPRINTS) {
    if (!used.has(bp.id)) {
      blueprints.push(bp);
      used.add(bp.id);
    }
  }

  blueprints.push(...speciesMatrixBlueprints(used));
  blueprints.push(...ancestrySweepBlueprints(used));

  return blueprints;
}

function assignAbilities(backgroundId, boostId, priority) {
  const bg = loadBackground(backgroundId);
  const allowed = bg.abilityOptions.map((l) => ABILITY_PT[l]);
  const base = {};
  priority.forEach((id, i) => {
    base[id] = STANDARD_ARRAY[i];
  });
  const abilities = { ...base };
  if (boostId === "three-plus-one") {
    for (const id of allowed) abilities[id] += 1;
  } else if (boostId === "two-and-one") {
    abilities[allowed[0]] += 2;
    abilities[allowed[1]] += 1;
  }
  return abilities;
}

function loadSpellList(classId) {
  return JSON.parse(
    fs.readFileSync(path.join(phb, "spells/by-class", `${classId}.json`), "utf8")
  );
}

function maxSpellLevel(slotsMax) {
  const keys = Object.keys(slotsMax).map(Number);
  return keys.length ? Math.max(...keys) : 1;
}

function pickSpells(classId, level, extraCantrips = 0, excludeCantripIds = []) {
  const list = loadSpellList(classId);
  const slotsMax = expectedSpellSlots(classId, level) ?? {};
  const maxLvl = maxSpellLevel(slotsMax);
  const cantripCount = (expectedClassCantrips(classId, level) ?? 0) + extraCantrips;
  const preparedCount = expectedPreparedCount(classId, level) ?? 0;

  const cantripPool = (list.byLevel["0"] ?? [])
    .map((s) => s.id)
    .filter((id) => !excludeCantripIds.includes(id));
  const cantripIds = cantripPool.slice(0, cantripCount);
  const pool = [];
  for (let l = 1; l <= maxLvl; l++) pool.push(...(list.byLevel[String(l)] ?? []));
  const preparedIds = pool.slice(0, preparedCount).map((s) => s.id);

  return { cantripIds, preparedIds, slotsMax };
}

function dedupeMagicInitiate(bp, cantripsSoFar) {
  if (!bp.magicInitiate) return bp.magicInitiate;
  const spellClass = MI_BG_CLASS[bp.backgroundId] ?? bp.classId;
  const used = new Set(Object.values(cantripsSoFar).flat());
  let ids = bp.magicInitiate.cantripIds.filter((id) => !used.has(id));
  if (ids.length < 2) {
    const list = loadSpellList(spellClass);
    for (const s of list.byLevel["0"] ?? []) {
      if (ids.length >= 2) break;
      if (!used.has(s.id) && !ids.includes(s.id)) ids.push(s.id);
    }
  }
  return { ...bp.magicInitiate, cantripIds: ids.slice(0, 2) };
}

function buildSpellcasting(bp, abilities) {
  const cantrips = {};
  const prepared = {};
  let slotsMax = {};

  const spellClass =
    bp.classChoices?.fightingStyleId === "blessed-warrior"
      ? "cleric"
      : bp.classChoices?.fightingStyleId === "druidic-warrior"
        ? "druid"
        : bp.classId;

  let extraCantrips = 0;
  if (bp.classId === "cleric" && bp.classChoices?.divineOrder === "thaumaturge") {
    extraCantrips = 1;
  }

  if (bp.blessedCantrips) {
    cantrips.class = bp.blessedCantrips;
    const p = pickSpells(bp.classId, bp.level);
    prepared.class = p.preparedIds;
    slotsMax = p.slotsMax;
  } else if (isSpellcaster(bp.classId, bp.level)) {
    const speciesExclude = allSpeciesCantripIds(bp.speciesId, bp.speciesChoices ?? {}, bp.level);
    const p = pickSpells(spellClass, bp.level, extraCantrips, speciesExclude);
    if (p.cantripIds.length) cantrips.class = p.cantripIds;
    if (p.preparedIds.length) prepared.class = p.preparedIds;
    slotsMax = p.slotsMax;
  }

  for (const entry of speciesSpellEntries(bp.speciesId, bp.speciesChoices ?? {}, bp.level)) {
    if (entry.cantrips.length) cantrips[entry.sourceKey] = entry.cantrips;
    if (entry.prepared.length) prepared[entry.sourceKey] = entry.prepared;
  }

  const mi = dedupeMagicInitiate(bp, cantrips);
  if (mi) {
    cantrips["magic-initiate"] = mi.cantripIds;
    prepared["magic-initiate"] = [mi.preparedSpellId];
    bp.magicInitiate = mi;
  }

  if (bp.subclassId) {
    const sub = expectedSubclassPrepared(
      bp.classId,
      bp.subclassId,
      bp.level,
      bp.classChoices ?? {}
    );
    if (sub && !sub.requiresTerrain && sub.spellIds.length) {
      prepared[sub.sourceKey] = sub.spellIds;
    }
  }

  const hasData =
    Object.keys(cantrips).length > 0 ||
    Object.keys(prepared).length > 0 ||
    Object.keys(slotsMax).length > 0;

  if (!hasData) return undefined;

  return {
    cantrips,
    prepared,
    slotsMax,
    slotsUsed: Object.fromEntries(Object.keys(slotsMax).map((k) => [k, 0])),
  };
}

function buildFeats(bp, bg) {
  const feats = [{ featId: bg.feat.id, source: "background" }];
  const mi = bp.magicInitiate ?? autoMagicInitiate(bp.backgroundId);
  if (mi && bg.feat.id === "magic-initiate") {
    feats[0].magicInitiate = {
      spellListClassId: MI_BG_CLASS[bp.backgroundId],
      ...mi,
    };
  }
  if (bp.speciesId === "human") {
    feats.push({ featId: "skilled", source: "species" });
  }
  return feats;
}

const MASTERY_FALLBACK = [
  "dagger",
  "quarterstaff",
  "mace",
  "spear",
  "longbow",
  "shortsword",
  "handaxe",
  "javelin",
  "light-crossbow",
  "rapier",
];

function fillWeaponMastery(classId, level, featIds, preferred = []) {
  const slots = expectedWeaponMasterySlots(classId, level, featIds);
  if (slots <= 0) return [];
  const pool = [...new Set([...preferred, ...(CLASS_CONFIG[classId]?.mastery ?? []), ...MASTERY_FALLBACK])];
  return pool.slice(0, slots);
}

function ensureElfKeenSenses(doc) {
  if (doc.speciesId !== "elf" || !doc.speciesChoices) return;
  const hasSpeciesKeen = doc.skillProficiencies.some(
    (s) => s.skillId === doc.speciesChoices.keenSensesSkillId && s.source === "species"
  );
  if (hasSpeciesKeen) return;

  for (const skillId of [
    doc.speciesChoices.keenSensesSkillId,
    ...ELF_KEEN.filter((k) => k !== doc.speciesChoices.keenSensesSkillId),
  ]) {
    const existing = doc.skillProficiencies.find((s) => s.skillId === skillId);
    if (existing && existing.source === "background") continue;
    if (existing) {
      const wasClass = existing.source === "class";
      existing.source = "species";
      if (wasClass) {
        const cls = loadClass(doc.classId);
        const pool = classSkillPool(cls);
        const needed = cls.skillChoices?.count ?? 0;
        const classCount = doc.skillProficiencies.filter((s) => s.source === "class").length;
        for (const replacement of pool) {
          if (classCount >= needed) break;
          if (!doc.skillProficiencies.some((s) => s.skillId === replacement)) {
            doc.skillProficiencies.push({ skillId: replacement, source: "class" });
            break;
          }
        }
      }
    } else {
      doc.skillProficiencies.push({ skillId, source: "species" });
    }
    doc.speciesChoices.keenSensesSkillId = skillId;
    return;
  }
}

function ensureLandTerrain(bp) {
  if (bp.classId === "druid" && bp.subclassId === "land" && !bp.classChoices?.landTerrainId) {
    bp.classChoices = { ...(bp.classChoices ?? {}), landTerrainId: LAND_TERRAINS[bp.level % LAND_TERRAINS.length] };
  }
}

function classSkillPool(cls) {
  if (cls.skillChoices?.skillIds?.length) return cls.skillChoices.skillIds;
  if (cls.skillChoices?.from === "any") {
    return JSON.parse(fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")).skills.map(
      (s) => s.id
    );
  }
  return [];
}

function buildSkills(bp, bg, cls) {
  const skills = bg.skillIds.map((skillId) => ({ skillId, source: "background" }));

  const classNeeded = cls.skillChoices?.count ?? 0;
  const classPool = classSkillPool(cls);
  const preferred = bp.classChoices?.skillIds ?? [];
  let classAdded = 0;

  const addClassSkill = (skillId) => {
    if (classAdded >= classNeeded) return;
    if (!classPool.includes(skillId)) return;
    if (skills.some((s) => s.skillId === skillId)) return;
    skills.push({ skillId, source: "class" });
    classAdded++;
  };

  for (const skillId of preferred) addClassSkill(skillId);
  for (const skillId of classPool) addClassSkill(skillId);

  if (bp.speciesId === "human" && !skills.some((s) => s.source === "species")) {
    const pool = classPool.length
      ? classPool
      : JSON.parse(fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")).skills.map(
          (s) => s.id
        );
    for (const skillId of pool) {
      if (!skills.some((s) => s.skillId === skillId)) {
        skills.push({ skillId, source: "species" });
        break;
      }
    }
  }

  if (bp.speciesChoices?.keenSensesSkillId) {
    const keen = bp.speciesChoices.keenSensesSkillId;
    if (!skills.some((s) => s.skillId === keen)) {
      skills.push({ skillId: keen, source: "species" });
    }
  }
  const skilledCount =
    (bg.feat?.id === "skilled" ? 1 : 0) + (bp.speciesId === "human" ? 1 : 0);
  for (const skillId of bp.skilledSkills ?? []) {
    if (!skills.some((s) => s.skillId === skillId)) {
      skills.push({ skillId, source: "feat" });
    }
  }
  const featSkillPool = JSON.parse(
    fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")
  ).skills.map((s) => s.id);
  let featAdded = skills.filter((s) => s.source === "feat").length;
  for (const skillId of featSkillPool) {
    if (featAdded >= skilledCount * 3) break;
    if (!skills.some((s) => s.skillId === skillId)) {
      skills.push({ skillId, source: "feat" });
      featAdded++;
    }
  }
  return skills;
}

function buildCharacter(bp) {
  const bg = loadBackground(bp.backgroundId);
  const cls = loadClass(bp.classId);
  const mi = bp.magicInitiate ?? autoMagicInitiate(bp.backgroundId);
  const enriched = mi ? { ...bp, magicInitiate: mi } : bp;
  const abilities = assignAbilities(enriched.backgroundId, enriched.boostId, enriched.priority);

  const equipKey = typeof enriched.equip === "string" ? enriched.equip : null;
  const equipTemplate = equipKey ? EQUIP[equipKey] : enriched.equip;
  const equipment = [...(equipTemplate?.items ?? [])];

  const classChoices = { ...(enriched.classChoices ?? {}) };
  if (equipTemplate?.style && !classChoices.fightingStyleId) {
    classChoices.fightingStyleId = equipTemplate.style;
  }

  const doc = {
    id: enriched.id,
    name: enriched.name,
    level: enriched.level,
    speciesId: enriched.speciesId,
    backgroundId: enriched.backgroundId,
    classId: enriched.classId,
    alignmentId: enriched.alignmentId,
    abilityGeneration: { methodId: "standard-array", backgroundBoostId: enriched.boostId },
    languageIds: ["common", "dwarvish", "elvish"].slice(0, 3),
    abilities,
    skillProficiencies: buildSkills(enriched, bg, cls),
    savingThrowProficiencies: cls.savingThrowIds,
    feats: [],
    startingPackages: { classOption: "A", backgroundOption: "a" },
    equipment,
    hp: { current: 0, max: 0, temp: 0 },
    armorClass: { total: 10 },
    resources: {},
  };

  if (enriched.speciesChoices) doc.speciesChoices = enriched.speciesChoices;
  if (enriched.subclassId) doc.subclassId = enriched.subclassId;
  if (Object.keys(classChoices).length) doc.classChoices = classChoices;

  const spellcasting = buildSpellcasting(enriched, abilities);
  if (spellcasting) doc.spellcasting = spellcasting;

  doc.feats = buildFeats(enriched, bg);
  ensureElfKeenSenses(doc);
  const featIds = doc.feats.map((f) => f.featId);
  const masterySlots = expectedWeaponMasterySlots(enriched.classId, enriched.level, featIds);
  if (masterySlots > 0) {
    doc.weaponMasteryWeaponIds = fillWeaponMastery(
      enriched.classId,
      enriched.level,
      featIds,
      enriched.mastery ?? []
    );
  }

  const cd = expectedChannelDivinity(enriched.classId, enriched.level);
  if (cd != null) {
    doc.resources.channelDivinity = { max: cd, remaining: cd };
  }

  const rages = expectedRageUses(enriched.level);
  if (enriched.classId === "barbarian" && rages != null) {
    doc.resources.rage = { max: rages, remaining: rages };
  }

  const focus = expectedFocusPoints(enriched.level);
  if (enriched.classId === "monk" && enriched.level >= 2 && focus != null) {
    doc.resources.focusPoints = { max: focus, remaining: focus };
  }

  for (const [key, { max }] of Object.entries(expectedSpeciesResources(doc))) {
    doc.resources[key] = { max, remaining: max };
  }

  doc.hp.max = expectedMaxHpForCharacter(doc);
  doc.hp.current = doc.hp.max;

  const ac = expectedArmorClass(doc);
  doc.armorClass = {
    total: ac.total,
    base: ac.base,
    dexBonus: ac.dexBonus,
    shieldBonus: ac.shieldBonus,
    fightingStyleBonus: ac.fightingStyleBonus,
  };
  if (ac.otherBonus) doc.armorClass.otherBonus = ac.otherBonus;

  doc.passivePerception = expectedPassivePerception(doc);

  return doc;
}

export { buildAllBlueprints, buildCharacter, TARGET_CHARACTER_COUNT };
