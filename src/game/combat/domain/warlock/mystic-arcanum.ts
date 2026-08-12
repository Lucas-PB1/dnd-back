/** Arcana Mística — Bruxo L11/13/15/17. */
export const MYSTIC_ARCANUM_SLOTS = [
  { optionKey: 'mysticArcanum6', unlockLevel: 11, spellLevel: 6 },
  { optionKey: 'mysticArcanum7', unlockLevel: 13, spellLevel: 7 },
  { optionKey: 'mysticArcanum8', unlockLevel: 15, spellLevel: 8 },
  { optionKey: 'mysticArcanum9', unlockLevel: 17, spellLevel: 9 },
] as const;

export type MysticArcanumSlot = (typeof MYSTIC_ARCANUM_SLOTS)[number];

export function mysticArcanumSlotsAtLevel(level: number): MysticArcanumSlot[] {
  return MYSTIC_ARCANUM_SLOTS.filter((slot) => slot.unlockLevel <= level);
}

export function isMysticArcanumOptionKey(optionKey: string): boolean {
  return MYSTIC_ARCANUM_SLOTS.some((slot) => slot.optionKey === optionKey);
}

export function mysticArcanumSpellLevelForKey(optionKey: string): number | null {
  return (
    MYSTIC_ARCANUM_SLOTS.find((slot) => slot.optionKey === optionKey)?.spellLevel ??
    null
  );
}
