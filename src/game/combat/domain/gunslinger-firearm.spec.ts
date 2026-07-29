import {
  applyOverkillDamageBonus,
  firearmAbilityDamageBonus,
  gunslingerCritThreshold,
  resolveAttackCritThreshold,
} from './gunslinger-firearm';

describe('gunslinger-firearm', () => {
  it('crit thresholds by level', () => {
    expect(gunslingerCritThreshold(1)).toBe(20);
    expect(gunslingerCritThreshold(2)).toBe(19);
    expect(gunslingerCritThreshold(8)).toBe(19);
    expect(gunslingerCritThreshold(9)).toBe(18);
    expect(gunslingerCritThreshold(16)).toBe(18);
    expect(gunslingerCritThreshold(17)).toBe(17);
  });

  it('omits ability mod on firearms before overkill', () => {
    expect(firearmAbilityDamageBonus(5)).toBe(0);
    expect(firearmAbilityDamageBonus(-1)).toBe(0);
  });

  it('overkill re-adds ability mod on firearms at 11+', () => {
    expect(
      applyOverkillDamageBonus({ level: 10, isFirearm: true, abilityMod: 4 }),
    ).toEqual({ abilityDamageBonus: 0, extraDamageDice: null });
    expect(
      applyOverkillDamageBonus({ level: 11, isFirearm: true, abilityMod: 4 }),
    ).toEqual({ abilityDamageBonus: 4, extraDamageDice: null });
  });

  it('overkill adds 1d8 when ability already applies', () => {
    expect(
      applyOverkillDamageBonus({ level: 11, isFirearm: false, abilityMod: 3 }),
    ).toEqual({ abilityDamageBonus: 3, extraDamageDice: '1d8' });
  });

  it('resolves attack crit threshold only for gunslinger ranged', () => {
    expect(
      resolveAttackCritThreshold({
        classSlug: 'gunslinger',
        level: 9,
        mode: 'ranged',
      }),
    ).toBe(18);
    expect(
      resolveAttackCritThreshold({
        classSlug: 'gunslinger',
        level: 9,
        mode: 'melee',
      }),
    ).toBe(20);
    expect(
      resolveAttackCritThreshold({
        classSlug: 'fighter',
        level: 20,
        mode: 'ranged',
      }),
    ).toBe(20);
  });
});
