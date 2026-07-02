/**
 * Progressão de conjuração de third-casters (PHB 2024).
 * Cavaleiro Místico e Trapaceiro Arcano usam lista de Mago.
 */

function slots(...counts) {
  const out = {};
  counts.forEach((n, i) => {
    if (n > 0) out[String(i + 1)] = n;
  });
  return out;
}

/** Mesma tabela de preparadas/slots para EK e AT (níveis 3–20). */
const THIRD_CASTER_LEVELS = {
  3: { preparedSpells: 3, spellSlots: slots(2) },
  4: { preparedSpells: 4, spellSlots: slots(3) },
  5: { preparedSpells: 4, spellSlots: slots(3) },
  6: { preparedSpells: 4, spellSlots: slots(3) },
  7: { preparedSpells: 5, spellSlots: slots(4, 2) },
  8: { preparedSpells: 6, spellSlots: slots(4, 2) },
  9: { preparedSpells: 6, spellSlots: slots(4, 2) },
  10: { preparedSpells: 7, spellSlots: slots(4, 3) },
  11: { preparedSpells: 8, spellSlots: slots(4, 3) },
  12: { preparedSpells: 8, spellSlots: slots(4, 3) },
  13: { preparedSpells: 9, spellSlots: slots(4, 3, 2) },
  14: { preparedSpells: 10, spellSlots: slots(4, 3, 2) },
  15: { preparedSpells: 10, spellSlots: slots(4, 3, 2) },
  16: { preparedSpells: 11, spellSlots: slots(4, 3, 3) },
  17: { preparedSpells: 11, spellSlots: slots(4, 3, 3) },
  18: { preparedSpells: 11, spellSlots: slots(4, 3, 3) },
  19: { preparedSpells: 12, spellSlots: slots(4, 3, 3, 1) },
  20: { preparedSpells: 13, spellSlots: slots(4, 3, 3, 1) },
};

export const THIRD_CASTER_SUBCLASSES = {
  "fighter:eldritch-knight": {
    spellListClassId: "wizard",
    cantripsAtLevel(level) {
      if (level < 3) return null;
      return level >= 10 ? 3 : 2;
    },
  },
  "rogue:arcane-trickster": {
    spellListClassId: "wizard",
    requiredCantripIds: ["maos-magicas"],
    cantripsAtLevel(level) {
      if (level < 3) return null;
      return level >= 10 ? 4 : 3;
    },
  },
};

export function thirdCasterKey(classId, subclassId) {
  return `${classId}:${subclassId}`;
}

export function isThirdCaster(classId, subclassId, level) {
  if (level < 3) return false;
  return thirdCasterKey(classId, subclassId) in THIRD_CASTER_SUBCLASSES;
}

export function thirdCasterConfig(classId, subclassId) {
  return THIRD_CASTER_SUBCLASSES[thirdCasterKey(classId, subclassId)] ?? null;
}

export function expectedThirdCasterPrepared(classId, subclassId, level) {
  if (!isThirdCaster(classId, subclassId, level)) return null;
  return THIRD_CASTER_LEVELS[level]?.preparedSpells ?? null;
}

export function expectedThirdCasterCantrips(classId, subclassId, level) {
  const cfg = thirdCasterConfig(classId, subclassId);
  if (!cfg || level < 3) return null;
  return cfg.cantripsAtLevel(level);
}

export function expectedThirdCasterSpellSlots(classId, subclassId, level) {
  if (!isThirdCaster(classId, subclassId, level)) return null;
  return THIRD_CASTER_LEVELS[level]?.spellSlots ?? null;
}
