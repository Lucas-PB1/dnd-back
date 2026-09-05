import { asDep } from '@common/testing/as-dep';
import { purseToCopper } from '../../domain/coin-purse';
import { resolvePurchaseLines } from './resolve-purchase-lines';

describe('resolvePurchaseLines purchase discount', () => {
  it('discounts each non-magic priced line only', async () => {
    const catalogLookup = {
      assertItemInCatalog: jest.fn(async (slug: string) => ({
        slug,
        cost: { text: '1 PO' },
        properties: { magic: slug === 'magic-item' },
      })),
    };

    const result = await resolvePurchaseLines(
      asDep(catalogLookup),
      {
        lines: [
          { itemSlug: 'artisan-tool', quantity: 1 },
          { itemSlug: 'magic-item', quantity: 1 },
        ],
      },
      { percentOff: 20, nonMagicOnly: true },
    );

    expect(purseToCopper(result.totalCost)).toBe(180);
  });

  it('applies Brewer food_drink filter including potions', async () => {
    const catalogLookup = {
      assertItemInCatalog: jest.fn(async (slug: string) => ({
        slug,
        cost: { text: '100 PO' },
        properties:
          slug === 'pocao-de-cura'
            ? { magic: true }
            : slug === 'pao'
              ? { kind: 'service', foodDrink: true }
              : { magic: false },
      })),
    };

    const result = await resolvePurchaseLines(
      asDep(catalogLookup),
      {
        lines: [
          { itemSlug: 'pao', quantity: 1 },
          { itemSlug: 'pocao-de-cura', quantity: 1 },
          { itemSlug: 'espada', quantity: 1 },
        ],
      },
      { percentOff: 50, nonMagicOnly: false, foodDrinkOnly: true },
    );

    // 50 + 50 + 100 = 200 PO → 20000 PC
    expect(purseToCopper(result.totalCost)).toBe(20000);
  });
});
