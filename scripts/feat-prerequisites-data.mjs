/**
 * Pré-requisitos de talentos (PHB 2024) — validação compartilhada gerador + validador.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { isThirdCaster } from "./third-caster-progression-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "data/phb");

const ADVANCEMENT = JSON.parse(
  fs.readFileSync(path.join(phb, "rules/character-advancement.json"), "utf8")
);

/** Treinamento concedido por talento (espelha GENERAL_FEAT_DEFS.armorTraining). */
const FEAT_ARMOR_GRANTS = {
  "lightly-armored": { light: true, shields: true },
  "moderately-armored": { medium: true },
  "heavily-armored": { heavy: true },
};

const FEAT_ARMOR_REQUIRES = {
  "moderately-armored": { light: true },
  "heavily-armored": { medium: true },
};

const GENERAL_FEAT_IDS = new Set([
  "fey-touched",
  "shadow-touched",
  "resilient",
  "lightly-armored",
  "moderately-armored",
  "heavily-armored",
  "martial-weapon-training",
  "telekinetic",
  "telepathic",
  "durable",
  "athlete",
  "medium-armor-master",
  "heavy-armor-master",
  "ritual-caster",
  "war-caster",
  "elemental-adept",
  "great-weapon-master",
  "sharpshooter",
  "sentinel",
  "polearm-master",
  "mobile",
  "shield-master",
  "grappler",
  "dual-wielder",
  "crossbow-expert",
  "crusher",
  "piercer",
  "slasher",
  "stealthy",
  "spell-sniper",
  "mage-slayer",
  "defensive-duelist",
  "charger",
  "mounted-combatant",
  "poisoner",
  "actor",
  "chef",
  "inspiring-leader",
]);

function loadClassJson(classId) {
  return JSON.parse(fs.readFileSync(path.join(phb, "classes", `${classId}.json`), "utf8"));
}

function armorTrainingForContext(ctx) {
  const cls = loadClassJson(ctx.classId);
  const training = { ...(cls.armorTraining ?? {}) };
  if (ctx.classId === "cleric" && ctx.classChoices?.divineOrder === "protector") {
    training.heavy = true;
  }
  if (ctx.classId === "bard" && ctx.subclassId === "valor" && (ctx.level ?? 1) >= 3) {
    training.medium = true;
    training.shields = true;
  }
  for (const feat of ctx.existingFeats ?? []) {
    const grant = FEAT_ARMOR_GRANTS[feat.featId];
    if (!grant) continue;
    for (const [key, val] of Object.entries(grant)) {
      if (val) training[key] = true;
    }
  }
  return training;
}

function hasSpellcastingFeature(ctx) {
  const cls = loadClassJson(ctx.classId);
  if (cls.spellcasting) return true;
  if (ctx.subclassId && isThirdCaster(ctx.classId, ctx.subclassId, ctx.level ?? ctx.unlockLevel ?? 1)) {
    return true;
  }
  return false;
}

function abilityMax(abilities, ids) {
  return Math.max(...ids.map((id) => abilities[id] ?? 0));
}

