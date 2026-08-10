import { GetCharacterInventoryQuery } from './get-character-inventory.query';

describe('GetCharacterInventoryQuery', () => {
  let access: { findAccessibleOrFail: jest.Mock };
  let campaignAccess: { resolveInventoryPaymentContext: jest.Mock };
  let inventory: { list: jest.Mock };
  let seedStartingInventory: { execute: jest.Mock };
  let equipment: { find: jest.Mock };
  let query: GetCharacterInventoryQuery;

  const character = {
    abilityScores: { forca: 14 },
    coinCopper: 1,
    coinSilver: 2,
    coinElectrum: 0,
    coinGold: 10,
    coinPlatinum: 0,
  };

  const paymentSolo = {
    inCampaign: false,
    viewerIsDmOrAssistant: false,
    allowPlayerSkipPayment: false,
  };

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue(character),
    };
    campaignAccess = {
      resolveInventoryPaymentContext: jest.fn().mockResolvedValue(paymentSolo),
    };
    inventory = { list: jest.fn() };
    seedStartingInventory = { execute: jest.fn() };
    equipment = { find: jest.fn() };
    query = new GetCharacterInventoryQuery(
      access as never,
      campaignAccess as never,
      inventory as never,
      seedStartingInventory as never,
      equipment as never,
    );
  });

  it('returns inventory when items already exist', async () => {
    const listed = { items: [{ itemSlug: 'dagger' }], encumbrance: {} };
    inventory.list.mockResolvedValue(listed);

    await expect(query.execute('u1', 'c1')).resolves.toEqual({
      ...listed,
      wealth: {
        copper: 1,
        silver: 2,
        electrum: 0,
        gold: 10,
        platinum: 0,
      },
      paymentContext: { ...paymentSolo, chargeApplies: false },
    });
    expect(equipment.find).not.toHaveBeenCalled();
    expect(seedStartingInventory.execute).not.toHaveBeenCalled();
    expect(inventory.list).toHaveBeenCalledWith('c1', 14);
  });

  it('returns empty list when no items and no sheet equipment', async () => {
    const empty = { items: [], encumbrance: {} };
    inventory.list.mockResolvedValue(empty);
    equipment.find.mockResolvedValue([]);

    const result = await query.execute('u1', 'c1');
    expect(result.items).toEqual([]);
    expect(seedStartingInventory.execute).not.toHaveBeenCalled();
  });

  it('seeds from sheet equipment then relists', async () => {
    const empty = { items: [], encumbrance: {} };
    const seeded = { items: [{ itemSlug: 'pack' }], encumbrance: {} };
    inventory.list
      .mockResolvedValueOnce(empty)
      .mockResolvedValueOnce(seeded);
    equipment.find.mockResolvedValue([
      { itemSlug: 'pack', quantity: 1 },
      { itemSlug: null, quantity: 2 },
    ]);
    seedStartingInventory.execute.mockResolvedValue(undefined);

    const result = await query.execute('u1', 'c1');
    expect(result.items).toEqual([{ itemSlug: 'pack' }]);
    expect(seedStartingInventory.execute).toHaveBeenCalledWith('c1', [
      { itemSlug: 'pack', quantity: 1 },
      { itemSlug: undefined, quantity: 2 },
    ]);
  });

  it('defaults strength to 10 when ability scores missing', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      coinCopper: 0,
      coinSilver: 0,
      coinElectrum: 0,
      coinGold: 0,
      coinPlatinum: 0,
    });
    inventory.list.mockResolvedValue({ items: [{ itemSlug: 'x' }], encumbrance: {} });
    await query.execute('u1', 'c1');
    expect(inventory.list).toHaveBeenCalledWith('c1', 10);
  });
});
