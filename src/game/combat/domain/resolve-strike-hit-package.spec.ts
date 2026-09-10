import { BLOOD_HOUND_STRIKE_OPTIONS } from './__fixtures__/mechanical-catalog/strike-options.fixtures';
import { findStrikeOption } from './strike-option';
import {
  halfDamage,
  resolveStrikeHitPackage,
  rollStrikeSecondaryDice,
  unarmoredDexArmorClass,
} from './resolve-strike-hit-package';

describe('resolveStrikeHitPackage', () => {
  it('halfDamage floors', () => {
    expect(halfDamage(5)).toBe(2);
    expect(halfDamage(0)).toBe(0);
  });

  it('unarmored DEX AC is 10 + DEX', () => {
    expect(unarmoredDexArmorClass(2)).toBe(12);
    expect(unarmoredDexArmorClass(-1)).toBe(9);
  });

  it('hit package rolls extra dice for hunting', () => {
    const option = findStrikeOption(
      BLOOD_HOUND_STRIKE_OPTIONS,
      'hunting-strike',
    )!;
    const pkg = resolveStrikeHitPackage({
      option,
      level: 5,
      rng: () => 0,
    });
    expect(pkg.ignoreTargetArmor).toBe(true);
    expect(pkg.extraDamage).toBe(1);
    expect(pkg.damageType).toBe('slashing');
  });

  it('secondary dice for replaces-attack option', () => {
    const option = findStrikeOption(
      BLOOD_HOUND_STRIKE_OPTIONS,
      'bloodshard-strike',
    )!;
    const pkg = resolveStrikeHitPackage({
      option,
      level: 5,
      rng: () => 0,
    });
    expect(pkg.replacesAttackWithSave).toBe(true);
    expect(pkg.extraDamage).toBe(0);
    const piercing = rollStrikeSecondaryDice({
      option,
      level: 5,
      rng: () => 0,
    });
    expect(piercing.total).toBe(1);
  });
});
