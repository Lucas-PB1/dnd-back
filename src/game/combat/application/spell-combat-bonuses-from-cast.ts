/**
 * CD / bônus de ataque do item (Treasure) substituem os do personagem no resolve.
 */
export function spellCombatBonusesFromCast(input: {
  spellAttackBonus: number;
  spellSaveDc: number;
  spellSaveDcOverride?: number | null;
  spellAttackBonusOverride?: number | null;
}): { spellAttackBonus: number; spellSaveDc: number } {
  return {
    spellAttackBonus:
      input.spellAttackBonusOverride ?? input.spellAttackBonus,
    spellSaveDc: input.spellSaveDcOverride ?? input.spellSaveDc,
  };
}
