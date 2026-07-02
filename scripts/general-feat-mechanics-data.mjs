/**
 * Talentos gerais com mecânica (PHB 2024) — magias, proficiências, ASI +1.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { applyAsiBoost } from "./asi-mechanics.mjs";
import { checkFeatPrerequisites, proficiencyBonusAtLevel } from "./feat-prerequisites-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "data/phb");

function loadClassJson(classId) {
  return JSON.parse(fs.readFileSync(path.join(phb, "classes", `${classId}.json`), "utf8"));
}

function classOnlyArmorTraining(ctx) {
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
    const grant = GENERAL_FEAT_DEFS[feat.featId]?.armorTraining;
    if (!grant) continue;
    for (const [key, val] of Object.entries(grant)) {
      if (val) training[key] = true;
    }
  }
  return training;
}

const SPELL_SCHOOLS = {
  feyTouched: ["Adivinhação", "Encantamento"],
  shadowTouched: ["Ilusão", "Necromancia"],
};

function loadLevel1SpellsBySchools(schools) {
  const idx = JSON.parse(fs.readFileSync(path.join(phb, "spells/index.json"), "utf8"));
  const out = [];
  for (const sp of idx.spells) {
    if (sp.level !== 1) continue;
    const doc = JSON.parse(fs.readFileSync(path.join(phb, "spells", sp.file), "utf8"));
    if (schools.includes(doc.school)) out.push(sp.id);
  }
  return out.sort();
}

export const FEY_TOUCHED_SPELL_POOL = loadLevel1SpellsBySchools(SPELL_SCHOOLS.feyTouched);
export const SHADOW_TOUCHED_SPELL_POOL = loadLevel1SpellsBySchools(SPELL_SCHOOLS.shadowTouched);

const RITUAL_SPELL_POOL = (() => {
  const idx = JSON.parse(fs.readFileSync(path.join(phb, "spells/index.json"), "utf8"));
  const out = [];
  for (const sp of idx.spells) {
    if (sp.level !== 1) continue;
    const doc = JSON.parse(fs.readFileSync(path.join(phb, "spells", sp.file), "utf8"));
    if (doc.ritual) out.push(sp.id);
  }
  return out.sort();
})();

export const ELEMENTAL_DAMAGE_TYPES = ["acido", "eletrico", "gelido", "igneo", "trovejante"];

export const GENERAL_FEAT_ROTATION = [
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
];

/** Definições mecânicas por talento geral implementado. */
export const GENERAL_FEAT_DEFS = {
  "fey-touched": {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
    spells: { fixedPrepared: ["passo-nebuloso"], chosenPool: FEY_TOUCHED_SPELL_POOL },
  },
  "shadow-touched": {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
    spells: { fixedPrepared: ["invisibilidade"], chosenPool: SHADOW_TOUCHED_SPELL_POOL },
  },
  resilient: {
    asiFromNonProficientSave: true,
  },
  "lightly-armored": {
    asiPool: ["forca", "destreza"],
    armorTraining: { light: true, shields: true },
  },
  "moderately-armored": {
    asiPool: ["forca", "destreza"],
    armorTraining: { medium: true },
    requiresArmor: { light: true },
  },
  "heavily-armored": {
    asiPool: ["constituicao", "forca"],
    armorTraining: { heavy: true },
    requiresArmor: { medium: true },
  },
  "martial-weapon-training": {
    asiPool: ["forca", "destreza"],
    martialWeapons: true,
  },
  telekinetic: {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
    spells: { cantrip: "maos-magicas" },
  },
  telepathic: {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
    spells: { fixedPrepared: ["detectar-pensamentos"] },
  },
  durable: {
    asiFixed: "constituicao",
  },
  athlete: {
    asiPool: ["forca", "destreza"],
  },
  "medium-armor-master": {
    asiPool: ["forca", "destreza"],
  },
  "heavy-armor-master": {
    asiPool: ["forca", "constituicao"],
  },
  "ritual-caster": {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
    ritualSpells: { pool: RITUAL_SPELL_POOL },
  },
  "war-caster": {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
  },
  "elemental-adept": {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
    elementalDamageType: true,
  },
  "great-weapon-master": {
    asiFixed: "forca",
  },
  sharpshooter: {
    asiFixed: "destreza",
  },
  sentinel: {
    asiPool: ["forca", "destreza"],
  },
  "polearm-master": {
    asiPool: ["forca", "destreza"],
  },
  mobile: {
    asiPool: ["destreza", "constituicao"],
  },
  "shield-master": {
    asiFixed: "forca",
  },
  grappler: {
    asiPool: ["forca", "destreza"],
  },
  "dual-wielder": {
    asiPool: ["forca", "destreza"],
  },
  "crossbow-expert": {
    asiFixed: "destreza",
  },
  crusher: {
    asiPool: ["forca", "constituicao"],
  },
  piercer: {
    asiPool: ["forca", "destreza"],
  },
  slasher: {
    asiPool: ["forca", "destreza"],
  },
  stealthy: {
    asiFixed: "destreza",
  },
  "spell-sniper": {
    asiPool: ["inteligencia", "sabedoria", "carisma"],
  },
  "mage-slayer": {
    asiPool: ["forca", "destreza"],
  },
  "defensive-duelist": {
    asiFixed: "destreza",
  },
  charger: {
    asiPool: ["forca", "destreza"],
  },
  "mounted-combatant": {
    asiPool: ["forca", "destreza", "sabedoria"],
  },
  poisoner: {
    asiPool: ["destreza", "inteligencia"],
  },
  actor: {
    asiFixed: "carisma",
  },
  chef: {
    asiPool: ["constituicao", "sabedoria"],
  },
  "inspiring-leader": {
    asiPool: ["sabedoria", "carisma"],
  },
};

