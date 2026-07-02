/**
 * Regras derivadas para validar fichas contra progression e features do PHB.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";
import {
  CLASS_SPELL_SLOT_PATTERN,
  spellSlotsForPattern,
} from "./lib/spell-slot-patterns.mjs";
import { abilityMod, expectedMaxHp, expectedMaxHpForCharacter, speciesHpBonus, toughFeatHpBonus } from "./hp-data.mjs";
import {
  abilitiesWithoutAsi,
  applyAsiBoost,
  expectedClassFeatSlots,
} from "./class-feat-progression-data.mjs";
import {
  ELEMENTAL_DAMAGE_TYPES,
  GENERAL_FEAT_DEFS,
  GENERAL_FEAT_ROTATION,
  effectiveArmorTrainingWithFeats,
  expectedGeneralFeatCantrips,
  expectedGeneralFeatPrepared,
} from "./general-feat-mechanics-data.mjs";
import {
  applyFeatPassiveBenefits,
  validateFeatSkillChoices,
  validateShieldMaster,
  validateToolProficiencies,
} from "./feat-passive-benefits.mjs";
import { checkFeatPrerequisites, proficiencyBonusAtLevel } from "./feat-prerequisites-data.mjs";
import { sumAsiDeltas } from "./asi-mechanics.mjs";
import {
  expectedThirdCasterCantrips,
  expectedThirdCasterPrepared,
  expectedThirdCasterSpellSlots,
  isThirdCaster,
  thirdCasterConfig,
} from "./third-caster-progression-data.mjs";
import {
  MAGIC_INITIATE_BACKGROUND_CLASS,
} from "./feat-mechanics-data.mjs";
import {
  optionsForSubclass,
  resourcesForSubclass,
  subclassResourceMax,
} from "./subclass-mechanics-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const phb = path.join(root, "data/phb");

/** Magia de linhagem élfica por nível (além do truque de nível 1). */
export const ELF_LINEAGE_SPELLS = {
  "high-elf": { 1: ["prestidigitacao-arcana"], 3: ["detectar-magia"], 5: ["passo-nebuloso"] },
  drow: { 1: ["luzes-dancantes"], 3: ["fogo-das-fadas"], 5: ["escuridao"] },
  "wood-elf": { 1: ["arte-druidica"], 3: ["passos-largos"], 5: ["passo-sem-rastro"] },
};

/** Legado ínfero do tiferino — truque (nível 1) e magias preparadas (níveis 3 e 5). */
export const TIEFLING_LEGACY_SPELLS = {
  abyssal: { 1: ["rajada-de-veneno"], 3: ["raio-nauseante"], 5: ["paralisar-pessoa"] },
  chthonic: { 1: ["toque-necrotico"], 3: ["vitalidade-vazia"], 5: ["raio-do-enfraquecimento"] },
  infernal: { 1: ["raio-de-fogo"], 3: ["repreensao-diabolica"], 5: ["escuridao"] },
};

/** Linhagem gnômica — truques e magias sempre preparadas. */
export const GNOME_LINEAGE_SPELLS = {
  "rock-gnome": { cantrips: ["prestidigitacao-arcana", "reparar"], prepared: [] },
  "forest-gnome": { cantrips: ["ilusao-menor"], prepared: ["falar-com-animais"] },
};

export const DRAGON_ANCESTRIES = [
  "blue",
  "black",
  "white",
  "gold",
  "bronze",
  "silver",
  "copper",
  "green",
  "brass",
  "red",
];

export const GIANT_ANCESTRIES = ["ice", "fire", "stone", "cloud", "hill", "storm"];

export const TIEFLING_LEGACIES = ["abyssal", "chthonic", "infernal"];

export const GNOME_LINEAGES = ["rock-gnome", "forest-gnome"];

export const AASIMAR_REVELATIONS = ["celestial-wings", "necrotic-shroud", "radiant-consumption"];

const CASTING_ABILITIES = ["inteligencia", "sabedoria", "carisma"];

export { abilityMod, expectedMaxHp, expectedMaxHpForCharacter, speciesHpBonus, toughFeatHpBonus };

const ADVANCEMENT = JSON.parse(
  fs.readFileSync(path.join(phb, "rules/character-advancement.json"), "utf8")
);

const ABILITY_GENERATION = JSON.parse(
  fs.readFileSync(path.join(phb, "creation/ability-generation.json"), "utf8")
);

const STANDARD_ARRAY = ABILITY_GENERATION.methods.find((m) => m.id === "standard-array").values;

const ABILITY_PT_TO_ID = {
  Força: "forca",
  Destreza: "destreza",
  Constituição: "constituicao",
  Inteligência: "inteligencia",
  Sabedoria: "sabedoria",
  Carisma: "carisma",
};

const ABILITY_IDS = Object.values(ABILITY_PT_TO_ID);

const POINT_BUY_COSTS = Object.fromEntries(
  ABILITY_GENERATION.pointBuyCosts.map((r) => [r.score, r.cost])
);

export function expectedProficiencyBonus(level) {
  return ADVANCEMENT.levels.find((r) => r.level === level)?.proficiencyBonus ?? null;
}

/** Percepção Passiva = 10 + bônus do teste de Sabedoria (Percepção). */
export function expectedPassivePerception(doc) {
  const wisMod = abilityMod(doc.abilities.sabedoria);
  const prof = expectedProficiencyBonus(doc.level) ?? 0;
  const proficient = doc.skillProficiencies?.some((s) => s.skillId === "perception");
  const expert = doc.expertise?.includes("perception");
  let skillBonus = wisMod;
  if (proficient) skillBonus += prof;
  if (expert) skillBonus += prof;
  return 10 + skillBonus;
}

/** Concessões de Especialização por classe (PHB 2024). */
const CLASS_EXPERTISE_TIERS = {
  rogue: [
    { minLevel: 1, count: 2, preferred: ["stealth", "sleight-of-hand", "perception", "investigation"] },
    { minLevel: 6, count: 2, preferred: ["deception", "insight", "acrobatics", "persuasion"] },
  ],
  bard: [
    { minLevel: 2, count: 2, preferred: ["performance", "persuasion", "deception", "insight"] },
    { minLevel: 9, count: 2, preferred: ["acrobatics", "perception", "intimidation", "history"] },
  ],
  ranger: [
    { minLevel: 2, count: 1, preferred: ["survival", "nature", "perception", "stealth"] },
    { minLevel: 9, count: 2, preferred: ["investigation", "animal-handling", "athletics", "insight"] },
  ],
  wizard: [
    {
      minLevel: 2,
      count: 1,
      pool: ["arcana", "history", "investigation", "medicine", "nature", "religion"],
      preferred: ["arcana", "investigation", "history"],
    },
  ],
};

const FEAT_EXPERTISE = {
  observant: { pool: ["insight", "investigation", "perception"], preferred: ["perception"] },
  "keen-mind": {
    pool: ["arcana", "history", "investigation", "nature", "religion"],
    preferred: ["investigation"],
  },
  "skill-expert": { preferred: ["stealth", "perception", "arcana", "investigation"] },
  "boon-of-skill-proficiency": { preferred: ["perception", "stealth", "arcana"] },
};

function hashSeed(str) {
  let h = 0;
  for (let i = 0; i < str.length; i++) h = (h * 31 + str.charCodeAt(i)) | 0;
  return Math.abs(h);
}

