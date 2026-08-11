import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import type { CatalogLookupService } from '@catalog/catalog-lookup.service';
import type { PhbItem } from '@entities/phb-item.entity';
import type { PlayerCharacterItem } from '../player-character-item.entity';
import {
  applyInventoryAttunement,
  applyAttachedCoverageAttunement,
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
        character: { classSlug: 'wizard', speciesSlug: null },
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
        character: { classSlug: 'wizard', speciesSlug: null },
        row,
        attuned: false,
      });
      expect(row.attuned).toBe(false);
      expect(catalogLookup.assertItemInCatalog).toHaveBeenCalled();
    });

    it('rejects ending attunement on cursed item without curseBroken', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'espada-da-vinganca',
        properties: { requiresAttunement: true, cursed: true },
      });
      const row = itemRow({
        itemSlug: 'espada-da-vinganca',
        attuned: true,
        instanceProperties: null,
      });
      await expect(
        applyInventoryAttunement({
          items: items as unknown as Repository<PlayerCharacterItem>,
          catalogLookup: catalogLookup as unknown as CatalogLookupService,
          characterId: 'ch1',
          character: { classSlug: 'wizard', speciesSlug: null },
          row,
          attuned: false,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
      expect(row.attuned).toBe(true);
    });

    it('allows ending attunement when curseBroken is set', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'espada-da-vinganca',
        properties: { requiresAttunement: true, cursed: true },
      });
      const row = itemRow({
        itemSlug: 'espada-da-vinganca',
        attuned: true,
        instanceProperties: { curseBroken: true },
      });
      await applyInventoryAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        character: { classSlug: 'wizard', speciesSlug: null },
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
        character: { classSlug: 'wizard', speciesSlug: null },
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
          character: { classSlug: 'wizard', speciesSlug: null },
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
          character: { classSlug: 'wizard', speciesSlug: null },
          row,
          attuned: true,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });
    it('rejects attunement when class does not match', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'cajado-da-cura',
        properties: {
          requiresAttunement: true,
          attunement: 'Requer Sintonização por um Bardo, Clérigo ou Druida',
        },
      });
      const row = itemRow({ itemSlug: 'cajado-da-cura', attuned: false });
      await expect(
        applyInventoryAttunement({
          items: items as unknown as Repository<PlayerCharacterItem>,
          catalogLookup: catalogLookup as unknown as CatalogLookupService,
          characterId: 'ch1',
          character: { classSlug: 'fighter', speciesSlug: null },
          row,
          attuned: true,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });

    it('rolls artifact instance properties on first attunement', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'varinha-de-orcus',
        properties: {
          requiresAttunement: true,
          artifactRandomQuota: {
            minorBeneficial: 1,
            majorBeneficial: 0,
            minorDetrimental: 0,
            majorDetrimental: 0,
          },
          sentience: { alignment: 'CM', inteligencia: 16 },
        },
      });
      const row = itemRow({
        itemSlug: 'varinha-de-orcus',
        attuned: false,
        instanceProperties: null,
      });
      await applyInventoryAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        character: { classSlug: 'wizard', speciesSlug: null },
        row,
        attuned: true,
        artifactRoll: {
          loadArtifactRandomRows: async () => [
            {
              kind: 'minor_beneficial',
              rollMin: 1,
              rollMax: 100,
              slug: 'ac-bonus-1',
              summaryPt: '+1 CA',
              effect: {
                type: 'permanentEffects',
                permanentEffects: { acBonus: 1 },
              },
            },
          ],
          rng: () => 0.5,
          nowIso: () => '2026-08-11T12:00:00.000Z',
        },
      });
      expect(row.attuned).toBe(true);
      expect(row.instanceProperties).toMatchObject({
        sentience: { alignment: 'CM', inteligencia: 16 },
        artifactRandom: {
          rolledAt: '2026-08-11T12:00:00.000Z',
          minorBeneficial: [expect.objectContaining({ slug: 'ac-bonus-1' })],
        },
      });
    });

    it('does not re-roll artifact properties on re-attunement', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'varinha-de-orcus',
        properties: {
          requiresAttunement: true,
          artifactRandomQuota: {
            minorBeneficial: 1,
            majorBeneficial: 0,
            minorDetrimental: 0,
            majorDetrimental: 0,
          },
          sentience: { alignment: 'CM' },
        },
      });
      const existing = {
        artifactRandom: {
          rolledAt: '2026-01-01T00:00:00.000Z',
          minorBeneficial: [{ slug: 'kept', summaryPt: 'kept', roll: 1, effect: { type: 'reminder', text: 'kept' } }],
          majorBeneficial: [],
          minorDetrimental: [],
          majorDetrimental: [],
        },
        sentience: { alignment: 'CM' },
      };
      const row = itemRow({
        itemSlug: 'varinha-de-orcus',
        attuned: false,
        instanceProperties: existing,
      });
      await applyInventoryAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        character: { classSlug: 'wizard', speciesSlug: null },
        row,
        attuned: true,
        artifactRoll: {
          loadArtifactRandomRows: async () => {
            throw new Error('should not load');
          },
        },
      });
      expect(row.instanceProperties).toBe(existing);
    });
  });

  describe('applyAttachedCoverageAttunement', () => {
    it('attunes attached coverage when it requires attunement', async () => {
      catalogLookup.assertItemInCatalog.mockResolvedValue({
        slug: 'espada-vorpal',
        properties: { requiresAttunement: true, kind: 'coverage' },
      });
      const row = itemRow({
        itemSlug: 'longsword',
        attachedCoverageSlug: 'espada-vorpal',
        attachedCoverageAttuned: false,
      });
      await applyAttachedCoverageAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        character: { classSlug: 'wizard', speciesSlug: null },
        row,
        attuned: true,
      });
      expect(row.attachedCoverageAttuned).toBe(true);
    });

    it('rejects when no coverage is attached', async () => {
      const row = itemRow({ attachedCoverageSlug: null });
      await expect(
        applyAttachedCoverageAttunement({
          items: items as unknown as Repository<PlayerCharacterItem>,
          catalogLookup: catalogLookup as unknown as CatalogLookupService,
          characterId: 'ch1',
          character: { classSlug: 'wizard', speciesSlug: null },
          row,
          attuned: true,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });

    it('clears coverage attunement', async () => {
      const row = itemRow({
        attachedCoverageSlug: 'espada-vorpal',
        attachedCoverageAttuned: true,
      });
      await applyAttachedCoverageAttunement({
        items: items as unknown as Repository<PlayerCharacterItem>,
        catalogLookup: catalogLookup as unknown as CatalogLookupService,
        characterId: 'ch1',
        character: { classSlug: 'wizard', speciesSlug: null },
        row,
        attuned: false,
      });
      expect(row.attachedCoverageAttuned).toBe(false);
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
        consumable: false,
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
