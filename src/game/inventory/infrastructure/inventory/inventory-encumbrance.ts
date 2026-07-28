import { Repository } from 'typeorm';
import { PhbItem } from '../../../../entities/phb-item.entity';
import { PlayerCharacterItem } from '../player-character-item.entity';
import { InventoryItemResponseDto } from '../../dto/inventory.dto';
import {
  assertWithinCarryingCapacity,
  encumbranceFromCatalogRows,
} from '../../domain/assert-encumbrance';
import {
  computeEncumbrance,
  parseItemWeightKg,
  type EncumbranceSummary,
} from '../../domain/encumbrance';

export function encumbranceFromInventoryDtos(
  dtos: InventoryItemResponseDto[],
  strengthScore: number,
): EncumbranceSummary {
  return computeEncumbrance(
    dtos.map((dto) => ({ weightKg: dto.weightKg, quantity: dto.quantity })),
    strengthScore,
  );
}

export async function loadInventoryEncumbrance(
  items: Repository<PlayerCharacterItem>,
  catalogItems: Repository<PhbItem>,
  characterId: string,
  strengthScore: number,
): Promise<EncumbranceSummary> {
  const rows = await items.find({ where: { characterId } });
  const withWeight = await Promise.all(
    rows.map(async (row) => {
      const catalog = await catalogItems.findOne({
        where: { slug: row.itemSlug },
      });
      return { weight: catalog?.weight ?? null, quantity: row.quantity };
    }),
  );
  return encumbranceFromCatalogRows(withWeight, strengthScore);
}

export async function assertInventoryAddFits(input: {
  items: Repository<PlayerCharacterItem>;
  catalogItems: Repository<PhbItem>;
  characterId: string;
  strengthScore: number;
  weight: string | null | undefined;
  deltaQuantity: number;
  itemSlug: string;
}): Promise<void> {
  const current = await loadInventoryEncumbrance(
    input.items,
    input.catalogItems,
    input.characterId,
    input.strengthScore,
  );
  assertWithinCarryingCapacity({
    current,
    itemWeightKg: parseItemWeightKg(input.weight),
    deltaQuantity: input.deltaQuantity,
    itemSlug: input.itemSlug,
  });
}
