import {
  assertItemCastEconomyAllows,
  type ItemCastEconomyMatch,
} from './assert-item-spell-cast';

describe('assertItemCastEconomyAllows', () => {
  const wandRow: ItemCastEconomyMatch = {
    actionId: 'item-varinha-de-misseis-magicos-2',
    itemSlug: 'varinha-de-misseis-magicos',
    spellSlug: 'misseis-magicos',
    resourceSlug: 'varinhaMisseisCharges',
    spendAmount: 2,
  };

  const enspelledRow: ItemCastEconomyMatch = {
    actionId: 'item-arma-magificada-cast',
    itemSlug: 'arma-magificada',
    spellSlug: null,
    resourceSlug: 'armaMagificadaCharges',
    spendAmount: 1,
  };

  it('matches fixed spell_slug economy row', () => {
    expect(
      assertItemCastEconomyAllows({
        matches: [wandRow],
        spellSlug: 'misseis-magicos',
        resourceSlug: 'varinhaMisseisCharges',
        spendAmount: 2,
        boundSpellSlug: null,
      }),
    ).toEqual(wandRow);
  });

  it('matches arma-magificada bound spell', () => {
    expect(
      assertItemCastEconomyAllows({
        matches: [enspelledRow],
        spellSlug: 'bola-de-fogo',
        resourceSlug: 'armaMagificadaCharges',
        spendAmount: 1,
        boundSpellSlug: 'bola-de-fogo',
      }),
    ).toEqual(enspelledRow);
  });

  it('matches armadura-magificada bound spell', () => {
    const armorRow: ItemCastEconomyMatch = {
      actionId: 'item-armadura-magificada-cast',
      itemSlug: 'armadura-magificada',
      spellSlug: null,
      resourceSlug: 'armaduraMagificadaCharges',
      spendAmount: 1,
    };
    expect(
      assertItemCastEconomyAllows({
        matches: [armorRow],
        spellSlug: 'escudo',
        resourceSlug: 'armaduraMagificadaCharges',
        spendAmount: 1,
        boundSpellSlug: 'escudo',
      }),
    ).toEqual(armorRow);
  });

  it('rejects when no row matches', () => {
    expect(() =>
      assertItemCastEconomyAllows({
        matches: [wandRow],
        spellSlug: 'bola-de-fogo',
        resourceSlug: 'varinhaMisseisCharges',
        spendAmount: 2,
        boundSpellSlug: null,
      }),
    ).toThrow(/not allowed/);
  });
});
