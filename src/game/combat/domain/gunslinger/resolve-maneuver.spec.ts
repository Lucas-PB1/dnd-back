import { FIXTURE_GUNSLINGER_MANEUVERS } from '../__fixtures__/mechanical-catalog';
import { findGunslingerManeuver } from './maneuvers';
import { resolveManeuverEffect, type ResourceDieRoll } from './resolve-maneuver';

const RISK: ResourceDieRoll = {
  resourceSlug: 'risk',
  faces: 8,
  value: 5,
  expression: '1d8',
};

describe('resolveManeuverEffect', () => {
  it('resolves temp_hp from catalog effectKind (not slug)', () => {
    const maneuver = findGunslingerManeuver(
      FIXTURE_GUNSLINGER_MANEUVERS,
      'bite-the-bullet',
    )!;
    const result = resolveManeuverEffect({
      maneuver,
      riskRoll: RISK,
      gunslingerLevel: 5,
      dexterityModifier: 3,
    });

    expect(result.effectKind).toBe('temp_hp');
    expect(result.tempHpGained).toBe(10);
    expect(result.note).toContain('PV Temporários');
  });

  it('resolves miss_damage with dexterity floor', () => {
    const maneuver = findGunslingerManeuver(
      FIXTURE_GUNSLINGER_MANEUVERS,
      'grazing-shot',
    )!;
    const result = resolveManeuverEffect({
      maneuver,
      riskRoll: { ...RISK, value: 1 },
      gunslingerLevel: 5,
      dexterityModifier: -2,
    });

    expect(result.missDamage).toBe(1);
    expect(result.note).toContain('Tiro Rasante');
  });

  it('keeps descriptive as note-only residual', () => {
    const maneuver = findGunslingerManeuver(
      FIXTURE_GUNSLINGER_MANEUVERS,
      'fan-the-hammer',
    )!;
    const result = resolveManeuverEffect({
      maneuver,
      riskRoll: RISK,
      gunslingerLevel: 5,
      dexterityModifier: 3,
    });

    expect(result.effectKind).toBe('descriptive');
    expect(result.note).toBe(maneuver.description);
    expect(result.tempHpGained).toBeUndefined();
  });

  it('resolves blindsense_until_eot for blindfire', () => {
    const maneuver = findGunslingerManeuver(
      FIXTURE_GUNSLINGER_MANEUVERS,
      'blindfire',
    )!;
    const result = resolveManeuverEffect({
      maneuver,
      riskRoll: RISK,
      gunslingerLevel: 5,
      dexterityModifier: 3,
    });
    expect(result.blindsenseMeters).toBe(9);
    expect(result.note).toContain('Visão Cega');
  });

  it('resolves attack_damage_bonus for showdown', () => {
    const maneuver = findGunslingerManeuver(
      FIXTURE_GUNSLINGER_MANEUVERS,
      'showdown',
    )!;
    const result = resolveManeuverEffect({
      maneuver,
      riskRoll: RISK,
      gunslingerLevel: 10,
      dexterityModifier: 3,
    });
    expect(result.damageBonus).toBe(5);
  });
});
