import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import type { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import type { PhbItem } from '../../../../entities/phb-item.entity';
import type { PlayerCharacterItem } from '../player-character-item.entity';
import {
  applyInventoryAttunement,
  clearEquippedSlotIfOccupied,
  findInventoryItemOrFail,
  inventoryItemToDto,
} from './inventory-item-ops';

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

describe('inventory-item-ops', () => {
  let items: { findOne: jest.Mock; save: jest.Mock; count: jest.Mock };
  let catalogItems: { find: jest.Mock; findOne: jest.Mock };
  let catalogLookup: { assertItemInCatalog: jest.Mock };

  beforeEach(() => {
    items = {
      findOne: jest.fn(),
      save: jest.fn(async (row) => row),
      count: jest.fn().mockResolvedValue(0),
    };
    const ropeCatalog = {
      slug: 'rope',
      name: 'Corda',
      itemType: 'gear',
      weight: '5 kg',
      properties: null,
    };
    catalogItems = {
      find: jest.fn().mockResolvedValue([ropeCatalog]),
      findOne: jest.fn().mockResolvedValue(ropeCatalog),
    };
    catalogLookup = {
      assertItemInCatalog: jest.fn().mockResolvedValue({
        slug: 'rope',
        properties: { requiresAttunement: true },
      }),
    };
  });

  describe('findInventoryItemOrFail', () => {
    it('returns row when found', async () => {
      const row = itemRow();
      items.findOne.mockResolvedValue(row);
      await expect(findInventoryItemOrFail(items as unknown as Repository<PlayerCharacterItem>, 'ch1', 'rope')).resolves.toBe(row);
    });

    it('throws NotFoundException when missing', async () => {
      items.findOne.mockResolvedValue(null);
      await expect(
        findInventoryItemOrFail(items as unknown as Repository<PlayerCharacterItem>, 'ch1', 'missing'),
      ).rejects.toBeInstanceOf(NotFoundException);
    });
  });

  describe('clearEquippedSlotIfOccupied', () => {
    it('moves occupant to backpack when slot is taken by another item', async () => {
      const occupant = itemRow({ itemSlug: 'shield', location: 'equipped', equipmentSlot: 'off_hand' });
      items.findOne.mockResolvedValue(occupant);
      await clearEquippedSlotIfOccupied(
        items as unknown as Repository<PlayerCharacterItem>,
        'ch1',
        'off_hand',
        'sword',
      );
      expect(occupant.location).toBe('backpack');
      expect(occupant.equipmentSlot).toBeNull();
      expect(items.save).toHaveBeenCalledWith(occupant);
    });

    it('does nothing when occupant is the same item', async () => {
      const occupant = itemRow({ location: 'equipped', equipmentSlot: 'main_hand' });
      items.findOne.mockResolvedValue(occupant);
      await clearEquippedSlotIfOccupied(
        items as unknown as Repository<PlayerCharacterItem>,
        'ch1',
        'main_hand',
        'rope',
      );
      expect(items.save).not.toHaveBeenCalled();
    });

    it('does nothing for non-exclusive worn/carried slots', async () => {
      await clearEquippedSlotIfOccupied(
        items as unknown as Repository<PlayerCharacterItem>,
        'ch1',
        'worn',
        'ring-a',
      );
      await clearEquippedSlotIfOccupied(
        items as unknown as Repository<PlayerCharacterItem>,
        'ch1',
        'carried',
        'trinket',
      );
      expect(items.findOne).not.toHaveBeenCalled();
      expect(items.save).not.toHaveBeenCalled();
    });
  });

  describe('applyInventoryAttunement', () => {
    it('no-ops when attuned state is unchanged', async () => {
      const row = itemRow({ attuned: true });
      await applyInventoryAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        row,
        attuned: true,
      });
      expect(catalogLookup.assertItemInCatalog).not.toHaveBeenCalled();
    });

    it('clears attunement when attuned is false', async () => {
      const row = itemRow({ attuned: true });
      await applyInventoryAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        row,
        attuned: false,
      });
      expect(row.attuned).toBe(false);
    });

    it('attunes when item requires attunement and limit not reached', async () => {
      const row = itemRow({ attuned: false });
      await applyInventoryAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        row,
        attuned: true,
      });
      expect(row.attuned).toBe(true);
    });

    it('rejects attunement when item does not require it', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({ slug: 'rope', properties: null });
      const row = itemRow({ attuned: false });
      await expect(
        applyInventoryAttunement({
          items: items as unknown as Repository<PlayerCharacterItem>,
          catalogLookup: catalogLookup as unknown as CatalogLookupService,
          characterId: 'ch1',
          row,
          attuned: true,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });

    it('rejects attunement when max attuned items reached', async () => {
      items.count.mockResolvedValue(3);
      const row = itemRow({ attuned: false });
      await expect(
        applyInventoryAttunement({
          items: items as unknown as Repository<PlayerCharacterItem>,
          catalogLookup: catalogLookup as unknown as CatalogLookupService,
          characterId: 'ch1',
          row,
          attuned: true,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });
  });

  describe('inventoryItemToDto', () => {
    it('maps catalog fields to dto', async () => {
      const dto = await inventoryItemToDto(
        catalogItems as unknown as Repository<PhbItem>,
        itemRow({ quantity: 2, attuned: true }),
      );
      expect(dto).toMatchObject({
        itemSlug: 'rope',
        itemName: 'Corda',
        itemType: 'gear',
        quantity: 2,
        weightKg: 5,
        attuned: true,
        effectsActive: false,
        effectsStatus: 'inactive_unequipped',
      });
    });

    it('marks effects active when equipped without attunement', async () => {
      const dto = await inventoryItemToDto(
        catalogItems as unknown as Repository<PhbItem>,
        itemRow({ location: 'equipped', equipmentSlot: 'carried', attuned: false }),
      );
      expect(dto.effectsActive).toBe(true);
      expect(dto.effectsStatus).toBe('active');
    });

    it('falls back when catalog row is missing', async () => {
      catalogItems.find.mockResolvedValue([]);
      const dto = await inventoryItemToDto(
        catalogItems as unknown as Repository<PhbItem>,
        itemRow({ itemSlug: 'unknown-item' }),
      );
      expect(dto.itemName).toBe('unknown-item');
      expect(dto.itemType).toBe('unknown');
      expect(dto.weightKg).toBe(0);
    });
  });
});