function pickExpertiseSkills({ proficient, count, pool = null, preferred = [], taken, seed = 0 }) {
  const eligible = (pool ?? proficient).filter((id) => proficient.includes(id) && !taken.has(id));
  if (!eligible.length || count <= 0) return [];

  const ordered = [
    ...preferred.filter((id) => eligible.includes(id)),
    ...eligible.filter((id) => !preferred.includes(id)),
  ];

  const picked = [];
  const offset = seed % ordered.length;
  for (let i = 0; i < count; i++) {
    let skill = null;
    for (let j = 0; j < ordered.length; j++) {
      const cand = ordered[(offset + i + j) % ordered.length];
      if (!taken.has(cand) && !picked.includes(cand)) {
        skill = cand;
        break;
      }
    }
    if (!skill) break;
    picked.push(skill);
  }
  return picked;
}

/** Monta lista de perícias com Especialização (classe + talentos). */
export function buildExpertise(doc) {
  const proficient = [...new Set((doc.skillProficiencies ?? []).map((s) => s.skillId))];
  const expertise = [];
  const taken = new Set();
  const seed = hashSeed(doc.id ?? "0");

  function grant(count, { pool, preferred = [], seedOffset = 0 } = {}) {
    for (const skillId of pickExpertiseSkills({
      proficient,
      count,
      pool,
      preferred,
      taken,
      seed: seed + seedOffset,
    })) {
      expertise.push(skillId);
      taken.add(skillId);
    }
  }

  for (const tier of CLASS_EXPERTISE_TIERS[doc.classId] ?? []) {
    if (doc.level >= tier.minLevel) {
      grant(tier.count, {
        pool: tier.pool,
        preferred: tier.preferred,
        seedOffset: tier.minLevel,
      });
    }
  }

  for (const feat of doc.feats ?? []) {
    if (feat.featId === "skill-expert" && feat.skillExpert?.expertiseSkillId) {
      const skillId = feat.skillExpert.expertiseSkillId;
      if (!taken.has(skillId)) {
        expertise.push(skillId);
        taken.add(skillId);
      }
      continue;
    }

    const cfg = FEAT_EXPERTISE[feat.featId];
    if (!cfg) continue;
    grant(1, {
      pool: cfg.pool,
      preferred: cfg.preferred,
      seedOffset: feat.featId.length,
    });
  }

  return expertise;
}

export function expectedClassCantrips(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.cantrips ?? null;
}

export function expectedPreparedCount(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.preparedSpells ?? null;
}

export function expectedSpellSlots(classId, level) {
  const patternSlug = CLASS_SPELL_SLOT_PATTERN[classId];
  if (!patternSlug) return null;
  return spellSlotsForPattern(patternSlug, level);
}

export function expectedChannelDivinity(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.channelDivinity ?? null;
}

export function lineagePreparedSpells(lineageId, level) {
  const table = ELF_LINEAGE_SPELLS[lineageId];
  if (!table) return [];
  const spells = [];
  if (level >= 3 && table[3]) spells.push(...table[3]);
  if (level >= 5 && table[5]) spells.push(...table[5]);
  return spells;
}

export function lineageCantrips(lineageId) {
  return ELF_LINEAGE_SPELLS[lineageId]?.[1] ?? [];
}

function legacyPreparedSpells(table, level) {
  if (!table) return [];
  const spells = [];
  if (level >= 3 && table[3]) spells.push(...table[3]);
  if (level >= 5 && table[5]) spells.push(...table[5]);
  return spells;
}

function legacyCantrips(table) {
  return table?.[1] ?? [];
}

/** Entradas de conjuração de espécie para spellcasting.cantrips / .prepared. */
export function speciesSpellEntries(speciesId, speciesChoices = {}, level = 1) {
  const entries = [];

  if (speciesId === "elf" && speciesChoices.lineageId) {
    entries.push({
      sourceKey: "elf-lineage",
      cantrips: lineageCantrips(speciesChoices.lineageId),
      prepared: lineagePreparedSpells(speciesChoices.lineageId, level),
    });
  }

  if (speciesId === "tiefling" && speciesChoices.infernalLegacyId) {
    const table = TIEFLING_LEGACY_SPELLS[speciesChoices.infernalLegacyId];
    entries.push({
      sourceKey: "infernal-legacy",
      cantrips: legacyCantrips(table),
      prepared: legacyPreparedSpells(table, level),
    });
    entries.push({
      sourceKey: "tiefling-presence",
      cantrips: ["taumaturgia"],
      prepared: [],
    });
  }

  if (speciesId === "gnome" && speciesChoices.gnomeLineageId) {
    const table = GNOME_LINEAGE_SPELLS[speciesChoices.gnomeLineageId];
    if (table) {
      entries.push({
        sourceKey: "gnome-lineage",
        cantrips: table.cantrips ?? [],
        prepared: table.prepared ?? [],
      });
    }
  }

  if (speciesId === "aasimar") {
    entries.push({
      sourceKey: "aasimar-light",
      cantrips: ["luz"],
      prepared: [],
    });
  }

  return entries;
}

export function allSpeciesCantripIds(speciesId, speciesChoices = {}, level = 1) {
  return speciesSpellEntries(speciesId, speciesChoices, level).flatMap((e) => e.cantrips);
}

/** Recursos de traços de espécie esperados (max por descanso). */
export function expectedSpeciesResources(doc) {
  const { speciesId, level } = doc;
  const pb = expectedProficiencyBonus(level);
  const out = {};

  if (speciesId === "dragonborn") {
    out.breathWeapon = { max: pb };
    if (level >= 5) out.dragonFlight = { max: 1 };
  }
  if (speciesId === "goliath") {
    out.giantAncestry = { max: pb };
    if (level >= 5) out.largeForm = { max: 1 };
  }
  if (speciesId === "orc") {
    out.adrenalineSurge = { max: pb };
    out.relentlessEndurance = { max: 1 };
  }
  if (speciesId === "aasimar") {
    out.healingHands = { max: 1 };
    if (level >= 3) out.celestialRevelation = { max: 1 };
  }
  if (speciesId === "dwarf") {
    out.stonecunning = { max: pb };
  }

  return out;
}

export function validateSpeciesChoices(doc) {
  const { speciesId, speciesChoices = {}, level } = doc;

  if (speciesId === "elf") {
    if (!speciesChoices.lineageId) {
      return { ok: false, reason: "elfo exige speciesChoices.lineageId" };
    }
    if (!speciesChoices.keenSensesSkillId) {
      return { ok: false, reason: "elfo exige speciesChoices.keenSensesSkillId" };
    }
  }

  if (speciesId === "tiefling") {
    if (!speciesChoices.infernalLegacyId) {
      return { ok: false, reason: "tiferino exige speciesChoices.infernalLegacyId" };
    }
    if (!speciesChoices.infernalCastingAbilityId) {
      return { ok: false, reason: "tiferino exige speciesChoices.infernalCastingAbilityId" };
    }
    if (!CASTING_ABILITIES.includes(speciesChoices.infernalCastingAbilityId)) {
      return { ok: false, reason: "infernalCastingAbilityId inválido" };
    }
  }

  if (speciesId === "gnome") {
    if (!speciesChoices.gnomeLineageId) {
      return { ok: false, reason: "gnomo exige speciesChoices.gnomeLineageId" };
    }
    if (!speciesChoices.gnomeCastingAbilityId) {
      return { ok: false, reason: "gnomo exige speciesChoices.gnomeCastingAbilityId" };
    }
  }

  if (speciesId === "dragonborn" && !speciesChoices.dragonAncestryId) {
    return { ok: false, reason: "draconato exige speciesChoices.dragonAncestryId" };
  }

  if (speciesId === "goliath" && !speciesChoices.giantAncestryId) {
    return { ok: false, reason: "golias exige speciesChoices.giantAncestryId" };
  }

  if (speciesId === "aasimar" && level >= 3 && !speciesChoices.aasimarRevelationId) {
    return { ok: false, reason: "aasimar nível 3+ exige speciesChoices.aasimarRevelationId" };
  }

  return { ok: true };
}

