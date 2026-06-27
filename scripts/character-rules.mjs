/**
 * Regras derivadas para validar fichas contra progression e features do PHB.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";
import { abilityMod, expectedMaxHp, expectedMaxHpForCharacter, speciesHpBonus, toughFeatHpBonus } from "./hp-data.mjs";

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

export function expectedClassCantrips(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.cantrips ?? null;
}

export function expectedPreparedCount(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  return row?.preparedSpells ?? null;
}

export function expectedSpellSlots(classId, level) {
  const row = CLASS_PROGRESSION[classId]?.levels[level - 1];
  if (!row) return null;
  if (classId === "warlock") {
    return row.pactSlots ? { [String(row.pactSlotLevel)]: row.pactSlots } : null;
  }
  return row.spellSlots ?? null;
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

/** Treinamento de armadura efetivo (classe + ordem divina + subclasse). */
export function effectiveArmorTraining(doc) {
  const cls = loadClass(doc.classId);
  const training = { ...(cls.armorTraining ?? {}) };

  if (doc.classId === "cleric" && doc.classChoices?.divineOrder === "protector") {
    training.heavy = true;
  }

  if (doc.classId === "bard" && doc.subclassId === "valor" && doc.level >= 3) {
    training.medium = true;
    training.shields = true;
  }

  return training;
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
  const { abilities, abilityGeneration, backgroundId } = doc;
  const { methodId, backgroundBoostId } = abilityGeneration ?? {};
  const maxScore = ABILITY_GENERATION.backgroundBoost.maxScore;

  for (const score of Object.values(abilities)) {
    if (score < 1 || score > maxScore) {
      return { ok: false, reason: `valor fora do intervalo 1–${maxScore}` };
    }
  }

  if (!backgroundBoostId) {
    return { ok: false, reason: "backgroundBoostId ausente" };
  }

  const allowedBoosts = backgroundAbilityIds(backgroundId);
  if (allowedBoosts.length !== 3) {
    return { ok: false, reason: "antecedente sem três atributos elegíveis" };
  }

  const baseResult = baseScoresFromBoost(abilities, allowedBoosts, backgroundBoostId);
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

  if (bases.some(matchesMethod)) return { ok: true };

  if (methodId === "standard-array") {
    return { ok: false, reason: "base não corresponde ao conjunto padrão após remover bônus" };
  }
  if (methodId === "point-buy") {
    return { ok: false, reason: "base não corresponde a ponto buy (27 pts, scores 8–15)" };
  }
  if (methodId === "roll") {
    return { ok: false, reason: "base fora do intervalo 3–18 (4d6 descartando menor)" };
  }

  return { ok: false, reason: `methodId desconhecido: ${methodId}` };
}

export function isSpellcaster(classId, level) {
  return expectedClassCantrips(classId, level) != null || expectedPreparedCount(classId, level) != null;
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
