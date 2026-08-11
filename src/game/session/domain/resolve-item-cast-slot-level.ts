import type { ItemCastSlotRule } from './item-cast-rules';

/**
 * Nível de conjuração ao gastar cargas de item.
 * - Default: max(nível da magia, spend) — custo em cargas ≠ círculo.
 * - Regra SSOT em `properties.itemCastSlotRule(s)` (charge-upcast / fixed / …).
 */
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
  // charge-upcast: 1 carga = círculo base; extras sobem o círculo
  return spellLevel + spendAmount - 1;
}