/** Fichas usam uma única classe; multiclasse não é modelado. */
export function validateSingleClass(doc) {
  if (Array.isArray(doc.classLevels) && doc.classLevels.length > 0) {
    return { ok: false, reason: "multiclasse (classLevels) não é suportado" };
  }
  if (!doc.classId) {
    return { ok: false, reason: "classId ausente" };
  }
  if (doc.level < 1 || doc.level > 20) {
    return { ok: false, reason: `nível ${doc.level} inválido para classe única` };
  }
  return { ok: true };
}

export function validateSpeciesSpellcasting(doc) {
  const { speciesId, speciesChoices, level, spellcasting } = doc;
  const entries = speciesSpellEntries(speciesId, speciesChoices ?? {}, level);

  for (const { sourceKey, cantrips, prepared } of entries) {
    const listedCantrips = spellcasting?.cantrips?.[sourceKey] ?? [];
    if (listedCantrips.length !== cantrips.length) {
      return {
        ok: false,
        reason: `truques de ${sourceKey}: ${listedCantrips.length}, esperado ${cantrips.length}`,
      };
    }
    for (const id of cantrips) {
      if (!listedCantrips.includes(id)) {
        return { ok: false, reason: `truque de ${sourceKey} ausente: ${id}` };
      }
    }

    const listedPrepared = spellcasting?.prepared?.[sourceKey] ?? [];
    if (listedPrepared.length !== prepared.length) {
      return {
        ok: false,
        reason: `magias de ${sourceKey}: ${listedPrepared.length}, esperado ${prepared.length}`,
      };
    }
    for (const id of prepared) {
      if (!listedPrepared.includes(id)) {
        return { ok: false, reason: `magia de ${sourceKey} ausente: ${id}` };
      }
    }
  }

  return { ok: true };
}

export function validateSpeciesResources(doc) {
  const expected = expectedSpeciesResources(doc);
  const { resources = {} } = doc;

  for (const [key, { max }] of Object.entries(expected)) {
    if (resources[key]?.max !== max) {
      return { ok: false, reason: `${key} max=${resources[key]?.max}, esperado ${max}` };
    }
  }

  const speciesKeys = new Set(Object.keys(expected));
  for (const key of [
    "breathWeapon",
    "dragonFlight",
    "giantAncestry",
    "largeForm",
    "adrenalineSurge",
    "relentlessEndurance",
    "healingHands",
    "celestialRevelation",
    "stonecunning",
  ]) {
    if (resources[key] != null && !speciesKeys.has(key)) {
      return { ok: false, reason: `recurso de espécie ${key} inesperado para ${doc.speciesId}` };
    }
  }

  return { ok: true };
}

export function loadBackground(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "backgrounds", `${id}.json`), "utf8"));
}

export function loadClass(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "classes", `${id}.json`), "utf8"));
}

export function loadSubclass(classId, subclassId) {
  return JSON.parse(
    fs.readFileSync(path.join(phb, "subclasses", `${classId}-${subclassId}.json`), "utf8")
  );
}

export function loadSpecies(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "species", `${id}.json`), "utf8"));
}

const ALL_SKILL_IDS = JSON.parse(
  fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")
).skills.map((s) => s.id);

/** Usos de Fúria por nível de bárbaro (PHB 2024). */
const RAGES_BY_LEVEL = [2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6];

/** Pontos de Foco por nível de monge (nível 1 não tem). */
const FOCUS_BY_LEVEL = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

export function expectedRageUses(level) {
  if (level < 1 || level > 20) return null;
  return RAGES_BY_LEVEL[level - 1];
}

export function expectedFocusPoints(level) {
  if (level < 2 || level > 20) return null;
  return FOCUS_BY_LEVEL[level - 1];
}

function classSkillPool(cls) {
  if (cls.skillChoices?.skillIds?.length) return cls.skillChoices.skillIds;
  if (cls.skillChoices?.from === "any") return ALL_SKILL_IDS;
  return [];
}

/** Treinamento de armadura efetivo (classe + ordem divina + subclasse + talentos). */
export function effectiveArmorTraining(doc) {
  return effectiveArmorTrainingWithFeats(doc);
}

function unarmoredDefenseBonus(doc, armorItem, shieldItem) {
  if (armorItem) return 0;
  if (doc.classId === "barbarian") {
    return abilityMod(doc.abilities.constituicao);
  }
  if (doc.classId === "monk" && !shieldItem) {
    return abilityMod(doc.abilities.sabedoria);
  }
  return 0;
}

/** Magias sempre preparadas da subclasse no nível atual (null se a subclasse não define). */
export function expectedSubclassPrepared(classId, subclassId, level, classChoices = {}) {
  let sub;
  try {
    sub = loadSubclass(classId, subclassId);
  } catch {
    return null;
  }

  const sourceKey = sub.preparedSpellSourceKey ?? `${subclassId}-domain`;

  let table = sub.preparedSpellsByLevel;
  if (sub.preparedSpellsByTerrain) {
    const terrainId = classChoices?.landTerrainId;
    if (!terrainId) {
      return { sourceKey, spellIds: [], requiresTerrain: true };
    }
    table = sub.preparedSpellsByTerrain[terrainId];
    if (!table) return null;
  }

  if (!table) return null;

  const spellIds = [];
  for (const [lvlStr, ids] of Object.entries(table)) {
    if (level >= Number(lvlStr)) spellIds.push(...ids);
  }
  if (!spellIds.length && !sub.preparedSpellsByTerrain) return null;

  return { sourceKey, spellIds, requiresTerrain: false };
}

function sortedMultiset(values) {
  return [...values].sort((a, b) => a - b);
}

function multisetsEqual(a, b) {
  const sa = sortedMultiset(a);
  const sb = sortedMultiset(b);
  return sa.length === sb.length && sa.every((v, i) => v === sb[i]);
}

function backgroundAbilityIds(backgroundId) {
  const bg = loadBackground(backgroundId);
  return bg.abilityOptions.map((label) => ABILITY_PT_TO_ID[label]).filter(Boolean);
}

function baseScoresFromBoost(abilities, allowedBoosts, boostId) {
  if (boostId === "three-plus-one") {
    const base = {};
    for (const id of ABILITY_IDS) {
      base[id] = abilities[id] - (allowedBoosts.includes(id) ? 1 : 0);
    }
    return base;
  }

  if (boostId === "two-and-one") {
    const candidates = [];
    for (const boosted of allowedBoosts) {
      for (const second of allowedBoosts) {
        if (boosted === second) continue;
        const base = {};
        for (const id of ABILITY_IDS) {
          let score = abilities[id];
          if (id === boosted) score -= 2;
          else if (id === second) score -= 1;
          base[id] = score;
        }
        if (Object.values(base).every((s) => s >= 1)) candidates.push(base);
      }
    }
    return candidates.length === 1 ? candidates[0] : candidates;
  }

  return null;
}

function validateStandardArrayBase(base) {
  return multisetsEqual(Object.values(base), STANDARD_ARRAY);
}

function validatePointBuyBase(base) {
  let total = 0;
  for (const score of Object.values(base)) {
    if (score < 8 || score > 15) return false;
    if (!(score in POINT_BUY_COSTS)) return false;
    total += POINT_BUY_COSTS[score];
  }
  return total === ABILITY_GENERATION.methods.find((m) => m.id === "point-buy").totalPoints;
}

function validateRollBase(base) {
  return Object.values(base).every((s) => s >= 3 && s <= 18);
}

/**
 * Verifica se os atributos finais são coerentes com methodId + bônus do antecedente.
 * Retorna { ok: true } ou { ok: false, reason: string }.
 */
