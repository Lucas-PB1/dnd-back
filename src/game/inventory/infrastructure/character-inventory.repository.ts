import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/phb-item.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { PlayerCharacterItem } from './player-character-item.entity';
import {
  AddInventoryItemDto,
  CharacterInventoryResponseDto,
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../dto/inventory.dto';
import { EquipmentSlotResolver } from './equipment-slot-resolver';
import {
  applyInventoryAttunement,
  applyAttachedCoverageAttunement,
  applyBoundSpellSlug,
  applyPactWeaponFlag,
  clearEquippedSlotIfOccupied,
  findInventoryItemOrFail,
  inventoryItemToDto,
  inventoryItemsToDtos,
  type AttunementCharacterContext,
} from './inventory/inventory-item-ops';
import {
  assertInventoryAddFits,
  encumbranceFromInventoryDtos,
} from './inventory/inventory-encumbrance';
import {
  applyCoinPurseToColumns,
  coinPurseFromColumns,
  debitCoins,
  type CoinPurse,
} from '../domain/coin-purse';

export type AddInventoryOptions = {
  /** Debitar estas moedas na mesma transação do add (null = free). */
  debit?: CoinPurse | null;
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
    const catalog = await this.catalogLookup.assertItemInCatalog(dto.itemSlug);
    const delta = dto.quantity ?? 1;
    await assertInventoryAddFits({
      items: this.items,
      catalogItems: this.catalogItems,
      characterId,
      strengthScore,
      weight: catalog.weight,
      deltaQuantity: delta,
      itemSlug: dto.itemSlug,
    });

    if (!options.debit) {
      return this.addItemRow(this.items, characterId, dto.itemSlug, delta);
    }

    return this.dataSource.transaction(async (manager) => {
      const characters = manager.getRepository(PlayerCharacter);
      const items = manager.getRepository(PlayerCharacterItem);
      const character = await characters.findOne({
        where: { id: characterId },
        lock: { mode: 'pessimistic_write' },
      });
      if (!character) {
        throw new BadRequestException('Character not found');
      }
      const next = debitCoins(
        coinPurseFromColumns(character),
        options.debit!,
      );
      applyCoinPurseToColumns(character, next);
      await characters.save(character);
      return this.addItemRow(items, characterId, dto.itemSlug, delta);
    });
  }

  private async addItemRow(
    items: Repository<PlayerCharacterItem>,
    characterId: string,
    itemSlug: string,
    delta: number,
  ): Promise<InventoryItemResponseDto> {
    const existing = await items.findOne({
      where: { characterId, itemSlug },
    });

    if (existing) {
      if (existing.location === 'equipped') {
        throw new BadRequestException(
          'Item is equipped; unequip before adding more quantity',
        );
      }
      existing.quantity += delta;
      await items.save(existing);
      return inventoryItemToDto(this.catalogItems, existing);
    }

    const row = items.create({
      characterId,
      itemSlug,
      quantity: delta,
      location: 'backpack',
      equipmentSlot: null,
      attuned: false,
      isPactWeapon: false,
      attachedCharmSlug: null,
    });
    await items.save(row);
    return inventoryItemToDto(this.catalogItems, row);
  }

  /** Seed mochila a partir do equipamento inicial; não sobrescreve itens existentes. */
  async ensureFromStartingEquipment(
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

    for (const [itemSlug, quantity] of totals) {
      const existing = await this.items.findOne({
        where: { characterId, itemSlug },
      });
      if (existing) continue;

      await this.catalogLookup.assertItemInCatalog(itemSlug);
      await this.items.save(
        this.items.create({
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
    }
  }

  async patch(
    characterId: string,
    itemSlug: string,
    dto: PatchInventoryItemDto,
    strengthScore: number,
    character: AttunementCharacterContext,
  ): Promise<InventoryItemResponseDto> {
    const row = await findInventoryItemOrFail(this.items, characterId, itemSlug);

    if (dto.quantity !== undefined && dto.quantity > row.quantity) {
      const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
      await assertInventoryAddFits({
        items: this.items,
        catalogItems: this.catalogItems,
        characterId,
        strengthScore,
        weight: catalog.weight,
        deltaQuantity: dto.quantity - row.quantity,
        itemSlug,
      });
    }

    if (dto.quantity !== undefined) {
      row.quantity = dto.quantity;
    }

    const touchesLocation =
      dto.location !== undefined || dto.equipmentSlot !== undefined;

    if (touchesLocation) {
      const targetLocation = dto.location ?? row.location;
      let targetSlot = dto.equipmentSlot ?? row.equipmentSlot;

      if (targetLocation === 'backpack') {
        row.location = 'backpack';
        row.equipmentSlot = null;
      } else {
        targetSlot = await this.slotResolver.resolve(
          characterId,
          itemSlug,
          targetSlot,
        );
        await clearEquippedSlotIfOccupied(
          this.items,
          characterId,
          targetSlot,
          itemSlug,
        );
        row.location = 'equipped';
        row.equipmentSlot = targetSlot;
      }
    }

    if (dto.attuned !== undefined) {
      await applyInventoryAttunement({
        items: this.items,
        catalogLookup: this.catalogLookup,
        characterId,
        character,
        row,
        attuned: dto.attuned,
      });
    }

    if (dto.attachedCoverageAttuned !== undefined) {
      await applyAttachedCoverageAttunement({
        items: this.items,
        catalogLookup: this.catalogLookup,
        characterId,
        character,
        row,
        attuned: dto.attachedCoverageAttuned,
      });
    }

    if (dto.pactWeapon !== undefined) {
      await applyPactWeaponFlag({
        items: this.items,
        characterId,
        row,
        pactWeapon: dto.pactWeapon,
      });
    }

    if (dto.boundSpellSlug !== undefined) {
      await applyBoundSpellSlug({
        catalogLookup: this.catalogLookup,
        row,
        boundSpellSlug: dto.boundSpellSlug,
      });
    }

    await this.items.save(row);
    return inventoryItemToDto(this.catalogItems, row);
  }

  async findPactWeaponSlug(characterId: string): Promise<string | null> {
    const row = await this.items.findOne({
      where: { characterId, isPactWeapon: true },
    });
    return row?.itemSlug ?? null;
  }

  /**
   * Marca arma de pacto (exclusiva) e equipa em main_hand se ainda não estiver.
   */
  async bindAndEquipPactWeapon(
    characterId: string,
    itemSlug: string,
    strengthScore: number,
    character: AttunementCharacterContext,
  ): Promise<InventoryItemResponseDto> {
    return this.patch(
      characterId,
      itemSlug,
      {
        pactWeapon: true,
        location: 'equipped',
        equipmentSlot: 'main_hand',
      },
      strengthScore,
      character,
    );
  }

  async remove(characterId: string, itemSlug: string): Promise<void> {
    const row = await findInventoryItemOrFail(this.items, characterId, itemSlug);
    await this.items.remove(row);
  }

  async loadWealth(characterId: string): Promise<CoinPurse> {
    const row = await this.characters.findOne({ where: { id: characterId } });
    if (!row) {
      return {
        copper: 0,
        silver: 0,
        electrum: 0,
        gold: 0,
        platinum: 0,
      };
    }
    return coinPurseFromColumns(row);
  }
}
