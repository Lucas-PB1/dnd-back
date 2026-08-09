import { PatchInventoryItemHandler } from './patch-inventory-item.handler';

describe('PatchInventoryItemHandler', () => {
  let access: { findAccessibleOrFail: jest.Mock };
  let inventory: { patch: jest.Mock };
  let assertCanEquip: { assert: jest.Mock };
  let assertCanBindPact: { assert: jest.Mock };
  let handler: PatchInventoryItemHandler;

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue({
        abilityScores: { forca: 12 },
      }),
    };
    inventory = { patch: jest.fn().mockResolvedValue({ itemSlug: 'dagger' }) };
    assertCanEquip = { assert: jest.fn().mockResolvedValue(undefined) };
    assertCanBindPact = { assert: jest.fn().mockResolvedValue(undefined) };
    handler = new PatchInventoryItemHandler(
      access as never,
      inventory as never,
      assertCanEquip as never,
      assertCanBindPact as never,
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
    access.findAccessibleOrFail.mockResolvedValue({});
    await handler.execute('u1', 'c1', 'dagger', { location: 'backpack' });
    expect(inventory.patch).toHaveBeenCalledWith(
      'c1',
      'dagger',
      { location: 'backpack' },
      10,
    );
  });
});