export function validateAbilityScores(doc) {
  const { abilities, abilityGeneration, backgroundId, feats } = doc;
  const { methodId, backgroundBoostId } = abilityGeneration ?? {};

  for (const score of Object.values(abilities)) {
    if (score < 1 || score > 30) {
      return { ok: false, reason: "valor fora do intervalo 1–30" };
    }
  }

  if (!backgroundBoostId) {
    return { ok: false, reason: "backgroundBoostId ausente" };
  }

  const allowedBoosts = backgroundAbilityIds(backgroundId);
  if (allowedBoosts.length !== 3) {
    return { ok: false, reason: "antecedente sem três atributos elegíveis" };
  }

  const preAsi = abilitiesWithoutAsi(abilities, feats);
  for (const score of Object.values(preAsi)) {
    if (score < 1 || score > ABILITY_GENERATION.backgroundBoost.maxScore) {
      return {
        ok: false,
        reason: `base pré-ASI fora do intervalo 1–${ABILITY_GENERATION.backgroundBoost.maxScore}`,
      };
    }
  }

  const baseResult = baseScoresFromBoost(preAsi, allowedBoosts, backgroundBoostId);
  const bases = Array.isArray(baseResult) ? baseResult : baseResult ? [baseResult] : [];
  if (!bases.length) {
    return { ok: false, reason: "combinação de bônus do antecedente inválida" };
  }

  const matchesMethod = (base) => {
    if (methodId === "standard-array") return validateStandardArrayBase(base);
    if (methodId === "point-buy") return validatePointBuyBase(base);
    if (methodId === "roll") return validateRollBase(base);
    return false;
  };

  if (!bases.some(matchesMethod)) {
    if (methodId === "standard-array") {
      return { ok: false, reason: "base não corresponde ao conjunto padrão após remover bônus/ASI" };
    }
    if (methodId === "point-buy") {
      return { ok: false, reason: "base não corresponde a ponto buy (27 pts, scores 8–15)" };
    }
    if (methodId === "roll") {
      return { ok: false, reason: "base fora do intervalo 3–18 (4d6 descartando menor)" };
    }
    return { ok: false, reason: `methodId desconhecido: ${methodId}` };
  }

  let expected = { ...preAsi };
  for (const feat of feats ?? []) {
    if (!feat.asi) continue;
    const asi = { ...feat.asi };
    expected = applyAsiBoost(expected, asi);
  }
  for (const id of ABILITY_IDS) {
    if ((abilities[id] ?? 0) !== (expected[id] ?? 0)) {
      return {
        ok: false,
        reason: `atributo ${id}=${abilities[id]}, esperado ${expected[id]} após ASI de talentos`,
      };
    }
  }

  return { ok: true };
}

export function isSpellcaster(classId, level, subclassId = null) {
  if (subclassId && isThirdCaster(classId, subclassId, level)) return true;
  return expectedClassCantrips(classId, level) != null || expectedPreparedCount(classId, level) != null;
}

/** Magias no livro de magias do Mago: 6 no nível 1, +2 por nível adicional. */
export function expectedSpellbookCount(classId, level) {
  if (classId !== "wizard" || level < 1) return null;
  return 6 + 2 * (level - 1);
}

export function spellIdsFromSpellcasting(sc, listType, sourceKey = null) {
  if (!sc) return [];
  const bucket = listType === "known" ? sc.cantrips : listType === "spellbook" ? sc.spellbook : sc.prepared;
  if (!bucket) return [];
  if (sourceKey) return bucket[sourceKey] ?? [];
  return Object.values(bucket).flat();
}

function countUnique(arr) {
  return new Set(arr).size;
}

export function validateSubclassRequired(doc) {
  const cls = loadClass(doc.classId);
  const unlock = cls.subclassUnlockLevel ?? 3;
  if (doc.level >= unlock && !doc.subclassId) {
    return {
      ok: false,
      reason: `nível ${doc.level} exige subclasse (desbloqueio ${unlock})`,
    };
  }
  return { ok: true };
}

export function validateSpellcasting(doc) {
  const { classId, level, subclassId, spellcasting: sc } = doc;
  const third = subclassId && isThirdCaster(classId, subclassId, level);

  if (third) {
    const cfg = thirdCasterConfig(classId, subclassId);
    const expCantrips = expectedThirdCasterCantrips(classId, subclassId, level);
    const expPrepared = expectedThirdCasterPrepared(classId, subclassId, level);
    const expSlots = expectedThirdCasterSpellSlots(classId, subclassId, level);

    if (!sc) {
      return { ok: false, reason: `${subclassId} nível ${level} exige conjuração` };
    }

    const classCantrips = sc.cantrips?.class ?? [];
    if (classCantrips.length !== expCantrips) {
      return {
        ok: false,
        reason: `truques ${classCantrips.length}, esperado ${expCantrips} (${subclassId})`,
      };
    }
    for (const req of cfg.requiredCantripIds ?? []) {
      if (!classCantrips.includes(req)) {
        return { ok: false, reason: `truque obrigatório ausente: ${req}` };
      }
    }

    const classPrepared = sc.prepared?.class ?? [];
    if (classPrepared.length !== expPrepared) {
      return {
        ok: false,
        reason: `magias preparadas ${classPrepared.length}, esperado ${expPrepared} (${subclassId})`,
      };
    }

    const slots = sc.slotsMax ?? {};
    const expKeys = Object.keys(expSlots ?? {}).sort();
    const gotKeys = Object.keys(slots).sort();
    if (expKeys.join(",") !== gotKeys.join(",")) {
      return { ok: false, reason: `slots ${gotKeys.join("/")}, esperado ${expKeys.join("/")}` };
    }
    for (const k of expKeys) {
      if (slots[k] !== expSlots[k]) {
        return { ok: false, reason: `slot círculo ${k}: ${slots[k]}, esperado ${expSlots[k]}` };
      }
    }
    return { ok: true };
  }

  if (!isSpellcaster(classId, level)) {
    if (sc?.cantrips?.class?.length || sc?.prepared?.class?.length || sc?.spellbook?.class?.length) {
      return { ok: false, reason: "classe não conjuradora com magias de classe" };
    }
    return { ok: true };
  }

  if (!sc) return { ok: false, reason: "conjurador sem spellcasting" };

  const expCantrips = expectedClassCantrips(classId, level);
  let extraCantrips = 0;
  if (classId === "cleric" && doc.classChoices?.divineOrder === "thaumaturge") {
    extraCantrips = 1;
  }
  const classCantrips = sc.cantrips?.class ?? [];
  if (expCantrips != null && classCantrips.length !== expCantrips + extraCantrips) {
    return {
      ok: false,
      reason: `truques ${classCantrips.length}, esperado ${expCantrips + extraCantrips}`,
    };
  }

  const expPrepared = expectedPreparedCount(classId, level);
  const classPrepared = sc.prepared?.class ?? [];
  if (expPrepared != null && classPrepared.length !== expPrepared) {
    return {
      ok: false,
      reason: `magias preparadas ${classPrepared.length}, esperado ${expPrepared}`,
    };
  }

  if (classId === "wizard") {
    const expBook = expectedSpellbookCount(classId, level);
    const bookIds = sc.spellbook?.class ?? [];
    if (bookIds.length !== expBook) {
      return {
        ok: false,
        reason: `livro de magias ${bookIds.length}, esperado ${expBook}`,
      };
    }
    for (const id of classPrepared) {
      if (!bookIds.includes(id)) {
        return { ok: false, reason: `preparada ${id} não está no livro de magias` };
      }
    }
  }

  const expSlots = expectedSpellSlots(classId, level);
  if (expSlots) {
    const slots = sc.slotsMax ?? {};
    for (const [circle, max] of Object.entries(expSlots)) {
      if (slots[circle] !== max) {
        return { ok: false, reason: `slot círculo ${circle}: ${slots[circle]}, esperado ${max}` };
      }
    }
  }

  return { ok: true };
}

