import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { PlayerCharacterItem } from '../player-character-item.entity';
import {
  AddInventoryItemDto,
  InventoryItemResponseDto,
} from '@game/inventory/dto/inventory.dto';
import { inventoryItemToDto } from './inventory-item-mappers';
import { assertInventoryAddFits } from './inventory-encumbrance';
import {
  applyCoinPurseToColumns,
  coinPurseFromColumns,
  creditCoinsWithExchange,
  debitCoinsWithExchange,
  type CoinPurse,
} from '@game/inventory/domain/coin-purse';

export async function addInventoryItem(input: {
  items: Repository<PlayerCharacterItem>;
  catalogItems: Repository<PhbItem>;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  characterId: string;
  dto: AddInventoryItemDto;
  strengthScore: number;
  debit?: CoinPurse | null;
}): Promise<InventoryItemResponseDto> {
  const {
    items,
    catalogItems,
    catalogLookup,
    dataSource,
    characterId,
    dto,
    strengthScore,
    debit,
  } = input;
  const catalog = await catalogLookup.assertItemInCatalog(dto.itemSlug);
  const delta = dto.quantity ?? 1;
  await assertInventoryAddFits({
    items,
    catalogItems,
    characterId,
    strengthScore,
    weight: catalog.weight,
    deltaQuantity: delta,
    itemSlug: dto.itemSlug,
  });
  if (!debit) {
    return addInventoryItemRow(
      items,
      catalogItems,
      characterId,
      dto.itemSlug,
      delta,
    );
  }
  return addInventoryItemWithDebit({
    dataSource,
    catalogItems,
    characterId,
    itemSlug: dto.itemSlug,
    delta,
    debit,
  });
}

export async function addInventoryItemRow(
  items: Repository<PlayerCharacterItem>,
  catalogItems: Repository<PhbItem>,
  characterId: string,
  itemSlug: string,
  delta: number,
): Promise<InventoryItemResponseDto> {
  const existing = await items.findOne({
    where: { characterId, itemSlug },
  });

  if (existing?.location === 'equipped') {
    throw new BadRequestException(
      'Item is equipped; unequip before adding more quantity',
    );
  }

  // Upsert em um único statement (compatível com PgBouncer transaction mode).
  // Evita TX TypeORM + findOne em outra conexão do pool.
  const returned = (await items.query(
    `INSERT INTO rpg.player_character_item (
       character_id, item_slug, quantity, location
     ) VALUES ($1, $2, $3, 'backpack')
     ON CONFLICT (character_id, item_slug) DO UPDATE
       SET quantity = rpg.player_character_item.quantity + EXCLUDED.quantity
     WHERE rpg.player_character_item.location <> 'equipped'
     RETURNING
       character_id AS "characterId",
       item_slug AS "itemSlug",
       quantity,
       location,
       equipment_slot AS "equipmentSlot",
       attuned,
       attached_charm_slug AS "attachedCharmSlug",
       is_pact_weapon AS "isPactWeapon",
       attached_coverage_slug AS "attachedCoverageSlug",
       attached_coverage_bonus AS "attachedCoverageBonus",
       attached_coverage_attuned AS "attachedCoverageAttuned",
       attached_coverage_spell_slug AS "attachedCoverageSpellSlug",
       bound_spell_slug AS "boundSpellSlug",
       instance_properties AS "instanceProperties",
       contained_in_item_slug AS "containedInItemSlug"`,
    [characterId, itemSlug, delta],
  )) as PlayerCharacterItem[];

  if (!returned?.length) {
    throw new BadRequestException(
      'Item is equipped; unequip before adding more quantity',
    );
  }

  return inventoryItemToDto(catalogItems, returned[0]);
}

export async function addInventoryItemWithDebit(input: {
  dataSource: DataSource;
  catalogItems: Repository<PhbItem>;
  characterId: string;
  itemSlug: string;
  delta: number;
  debit: CoinPurse;
}): Promise<InventoryItemResponseDto> {
  const { dataSource, catalogItems, characterId, itemSlug, delta, debit } =
    input;
  await dataSource.transaction(async (manager) => {
    const characters = manager.getRepository(PlayerCharacter);
    const character = await characters.findOne({
      where: { id: characterId },
      lock: { mode: 'pessimistic_write' },
    });
    if (!character) {
      throw new BadRequestException('Character not found');
    }
    const next = debitCoinsWithExchange(coinPurseFromColumns(character), debit);
    applyCoinPurseToColumns(character, next);
    await characters.save(character);
  });
  return addInventoryItemRow(
    dataSource.getRepository(PlayerCharacterItem),
    catalogItems,
    characterId,
    itemSlug,
    delta,
  );
}

export async function removeInventoryItemWithCredit(input: {
  dataSource: DataSource;
  characterId: string;
  itemSlug: string;
  credit: CoinPurse;
}): Promise<void> {
  const { dataSource, characterId, itemSlug, credit } = input;
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
    const locked = await items.findOne({
      where: { characterId, itemSlug },
      lock: { mode: 'pessimistic_write' },
    });
    if (!locked) {
      throw new BadRequestException(`Inventory item '${itemSlug}' not found`);
    }
    const next = creditCoinsWithExchange(
      coinPurseFromColumns(character),
      credit,
    );
    applyCoinPurseToColumns(character, next);
    await characters.save(character);
    await items.remove(locked);
  });
}
