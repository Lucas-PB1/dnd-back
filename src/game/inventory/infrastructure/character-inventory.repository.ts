import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/phb-item.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { PlayerCharacterItem } from './player-character-item.entity';
import { DmgArtifactRandomProperty } from './dmg-artifact-random-property.entity';
import {
  AddInventoryItemDto,
  CharacterInventoryResponseDto,
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../dto/inventory.dto';
import { EquipmentSlotResolver } from './equipment-slot-resolver';
import {
  findInventoryItemOrFail,
  inventoryItemsToDtos,
  type AttunementCharacterContext,
} from './inventory/inventory-item-ops';
import { encumbranceFromInventoryDtos } from './inventory/inventory-encumbrance';
import { coinPurseFromColumns, type CoinPurse } from '../domain/coin-purse';
import {
  addInventoryItem,
  removeInventoryItemWithCredit,
} from './inventory/inventory-coin-tx';
import { patchInventoryItem } from './inventory/inventory-item-patch';
import { ensureFromStartingEquipment } from './inventory/ensure-starting-inventory';

export type AddInventoryOptions = {
  /** Debitar estas moedas na mesma transação do add (null = free). */
  debit?: CoinPurse | null;
};

export type RemoveInventoryOptions = {
  /** Creditar estas moedas na mesma transação do remove (null = sem venda). */
  credit?: CoinPurse | null;
};

const EMPTY_WEALTH: CoinPurse = {
  copper: 0,
  silver: 0,
  electrum: 0,
  gold: 0,
  platinum: 0,
};

@Injectable()
export class CharacterInventoryRepository {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    @InjectRepository(PlayerCharacter)
    private readonly characters: Repository<PlayerCharacter>,
    @InjectRepository(DmgArtifactRandomProperty)
    private readonly artifactRandomProperties: Repository<DmgArtifactRandomProperty>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly slotResolver: EquipmentSlotResolver,
    private readonly dataSource: DataSource,
  ) {}

  async list(
    characterId: string,
    strengthScore: number,
  ): Promise<Omit<CharacterInventoryResponseDto, 'wealth' | 'paymentContext'>> {
    const rows = await this.items.find({
      where: { characterId },
      order: { location: 'ASC', itemSlug: 'ASC' },
    });
    const dtos = await inventoryItemsToDtos(this.catalogItems, rows);
    return {
      items: dtos,
      encumbrance: encumbranceFromInventoryDtos(dtos, strengthScore),
    };
  }

  async add(
    characterId: string,
    dto: AddInventoryItemDto,
    strengthScore: number,
    options: AddInventoryOptions = {},
  ): Promise<InventoryItemResponseDto> {
    return addInventoryItem({
      items: this.items,
      catalogItems: this.catalogItems,
      catalogLookup: this.catalogLookup,
      dataSource: this.dataSource,
      characterId,
      dto,
      strengthScore,
      debit: options.debit,
    });
  }

  async ensureFromStartingEquipment(
    characterId: string,
    equipment: Array<{ itemSlug?: string; quantity?: number }>,
  ): Promise<void> {
    return ensureFromStartingEquipment(
      this.items,
      this.catalogLookup,
      characterId,
      equipment,
    );
  }

  async patch(
    characterId: string,
    itemSlug: string,
    dto: PatchInventoryItemDto,
    strengthScore: number,
    character: AttunementCharacterContext,
  ): Promise<InventoryItemResponseDto> {
    return patchInventoryItem({
      items: this.items,
      catalogItems: this.catalogItems,
      catalogLookup: this.catalogLookup,
      slotResolver: this.slotResolver,
      artifactRandomProperties: this.artifactRandomProperties,
      dataSource: this.dataSource,
      characterId,
      itemSlug,
      dto,
      strengthScore,
      character,
    });
  }

  async findPactWeaponSlug(characterId: string): Promise<string | null> {
    const row = await this.items.findOne({
      where: { characterId, isPactWeapon: true },
    });
    return row?.itemSlug ?? null;
  }

  /** Marca arma de pacto (exclusiva) e equipa em main_hand se ainda não estiver. */
  async bindAndEquipPactWeapon(
    characterId: string,
    itemSlug: string,
    strengthScore: number,
    character: AttunementCharacterContext,
  ): Promise<InventoryItemResponseDto> {
    return this.patch(
      characterId,
      itemSlug,
      { pactWeapon: true, location: 'equipped', equipmentSlot: 'main_hand' },
      strengthScore,
      character,
    );
  }

  async peekItemQuantity(
    characterId: string,
    itemSlug: string,
  ): Promise<number | null> {
    const row = await this.items.findOne({ where: { characterId, itemSlug } });
    return row?.quantity ?? null;
  }

  async remove(
    characterId: string,
    itemSlug: string,
    options: RemoveInventoryOptions = {},
  ): Promise<void> {
    const row = await findInventoryItemOrFail(this.items, characterId, itemSlug);
    if (!options.credit) {
      await this.items.remove(row);
      return;
    }
    await removeInventoryItemWithCredit({
      dataSource: this.dataSource,
      characterId,
      itemSlug,
      credit: options.credit,
    });
  }

  async loadWealth(characterId: string): Promise<CoinPurse> {
    const row = await this.characters.findOne({ where: { id: characterId } });
    return row ? coinPurseFromColumns(row) : EMPTY_WEALTH;
  }
}
