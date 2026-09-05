import {
  catalogEffectsToCombatMods,
  catalogEffectsToResourceGrants,
} from './dual-read-legacy-grants';
import type { CatalogEffect } from './catalog-effect';

describe('dual-read-legacy-grants', () => {
  const grantEffect: CatalogEffect = {
    id: '1',
    kind: 'grant_resource',
    ownerKind: 'class',
    ownerId: '10',
    ownerSlug: 'fighter',
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
    resource: {
      resourceId: '99',
      maxFormula: 'fixed',
      fixedMax: 2,
      recoverOneOnShort: false,
      recoverAllOnShort: false,
      recoverAllOnLong: true,
      recoverOnLongDice: null,
    },
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
  };

  const modEffect: CatalogEffect = {
    ...grantEffect,
    id: '2',
    kind: 'combat_mod',
    resource: null,
    combatMod: {
      modKind: 'hp_bonus',
      flatBonus: 1,
      perLevelBonus: 0,
      fromLevel: 1,
      secondAbilitySlug: null,
      allowsShield: false,
    },
  };

  it('maps grant_resource and combat_mod satellites', () => {
    expect(catalogEffectsToResourceGrants([grantEffect, modEffect])).toEqual([
      expect.objectContaining({
        effectId: '1',
        resourceId: '99',
        maxFormula: 'fixed',
        fixedMax: 2,
      }),
    ]);
    expect(catalogEffectsToCombatMods([grantEffect, modEffect])).toEqual([
      expect.objectContaining({
        effectId: '2',
        modKind: 'hp_bonus',
        flatBonus: 1,
      }),
    ]);
  });
});
