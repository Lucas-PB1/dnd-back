import { PatchInventoryItemHandler } from './patch-inventory-item.handler';

describe('PatchInventoryItemHandler', () => {
  let access: { findAccessibleOrFail: jest.Mock };
  let campaignAccess: { resolveInventoryPaymentContext: jest.Mock };
  let catalogLookup: { assertItemInCatalog: jest.Mock };
  let inventory: {
    patch: jest.Mock;
    peekItemQuantity: jest.Mock;
    patchQuantityWithCoins: jest.Mock;
  };
  let assertCanEquip: { assert: jest.Mock };
  let assertCanBindPact: { assert: jest.Mock };
  let catalogStats: { recordPurchase: jest.Mock };
  let handler: PatchInventoryItemHandler;

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue({
        abilityScores: { forca: 12 },
        classSlug: 'fighter',
        speciesSlug: 'human',
        coinCopper: 0,
        coinSilver: 0,
        coinElectrum: 0,
        coinGold: 100,
        coinPlatinum: 0,
      }),
    };
    campaignAccess = {
      resolveInventoryPaymentContext: jest.fn().mockResolvedValue({
        inCampaign: false,
        viewerIsDmOrAssistant: false,
        allowPlayerSkipPayment: false,
      }),
    };
    catalogLookup = { assertItemInCatalog: jest.fn() };
    inventory = {
      patch: jest.fn().mockResolvedValue({ itemSlug: 'dagger' }),
      peekItemQuantity: jest.fn().mockResolvedValue(1),
      patchQuantityWithCoins: jest.fn(),
    };
    assertCanEquip = { assert: jest.fn().mockResolvedValue(undefined) };
    assertCanBindPact = { assert: jest.fn().mockResolvedValue(undefined) };
    catalogStats = { recordPurchase: jest.fn() };
    handler = new PatchInventoryItemHandler(
      access as never,
      campaignAccess as never,
      catalogLookup as never,
      inventory as never,
      assertCanEquip as never,
      assertCanBindPact as never,
      catalogStats as never,
    );
  });

  it('asserts equip when location is equipped', async () => {
    await handler.execute('u1', 'c1', 'dagger', { location: 'equipped' });
    expect(assertCanEquip.assert).toHaveBeenCalled();
    expect(inventory.patch).toHaveBeenCalledWith(
      'c1',
      'dagger',
      { location: 'equipped' },
      12,
      { classSlug: 'fighter', speciesSlug: 'human' },
    );
  });

  it('skips assert when moving to backpack', async () => {
    await handler.execute('u1', 'c1', 'dagger', { location: 'backpack' });
    expect(assertCanEquip.assert).not.toHaveBeenCalled();
  });

  it('asserts equip when only equipmentSlot is set', async () => {
    await handler.execute('u1', 'c1', 'dagger', { equipmentSlot: 'main_hand' });
    expect(assertCanEquip.assert).toHaveBeenCalled();
  });

  it('defaults strength to 10 when missing', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      classSlug: 'wizard',
      speciesSlug: null,
    });
    await handler.execute('u1', 'c1', 'dagger', { location: 'backpack' });
    expect(inventory.patch).toHaveBeenCalledWith(
      'c1',
      'dagger',
      { location: 'backpack' },
      10,
      { classSlug: 'wizard', speciesSlug: null },
    );
  });
});
