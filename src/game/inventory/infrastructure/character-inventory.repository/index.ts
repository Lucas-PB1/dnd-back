import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { PlayerCharacterItem } from '../player-character-item.entity';
import { DmgArtifactRandomProperty } from '../dmg-artifact-random-property.entity';
import {
  AddInventoryItemDto,
  CharacterInventoryResponseDto,
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../../dto/inventory.dto';
import { EquipmentSlotResolver } from '../equipment-slot-resolver';
import {
  inventoryItemsToDtos,
  type AttunementCharacterContext,
} from '../inventory/inventory-item-ops';
import { encumbranceFromInventoryDtos } from '../inventory/inventory-encumbrance';
import type { CoinPurse } from '../../domain/coin-purse';
import { addInventoryItem } from '../inventory/inventory-coin-tx';
import { adjustInventoryQuantityWithCoins } from '../inventory/inventory-purchase-tx';
import { patchInventoryItem } from '../inventory/inventory-item-patch';
import { ensureFromStartingEquipment } from '../inventory/ensure-starting-inventory';
import { removeInventoryItem } from './remove-item';
import {
  AddInventoryOptions,
  PatchQuantityCoinOptions,
  RemoveInventoryOptions,
} from './types';
import { debitCharacterWealth, loadCharacterWealth } from './wealth-ops';

export type {
  AddInventoryOptions,
  PatchQuantityCoinOptions,
  RemoveInventoryOptions,
} from './types';

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

  async patchQuantityWithCoins(
    characterId: string,
    itemSlug: string,
    newQuantity: number,
    options: PatchQuantityCoinOptions = {},
  ): Promise<InventoryItemResponseDto> {
    return adjustInventoryQuantityWithCoins({
      dataSource: this.dataSource,
      catalogItems: this.catalogItems,
      catalogLookup: this.catalogLookup,
      characterId,
      itemSlug,
      newQuantity,
      debit: options.debit,
      credit: options.credit,
    });
  }

  async findPactWeaponSlug(characterId: string): Promise<string | null> {
    const row = await this.items.findOne({
      where: { characterId, isPactWeapon: true },
    });
    return row?.itemSlug ?? null;
  }

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
    return removeInventoryItem(
      { items: this.items, dataSource: this.dataSource },
      characterId,
      itemSlug,
      options,
    );
  }

  async debitWealth(characterId: string, debit: CoinPurse): Promise<void> {
    return debitCharacterWealth(this.dataSource, characterId, debit);
  }

  async loadWealth(characterId: string): Promise<CoinPurse> {
    return loadCharacterWealth(this.characters, characterId);
  }
}