export function validateSubclassSpells(doc) {
  if (!doc.subclassId || doc.level < 3) return { ok: true };

  const expected = expectedSubclassPrepared(
    doc.classId,
    doc.subclassId,
    doc.level,
    doc.classChoices ?? {}
  );
  if (!expected) return { ok: true };
  if (expected.requiresTerrain && !doc.classChoices?.landTerrainId) {
    return { ok: false, reason: "druida Círculo da Terra exige landTerrainId" };
  }

  const got = doc.spellcasting?.prepared?.[expected.sourceKey] ?? [];
  const exp = expected.spellIds;
  const missing = exp.filter((id) => !got.includes(id));
  if (missing.length) {
    return {
      ok: false,
      reason: `magias de subclasse ausentes (${expected.sourceKey}): ${missing.join(", ")}`,
    };
  }
  return { ok: true };
}

export function validateSubclassMechanics(doc) {
  if (!doc.subclassId || doc.level < 3) return { ok: true };

  for (const res of resourcesForSubclass(doc.classId, doc.subclassId)) {
    if (doc.level < res.unlockLevel) continue;
    const expectedMax = subclassResourceMax(res.maxFormula, doc, res.fixedMax);
    const got = doc.resources?.[res.slug];
    if (!got) {
      return { ok: false, reason: `recurso de subclasse ausente: ${res.slug}` };
    }
    if (got.max !== expectedMax) {
      return {
        ok: false,
        reason: `recurso ${res.slug} max=${got.max}, esperado ${expectedMax}`,
      };
    }
  }

  for (const opt of optionsForSubclass(doc.classId, doc.subclassId)) {
    if (doc.level < opt.unlockLevel) continue;
    const val = doc.subclassChoices?.[opt.optionKey];
    if (!val) {
      return { ok: false, reason: `opção de subclasse ausente: ${opt.optionKey}` };
    }
    const allowed = opt.values.map((v) => v.valueId);
    if (!allowed.includes(val)) {
      return { ok: false, reason: `opção ${opt.optionKey}=${val} inválida` };
    }
  }

  return { ok: true };
}

export function validateFeatRoster(doc) {
  const bg = loadBackground(doc.backgroundId);
  const feats = doc.feats ?? [];

  const bgFeats = feats.filter((f) => f.source === "background");
  if (bgFeats.length !== 1 || bgFeats[0].featId !== bg.feat.id) {
    return {
      ok: false,
      reason: `antecedente ${doc.backgroundId} exige feat ${bg.feat.id}, encontrado: ${bgFeats.map((f) => f.featId).join(", ") || "nenhum"}`,
    };
  }
  if ((bgFeats[0].unlockLevel ?? 1) !== 1) {
    return { ok: false, reason: "feat de antecedente deve ter unlockLevel 1" };
  }

  const speciesFeats = feats.filter((f) => f.source === "species");
  if (doc.speciesId === "human") {
    if (speciesFeats.length !== 1 || speciesFeats[0].featId !== "skilled") {
      return { ok: false, reason: "humano (Versátil) exige skilled com source species" };
    }
  } else if (speciesFeats.length > 0) {
    return { ok: false, reason: "espécie não-humana não deve ter feat de species" };
  }

  const classFeats = feats.filter((f) => f.source === "class");
  const generalFeats = feats.filter((f) => f.source === "general");
  const expectedSlots = expectedClassFeatSlots(doc.classId, doc.level);
  const asiLevels = expectedSlots.filter((s) => !s.epic).map((s) => s.unlockLevel);
  const epicSlots = expectedSlots.filter((s) => s.epic);

  if (classFeats.length + generalFeats.length !== expectedSlots.length) {
    return {
      ok: false,
      reason: `progressão nível=${classFeats.length + generalFeats.length}, esperado ${expectedSlots.length} (ASI/talento geral + épico)`,
    };
  }

  for (const gf of generalFeats) {
    if (!asiLevels.includes(gf.unlockLevel)) {
      return {
        ok: false,
        reason: `talento geral ${gf.featId} no nível ${gf.unlockLevel} não substitui slot de ASI`,
      };
    }
    if (!GENERAL_FEAT_DEFS[gf.featId]) {
      return { ok: false, reason: `talento geral ${gf.featId} sem mecânica implementada` };
    }
  }

  const generalLevels = new Set(generalFeats.map((f) => f.unlockLevel));
  const classAsi = classFeats.filter((f) => f.featId === "ability-score-improvement");
  if (classAsi.length + generalFeats.length !== asiLevels.length) {
    return {
      ok: false,
      reason: `slots ASI=${classAsi.length}+gerais ${generalFeats.length}, esperado ${asiLevels.length}`,
    };
  }

  const sortedClass = [...classFeats].sort((a, b) => (a.unlockLevel ?? 1) - (b.unlockLevel ?? 1));
  for (const exp of epicSlots) {
    const got = sortedClass.find((f) => f.unlockLevel === exp.unlockLevel);
    if (!got) return { ok: false, reason: `dádiva épica nível ${exp.unlockLevel} ausente` };
    if (got.featId === "ability-score-improvement") {
      return { ok: false, reason: `nível ${exp.unlockLevel} deve ser dádiva épica, não ASI` };
    }
    if (!got.asi || got.asi.mode !== "single+1") {
      return { ok: false, reason: `dádiva épica ${got.featId} exige ASI +1` };
    }
  }

  for (const unlockLevel of asiLevels) {
    if (generalLevels.has(unlockLevel)) continue;
    const got = classAsi.find((f) => f.unlockLevel === unlockLevel);
    if (!got) {
      return { ok: false, reason: `ASI nível ${unlockLevel} ausente` };
    }
    if (!got.asi) {
      return { ok: false, reason: `ASI nível ${unlockLevel} sem objeto asi` };
    }
  }

  const unexpected = feats.filter(
    (f) => f.source !== "background" && f.source !== "species" && f.source !== "class" && f.source !== "general"
  );
  if (unexpected.length) {
    return {
      ok: false,
      reason: `feats com source inesperada: ${unexpected.map((f) => `${f.featId}(${f.source})`).join(", ")}`,
    };
  }

  return { ok: true };
}

function abilitiesBeforeFeat(doc, feat) {
  const abilities = { ...doc.abilities };
  const later = (doc.feats ?? []).filter((f) => (f.unlockLevel ?? 1) > (feat.unlockLevel ?? 1));
  for (const [id, delta] of Object.entries(sumAsiDeltas(later))) {
    abilities[id] = (abilities[id] ?? 0) - delta;
  }
  return abilities;
}

function prerequisiteContextForFeat(doc, feat) {
  const unlock = feat.unlockLevel ?? 1;
  const existingFeats = (doc.feats ?? []).filter(
    (f) => f.source === "general" && (f.unlockLevel ?? 1) < unlock
  );
  return {
    classId: doc.classId,
    level: doc.level,
    unlockLevel: unlock,
    abilities: abilitiesBeforeFeat(doc, feat),
    classSavingThrows: loadClass(doc.classId).savingThrowIds ?? [],
    classChoices: doc.classChoices,
    subclassId: doc.subclassId,
    existingFeats,
  };
}

export function validateFeatPrerequisites(doc) {
  for (const feat of doc.feats ?? []) {
    if (feat.source !== "general") continue;
    const ctx = prerequisiteContextForFeat(doc, feat);
    const result = checkFeatPrerequisites(feat.featId, ctx);
    if (!result.ok) {
      return { ok: false, reason: `${feat.featId}@${feat.unlockLevel}: ${result.reason}` };
    }
  }
  return { ok: true };
}