const ALL_ABILITIES = ["forca", "destreza", "constituicao", "inteligencia", "sabedoria", "carisma"];

function pickFromPool(abilities, pool, seed, maxScore = 20) {
  const ordered = [
    ...pool.filter((id) => (abilities[id] ?? 0) + 1 <= maxScore),
    ...pool.filter((id) => (abilities[id] ?? 0) + 1 > maxScore),
  ];
  return ordered[seed % ordered.length] ?? pool[0];
}

function pickChosenSpell(pool, seed) {
  return pool[seed % pool.length];
}

function pickResilientAbility(classSavingThrows, abilities, seed) {
  const nonProf = ALL_ABILITIES.filter((id) => !classSavingThrows.includes(id));
  const pool = nonProf.length ? nonProf : ALL_ABILITIES;
  return pickFromPool(abilities, pool, seed);
}

function armorTrainingForContext(ctx) {
  return classOnlyArmorTraining(ctx);
}

export function canTakeGeneralFeat(featId, ctx) {
  if (!GENERAL_FEAT_DEFS[featId]) return false;
  return checkFeatPrerequisites(featId, ctx).ok;
}

/** Substitui um slot de ASI de classe por talento geral em ~11% dos slots. */
export function tryPickGeneralFeat(ctx) {
  const { seed } = ctx;
  if (seed % 9 !== 0) return null;

  const featId = GENERAL_FEAT_ROTATION[Math.floor(seed / 9) % GENERAL_FEAT_ROTATION.length];
  return canTakeGeneralFeat(featId, ctx) ? featId : null;
}

/**
 * Aplica um talento geral num slot de progressão (substitui ASI).
 * Retorna feat, abilities atualizados e efeitos colaterais.
 */
