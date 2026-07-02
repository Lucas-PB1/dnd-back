/**
 * Progressão de talentos de classe (ASI + Dádiva Épica) — PHB 2024.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { applyGeneralFeat, tryPickGeneralFeat, tryPickManualGeneralFeat } from "./general-feat-mechanics-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "data/phb");

const EPIC_BOON_LEVEL = 19;

function parseAsiLevels(description, firstLevel) {
  const levels = new Set([firstLevel]);
  const m =
    description.match(/níveis?\s+([\d,\s,e\s]+)\s+de\s+/i) ||
    description.match(/novamente nos níveis?\s+([\d,\s,e\s]+)/i);
  if (m) {
    for (const n of m[1].match(/\d+/g) ?? []) levels.add(Number(n));
  }
  return [...levels].sort((a, b) => a - b);
}

function loadClassFeatProgression() {
  const asiLevels = {};
  const epicBoonLevel = {};
  const dir = path.join(phb, "classes");

  for (const file of fs.readdirSync(dir)) {
    if (!file.endsWith(".json") || file === "fighting-styles.json") continue;
    const doc = JSON.parse(fs.readFileSync(path.join(dir, file), "utf8"));
    const asi = doc.features?.find((f) => f.name?.includes("Aumento no Valor de Atributo"));
    if (asi) asiLevels[doc.id] = parseAsiLevels(asi.description, asi.level);
    epicBoonLevel[doc.id] = EPIC_BOON_LEVEL;
  }

  return { asiLevels, epicBoonLevel };
}

export const CLASS_FEAT_PROGRESSION = loadClassFeatProgression();

export const EPIC_BOON_IDS = JSON.parse(
  fs.readFileSync(path.join(phb, "feats/index.json"), "utf8")
).feats.filter((f) => f.category === "epic-boon").map((f) => f.id);

/** Níveis em que a classe concede ASI até o nível informado. */
export function asiUnlockLevels(classId, level) {
  return (CLASS_FEAT_PROGRESSION.asiLevels[classId] ?? []).filter((l) => l <= level);
}

/** Slots de talento de classe (ASI + dádiva épica) no nível atual. */
export function expectedClassFeatSlots(classId, level) {
  const slots = asiUnlockLevels(classId, level).map((unlockLevel) => ({
    featId: "ability-score-improvement",
    source: "class",
    unlockLevel,
  }));
  const epicLevel = CLASS_FEAT_PROGRESSION.epicBoonLevel[classId];
  if (epicLevel != null && level >= epicLevel) {
    slots.push({ featId: null, source: "class", unlockLevel: epicLevel, epic: true });
  }
  return slots;
}

export function pickEpicBoonId(seed) {
  return EPIC_BOON_IDS[Math.abs(seed) % EPIC_BOON_IDS.length];
}

/** +2 em um ou +1 em dois (cap padrão 20). */
import {
  applyAsiBoost,
  pickAsiBoost,
  pickEpicBoonAsi,
  abilitiesWithoutAsi,
  sumAsiDeltas,
} from "./asi-mechanics.mjs";

export { applyAsiBoost, pickAsiBoost, pickEpicBoonAsi, abilitiesWithoutAsi, sumAsiDeltas };

/** Gera talentos de classe e retorna atributos após ASI. */
export function buildClassProgressionFeats(classId, level, priority, seed, baseAbilities, options = {}) {
  const {
    classSavingThrows = [],
    classChoices = {},
    subclassId = null,
    forcedGeneralFeatId = null,
  } = options;
  const feats = [];
  const sideEffects = [];
  let abilities = { ...baseAbilities };
  const existingFeats = [];

  for (const unlockLevel of asiUnlockLevels(classId, level)) {
    const slotSeed = seed + unlockLevel;
    const pickCtx = {
      classId,
      level,
      subclassId,
      classChoices,
      classSavingThrows,
      unlockLevel,
      seed: slotSeed,
      existingFeats,
      abilities,
    };
    let generalId = forcedGeneralFeatId?.[unlockLevel] ?? null;
    if (!generalId && slotSeed % 13 === 0) {
      generalId = tryPickManualGeneralFeat(pickCtx);
    }
    if (!generalId && slotSeed % 9 === 0) {
      generalId = tryPickGeneralFeat(pickCtx);
    }
    if (generalId) {
      const applied = applyGeneralFeat(generalId, unlockLevel, abilities, priority, {
        classSavingThrows,
        seed: slotSeed,
      });
      feats.push(applied.feat);
      abilities = applied.abilities;
      sideEffects.push(applied.sideEffects);
      existingFeats.push(applied.feat);
      continue;
    }

    const asi = pickAsiBoost(abilities, priority, 20);
    abilities = applyAsiBoost(abilities, asi);
    const asiFeat = {
      featId: "ability-score-improvement",
      source: "class",
      unlockLevel,
      asi,
    };
    feats.push(asiFeat);
    existingFeats.push(asiFeat);
  }

  const epicLevel = CLASS_FEAT_PROGRESSION.epicBoonLevel[classId];
  if (epicLevel != null && level >= epicLevel) {
    const featId = pickEpicBoonId(seed + level);
    const asi = pickEpicBoonAsi(featId, abilities, priority, 30);
    abilities = applyAsiBoost(abilities, asi);
    feats.push({
      featId,
      source: "class",
      unlockLevel: epicLevel,
      asi,
    });
  }

  return { feats, abilities, sideEffects };
}
