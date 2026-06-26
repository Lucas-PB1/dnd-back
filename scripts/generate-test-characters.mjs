/**
 * Gera fichas de teste diversas em data/characters/.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  ELF_LINEAGE_SPELLS,
  expectedArmorClass,
  expectedChannelDivinity,
  expectedClassCantrips,
  expectedFocusPoints,
  expectedMaxHpForCharacter,
  expectedPassivePerception,
  expectedRageUses,
  expectedPreparedCount,
  expectedSpellSlots,
  expectedSubclassPrepared,
  expectedWeaponMasterySlots,
  isSpellcaster,
  lineageCantrips,
  lineagePreparedSpells,
  loadBackground,
  loadClass,
} from "./character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const phb = path.join(root, "data/phb");
const charsDir = path.join(root, "data/characters");

const STANDARD_ARRAY = [15, 14, 13, 12, 10, 8];
const ABILITY_PT = {
  Força: "forca",
  Destreza: "destreza",
  Constituição: "constituicao",
  Inteligência: "inteligencia",
  Sabedoria: "sabedoria",
  Carisma: "carisma",
};

const SPECIES_SKILL = {
  human: "perception",
  dwarf: "history",
  elf: null,
  halfling: "stealth",
  gnome: "investigation",
  tiefling: "religion",
  dragonborn: "intimidation",
  goliath: "athletics",
  orc: "intimidation",
  aasimar: "insight",
};

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

/** @type {import('./character-rules.mjs').[]} */
const BLUEPRINTS = [
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
];

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

function buildSpellcasting(bp, abilities) {
  if (!isSpellcaster(bp.classId, bp.level) && !bp.blessedCantrips) return undefined;

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

  const cantrips = {};
  const prepared = {};
  let slotsMax = {};

  if (bp.blessedCantrips) {
    cantrips.class = bp.blessedCantrips;
    const p = pickSpells(bp.classId, bp.level);
    prepared.class = p.preparedIds;
    slotsMax = p.slotsMax;
  } else if (isSpellcaster(bp.classId, bp.level)) {
    const lineageExclude = bp.speciesChoices?.lineageId
      ? lineageCantrips(bp.speciesChoices.lineageId)
      : [];
    const p = pickSpells(spellClass, bp.level, extraCantrips, lineageExclude);
    if (p.cantripIds.length) cantrips.class = p.cantripIds;
    if (p.preparedIds.length) prepared.class = p.preparedIds;
    slotsMax = p.slotsMax;
  }

  if (bp.speciesChoices?.lineageId) {
    const lc = lineageCantrips(bp.speciesChoices.lineageId);
    if (lc.length) cantrips["elf-lineage"] = lc;
    const lp = lineagePreparedSpells(bp.speciesChoices.lineageId, bp.level);
    if (lp.length) prepared["elf-lineage"] = lp;
  }

  if (bp.magicInitiate) {
    cantrips["magic-initiate"] = bp.magicInitiate.cantripIds;
    prepared["magic-initiate"] = [bp.magicInitiate.preparedSpellId];
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

  return {
    cantrips,
    prepared,
    slotsMax,
    slotsUsed: Object.fromEntries(Object.keys(slotsMax).map((k) => [k, 0])),
  };
}

function buildFeats(bp, bg) {
  const feats = [{ featId: bg.feat.id, source: "background" }];
  if (bp.magicInitiate) {
    feats[0].magicInitiate = {
      spellListClassId: "cleric",
      ...bp.magicInitiate,
    };
  }
  if (bp.speciesId === "human") {
    feats.push({ featId: "skilled", source: "species" });
  }
  return feats;
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

  const speciesSkill =
    bp.speciesId === "human"
      ? null
      : bp.speciesChoices?.keenSensesSkillId ?? SPECIES_SKILL[bp.speciesId];
  if (speciesSkill && !skills.some((s) => s.skillId === speciesSkill)) {
    skills.push({ skillId: speciesSkill, source: "species" });
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
  const abilities = assignAbilities(bp.backgroundId, bp.boostId, bp.priority);

  const equipKey = typeof bp.equip === "string" ? bp.equip : null;
  const equipTemplate = equipKey ? EQUIP[equipKey] : bp.equip;
  const equipment = [...(equipTemplate?.items ?? [])];

  const classChoices = { ...(bp.classChoices ?? {}) };
  if (equipTemplate?.style && !classChoices.fightingStyleId) {
    classChoices.fightingStyleId = equipTemplate.style;
  }

  const doc = {
    $schema: "../../schema/character.schema.json",
    id: bp.id,
    name: bp.name,
    level: bp.level,
    speciesId: bp.speciesId,
    backgroundId: bp.backgroundId,
    classId: bp.classId,
    alignmentId: bp.alignmentId,
    abilityGeneration: { methodId: "standard-array", backgroundBoostId: bp.boostId },
    languageIds: ["common", "dwarvish", "elvish"].slice(0, 3),
    abilities,
    skillProficiencies: buildSkills(bp, bg, cls),
    savingThrowProficiencies: cls.savingThrowIds,
    feats: buildFeats(bp, bg),
    startingPackages: { classOption: "A", backgroundOption: "a" },
    equipment,
    hp: { current: 0, max: 0, temp: 0 },
    armorClass: { total: 10 },
    resources: {},
  };

  if (bp.speciesChoices) doc.speciesChoices = bp.speciesChoices;
  if (bp.subclassId) doc.subclassId = bp.subclassId;
  if (Object.keys(classChoices).length) doc.classChoices = classChoices;

  const spellcasting = buildSpellcasting(bp, abilities);
  if (spellcasting) doc.spellcasting = spellcasting;

  const featIds = doc.feats.map((f) => f.featId);
  const masterySlots = expectedWeaponMasterySlots(bp.classId, bp.level, featIds);
  if (masterySlots > 0) {
    doc.weaponMasteryWeaponIds = bp.mastery?.slice(0, masterySlots) ?? [];
  }

  const cd = expectedChannelDivinity(bp.classId, bp.level);
  if (cd != null) {
    doc.resources.channelDivinity = { max: cd, remaining: cd };
  }

  const rages = expectedRageUses(bp.level);
  if (bp.classId === "barbarian" && rages != null) {
    doc.resources.rage = { max: rages, remaining: rages };
  }

  const focus = expectedFocusPoints(bp.level);
  if (bp.classId === "monk" && bp.level >= 2 && focus != null) {
    doc.resources.focusPoints = { max: focus, remaining: focus };
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

for (const bp of BLUEPRINTS) {
  const doc = buildCharacter(bp);
  const file = path.join(charsDir, `${bp.id}.json`);
  fs.writeFileSync(file, `${JSON.stringify(doc, null, 2)}\n`, "utf8");
  console.log(`✓ ${bp.id}.json — ${doc.classId} nível ${doc.level}`);
}

console.log(`\n${BLUEPRINTS.length} fichas geradas (+ marcus, aelindra existentes)`);
