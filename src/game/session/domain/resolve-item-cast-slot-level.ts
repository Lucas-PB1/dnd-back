import type { ItemCastSlotRule } from './item-cast-rules';


export function resolveItemCastSlotLevel(input: {
  spellLevel: number;
  spendAmount: number;
  slotRule?: ItemCastSlotRule | null;
}): number | null {
  const { spellLevel, spendAmount, slotRule } = input;
  if (spellLevel <= 0) return null;
  if (!slotRule) {
    return Math.max(spellLevel, spendAmount);
  }
  if (slotRule.mode === 'fixed') {
    return slotRule.slotLevel;
  }
  if (slotRule.mode === 'fixed-by-spend') {
    if (
      slotRule.spendAmount === spendAmount &&
      slotRule.spellLevel === spellLevel
    ) {
      return slotRule.slotLevel;
    }
    return Math.max(spellLevel, spendAmount);
  }
  return spellLevel + spendAmount - 1;
}
