import { In, Repository } from 'typeorm';
import { PhbItem } from '@entities/phb-item.entity';
import { PlayerCharacterItem } from '../player-character-item.entity';
import { InventoryItemResponseDto } from '@game/inventory/dto/inventory.dto';
import { catalogCostText } from '@game/inventory/domain/coin-purse';
import { itemRequiresAttunement } from '@game/inventory/domain/attunement';
import {
  itemIsCursed,
  instanceCurseBroken,
} from '@game/inventory/domain/cursed-item';
import {
  itemEffectsActive,
  itemEffectsStatus,
} from '@game/inventory/domain/item-effects-active';
import { parseItemWeightKg } from '@game/inventory/domain/encumbrance';

export function inventoryItemToDtoFromCatalog(
  catalogBySlug: Map<string, PhbItem>,
  row: PlayerCharacterItem,
): InventoryItemResponseDto {
  const catalog = catalogBySlug.get(row.itemSlug);
  const requiresAttunement = itemRequiresAttunement(catalog?.properties);
  const props =
    catalog?.properties != null &&
    typeof catalog.properties === 'object' &&
    !Array.isArray(catalog.properties)
      ? (catalog.properties as Record<string, unknown>)
      : null;
  const consumable = props?.consumable === true;
  const activation = {
    location: row.location,
    attuned: row.attuned,
    requiresAttunement,
  };
  const charmSlug = row.attachedCharmSlug ?? null;
  const charm = charmSlug ? catalogBySlug.get(charmSlug) : undefined;
  const coverageSlug = row.attachedCoverageSlug ?? null;
  const coverage = coverageSlug ? catalogBySlug.get(coverageSlug) : undefined;
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
    cursed: itemIsCursed(props),
    curseBroken: instanceCurseBroken(row.instanceProperties),
    effectsActive: itemEffectsActive(activation),
    consumable,
    effectsStatus: itemEffectsStatus(activation),
    weightKg: parseItemWeightKg(catalog?.weight),
    attachedCharmSlug: charmSlug,
    attachedCharmName: charmSlug ? (charm?.name ?? charmSlug) : null,
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
    instanceProperties: row.instanceProperties ?? null,
    costText: catalogCostText(catalog?.cost ?? null),
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
