import { spellCombatBonusesFromCast } from './spell-combat-bonuses-from-cast';

describe('spellCombatBonusesFromCast', () => {
  it('keeps character bonuses when item has no override', () => {
    expect(
      spellCombatBonusesFromCast({
        spellAttackBonus: 7,
        spellSaveDc: 15,
        spellSaveDcOverride: null,
        spellAttackBonusOverride: null,
      }),
    ).toEqual({ spellAttackBonus: 7, spellSaveDc: 15 });
  });

  it('applies wand CD and attack overrides (PVE-6b)', () => {
    expect(
      spellCombatBonusesFromCast({
        spellAttackBonus: 5,
        spellSaveDc: 13,
        spellSaveDcOverride: 15,
        spellAttackBonusOverride: 7,
      }),
    ).toEqual({ spellAttackBonus: 7, spellSaveDc: 15 });
  });
});
