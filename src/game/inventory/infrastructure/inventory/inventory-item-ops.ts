import { BadRequestException, NotFoundException } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/phb-item.entity';
import {
  EquipmentSlot,
  EXCLUSIVE_EQUIPMENT_SLOTS,
  PlayerCharacterItem,
} from '../player-character-item.entity';
import { InventoryItemResponseDto } from '@game/inventory/dto/inventory.dto';
import {
  itemRequiresAttunement,
  MAX_ATTUNED_ITEMS,
} from '@game/inventory/domain/attunement';
import { assertCharacterMayAttune } from '@game/inventory/domain/attunement-restriction';
import {
  assertEnspelledBoundSpell,
  getEnspelledProfile,
} from '@game/inventory/domain/coverage/enspelled-weapon';
import {
  itemEffectsActive,
  itemEffectsStatus,
} from '@game/inventory/domain/item-effects-active';
import { parseItemWeightKg } from '@game/inventory/domain/encumbrance';

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

export type AttunementCharacterContext = {
  classSlug: string;
  speciesSlug: string | null;
};

export async function applyInventoryAttunement(input: {
  items: Repository<PlayerCharacterItem>;
  catalogLookup: CatalogLookupService;
  characterId: string;
  character: AttunementCharacterContext;
  row: PlayerCharacterItem;
  attuned: boolean;
}): Promise<void> {
  const { items, catalogLookup, characterId, character, row, attuned } = input;
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

  try {
    assertCharacterMayAttune({
      itemLabel: row.itemSlug,
      classSlug: character.classSlug,
      speciesSlug: character.speciesSlug,
      properties: catalog.properties,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Attunement not allowed',
    );
  }

  const attunedCount = await items.count({
    where: { characterId, attuned: true },
  });
  const coverageAttunedCount = await items.count({
    where: { characterId, attachedCoverageAttuned: true },
  });
  if (attunedCount + coverageAttunedCount >= MAX_ATTUNED_ITEMS) {
    throw new BadRequestException(
      `Maximum of ${MAX_ATTUNED_ITEMS} attuned items reached`,
    );
  }

  row.attuned = true;
}

export async function applyAttachedCoverageAttunement(input: {
  items: Repository<PlayerCharacterItem>;
  catalogLookup: CatalogLookupService;
  characterId: string;
  character: AttunementCharacterContext;
  row: PlayerCharacterItem;
  attuned: boolean;
}): Promise<void> {
  const { items, catalogLookup, characterId, character, row, attuned } = input;
  if (row.attachedCoverageAttuned === attuned) return;

  if (!attuned) {
    row.attachedCoverageAttuned = false;
    return;
  }

  const coverageSlug = row.attachedCoverageSlug;
  if (!coverageSlug) {
    throw new BadRequestException(
      `Item '${row.itemSlug}' has no attached coverage to attune`,
    );
  }

  const catalog = await catalogLookup.assertItemInCatalog(coverageSlug);
  if (!itemRequiresAttunement(catalog.properties)) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' does not require attunement`,
    );
  }

  try {
    assertCharacterMayAttune({
      itemLabel: coverageSlug,
      classSlug: character.classSlug,
      speciesSlug: character.speciesSlug,
      properties: catalog.properties,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Attunement not allowed',
    );
  }

  const attunedCount = await items.count({
    where: { characterId, attuned: true },
  });
  const coverageAttunedCount = await items.count({
    where: { characterId, attachedCoverageAttuned: true },
  });
  if (attunedCount + coverageAttunedCount >= MAX_ATTUNED_ITEMS) {
    throw new BadRequestException(
      `Maximum of ${MAX_ATTUNED_ITEMS} attuned items reached`,
    );
  }

  row.attachedCoverageAttuned = true;
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

export function inventoryItemToDtoFromCatalog(
  catalogBySlug: Map<string, PhbItem>,
  row: PlayerCharacterItem,
): InventoryItemResponseDto {
  const catalog = catalogBySlug.get(row.itemSlug);
  const requiresAttunement = itemRequiresAttunement(catalog?.properties);
  const consumable =
    catalog?.properties != null &&
    typeof catalog.properties === 'object' &&
    !Array.isArray(catalog.properties) &&
    (catalog.properties as Record<string, unknown>).consumable === true;
  const activation = {
    location: row.location,
    attuned: row.attuned,
    requiresAttunement,
  };
  const charmSlug = row.attachedCharmSlug ?? null;
  const charm = charmSlug ? catalogBySlug.get(charmSlug) : undefined;
  const coverageSlug = row.attachedCoverageSlug ?? null;
  const coverage = coverageSlug ? catalogBySlug.get(coverageSlug) : undefined;
  const props =
    catalog?.properties != null &&
    typeof catalog.properties === 'object' &&
    !Array.isArray(catalog.properties)
      ? (catalog.properties as Record<string, unknown>)
      : null;
  const isCoverage = props?.kind === 'coverage';
  return {
    itemSlug: row.itemSlug,
    itemName: catalog?.name ?? row.itemSlug,
    itemType: catalog?.itemType ?? 'unknown',
    quantity: row.quantity,
    location: row.location,
    equipmentSlot: row.equipmentSlot,
    attuned: row.attuned,
    isPactWeapon: row.isPactWeapon ?? false,
    requiresAttunement,
    effectsActive: itemEffectsActive(activation),
    consumable,
    effectsStatus: itemEffectsStatus(activation),
    weightKg: parseItemWeightKg(catalog?.weight),
    attachedCharmSlug: charmSlug,
    attachedCharmName: charmSlug
      ? (charm?.name ?? charmSlug)
      : null,
    attachedCoverageSlug: coverageSlug,
    attachedCoverageName: coverageSlug
      ? (coverage?.name ?? coverageSlug)
      : null,
    attachedCoverageBonus: row.attachedCoverageBonus ?? null,
    attachedCoverageAttuned: row.attachedCoverageAttuned ?? false,
    attachedCoverageRequiresAttunement: coverageSlug
      ? itemRequiresAttunement(coverage?.properties)
      : false,
    attachedCoverageSpellSlug: row.attachedCoverageSpellSlug ?? null,
    boundSpellSlug: row.boundSpellSlug ?? null,
    isCoverage,
  };
}

export async function loadInventoryCatalogBySlugs(
  catalogItems: Repository<PhbItem>,
  slugs: readonly string[],
): Promise<Map<string, PhbItem>> {
  const unique = [...new Set(slugs.filter(Boolean))];
  if (unique.length === 0) return new Map();
  const rows = await catalogItems.find({ where: { slug: In(unique) } });
  return new Map(rows.map((item) => [item.slug, item]));
}

export async function inventoryItemsToDtos(
  catalogItems: Repository<PhbItem>,
  rows: readonly PlayerCharacterItem[],
): Promise<InventoryItemResponseDto[]> {
  const slugs = rows.flatMap((row) => {
    const list = [row.itemSlug];
    if (row.attachedCharmSlug) list.push(row.attachedCharmSlug);
    if (row.attachedCoverageSlug) list.push(row.attachedCoverageSlug);
    return list;
  });
  const catalogBySlug = await loadInventoryCatalogBySlugs(catalogItems, slugs);
  return rows.map((row) => inventoryItemToDtoFromCatalog(catalogBySlug, row));
}

export async function inventoryItemToDto(
  catalogItems: Repository<PhbItem>,
  row: PlayerCharacterItem,
): Promise<InventoryItemResponseDto> {
  const [dto] = await inventoryItemsToDtos(catalogItems, [row]);
  return dto;
}