export function validateGeneralFeats(doc) {
  const sc = doc.spellcasting;

  for (const feat of doc.feats ?? []) {
    if (feat.source !== "general") continue;
    const def = GENERAL_FEAT_DEFS[feat.featId];
    if (!def) {
      return { ok: false, reason: `talento geral ${feat.featId} não implementado` };
    }
    if (!feat.asi || feat.asi.mode !== "single+1") {
      return { ok: false, reason: `${feat.featId} exige ASI +1` };
    }

    if (feat.featId === "resilient") {
      if (!feat.resilient?.abilityId) {
        return { ok: false, reason: "resilient sem resilient.abilityId" };
      }
      if (!doc.savingThrowProficiencies?.includes(feat.resilient.abilityId)) {
        return {
          ok: false,
          reason: `resilient ${feat.resilient.abilityId} não está em savingThrowProficiencies`,
        };
      }
    }

    if (feat.featId === "elemental-adept") {
      const typeId = feat.elementalAdept?.damageTypeId;
      if (!typeId || !ELEMENTAL_DAMAGE_TYPES.includes(typeId)) {
        return { ok: false, reason: `elemental-adept tipo inválido: ${typeId ?? "ausente"}` };
      }
    }

    if (def.spells || def.ritualSpells) {
      const expPrep = expectedGeneralFeatPrepared(feat);
      const expCantrips = expectedGeneralFeatCantrips(feat);
      const gotPrep = sc?.prepared?.[feat.featId] ?? [];
      const gotCantrips = sc?.cantrips?.[feat.featId] ?? [];
      if (expPrep.length && gotPrep.sort().join(",") !== [...expPrep].sort().join(",")) {
        return {
          ok: false,
          reason: `${feat.featId} preparadas=${gotPrep.join(",")}, esperado ${expPrep.join(",")}`,
        };
      }
      if (expCantrips.length && gotCantrips.sort().join(",") !== [...expCantrips].sort().join(",")) {
        return {
          ok: false,
          reason: `${feat.featId} truques=${gotCantrips.join(",")}, esperado ${expCantrips.join(",")}`,
        };
      }
      if (def.ritualSpells) {
        const pb = proficiencyBonusAtLevel(feat.unlockLevel ?? doc.level) ?? 2;
        if (expPrep.length !== pb) {
          return {
            ok: false,
            reason: `${feat.featId} rituais=${expPrep.length}, esperado ${pb} (PB no nível ${feat.unlockLevel})`,
          };
        }
      }
      if ((expPrep.length || expCantrips.length) && !feat.castingAbilityId) {
        return { ok: false, reason: `${feat.featId} sem castingAbilityId` };
      }
    }
  }

  return { ok: true };
}

export function validateMagicInitiate(doc) {
  const hasFeat = (doc.feats ?? []).some((f) => f.featId === "magic-initiate");
  const sc = doc.spellcasting;
  const hasSpells =
    (sc?.cantrips?.["magic-initiate"]?.length ?? 0) > 0 ||
    (sc?.prepared?.["magic-initiate"]?.length ?? 0) > 0;

  if (!hasFeat) {
    if (hasSpells) return { ok: false, reason: "magias magic-initiate sem talento na ficha" };
    return { ok: true };
  }

  const miFeat = (doc.feats ?? []).find((f) => f.featId === "magic-initiate");
  if (miFeat.source !== "background") {
    return { ok: false, reason: "magic-initiate deve vir do antecedente" };
  }

  const expectedList = MAGIC_INITIATE_BACKGROUND_CLASS[doc.backgroundId];
  if (!expectedList) {
    return { ok: false, reason: `antecedente ${doc.backgroundId} não concede Iniciado em Magia` };
  }

  const mi = miFeat.magicInitiate;
  if (!mi) return { ok: false, reason: "feats[].magicInitiate ausente" };
  if (mi.spellListClassId !== expectedList) {
    return {
      ok: false,
      reason: `magicInitiate.spellListClassId=${mi.spellListClassId}, esperado ${expectedList}`,
    };
  }

  const cantrips = sc?.cantrips?.["magic-initiate"] ?? [];
  const prepared = sc?.prepared?.["magic-initiate"] ?? [];
  if (cantrips.length !== 2) {
    return { ok: false, reason: `MI truques=${cantrips.length}, esperado 2` };
  }
  if (prepared.length !== 1) {
    return { ok: false, reason: `MI preparadas=${prepared.length}, esperado 1` };
  }
  if (prepared[0] !== mi.preparedSpellId) {
    return {
      ok: false,
      reason: `MI preparada ${prepared[0]} ≠ magicInitiate.preparedSpellId ${mi.preparedSpellId}`,
    };
  }
  for (const id of cantrips) {
    if (!mi.cantripIds.includes(id)) {
      return { ok: false, reason: `truque MI ${id} não está em magicInitiate.cantripIds` };
    }
  }

  return { ok: true };
}

export function validateHp(doc) {
  const expected = expectedMaxHpForCharacter(doc);
  if (expected == null) return { ok: true };
  if (doc.hp?.max !== expected) {
    return { ok: false, reason: `HP max=${doc.hp?.max}, esperado ${expected} (inclui Vigoroso/espécie)` };
  }
  if (doc.hp?.current !== expected) {
    return { ok: false, reason: `HP current=${doc.hp?.current}, esperado ${expected}` };
  }
  return { ok: true };
}

export function validateExpertiseList(doc) {
  const expected = buildExpertise(doc);
  const got = [...(doc.expertise ?? [])].sort();
  const exp = [...expected].sort();
  if (got.length !== exp.length) {
    return { ok: false, reason: `expertise=${got.join(",")}, esperado ${exp.join(",")}` };
  }
  for (let i = 0; i < exp.length; i++) {
    if (got[i] !== exp[i]) {
      return { ok: false, reason: `expertise=${got.join(",")}, esperado ${exp.join(",")}` };
    }
  }
  return { ok: true };
}

/** Executa todos os validadores de regras de jogo sobre uma ficha. */
export function validateCharacterRules(doc) {
  const checks = [
    validateAbilityScores,
    validateSpeciesChoices,
    validateSingleClass,
    validateSubclassRequired,
    validateSubclassLevel,
    validateSpeciesSpellcasting,
    validateSpeciesResources,
    validateFeatRoster,
    validateFeatPrerequisites,
    validateGeneralFeats,
    validateMagicInitiate,
    validateHp,
    validateExpertiseList,
    validateWeaponMasteryChoices,
    validateEquippedArmorTraining,
    validateShieldMaster,
    validateToolProficiencies,
    validateFeatSkillChoices,
    validateArmorClass,
    validateFightingStyle,
    validateSkillProficiencies,
    validatePassivePerception,
    validateStartingEquipment,
    validateClassResources,
    validateSpellcasting,
    validateSubclassSpells,
    validateSubclassMechanics,
  ];

  for (const fn of checks) {
    const result = fn(doc);
    if (!result.ok) {
      return { ok: false, reason: result.reason, validator: fn.name };
    }
  }
  return { ok: true };
}

export function allCantripIds(character) {
  if (!character.spellcasting?.cantrips) return [];
  return Object.values(character.spellcasting.cantrips).flat();
}

export function allPreparedIds(character) {
  if (!character.spellcasting?.prepared) return [];
  return Object.values(character.spellcasting.prepared).flat();
}

const WEAPONS_DOC = JSON.parse(
  fs.readFileSync(path.join(phb, "weapons/weapons.json"), "utf8")
);
const ARMOR_DOC = JSON.parse(fs.readFileSync(path.join(phb, "armor/armor.json"), "utf8"));
const MASTERY_PROGRESSION = JSON.parse(
  fs.readFileSync(path.join(phb, "weapons/mastery-progression.json"), "utf8")
);
const FIGHTING_STYLES = JSON.parse(
  fs.readFileSync(path.join(phb, "classes/fighting-styles.json"), "utf8")
);

