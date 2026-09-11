/**
 * Especialização (Expertise) — predicados puros sobre slots do catálogo
 * (`phb_option_def` scope=class, option_key expertiseSkill*).
 */

export type ClassExpertiseSlot = {
  optionKey: string;
  unlockLevel: number;
};

export function isClassExpertiseOptionKey(optionKey: string): boolean {
  return /^expertiseSkill\d+$/.test(optionKey);
}

export function classExpertiseSlotsAtLevel(
  slots: readonly ClassExpertiseSlot[],
  level: number,
): ClassExpertiseSlot[] {
  return slots.filter((slot) => slot.unlockLevel <= level);
}

/** Slots que desbloqueiam exatamente neste nível (ex.: Rogue 6 → +2 expertise). */
export function classExpertiseSlotsNewAtLevel(
  slots: readonly ClassExpertiseSlot[],
  level: number,
): ClassExpertiseSlot[] {
  return slots.filter((slot) => slot.unlockLevel === level);
}

/** Pau pra Toda Obra — predicado puro sobre unlock do catálogo. */
export function hasJackOfAllTrades(
  unlockLevel: number | null | undefined,
  level: number,
): boolean {
  return unlockLevel != null && level >= unlockLevel;
}
