import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { PhbItem } from '../../../../entities/phb-item.entity';
import {
  EquipmentSlot,
  PlayerCharacterItem,
} from '../player-character-item.entity';
import { InventoryItemResponseDto } from '../../dto/inventory.dto';
import {
  itemRequiresAttunement,
  MAX_ATTUNED_ITEMS,
} from '../../domain/attunement';
import { parseItemWeightKg } from '../../domain/encumbrance';

export async function findInventoryItemOrFail(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
  itemSlug: string,
): Promise<PlayerCharacterItem> {
  const row = await items.findOne({ where: { characterId, itemSlug } });
  if (!row) {
    throw new NotFoundException(
      `Inventory item '${itemSlug}' not found on this character`,
    );
  }
  return row;
}

export async function clearEquippedSlotIfOccupied(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
  slot: EquipmentSlot,
  exceptItemSlug: string,
): Promise<void> {
  const occupant = await items.findOne({
    where: { characterId, location: 'equipped', equipmentSlot: slot },
  });
  if (occupant && occupant.itemSlug !== exceptItemSlug) {
    occupant.location = 'backpack';
    occupant.equipmentSlot = null;
    await items.save(occupant);
  }
}

export async function applyInventoryAttunement(input: {
  items: Repository<PlayerCharacterItem>;
  catalogLookup: CatalogLookupService;
  characterId: string;
  row: PlayerCharacterItem;
  attuned: boolean;
}): Promise<void> {
  const { items, catalogLookup, characterId, row, attuned } = input;
  if (row.attuned === attuned) return;

  if (!attuned) {
    row.attuned = false;
    return;
  }

  const catalog = await catalogLookup.assertItemInCatalog(row.itemSlug);
  if (!itemRequiresAttunement(catalog.properties)) {
    throw new BadRequestException(
      `Item '${row.itemSlug}' does not require attunement`,
    );
  }

  const attunedCount = await items.count({
    where: { characterId, attuned: true },
  });
  if (attunedCount >= MAX_ATTUNED_ITEMS) {
    throw new BadRequestException(
      `Maximum of ${MAX_ATTUNED_ITEMS} attuned items reached`,
    );
  }

  row.attuned = true;
}

export async function inventoryItemToDto(
  catalogItems: Repository<PhbItem>,
  row: PlayerCharacterItem,
): Promise<InventoryItemResponseDto> {
  const catalog = await catalogItems.findOne({ where: { slug: row.itemSlug } });
  return {
    itemSlug: row.itemSlug,
    itemName: catalog?.name ?? row.itemSlug,
    itemType: catalog?.itemType ?? 'unknown',
    quantity: row.quantity,
    location: row.location,
    equipmentSlot: row.equipmentSlot,
    attuned: row.attuned,
    requiresAttunement: itemRequiresAttunement(catalog?.properties),
    weightKg: parseItemWeightKg(catalog?.weight),
  };
}
