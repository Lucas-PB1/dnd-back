

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

export function classExpertiseSlotsNewAtLevel(
  slots: readonly ClassExpertiseSlot[],
  level: number,
): ClassExpertiseSlot[] {
  return slots.filter((slot) => slot.unlockLevel === level);
}

export function hasJackOfAllTrades(
  unlockLevel: number | null | undefined,
  level: number,
): boolean {
  return unlockLevel != null && level >= unlockLevel;
}
