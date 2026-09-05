import {
  resolveCastMaxUses,
  resolveEffectAmount,
} from './resolve-effect-amount';

describe('resolveEffectAmount', () => {
  it('resolves fixed and proficiency formulas', () => {
    expect(
      resolveEffectAmount({
        amountFormula: 'fixed',
        flat: 7,
        level: 5,
      }).amount,
    ).toBe(7);
    expect(
      resolveEffectAmount({
        amountFormula: 'proficiency_bonus',
        flat: null,
        level: 5,
      }).amount,
    ).toBe(3);
    expect(
      resolveEffectAmount({
        amountFormula: 'level_times_2',
        flat: null,
        level: 4,
      }).amount,
    ).toBe(8);
    expect(
      resolveEffectAmount({
        amountFormula: 'level_div_2',
        flat: null,
        level: 5,
      }).amount,
    ).toBe(2);
  });

  it('rolls 1d4 with deterministic rng', () => {
    expect(
      resolveEffectAmount({
        amountFormula: 'dice_1d4',
        flat: null,
        level: 1,
        rng: () => 0.99,
      }).amount,
    ).toBe(4);
  });

  it('rolls pb dice with deterministic rng', () => {
    const rng = () => 0;
    const rolled = resolveEffectAmount({
      amountFormula: 'dice_pb_d4',
      flat: null,
      level: 1,
      rng,
    });
    expect(rolled.amount).toBe(2);
    expect(rolled.expression).toContain('d4');
  });

  it('rolls hit die plus PB for healer formula', () => {
    const rng = () => 0;
    const rolled = resolveEffectAmount({
      amountFormula: 'dice_hit_die_plus_pb',
      flat: null,
      level: 5,
      hitDieFaces: 10,
      rng,
    });
    expect(rolled.amount).toBe(1 + 3);
    expect(rolled.faces).toBe(10);
  });
});

describe('resolveCastMaxUses', () => {
  it('uses fixed or proficiency bonus for once_per_long_rest', () => {
    expect(
      resolveCastMaxUses({
        economy: 'once_per_long_rest',
        usesFormula: 'fixed',
        fixedUses: 1,
        proficiencyBonus: 4,
      }),
    ).toBe(1);
    expect(
      resolveCastMaxUses({
        economy: 'once_per_long_rest',
        usesFormula: 'proficiency_bonus',
        fixedUses: null,
        proficiencyBonus: 4,
      }),
    ).toBe(4);
    expect(
      resolveCastMaxUses({
        economy: 'at_will',
        usesFormula: 'fixed',
        fixedUses: 1,
        proficiencyBonus: 4,
      }),
    ).toBe(0);
  });
});
