import { PurchaseInventoryHandler } from './purchase-inventory.handler';

describe('PurchaseInventoryHandler', () => {
  const character = {
    abilityScores: { forca: 12 },
    coinCopper: 0,
    coinSilver: 0,
    coinElectrum: 0,
    coinGold: 100,
    coinPlatinum: 0,
    classSlug: 'fighter',
    speciesSlug: 'human',
  };

  let access: { findAccessibleOrFail: jest.Mock };
  let campaignAccess: { resolveInventoryPaymentContext: jest.Mock };
  let catalogLookup: { assertItemInCatalog: jest.Mock };
  let inventory: { debitWealth: jest.Mock };
  let getInventory: { execute: jest.Mock };
  let catalogStats: { recordPurchases: jest.Mock };
  let attachCoverage: { attach: jest.Mock };
  let dataSource: { transaction: jest.Mock };
  let catalogItems: object;
  let handler: PurchaseInventoryHandler;

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue(character),
    };
    campaignAccess = {
      resolveInventoryPaymentContext: jest.fn().mockResolvedValue({
        inCampaign: true,
        viewerIsDmOrAssistant: false,
        allowPlayerSkipPayment: false,
      }),
    };
    catalogLookup = {
      assertItemInCatalog: jest.fn().mockImplementation(async (slug: string) => {
        if (slug === 'estadia') {
          return {
            slug,
            cost: { text: '5 PO' },
            properties: { kind: 'service' },
          };
        }
        return {
          slug,
          cost: { text: '1 PO' },
          properties: {},
        };
      }),
    };
    inventory = { debitWealth: jest.fn().mockResolvedValue(undefined) };
    getInventory = {
      execute: jest.fn().mockResolvedValue({ items: [], wealth: {} }),
    };
    catalogStats = {
      recordPurchases: jest.fn().mockResolvedValue(undefined),
    };
    attachCoverage = { attach: jest.fn() };
    dataSource = { transaction: jest.fn() };
    catalogItems = {};
    handler = new PurchaseInventoryHandler(
      access as never,
      campaignAccess as never,
      catalogLookup as never,
      inventory as never,
      getInventory as never,
      catalogStats as never,
      attachCoverage as never,
      dataSource as never,
      catalogItems as never,
    );
  });

  it('rejects class-granted catalog items', async () => {
    catalogLookup.assertItemInCatalog.mockResolvedValue({
      slug: 'psychic-blade',
      cost: { text: '1 PO' },
      properties: { grantedBySubclass: 'soulknife' },
    });

    await expect(
      handler.execute('u1', 'c1', {
        lines: [{ itemSlug: 'psychic-blade', quantity: 1 }],
      }),
    ).rejects.toThrow(/cannot be purchased or stored/i);
    expect(inventory.debitWealth).not.toHaveBeenCalled();
  });

  it('rejects standalone coverage items', async () => {
    catalogLookup.assertItemInCatalog.mockResolvedValue({
      slug: 'armadura-de-vulnerabilidade',
      cost: { text: '4000 PO' },
      properties: {
        kind: 'coverage',
        appliesTo: 'armor',
        appliesFilter: 'Qualquer Leve, Média ou Pesada',
      },
    });

    await expect(
      handler.execute('u1', 'c1', {
        lines: [{ itemSlug: 'armadura-de-vulnerabilidade', quantity: 1 }],
      }),
    ).rejects.toThrow(/requires attachToBaseSlug/i);
  });

  it('debits service without inventoriing', async () => {
    await handler.execute('u1', 'c1', {
      lines: [{ itemSlug: 'estadia', quantity: 1 }],
    });
    expect(inventory.debitWealth).toHaveBeenCalled();
    expect(catalogStats.recordPurchases).toHaveBeenCalled();
    expect(getInventory.execute).toHaveBeenCalled();
  });
});
