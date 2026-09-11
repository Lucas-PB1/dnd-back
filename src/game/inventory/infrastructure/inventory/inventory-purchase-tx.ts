import { BadRequestException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  InventoryItemResponseDto,
} from '@game/inventory/dto/inventory.dto';
import {
  applyCoinPurseToColumns,
  coinPurseFromColumns,
  creditCoinsWithExchange,
  debitCoinsWithExchange,
  type CoinPurse,
} from '@game/inventory/domain/coin-purse';
import { PlayerCharacterItem } from '../player-character-item.entity';
import { addInventoryItemRow } from './inventory-coin-tx';
import { inventoryItemToDto } from './inventory-item-mappers';
import { findInventoryItemOrFail } from './inventory-item-ops';

/** Compra multi-linha: débito (se houver) + upserts atômicos. */
export async function purchaseInventoryLines(input: {
  dataSource: DataSource;
  catalogItems: Repository<PhbItem>;
  characterId: string;
  lines: ReadonlyArray<{ itemSlug: string; quantity: number }>;
  debit: CoinPurse | null;
}): Promise<InventoryItemResponseDto[]> {
  const { dataSource, catalogItems, characterId, lines, debit } = input;

  if (debit) {
    await dataSource.transaction(async (manager) => {
      const characters = manager.getRepository(PlayerCharacter);
      const character = await characters.findOne({
        where: { id: characterId },
        lock: { mode: 'pessimistic_write' },
      });
      if (!character) {
        throw new BadRequestException('Character not found');
      }
      const next = debitCoinsWithExchange(
        coinPurseFromColumns(character),
        debit,
      );
      applyCoinPurseToColumns(character, next);
      await characters.save(character);
    });
  }

  // Upserts fora da TX de moedas: cada INSERT…ON CONFLICT é atômico e
  // não depende de hold de conexão (PgBouncer transaction pooler).
  const items = dataSource.getRepository(PlayerCharacterItem);
  const results: InventoryItemResponseDto[] = [];
  for (const line of lines) {
    results.push(
      await addInventoryItemRow(
        items,
        catalogItems,
        characterId,
        line.itemSlug,
        line.quantity,
      ),
    );
  }
  return results;
}

/** Ajusta qty com débito (↑) ou crédito (↓) atômico. */
export async function adjustInventoryQuantityWithCoins(input: {
  dataSource: DataSource;
  catalogItems: Repository<PhbItem>;
  catalogLookup: CatalogLookupService;
  characterId: string;
  itemSlug: string;
  newQuantity: number;
  debit?: CoinPurse | null;
  credit?: CoinPurse | null;
}): Promise<InventoryItemResponseDto> {
  const {
    dataSource,
    catalogItems,
    characterId,
    itemSlug,
    newQuantity,
    debit,
    credit,
  } = input;
  return dataSource.transaction(async (manager) => {
    const characters = manager.getRepository(PlayerCharacter);
    const items = manager.getRepository(PlayerCharacterItem);
    const character = await characters.findOne({
      where: { id: characterId },
      lock: { mode: 'pessimistic_write' },
    });
    if (!character) {
      throw new BadRequestException('Character not found');
    }
    const locked = await items.findOne({
      where: { characterId, itemSlug },
      lock: { mode: 'pessimistic_write' },
    });
    if (!locked) {
      throw new BadRequestException(`Inventory item '${itemSlug}' not found`);
    }
    if (debit) {
      const next = debitCoinsWithExchange(
        coinPurseFromColumns(character),
        debit,
      );
      applyCoinPurseToColumns(character, next);
      await characters.save(character);
    } else if (credit) {
      const next = creditCoinsWithExchange(
        coinPurseFromColumns(character),
        credit,
      );
      applyCoinPurseToColumns(character, next);
      await characters.save(character);
    }
    locked.quantity = newQuantity;
    await items.save(locked);
    return inventoryItemToDto(catalogItems, locked);
  });
}

/** Remove qty parcial ou total, com crédito opcional. */
export async function removeInventoryQuantityWithCredit(input: {
  dataSource: DataSource;
  characterId: string;
  itemSlug: string;
  quantity: number;
  credit: CoinPurse | null;
}): Promise<void> {
  const { dataSource, characterId, itemSlug, quantity, credit } = input;
  await dataSource.transaction(async (manager) => {
    const characters = manager.getRepository(PlayerCharacter);
    const items = manager.getRepository(PlayerCharacterItem);
    const character = await characters.findOne({
      where: { id: characterId },
      lock: { mode: 'pessimistic_write' },
    });
    if (!character) {
      throw new BadRequestException('Character not found');
    }
    const locked = await findInventoryItemOrFail(items, characterId, itemSlug);
    if (quantity > locked.quantity) {
      throw new BadRequestException(
        `Cannot remove ${quantity}; only ${locked.quantity} in inventory`,
      );
    }
    if (credit) {
      const next = creditCoinsWithExchange(
        coinPurseFromColumns(character),
        credit,
      );
      applyCoinPurseToColumns(character, next);
      await characters.save(character);
    }
    if (quantity >= locked.quantity) {
      await items.remove(locked);
      return;
    }
    locked.quantity -= quantity;
    await items.save(locked);
  });
}
