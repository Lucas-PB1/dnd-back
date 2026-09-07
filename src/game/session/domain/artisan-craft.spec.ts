import {
  isArtisanQuickCraftItem,
  readArtisanCraftedQty,
  toolSlugForCraftItem,
  withArtisanCraftedQty,
} from './artisan-craft';
import { dissolveArtisanCraftedItems } from './dissolve-artisan-crafted';
import {
  normalizeMesaCircumstances,
  toggleMesaCircumstance,
} from './mesa-circumstances';

describe('artisan-craft', () => {
  it('maps tool ↔ item da tabela Fabricação Rápida', () => {
    expect(toolSlugForCraftItem('escada')).toBe('ferramentas-de-carpinteiro');
    expect(isArtisanQuickCraftItem('corda')).toBe(true);
    expect(isArtisanQuickCraftItem('espada-longa')).toBe(false);
  });

  it('tracks artisanCraftedQty em instanceProperties', () => {
    expect(readArtisanCraftedQty(null)).toBe(0);
    expect(withArtisanCraftedQty(null, 2)).toEqual({ artisanCraftedQty: 2 });
    expect(withArtisanCraftedQty({ artisanCraftedQty: 2 }, 0)).toBeNull();
  });
});

describe('dissolveArtisanCraftedItems', () => {
  it('remove só a quantidade fabricada', () => {
    const { keep, removedNotes } = dissolveArtisanCraftedItems([
      {
        itemSlug: 'corda',
        quantity: 3,
        instanceProperties: { artisanCraftedQty: 1 },
      },
      {
        itemSlug: 'tocha',
        quantity: 1,
        instanceProperties: { artisanCraftedQty: 1 },
      },
    ]);
    expect(removedNotes).toHaveLength(2);
    expect(keep).toEqual([
      { itemSlug: 'corda', quantity: 2, instanceProperties: null },
    ]);
  });
});

describe('mesa-circumstances', () => {
  it('normaliza e faz toggle', () => {
    expect(normalizeMesaCircumstances(['snow_ice', 'nope'])).toEqual([
      'snow_ice',
    ]);
    expect(toggleMesaCircumstance([], 'in_water')).toEqual(['in_water']);
    expect(toggleMesaCircumstance(['in_water'], 'in_water')).toEqual([]);
    expect(toggleMesaCircumstance(['in_water'], 'in_water', true)).toEqual([
      'in_water',
    ]);
  });
});