const WEAPONS_BY_ID = Object.fromEntries(WEAPONS_DOC.weapons.map((w) => [w.id, w]));
const ARMOR_BY_ID = Object.fromEntries(ARMOR_DOC.items.map((a) => [a.id, a]));

export function loadWeapon(weaponId) {
  return WEAPONS_BY_ID[weaponId] ?? null;
}

export function loadArmor(armorId) {
  return ARMOR_BY_ID[armorId] ?? null;
}

/** Slots de maestria em armas no nível atual (0 se a classe não usa). */
export function expectedWeaponMasterySlots(classId, level, featIds = []) {
  const rule = MASTERY_PROGRESSION.classes[classId];
  if (!rule) return 0;

  let slots = 0;
  for (const [lvlStr, count] of Object.entries(rule.slotsByLevel)) {
    if (level >= Number(lvlStr)) slots = Math.max(slots, count);
  }

  const bonus = MASTERY_PROGRESSION.featBonus;
  if (bonus && featIds.includes(bonus.featId)) {
    slots += bonus.extraSlots;
  }

  return slots;
}

export function validateWeaponMasteryChoices(doc) {
  const featIds = doc.feats.map((f) => f.featId);
  const expected = expectedWeaponMasterySlots(doc.classId, doc.level, featIds);
  const choices = doc.weaponMasteryWeaponIds ?? [];

  if (expected === 0) {
    if (choices.length) {
      return { ok: false, reason: "classe não concede maestria em armas" };
    }
    return { ok: true };
  }

  if (choices.length !== expected) {
    return {
      ok: false,
      reason: `${choices.length} armas de maestria, esperado ${expected} no nível ${doc.level}`,
    };
  }

  const rule = MASTERY_PROGRESSION.classes[doc.classId];
  const unique = new Set(choices);
  if (unique.size !== choices.length) {
    return { ok: false, reason: "arma de maestria duplicada" };
  }

  for (const weaponId of choices) {
    const weapon = loadWeapon(weaponId);
    if (!weapon) return { ok: false, reason: `arma desconhecida: ${weaponId}` };
    if (!rule.allowedCategories.includes(weapon.category)) {
      return { ok: false, reason: `${weaponId}: categoria ${weapon.category} não permitida` };
    }
    if (!rule.allowedTypes.includes(weapon.type)) {
      return { ok: false, reason: `${weaponId}: tipo ${weapon.type} não permitido para a classe` };
    }
  }

  return { ok: true };
}

const ARMOR_CATEGORY_TO_TRAINING = {
  light: "light",
  medium: "medium",
  heavy: "heavy",
  shield: "shields",
};

export function validateEquippedArmorTraining(doc) {
  const training = effectiveArmorTraining(doc);
  if (!Object.keys(training).length) return { ok: true };

  for (const item of doc.equipment) {
    if (!item.equipped || (item.slot !== "armor" && item.slot !== "shield")) continue;

    const armor = loadArmor(item.itemId);
    if (!armor) {
      return { ok: false, reason: `equipamento ${item.itemId} não é armadura` };
    }

    const key = ARMOR_CATEGORY_TO_TRAINING[armor.category];
    if (!key || !training[key]) {
      return {
        ok: false,
        reason: `sem treinamento para ${armor.name} (${armor.category})`,
      };
    }
  }

  return { ok: true };
}

function equippedItem(doc, slot) {
  return doc.equipment.find((item) => item.equipped && item.slot === slot);
}

/** Calcula CA esperada a partir de armadura equipada, escudo, Destreza e estilo de luta. */
export function expectedArmorClass(doc) {
  const dexMod = abilityMod(doc.abilities.destreza);
  const armorItem = equippedItem(doc, "armor");
  const shieldItem = equippedItem(doc, "shield");

  let base = 10;
  let dexBonus = dexMod;
  let shieldBonus = 0;
  let fightingStyleBonus = 0;

  if (armorItem) {
    const armor = loadArmor(armorItem.itemId);
    if (armor?.acFormula?.type === "fixed") {
      base = armor.acFormula.base;
      dexBonus = 0;
    } else if (armor?.acFormula?.type === "dex-plus-base") {
      base = armor.acFormula.base;
      const cap = armor.acFormula.dexMax;
      dexBonus = cap != null ? Math.min(dexMod, cap) : dexMod;
    }
  }

  if (shieldItem) {
    const shield = loadArmor(shieldItem.itemId);
    shieldBonus = shield?.acFormula?.bonus ?? 0;
  }

  const styleId = doc.classChoices?.fightingStyleId;
  const styleRule = styleId ? FIGHTING_STYLES.acBonuses?.[styleId] : null;
  if (styleRule) {
    const wornArmor = armorItem ? loadArmor(armorItem.itemId) : null;
    const qualifies =
      !styleRule.requiresEquippedArmor ||
      (wornArmor && styleRule.armorCategories?.includes(wornArmor.category));
    if (qualifies) fightingStyleBonus = styleRule.bonus;
  }

  const unarmoredBonus = unarmoredDefenseBonus(doc, armorItem, shieldItem);
  const enchantBonus = doc.armorClass?.otherBonus ?? 0;
  const otherBonus = unarmoredBonus > 0 ? unarmoredBonus : enchantBonus;
  const total = base + dexBonus + shieldBonus + fightingStyleBonus + otherBonus;

  return {
    total,
    base,
    dexBonus,
    shieldBonus,
    fightingStyleBonus,
    otherBonus,
  };
}

export function validateArmorClass(doc) {
  const expected = expectedArmorClass(doc);
  const actual = doc.armorClass;

  if (!actual) {
    return { ok: false, reason: "armorClass ausente" };
  }

  if (actual.total !== expected.total) {
    return {
      ok: false,
      reason: `armorClass.total=${actual.total}, esperado ${expected.total}`,
    };
  }

  const fields = ["base", "dexBonus", "shieldBonus", "fightingStyleBonus", "otherBonus"];
  for (const field of fields) {
    if (actual[field] != null && actual[field] !== expected[field]) {
      return {
        ok: false,
        reason: `armorClass.${field}=${actual[field]}, esperado ${expected[field]}`,
      };
    }
  }

  return { ok: true };
}

export function validateFightingStyle(doc) {
  const needsStyle =
    FIGHTING_STYLES.classesWithFightingStyle.includes(doc.classId) &&
    doc.level >= FIGHTING_STYLES.unlockLevel;

  const styleId = doc.classChoices?.fightingStyleId;

  if (!needsStyle) {
    if (styleId) return { ok: false, reason: "classe não usa estilo de luta" };
    return { ok: true };
  }

  if (!styleId) {
    return { ok: false, reason: "classChoices.fightingStyleId ausente" };
  }

  const classAlternatives = FIGHTING_STYLES.classAlternativeStyleIds?.[doc.classId] ?? [];
  const allowed = [...FIGHTING_STYLES.standardStyleIds, ...classAlternatives];

  if (!allowed.includes(styleId)) {
    return { ok: false, reason: `estilo de luta inválido: ${styleId}` };
  }

  if (styleId === "blessed-warrior") {
    const cantrips = doc.spellcasting?.cantrips?.class ?? [];
    if (cantrips.length !== 2) {
      return {
        ok: false,
        reason: `Combatente Abençoado exige 2 truques de Clérigo em spellcasting.cantrips.class (tem ${cantrips.length})`,
      };
    }
  }

  if (styleId === "druidic-warrior") {
    const cantrips = doc.spellcasting?.cantrips?.class ?? [];
    if (cantrips.length !== 2) {
      return {
        ok: false,
        reason: `Combatente Druídico exige 2 truques de Druida em spellcasting.cantrips.class (tem ${cantrips.length})`,
      };
    }
  }

  return { ok: true };
}

