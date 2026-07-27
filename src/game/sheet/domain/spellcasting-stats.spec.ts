import {
  computeSpellAttackBonus,
  computeSpellSaveDc,
  spellcastingDerivedStats,
} from './spellcasting-stats';

describe('spellcastingDerivedStats', () => {
  it('returns nulls without spellcasting ability', () => {
    expect(
      spellcastingDerivedStats({
        spellcastingAbilitySlug: null,
        proficiencyBonus: 3,
        abilityModifiers: {
          forca: 2,
          destreza: 1,
          constituicao: 1,
          inteligencia: 0,
          sabedoria: 3,
          carisma: -1,
        },
      }),
    ).toEqual({
      spellcastingAbilitySlug: null,
      spellSaveDc: null,
      spellAttackBonus: null,
    });
  });

  it('computes DC and attack for ranger WIS', () => {
    const result = spellcastingDerivedStats({
      spellcastingAbilitySlug: 'sabedoria',
      proficiencyBonus: 3,
      abilityModifiers: {
        forca: 2,
        destreza: 2,
        constituicao: 1,
        inteligencia: 0,
        sabedoria: 3,
        carisma: -1,
      },
    });
    expect(result.spellSaveDc).toBe(14);
    expect(result.spellAttackBonus).toBe(6);
  });
});

describe('computeSpellSaveDc / computeSpellAttackBonus', () => {
  it('uses 8 + PB + mod', () => {
    expect(computeSpellSaveDc(2, 4)).toBe(14);
    expect(computeSpellAttackBonus(2, 4)).toBe(6);
  });
});
