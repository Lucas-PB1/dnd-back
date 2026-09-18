import {
  assertPolearmHaftBonusAttack,
  isPolearmHaftEligibleWeapon,
} from './polearm-haft';

describe('polearm haft', () => {
  it('allows quarterstaff and spear by slug', () => {
    expect(
      isPolearmHaftEligibleWeapon({ itemSlug: 'quarterstaff' }),
    ).toBe(true);
    expect(isPolearmHaftEligibleWeapon({ itemSlug: 'spear' })).toBe(true);
  });

  it('allows reach+heavy weapons', () => {
    expect(
      isPolearmHaftEligibleWeapon({
        itemSlug: 'glaive',
        propertySlugs: ['reach', 'heavy', 'two-handed'],
      }),
    ).toBe(true);
  });

  it('rejects ineligible weapons', () => {
    expect(
      isPolearmHaftEligibleWeapon({
        itemSlug: 'longsword',
        propertySlugs: ['versatile'],
      }),
    ).toBe(false);
  });

  it('assert requires feat and melee', () => {
    expect(() =>
      assertPolearmHaftBonusAttack({
        featSlugs: [],
        mode: 'melee',
        itemSlug: 'spear',
      }),
    ).toThrow(/Mestre em Armas de Haste/);
    expect(() =>
      assertPolearmHaftBonusAttack({
        featSlugs: ['polearm-master'],
        mode: 'ranged',
        itemSlug: 'spear',
      }),
    ).toThrow(/corpo a corpo/);
  });
});