export function validateSkillProficiencies(doc) {
  const bg = loadBackground(doc.backgroundId);
  const cls = loadClass(doc.classId);
  const skills = doc.skillProficiencies ?? [];
  const skillIds = skills.map((s) => s.skillId);

  if (new Set(skillIds).size !== skillIds.length) {
    return { ok: false, reason: "perícia duplicada em skillProficiencies" };
  }

  for (const skillId of bg.skillIds) {
    const entry = skills.find((s) => s.skillId === skillId);
    if (!entry) {
      return { ok: false, reason: `perícia do antecedente ausente: ${skillId}` };
    }
    if (entry.source !== "background") {
      return { ok: false, reason: `${skillId} deveria ter source background` };
    }
  }

  const classNeeded = cls.skillChoices?.count ?? 0;
  const classSkills = skills.filter((s) => s.source === "class");
  if (classSkills.length !== classNeeded) {
    return {
      ok: false,
      reason: `${classSkills.length} perícias de classe, esperado ${classNeeded}`,
    };
  }

  const pool = classSkillPool(cls);
  for (const { skillId } of classSkills) {
    if (!pool.includes(skillId)) {
      return { ok: false, reason: `perícia de classe inválida: ${skillId}` };
    }
  }

  if (doc.speciesId === "human") {
    const speciesSkills = skills.filter((s) => s.source === "species");
    if (speciesSkills.length !== 1) {
      return { ok: false, reason: "humano (Hábil) exige exatamente 1 perícia de espécie" };
    }
  }

  if (doc.speciesChoices?.keenSensesSkillId) {
    const keen = skills.find((s) => s.skillId === doc.speciesChoices.keenSensesSkillId);
    if (!keen || keen.source !== "species") {
      return {
        ok: false,
        reason: `perícia de Sentidos Aguçados ausente: ${doc.speciesChoices.keenSensesSkillId}`,
      };
    }
  }

  const skilledCount = doc.feats?.filter((f) => f.featId === "skilled").length ?? 0;
  if (skilledCount > 0) {
    const featSkills = skills.filter((s) => s.source === "feat");
    const expectedFeatSkills = skilledCount * 3;
    if (featSkills.length < expectedFeatSkills) {
      return {
        ok: false,
        reason: `talento Habilidoso exige ${expectedFeatSkills} perícias de feat, tem ${featSkills.length}`,
      };
    }
  }

  return { ok: true };
}

export function validateSubclassLevel(doc) {
  if (!doc.subclassId) return { ok: true };

  const cls = loadClass(doc.classId);
  const unlock = cls.subclassUnlockLevel ?? 3;
  if (doc.level < unlock) {
    return {
      ok: false,
      reason: `subclasse ${doc.subclassId} antes do nível ${unlock}`,
    };
  }

  const classData = JSON.parse(
    fs.readFileSync(path.join(phb, "index.json"), "utf8")
  ).classes.find((c) => c.id === doc.classId);
  const validSubs = classData?.subclasses?.map((s) => s.id) ?? [];
  if (!validSubs.includes(doc.subclassId)) {
    return { ok: false, reason: `subclasse ${doc.subclassId} inválida para ${doc.classId}` };
  }

  return { ok: true };
}

export function validatePassivePerception(doc) {
  const expected = expectedPassivePerception(doc);
  if (doc.passivePerception == null) {
    return { ok: false, reason: "passivePerception ausente" };
  }
  if (doc.passivePerception !== expected) {
    return {
      ok: false,
      reason: `passivePerception=${doc.passivePerception}, esperado ${expected}`,
    };
  }
  return { ok: true };
}

function packageFixedItemIds(pkg) {
  if (!pkg?.items) return [];
  return pkg.items.filter((i) => i.id).map((i) => i.id);
}

/** Itens típicos de escolhas textuais nos pacotes iniciais (PHB 2024). */
const PACKAGE_CHOICE_ITEMS = {
  "2 Adagas": ["dagger"],
  "2 adagas": ["dagger"],
  "4 Machadinhas": ["handaxe"],
  "6 Azagaias": ["javelin"],
};

function packageAllowedItemIds(pkg) {
  const ids = new Set(packageFixedItemIds(pkg));
  for (const item of pkg?.items ?? []) {
    if (item.choice && PACKAGE_CHOICE_ITEMS[item.choice]) {
      for (const id of PACKAGE_CHOICE_ITEMS[item.choice]) ids.add(id);
    }
  }
  return ids;
}

export function validateStartingEquipment(doc) {
  const cls = loadClass(doc.classId);
  const bg = loadBackground(doc.backgroundId);
  const classOpt = cls.startingEquipment?.options?.find(
    (o) => o.label === doc.startingPackages.classOption
  );
  const bgOpt = bg.equipment?.packages?.find((p) => p.id === doc.startingPackages.backgroundOption);

  if (!classOpt) return { ok: false, reason: "opção de equipamento de classe inválida" };
  if (!bgOpt) return { ok: false, reason: "opção de equipamento de antecedente inválida" };

  const allowedClass = packageAllowedItemIds(classOpt);
  const allowedBg = packageAllowedItemIds(bgOpt);

  for (const item of doc.equipment) {
    if (item.source === "purchased" || item.source === "other") continue;
    if (item.source === "class-starting" && !allowedClass.has(item.itemId)) {
      return {
        ok: false,
        reason: `${item.itemId} não consta no pacote ${doc.startingPackages.classOption} da classe`,
      };
    }
    if (item.source === "background-starting" && !allowedBg.has(item.itemId)) {
      return {
        ok: false,
        reason: `${item.itemId} não consta no pacote do antecedente`,
      };
    }
  }

  return { ok: true };
}

export function validateClassResources(doc) {
  const { classId, level, resources } = doc;

  const cd = expectedChannelDivinity(classId, level);
  if (cd != null) {
    if (resources?.channelDivinity?.max !== cd) {
      return {
        ok: false,
        reason: `Canalizar Divindade max=${resources?.channelDivinity?.max}, esperado ${cd}`,
      };
    }
  } else if (resources?.channelDivinity != null) {
    return { ok: false, reason: "classe não usa Canalizar Divindade" };
  }

  const rages = expectedRageUses(level);
  if (classId === "barbarian" && rages != null) {
    if (resources?.rage?.max !== rages) {
      return { ok: false, reason: `Fúria max=${resources?.rage?.max}, esperado ${rages}` };
    }
  } else if (resources?.rage != null) {
    return { ok: false, reason: "classe não usa Fúria" };
  }

  const focus = expectedFocusPoints(level);
  if (classId === "monk" && level >= 2 && focus != null) {
    if (resources?.focusPoints?.max !== focus) {
      return {
        ok: false,
        reason: `Pontos de Foco max=${resources?.focusPoints?.max}, esperado ${focus}`,
      };
    }
  } else if (resources?.focusPoints != null) {
    return { ok: false, reason: "classe não usa Pontos de Foco neste nível" };
  }

  return { ok: true };
}

/** Modificador de ataque para arma com Acuidade (finesse): maior entre Força e Destreza. */
export function finesseAttackModifier(abilities) {
  return Math.max(abilityMod(abilities.forca), abilityMod(abilities.destreza));
}

export function weaponHasFinesse(weaponId) {
  const weaponsDoc = JSON.parse(
    fs.readFileSync(path.join(phb, "weapons/weapons.json"), "utf8")
  );
  const weapon = weaponsDoc.weapons.find((w) => w.id === weaponId);
  return weapon?.propertyIds?.includes("finesse") ?? false;
}
