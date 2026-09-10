import type { CatalogEffect } from '../catalog-effect';
import {
  acBonusFromEffects,
  acBonusSourcesFromEffects,
  grantedWeaponPropertySlugsFromEffects,
  hasInspirationRefundOnFail,
  overrideWeaponRangeFtFromEffects,
} from './combat-flags';

function effect(
  overrides: Partial<CatalogEffect> & Pick<CatalogEffect, 'kind'>,
): CatalogEffect {
  return {
    id: '1',
    ownerKind: 'feat',
    ownerId: '10',
    ownerSlug: 'iron-hero',
    trigger: 'passive',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    label: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
    ...overrides,
  };
}

describe('queries/combat-flags', () => {
  it('sums ac_bonus fixed and PB', () => {
    const effects = [
      effect({
        kind: 'ac_bonus',
        ownerSlug: 'iron-hero',
        numeric: { amountFormula: 'fixed', flat: 2 },
      }),
      effect({
        kind: 'ac_bonus',
        ownerSlug: 'defensive-duelist',
        numeric: { amountFormula: 'proficiency_bonus', flat: null },
      }),
    ];
    expect(
      acBonusFromEffects(effects, ['iron-hero', 'defensive-duelist'], 3),
    ).toBe(5);
    expect(
      acBonusSourcesFromEffects(
        effects,
        ['iron-hero', 'defensive-duelist'],
        3,
      ),
    ).toEqual([
      { featSlug: 'defensive-duelist', bonus: 3 },
      { featSlug: 'iron-hero', bonus: 2 },
    ]);
  });

  it('reads grant_weapon_property from weapon satellite', () => {
    const effects = [
      effect({
        kind: 'grant_weapon_property',
        ownerSlug: 'brutal-grip',
        weapon: {
          propertySlug: 'light',
          rangeNormalFt: null,
          rangeLongFt: null,
        },
      }),
    ];
    expect(
      grantedWeaponPropertySlugsFromEffects(effects, ['brutal-grip']),
    ).toEqual(['light']);
  });

  it('reads override range from weapon satellite', () => {
    const effects = [
      effect({
        kind: 'override_weapon_range',
        ownerSlug: 'spear-expert',
        weapon: {
          propertySlug: null,
          rangeNormalFt: 30,
          rangeLongFt: 90,
        },
      }),
    ];
    expect(
      overrideWeaponRangeFtFromEffects(effects, ['spear-expert']),
    ).toEqual({ normalFt: 30, longFt: 90 });
  });

  it('detects inspiration refund', () => {
    const effects = [
      effect({
        kind: 'inspiration_refund_on_fail',
        ownerSlug: 'chosen-by-fate',
      }),
    ];
    expect(
      hasInspirationRefundOnFail(effects, ['chosen-by-fate']),
    ).toBe(true);
  });
});
