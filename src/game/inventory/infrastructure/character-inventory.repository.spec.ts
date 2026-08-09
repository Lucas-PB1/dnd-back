import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import type { CatalogLookupService } from '@catalog/catalog-lookup.service';
import type { PhbItem } from '@entities/phb-item.entity';
import { CharacterInventoryRepository } from './character-inventory.repository';
import type { EquipmentSlotResolver } from './equipment-slot-resolver';
import type { PlayerCharacterItem } from './player-character-item.entity';

function itemRow(overrides: Partial<PlayerCharacterItem> = {}): PlayerCharacterItem {
  return {
    characterId: 'ch1',
    itemSlug: 'rope',
    quantity: 1,
    location: 'backpack',
    equipmentSlot: null,
    attuned: false,
    ...overrides,
  } as PlayerCharacterItem;
}

describe('CharacterInventoryRepository', () => {
  let items: {
    find: jest.Mock;
    findOne: jest.Mock;
    create: jest.Mock;
    save: jest.Mock;
    remove: jest.Mock;
    count: jest.Mock;
  };
  let catalogItems: { findOne: jest.Mock };
  let catalogLookup: { assertItemInCatalog: jest.Mock };
  let slotResolver: { resolve: jest.Mock };
  let repository: CharacterInventoryRepository;

  beforeEach(() => {
    items = {
      find: jest.fn(),
      findOne: jest.fn(),
      create: jest.fn((row) => row),
      save: jest.fn(async (row) => row),
      remove: jest.fn(),
      count: jest.fn().mockResolvedValue(0),
    };
    catalogItems = {
      findOne: jest.fn().mockResolvedValue({
        slug: 'rope',
        name: 'Corda',
        itemType: 'gear',
        weight: '5 lb.',
        properties: null,
      }),
    };
    catalogLookup = {
      assertItemInCatalog: jest.fn().mockResolvedValue({
        slug: 'rope',
        name: 'Corda',
        weight: '5 lb.',
        properties: null,
      }),
    };
    slotResolver = { resolve: jest.fn().mockResolvedValue('main_hand') };
    repository = new CharacterInventoryRepository(
      items as unknown as Repository<PlayerCharacterItem>,
      catalogItems as unknown as Repository<PhbItem>,
      catalogLookup as unknown as CatalogLookupService,
      slotResolver as unknown as EquipmentSlotResolver,
    );
  });

  describe('list', () => {
    it('returns items and encumbrance summary', async () => {
      items.find.mockResolvedValue([itemRow({ quantity: 2 })]);
      const result = await repository.list('ch1', 16);
      expect(result.items).toHaveLength(1);
      expect(result.items[0].itemSlug).toBe('rope');
      expect(result.encumbrance).toMatchObject({ carryingCapacityKg: 120, encumbered: false });
    });
  });

  describe('add', () => {
    beforeEach(() => {
      items.find.mockResolvedValue([]);
    });

    it('creates a new backpack row', async () => {
      items.findOne.mockResolvedValue(null);
      const dto = await repository.add('ch1', { itemSlug: 'rope' }, 16);
      expect(catalogLookup.assertItemInCatalog).toHaveBeenCalledWith('rope');
      expect(items.create).toHaveBeenCalledWith(
        expect.objectContaining({ location: 'backpack', quantity: 1 }),
      );
      expect(dto.itemSlug).toBe('rope');
    });

    it('increments quantity on existing backpack item', async () => {
      const existing = itemRow({ quantity: 1 });
      items.findOne.mockResolvedValue(existing);
      await repository.add('ch1', { itemSlug: 'rope', quantity: 2 }, 16);
      expect(existing.quantity).toBe(3);
      expect(items.save).toHaveBeenCalledWith(existing);
    });

    it('rejects add when item is equipped', async () => {
      items.findOne.mockResolvedValue(itemRow({ location: 'equipped', equipmentSlot: 'main_hand' }));
      await expect(repository.add('ch1', { itemSlug: 'rope' }, 16)).rejects.toBeInstanceOf(
        BadRequestException,
      );
    });
  });

  describe('ensureFromStartingEquipment', () => {
    it('seeds backpack rows for new slugs and aggregates quantity', async () => {
      items.findOne.mockResolvedValue(null);
      await repository.ensureFromStartingEquipment('ch1', [
        { itemSlug: ' rope ', quantity: 2 },
        { itemSlug: 'rope', quantity: 1 },
        { itemSlug: '  ' },
      ]);
      expect(catalogLookup.assertItemInCatalog).toHaveBeenCalledWith('rope');
      expect(items.create).toHaveBeenCalledWith(
        expect.objectContaining({ itemSlug: 'rope', quantity: 3, location: 'backpack' }),
      );
      expect(items.save).toHaveBeenCalledTimes(1);
    });

    it('skips slugs that already exist in inventory', async () => {
      items.findOne.mockResolvedValue(itemRow({ itemSlug: 'rope' }));
      await repository.ensureFromStartingEquipment('ch1', [{ itemSlug: 'rope' }]);
      expect(items.save).not.toHaveBeenCalled();
    });
  });

  describe('patch', () => {
    it('equips item in resolved slot', async () => {
      const row = itemRow();
      items.findOne
        .mockResolvedValueOnce(row)
        .mockResolvedValueOnce(null);
      const dto = await repository.patch(
        'ch1',
        'rope',
        { location: 'equipped', equipmentSlot: 'main_hand' },
        16,
      );
      expect(slotResolver.resolve).toHaveBeenCalledWith('ch1', 'rope', 'main_hand');
      expect(row.location).toBe('equipped');
      expect(row.equipmentSlot).toBe('main_hand');
      expect(dto.location).toBe('equipped');
    });

    it('moves equipped item back to backpack', async () => {
      const row = itemRow({ location: 'equipped', equipmentSlot: 'main_hand' });
      items.findOne.mockResolvedValue(row);
      await repository.patch('ch1', 'rope', { location: 'backpack' }, 16);
      expect(row.location).toBe('backpack');
      expect(row.equipmentSlot).toBeNull();
    });

    it('updates quantity without location change', async () => {
      const row = itemRow({ quantity: 2 });
      items.findOne.mockResolvedValue(row);
      await repository.patch('ch1', 'rope', { quantity: 1 }, 16);
      expect(row.quantity).toBe(1);
      expect(items.save).toHaveBeenCalledWith(row);
    });

    it('attunes item when catalog requires attunement', async () => {
      const row = itemRow({ attuned: false });
      items.findOne.mockResolvedValue(row);
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'rope',
        weight: '5 lb.',
        properties: { requiresAttunement: true },
      });
      await repository.patch('ch1', 'rope', { attuned: true }, 16);
      expect(row.attuned).toBe(true);
    });
  });

  describe('remove', () => {
    it('removes inventory row', async () => {
      const row = itemRow();
      items.findOne.mockResolvedValue(row);
      await repository.remove('ch1', 'rope');
      expect(items.remove).toHaveBeenCalledWith(row);
    });

    it('throws when item is missing', async () => {
      items.findOne.mockResolvedValue(null);
      await expect(repository.remove('ch1', 'missing')).rejects.toBeInstanceOf(
        NotFoundException,
      );
    });
  });
});