/** Pré-requisitos explícitos além das flags em GENERAL_FEAT_DEFS. */
export const FEAT_PREREQUISITES = {
  athlete: { abilityOrMin: { ids: ["forca", "destreza"], min: 13 } },
  "ritual-caster": { abilityOrMin: { ids: ["inteligencia", "sabedoria", "carisma"], min: 13 } },
  "war-caster": { requiresSpellcasting: true },
  "medium-armor-master": { armorTraining: { medium: true } },
  "heavy-armor-master": { armorTraining: { heavy: true } },
  "shield-master": { armorTraining: { shields: true } },
  "great-weapon-master": { abilityOrMin: { ids: ["forca"], min: 13 } },
  sharpshooter: { abilityOrMin: { ids: ["destreza"], min: 13 } },
  sentinel: { abilityOrMin: { ids: ["forca", "destreza"], min: 13 } },
  grappler: { abilityOrMin: { ids: ["forca", "destreza"], min: 13 } },
  "polearm-master": { abilityOrMin: { ids: ["forca", "destreza"], min: 13 } },
  stealthy: { abilityOrMin: { ids: ["destreza"], min: 13 } },
  mobile: { abilityOrMin: { ids: ["destreza", "constituicao"], min: 13 } },
  observant: { abilityOrMin: { ids: ["inteligencia", "sabedoria"], min: 13 } },
  "keen-mind": { abilityOrMin: { ids: ["inteligencia"], min: 13 } },
  "inspiring-leader": { abilityOrMin: { ids: ["sabedoria", "carisma"], min: 13 } },
  "elemental-adept": { requiresSpellcasting: true },
  "spell-sniper": { requiresSpellcasting: true },
  actor: { abilityOrMin: { ids: ["carisma"], min: 13 } },
  "crossbow-expert": { abilityOrMin: { ids: ["destreza"], min: 13 } },
  "defensive-duelist": { abilityOrMin: { ids: ["destreza"], min: 13 } },
  "dual-wielder": { abilityOrMin: { ids: ["forca", "destreza"], min: 13 } },
  charger: { abilityOrMin: { ids: ["forca", "destreza"], min: 13 } },
};

export function proficiencyBonusAtLevel(level) {
  return ADVANCEMENT.levels.find((r) => r.level === level)?.proficiencyBonus ?? null;
}

/**
 * @param {object} ctx
 * @param {string} ctx.classId
 * @param {number} ctx.level
 * @param {number} [ctx.unlockLevel]
 * @param {object} ctx.abilities
 * @param {string[]} [ctx.classSavingThrows]
 * @param {object} [ctx.classChoices]
 * @param {string} [ctx.subclassId]
 * @param {object[]} [ctx.existingFeats]
 */
export function checkFeatPrerequisites(featId, ctx) {
  const level = ctx.level ?? ctx.unlockLevel ?? 1;
  const abilities = ctx.abilities ?? {};

  if (GENERAL_FEAT_IDS.has(featId) && level < 4) {
    return { ok: false, reason: `${featId} exige nível 4+` };
  }

  const req = FEAT_PREREQUISITES[featId];
  if (req?.abilityOrMin) {
    const max = abilityMax(abilities, req.abilityOrMin.ids);
    if (max < req.abilityOrMin.min) {
      return {
        ok: false,
        reason: `${featId} exige ${req.abilityOrMin.ids.join(" ou ")} ≥ ${req.abilityOrMin.min} (max=${max})`,
      };
    }
  }

  if (req?.requiresSpellcasting && !hasSpellcastingFeature(ctx)) {
    return { ok: false, reason: `${featId} exige conjuração` };
  }

  const training = armorTrainingForContext(ctx);

  if (FEAT_ARMOR_REQUIRES[featId]) {
    for (const [key, required] of Object.entries(FEAT_ARMOR_REQUIRES[featId])) {
      if (required && !training[key]) {
        return { ok: false, reason: `${featId} exige treinamento ${key}` };
      }
    }
  }

  if (req?.armorTraining) {
    for (const [key, required] of Object.entries(req.armorTraining)) {
      if (required && !training[key]) {
        return { ok: false, reason: `${featId} exige treinamento ${key}` };
      }
    }
  }

  if (featId === "lightly-armored" && training.light) {
    return { ok: false, reason: "lightly-armored redundante (já tem armadura leve)" };
  }
  if (featId === "moderately-armored" && training.medium) {
    return { ok: false, reason: "moderately-armored redundante (já tem armadura média)" };
  }
  if (featId === "heavily-armored" && training.heavy) {
    return { ok: false, reason: "heavily-armored redundante (já tem armadura pesada)" };
  }

  return { ok: true };
}

export function hasSpellcasting(ctx) {
  return hasSpellcastingFeature(ctx);
}

export { armorTrainingForContext };
