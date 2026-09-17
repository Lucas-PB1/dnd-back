import {
  battleMasterOnHitKind,
  resolveBattleMasterOnHit,
} from './resolve-battle-master-on-hit';
import { FIXTURE_BATTLE_MASTER_MANEUVERS } from '../__fixtures__/mechanical-catalog';

jest.mock('@game/dice/domain/dice', () => ({
  rollD20Check: jest.fn((bonus: number) => ({
    total: 8 + bonus,
    d20: { kept: [8], rolls: [8] },
  })),
}));

describe('battleMasterOnHitKind', () => {
  it('maps the three PVE-5b maneuvers', () => {
    expect(battleMasterOnHitKind('trip-attack')).toBe('damage_save_prone');
    expect(battleMasterOnHitKind('menacing-attack')).toBe(
      'damage_save_frightened',
    );
    expect(battleMasterOnHitKind('pushing-attack')).toBe('damage_save_push');
  });

  it('returns null for precision (on miss)', () => {
    expect(battleMasterOnHitKind('precision-attack')).toBeNull();
  });
});

describe('resolveBattleMasterOnHit', () => {
  const base = {
    catalog: FIXTURE_BATTLE_MASTER_MANEUVERS,
    dieFaces: 8,
    dieRoll: 5,
    proficiencyBonus: 3,
    strengthMod: 4,
    dexterityMod: 1,
    targetSaveBonus: 0,
  };

  it('trip-attack adds damage and prone on failed Str save', () => {
    const r = resolveBattleMasterOnHit({
      ...base,
      maneuverSlug: 'trip-attack',
    });
    expect(r.extraDamage).toBe(5);
    expect(r.saveDc).toBe(15);
    expect(r.saved).toBe(false);
    expect(r.conditionSlug).toBe('prone');
    expect(r.note).toContain('Caído');
  });

  it('menacing-attack applies frightened on failed Wis save', () => {
    const r = resolveBattleMasterOnHit({
      ...base,
      maneuverSlug: 'menacing-attack',
    });
    expect(r.extraDamage).toBe(5);
    expect(r.conditionSlug).toBe('frightened');
  });

  it('pushing-attack notes push without condition', () => {
    const r = resolveBattleMasterOnHit({
      ...base,
      maneuverSlug: 'pushing-attack',
    });
    expect(r.extraDamage).toBe(5);
    expect(r.conditionSlug).toBeNull();
    expect(r.pushNote).toBe(true);
    expect(r.note).toContain('empurrado');
  });

  it('rejects non on-hit maneuvers', () => {
    expect(() =>
      resolveBattleMasterOnHit({
        ...base,
        maneuverSlug: 'precision-attack',
      }),
    ).toThrow(/on-hit/i);
  });
});
