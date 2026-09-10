import type { CatalogEffect } from '../catalog-effect';
import {
  flatDamageBonusFromEffects,
  numericBonusFromOwnerEffect,
  scaledDamageDiceFromEffects,
  styleOrFeatHasKind,
  styleOrFeatNumericBonus,
} from './combat-bonus';
import { fixedSkillSlugsFromEffects } from './skills';

function effect(
  overrides: Partial<CatalogEffect> & Pick<CatalogEffect, 'kind'>,
): CatalogEffect {
  return {
    id: '1',
    ownerKind: 'feat',
    ownerId: '10',
    ownerSlug: 'archery',
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

describe('queries/combat-bonus', () => {
  it('reads attack_bonus from owner effect', () => {
    const effects = [
      effect({
        kind: 'attack_bonus',
        ownerSlug: 'archery',
        numeric: { amountFormula: 'fixed', flat: 2 },
      }),
    ];
    expect(
      numericBonusFromOwnerEffect(effects, ['archery'], 'archery', 'attack_bonus', 3),
    ).toBe(2);
  });

  it('reads numeric bonus only from catalog effects', () => {
    expect(
      styleOrFeatNumericBonus({
        effects: [],
        ownedSlugs: ['dueling'],
        ownerSlug: 'dueling',
        kind: 'damage_bonus',
        proficiencyBonus: 3,
      }),
    ).toBe(0);
    expect(
      styleOrFeatNumericBonus({
        effects: [
          effect({
            kind: 'damage_bonus',
            ownerSlug: 'dueling',
            numeric: { amountFormula: 'fixed', flat: 2 },
          }),
        ],
        ownedSlugs: ['dueling'],
        ownerSlug: 'dueling',
        kind: 'damage_bonus',
        proficiencyBonus: 3,
      }),
    ).toBe(2);
  });

  it('detects light_bonus_ability_mod for TWF', () => {
    const effects = [
      effect({ kind: 'light_bonus_ability_mod', ownerSlug: 'two-weapon-fighting' }),
    ];
    expect(
      styleOrFeatHasKind({
        effects,
        ownedSlugs: ['two-weapon-fighting'],
        ownerSlug: 'two-weapon-fighting',
        kind: 'light_bonus_ability_mod',
      }),
    ).toBe(true);
  });

  it('sums flat damage_bonus numeric without treating scaled dice as flat', () => {
    const effects = [
      effect({
        kind: 'damage_bonus',
        ownerSlug: 'great-weapon-master',
        numeric: { amountFormula: 'proficiency_bonus', flat: null },
      }),
      effect({
        kind: 'scaled_damage_dice',
        ownerSlug: 'resolutionofthe-syndicate',
      }),
    ];
    expect(
      flatDamageBonusFromEffects(
        effects,
        ['great-weapon-master', 'resolutionofthe-syndicate'],
        4,
      ),
    ).toBe(4);
    expect(
      scaledDamageDiceFromEffects(
        effects,
        ['great-weapon-master', 'resolutionofthe-syndicate'],
        9,
      ),
    ).toBe('2d4');
  });
});

describe('fixedSkillSlugsFromEffects', () => {
  it('returns deception from blessing-of-loki', () => {
    const effects = [
      effect({
        kind: 'grant_proficiency',
        ownerSlug: 'blessing-of-loki',
        proficiency: { optionKey: 'deception', proficiencyKind: 'skill' },
      }),
      effect({
        kind: 'grant_proficiency',
        ownerSlug: 'skilled',
        proficiency: { optionKey: 'skill1', proficiencyKind: 'skill' },
      }),
    ];
    expect(
      fixedSkillSlugsFromEffects(effects, ['blessing-of-loki', 'skilled']),
    ).toEqual(['deception']);
  });

  it('returns all PHB skills from grant_all_skill_proficiencies', () => {
    const effects = [
      effect({
        kind: 'grant_all_skill_proficiencies',
        ownerSlug: 'boon-of-skill-proficiency',
      }),
    ];
    expect(
      fixedSkillSlugsFromEffects(effects, ['boon-of-skill-proficiency']),
    ).toHaveLength(18);
  });
});
