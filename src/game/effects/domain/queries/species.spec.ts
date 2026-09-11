import {
  featSlugsFromEffects,
  filterEffectsByOptionGates,
  languageChoiceCountFromEffects,
  withDefaultSpeciesChoices,
} from './index';
import type { CatalogEffect } from '../catalog-effect';

function baseEffect(
  overrides: Partial<CatalogEffect> & Pick<CatalogEffect, 'kind'>,
): CatalogEffect {
  return {
    id: '1',
    ownerKind: 'species',
    ownerId: '10',
    ownerSlug: 'dwarf',
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
    combatFlag: null,
    companion: null,
    ...overrides,
  };
}

describe('species effect queries', () => {
  it('defaults dwarf culture to phb when missing', () => {
    expect(withDefaultSpeciesChoices('dwarf', [])).toEqual([
      { choiceKind: 'dwarf_culture', choiceSlug: 'phb' },
    ]);
  });

  it('filters tenacity by dwarf culture gate', () => {
    const effects = [
      baseEffect({
        id: 'a',
        kind: 'combat_mod',
        requiresOptionKey: 'dwarfCultureId',
        requiresOptionValue: 'phb',
        combatMod: {
          modKind: 'hp_bonus',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
          secondAbilitySlug: null,
          allowsShield: false,
        },
      }),
      baseEffect({
        id: 'b',
        kind: 'combat_mod',
        requiresOptionKey: 'dwarfCultureId',
        requiresOptionValue: 'fjord',
        combatMod: {
          modKind: 'hp_bonus',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
          secondAbilitySlug: null,
          allowsShield: false,
        },
      }),
    ];
    const gated = filterEffectsByOptionGates(
      effects,
      withDefaultSpeciesChoices('dwarf', [
        { choiceKind: 'dwarf_culture', choiceSlug: 'baugsmidr' },
      ]),
    );
    expect(gated).toHaveLength(0);
  });

  it('resolves grant_feat from human_origin_feat choice', () => {
    const effects = [
      baseEffect({
        ownerSlug: 'human',
        kind: 'grant_feat',
        feat: { optionKey: 'human_origin_feat', featCategory: 'origin' },
      }),
    ];
    expect(
      featSlugsFromEffects(effects, [
        { choiceKind: 'human_origin_feat', choiceSlug: 'alert' },
      ]),
    ).toEqual(['alert']);
  });

  it('sums language choice_count from grant_language', () => {
    const effects = [
      baseEffect({
        kind: 'grant_language',
        language: {
          optionKey: 'speciesLanguage',
          languageSlug: null,
          choiceCount: 2,
        },
      }),
    ];
    expect(languageChoiceCountFromEffects(effects)).toBe(2);
  });
});
