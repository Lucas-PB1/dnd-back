import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { PhbItem } from '../../../entities/phb-item.entity';
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
  clearEquippedSlotIfOccupied,
  findInventoryItemOrFail,
  inventoryItemToDto,
} from './inventory/inventory-item-ops';
import {
  assertInventoryAddFits,
  encumbranceFromInventoryDtos,
} from './inventory/inventory-encumbrance';

@Injectable()
export class CharacterInventoryRepository {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly slotResolver: EquipmentSlotResolver,
  ) {}

  async list(
    characterId: string,
    strengthScore: number,
  ): Promise<CharacterInventoryResponseDto> {
    const rows = await this.items.find({
      where: { characterId },
      order: { location: 'ASC', itemSlug: 'ASC' },
    });
    const dtos = await Promise.all(
      rows.map((row) => inventoryItemToDto(this.catalogItems, row)),
    );
    return {
      items: dtos,
      encumbrance: encumbranceFromInventoryDtos(dtos, strengthScore),
    };
  }

  async add(
    characterId: string,
    dto: AddInventoryItemDto,
    strengthScore: number,
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

    const existing = await this.items.findOne({
      where: { characterId, itemSlug: dto.itemSlug },
    });

    if (existing) {
      if (existing.location === 'equipped') {
        throw new BadRequestException(
          'Item is equipped; unequip before adding more quantity',
        );
      }
      existing.quantity += delta;
      await this.items.save(existing);
      return inventoryItemToDto(this.catalogItems, existing);
    }

    const row = this.items.create({
      characterId,
      itemSlug: dto.itemSlug,
      quantity: delta,
      location: 'backpack',
      equipmentSlot: null,
      attuned: false,
      attachedCharmSlug: null,
    });
    await this.items.save(row);
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
        row,
        attuned: dto.attuned,
      });
    }

    await this.items.save(row);
    return inventoryItemToDto(this.catalogItems, row);
  }

  async remove(characterId: string, itemSlug: string): Promise<void> {
    const row = await findInventoryItemOrFail(this.items, characterId, itemSlug);
    await this.items.remove(row);
  }
}
