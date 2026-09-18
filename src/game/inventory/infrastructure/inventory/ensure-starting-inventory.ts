import { BadRequestException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { Repository } from 'typeorm';
import { EquipmentSlotService } from '../equipment-slot.service';
import { PlayerCharacterItem } from '../player-character-item.entity';
import { clearEquippedSlotIfOccupied } from './inventory-item-ops';

export async function ensureFromStartingEquipment(
  items: Repository<PlayerCharacterItem>,
  catalogLookup: CatalogLookupService,
  slotResolver: EquipmentSlotService,
  characterId: string,
  equipment: Array<{ itemSlug?: string; quantity?: number }>,
): Promise<void> {
  const totals = new Map<string, number>();
  for (const row of equipment) {
    const slug = row.itemSlug?.trim();
    if (!slug) continue;
    const qty = Math.max(1, row.quantity ?? 1);
    totals.set(slug, (totals.get(slug) ?? 0) + qty);
  }

  const created: PlayerCharacterItem[] = [];

  for (const [itemSlug, quantity] of totals) {
    const existing = await items.findOne({
      where: { characterId, itemSlug },
    });
    if (existing) continue;

    await catalogLookup.assertItemInCatalog(itemSlug);
    const saved = await items.save(
      items.create({
        characterId,
        itemSlug,
        quantity,
        location: 'backpack',
        equipmentSlot: null,
        attuned: false,
        isPactWeapon: false,
        attachedCharmSlug: null,
      }),
    );
    created.push(saved);
  }

  for (const row of created) {
    try {
      const slot = await slotResolver.resolve(characterId, row.itemSlug);
      await clearEquippedSlotIfOccupied(
        items,
        characterId,
        slot,
        row.itemSlug,
      );
      row.location = 'equipped';
      row.equipmentSlot = slot;
      await items.save(row);
    } catch (error) {
      if (error instanceof BadRequestException) continue;
      throw error;
    }
  }
}
