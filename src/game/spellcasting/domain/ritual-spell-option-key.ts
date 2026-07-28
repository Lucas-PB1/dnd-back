const RITUAL_SPELL_KEY = /^ritualSpell(\d+)$/;

export function ritualSpellSlotIndex(optionKey: string): number | null {
  const match = RITUAL_SPELL_KEY.exec(optionKey);
  if (!match) return null;
  return Number.parseInt(match[1], 10);
}
