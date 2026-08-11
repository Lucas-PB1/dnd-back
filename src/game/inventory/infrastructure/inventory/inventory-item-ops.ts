import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import {
  EquipmentSlot,
  EXCLUSIVE_EQUIPMENT_SLOTS,
  PlayerCharacterItem,
} from '../player-character-item.entity';
import {
  assertEnspelledBoundSpell,
  getEnspelledProfile,
} from '@game/inventory/domain/coverage/enspelled-weapon';

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
  if (!EXCLUSIVE_EQUIPMENT_SLOTS.has(slot)) return;

  const occupant = await items.findOne({
    where: { characterId, location: 'equipped', equipmentSlot: slot },
  });
  if (occupant && occupant.itemSlug !== exceptItemSlug) {
    occupant.location = 'backpack';
    occupant.equipmentSlot = null;
    await items.save(occupant);
  }
}

export async function applyPactWeaponFlag(input: {
  items: Repository<PlayerCharacterItem>;
  characterId: string;
  row: PlayerCharacterItem;
  pactWeapon: boolean;
}): Promise<void> {
  const { items, characterId, row, pactWeapon } = input;
  if (!pactWeapon) {
    row.isPactWeapon = false;
    return;
  }

  const previous = await items.find({
    where: { characterId, isPactWeapon: true },
  });
  for (const other of previous) {
    if (other.itemSlug === row.itemSlug) continue;
    other.isPactWeapon = false;
    await items.save(other);
  }
  row.isPactWeapon = true;
}

export async function applyBoundSpellSlug(input: {
  catalogLookup: CatalogLookupService;
  row: PlayerCharacterItem;
  boundSpellSlug: string | null;
}): Promise<void> {
  const { catalogLookup, row, boundSpellSlug } = input;
  if ((row.boundSpellSlug ?? null) === boundSpellSlug) return;

  if (boundSpellSlug == null) {
    row.boundSpellSlug = null;
    return;
  }

  const profile = getEnspelledProfile(row.itemSlug);
  if (!profile || profile.kind !== 'unique') {
    throw new BadRequestException(
      `Item '${row.itemSlug}' does not accept a bound spell`,
    );
  }

  const spell = await catalogLookup.findSpellOrFail(boundSpellSlug);
  try {
    assertEnspelledBoundSpell({
      itemSlug: row.itemSlug,
      spellSlug: spell.slug,
      spellLevel: Number(spell.level),
      schoolSlug: spell.schoolSlug,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid bound spell',
    );
  }
  row.boundSpellSlug = spell.slug;
}

export type {
  ArtifactAttunementRollDeps,
  AttunementCharacterContext,
} from './inventory-attunement-ops';
export {
  applyAttachedCoverageAttunement,
  applyInventoryAttunement,
} from './inventory-attunement-ops';
export {
  inventoryItemToDto,
  inventoryItemToDtoFromCatalog,
  inventoryItemsToDtos,
  loadInventoryCatalogBySlugs,
} from './inventory-item-mappers';