export function applyGeneralFeat(featId, unlockLevel, abilities, priority, ctx) {
  const def = GENERAL_FEAT_DEFS[featId];
  if (!def) throw new Error(`general feat não implementado: ${featId}`);

  const seed = ctx.seed ?? 0;
  let asi;
  const feat = {
    featId,
    source: "general",
    unlockLevel,
  };

  if (def.asiFromNonProficientSave) {
    const abilityId = pickResilientAbility(ctx.classSavingThrows ?? [], abilities, seed);
    asi = { mode: "single+1", abilityIds: [abilityId] };
    feat.resilient = { abilityId };
  } else if (def.asiFixed) {
    asi = { mode: "single+1", abilityIds: [def.asiFixed] };
  } else {
    const abilityId = pickFromPool(abilities, def.asiPool ?? priority, seed);
    asi = { mode: "single+1", abilityIds: [abilityId] };
  }

  feat.asi = asi;
  if (def.elementalDamageType) {
    feat.elementalAdept = {
      damageTypeId: ELEMENTAL_DAMAGE_TYPES[seed % ELEMENTAL_DAMAGE_TYPES.length],
    };
  } else if (def.ritualSpells) {
    const pb = proficiencyBonusAtLevel(unlockLevel) ?? 2;
    const pool = def.ritualSpells.pool;
    const picked = [];
    for (let i = 0; i < pb; i++) {
      const id = pool[(seed + i) % pool.length];
      if (!picked.includes(id)) picked.push(id);
    }
    feat.castingAbilityId = asi.abilityIds[0];
    feat.featSpells = { preparedSpellIds: picked.sort() };
    feat.ritualCaster = { ritualSpellIds: picked, castingAbilityId: feat.castingAbilityId };
  } else if (def.spells) {
    feat.castingAbilityId = asi.abilityIds[0];
    const chosenSpellId = def.spells.chosenPool
      ? pickChosenSpell(def.spells.chosenPool, seed)
      : null;
    feat.featSpells = {
      ...(def.spells.cantrip ? { cantripIds: [def.spells.cantrip] } : {}),
      ...(def.spells.fixedPrepared || chosenSpellId
        ? {
            preparedSpellIds: [
              ...(def.spells.fixedPrepared ?? []),
              ...(chosenSpellId ? [chosenSpellId] : []),
            ],
          }
        : {}),
      ...(chosenSpellId ? { chosenSpellId } : {}),
    };
  }

  const nextAbilities = applyAsiBoost(abilities, asi);
  const sideEffects = {
    savingThrows: feat.resilient ? [feat.resilient.abilityId] : [],
    armorTraining: def.armorTraining ?? null,
    martialWeapons: Boolean(def.martialWeapons),
    spells: def.spells || def.ritualSpells
      ? { featId, ...feat.featSpells, castingAbilityId: feat.castingAbilityId }
      : null,
  };

  return { feat, abilities: nextAbilities, sideEffects };
}

/** Mescla magias de talentos gerais no objeto spellcasting. */
export function mergeGeneralFeatSpells(spellcasting, feats) {
  if (!feats?.length) return spellcasting;

  const cantrips = { ...(spellcasting?.cantrips ?? {}) };
  const prepared = { ...(spellcasting?.prepared ?? {}) };
  let changed = false;

  for (const feat of feats) {
    if (feat.source !== "general" || !feat.featSpells) continue;
    const key = feat.featId;
    if (feat.featSpells.cantripIds?.length) {
      cantrips[key] = feat.featSpells.cantripIds;
      changed = true;
    }
    if (feat.featSpells.preparedSpellIds?.length) {
      prepared[key] = feat.featSpells.preparedSpellIds;
      changed = true;
    }
  }

  if (!changed) return spellcasting;
  if (!spellcasting) {
    return {
      cantrips,
      prepared,
      slotsMax: {},
      slotsUsed: {},
    };
  }
  return { ...spellcasting, cantrips, prepared };
}

export function expectedGeneralFeatPrepared(feat) {
  if (!feat.featSpells) return [];
  return feat.featSpells.preparedSpellIds ?? [];
}

export function expectedGeneralFeatCantrips(feat) {
  if (!feat.featSpells) return [];
  return feat.featSpells.cantripIds ?? [];
}

/** Proficiências de salvaguarda efetivas (classe + Resiliente). */
export function effectiveSavingThrows(doc) {
  const base = [...(doc.savingThrowProficiencies ?? [])];
  const set = new Set(base);
  for (const feat of doc.feats ?? []) {
    if (feat.featId === "resilient" && feat.resilient?.abilityId) {
      set.add(feat.resilient.abilityId);
    }
  }
  return [...set].sort();
}

/** Treinamento de armadura incluindo talentos gerais. */
export function effectiveArmorTrainingWithFeats(doc) {
  return classOnlyArmorTraining({
    classId: doc.classId,
    level: doc.level,
    subclassId: doc.subclassId,
    classChoices: doc.classChoices,
    existingFeats: doc.feats ?? [],
  });
}

export function classSavingThrows(classId) {
  return loadClassJson(classId).savingThrowIds ?? [];
}
