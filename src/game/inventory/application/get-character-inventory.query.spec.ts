import { GetCharacterInventoryQuery } from './get-character-inventory.query';

describe('GetCharacterInventoryQuery', () => {
  let access: { findAccessibleOrFail: jest.Mock };
  let inventory: { list: jest.Mock };
  let seedStartingInventory: { execute: jest.Mock };
  let equipment: { find: jest.Mock };
  let query: GetCharacterInventoryQuery;

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue({
        abilityScores: { forca: 14 },
      }),
    };
    inventory = { list: jest.fn() };
    seedStartingInventory = { execute: jest.fn() };
    equipment = { find: jest.fn() };
    query = new GetCharacterInventoryQuery(
      access as never,
      inventory as never,
      seedStartingInventory as never,
      equipment as never,
    );
  });

  it('returns inventory when items already exist', async () => {
    const listed = { items: [{ itemSlug: 'dagger' }], capacity: {} };
    inventory.list.mockResolvedValue(listed);

    await expect(query.execute('u1', 'c1')).resolves.toBe(listed);
    expect(equipment.find).not.toHaveBeenCalled();
    expect(seedStartingInventory.execute).not.toHaveBeenCalled();
    expect(inventory.list).toHaveBeenCalledWith('c1', 14);
  });

  it('returns empty list when no items and no sheet equipment', async () => {
    const empty = { items: [], capacity: {} };
    inventory.list.mockResolvedValue(empty);
    equipment.find.mockResolvedValue([]);

    await expect(query.execute('u1', 'c1')).resolves.toBe(empty);
    expect(seedStartingInventory.execute).not.toHaveBeenCalled();
  });

  it('seeds from sheet equipment then relists', async () => {
    const empty = { items: [], capacity: {} };
    const seeded = { items: [{ itemSlug: 'pack' }], capacity: {} };
    inventory.list
      .mockResolvedValueOnce(empty)
      .mockResolvedValueOnce(seeded);
    equipment.find.mockResolvedValue([
      { itemSlug: 'pack', quantity: 1 },
      { itemSlug: null, quantity: 2 },
    ]);
    seedStartingInventory.execute.mockResolvedValue(undefined);

    await expect(query.execute('u1', 'c1')).resolves.toBe(seeded);
    expect(seedStartingInventory.execute).toHaveBeenCalledWith('c1', [
      { itemSlug: 'pack', quantity: 1 },
      { itemSlug: undefined, quantity: 2 },
    ]);
  });

  it('defaults strength to 10 when ability scores missing', async () => {
    access.findAccessibleOrFail.mockResolvedValue({});
    inventory.list.mockResolvedValue({ items: [{ itemSlug: 'x' }] });
    await query.execute('u1', 'c1');
    expect(inventory.list).toHaveBeenCalledWith('c1', 10);
  });
});
