import { applyPurchaseDiscount, copperToPurse } from '../../domain/coin-purse';

describe('applyPurchaseDiscount', () => {
  it('applies 20% off flooring copper', () => {
    const purse = copperToPurse(9);
    expect(applyPurchaseDiscount(purse, 20)).toEqual(copperToPurse(7));
  });
});
