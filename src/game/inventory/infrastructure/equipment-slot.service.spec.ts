import { BadRequestException } from '@nestjs/common';
import { EquipmentSlotService } from './equipment-slot.service';
import { asDep } from '@common/testing/as-dep';

describe('EquipmentSlotService', () => {
  let catalogItems: { findOne: jest.Mock };
  let armorCatalog: { findOne: jest.Mock };
  let inventoryItems: { findOne: jest.Mock };
  let slots: EquipmentSlotService;

  beforeEach(() => {
    catalogItems = { findOne: jest.fn() };
    armorCatalog = { findOne: jest.fn() };
    inventoryItems = { findOne: jest.fn() };
    slots = new EquipmentSlotService(
      asDep(catalogItems),
      asDep(armorCatalog),
      asDep(inventoryItems),
    );
  });

  it('returns provided slot immediately', async () => {
    await expect(slots.resolve('c1', 'x', 'off_hand')).resolves.toBe('off_hand');
    expect(armorCatalog.findOne).not.toHaveBeenCalled();
  });

  it('maps armor and shield from armor catalog', async () => {
    armorCatalog.findOne.mockResolvedValueOnce({ categorySlug: 'light' });
    await expect(slots.resolve('c1', 'leather')).resolves.toBe('armor');
    armorCatalog.findOne.mockResolvedValueOnce({ categorySlug: 'shield' });
    await expect(slots.resolve('c1', 'shield')).resolves.toBe('shield');
  });

  it('puts first weapon in main_hand and second in off_hand', async () => {
    armorCatalog.findOne.mockResolvedValue(null);
    catalogItems.findOne.mockResolvedValue({ itemType: 'weapon' });
    inventoryItems.findOne.mockResolvedValueOnce(null);
    await expect(slots.resolve('c1', 'dagger')).resolves.toBe('main_hand');
    inventoryItems.findOne.mockResolvedValueOnce({ itemSlug: 'longsword' });
    await expect(slots.resolve('c1', 'dagger')).resolves.toBe('off_hand');
    inventoryItems.findOne.mockResolvedValueOnce({ itemSlug: 'dagger' });
    await expect(slots.resolve('c1', 'dagger')).resolves.toBe('main_hand');
  });

  it('maps other/magic ring to worn and other magic to carried', async () => {
    armorCatalog.findOne.mockResolvedValue(null);
    catalogItems.findOne.mockResolvedValueOnce({
      itemType: 'other',
      properties: { magic: true, category: 'Anel' },
    });
    await expect(slots.resolve('c1', 'ring-of-barrels')).resolves.toBe('worn');

    catalogItems.findOne.mockResolvedValueOnce({
      itemType: 'other',
      properties: { magic: true, category: 'Maravilhoso' },
    });
    await expect(slots.resolve('c1', 'memento-mori')).resolves.toBe('carried');
  });

  it('requires slot for non-armor non-weapon non-magic items', async () => {
    armorCatalog.findOne.mockResolvedValue(null);
    catalogItems.findOne.mockResolvedValue({ itemType: 'gear' });
    await expect(slots.resolve('c1', 'rope')).rejects.toThrow(BadRequestException);
  });
});
