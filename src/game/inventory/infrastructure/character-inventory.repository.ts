import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbItem } from '../../../entities/phb-item.entity';
import {
  EquipmentSlot,
  PlayerCharacterItem,
} from './player-character-item.entity';
import {
  AddInventoryItemDto,
  CharacterInventoryResponseDto,
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../dto/inventory.dto';

@Injectable()
export class CharacterInventoryRepository {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
  ) {}

  async list(characterId: string): Promise<CharacterInventoryResponseDto> {
    const rows = await this.items.find({
      where: { characterId },
      order: { location: 'ASC', itemSlug: 'ASC' },
    });

    const dtos = await Promise.all(rows.map((row) => this.toDto(row)));
    return { items: dtos };
  }

  async add(characterId: string, dto: AddInventoryItemDto): Promise<InventoryItemResponseDto> {
    await this.assertItemExists(dto.itemSlug);

    const existing = await this.items.findOne({
      where: { characterId, itemSlug: dto.itemSlug },
    });

    if (existing) {
      if (existing.location === 'equipped') {
        throw new BadRequestException(
          'Item is equipped; unequip before adding more quantity',
        );
      }
      existing.quantity += dto.quantity ?? 1;
      await this.items.save(existing);
      return this.toDto(existing);
    }

    const row = this.items.create({
      characterId,
      itemSlug: dto.itemSlug,
      quantity: dto.quantity ?? 1,
      location: 'backpack',
      equipmentSlot: null,
    });
    await this.items.save(row);
    return this.toDto(row);
  }

  async patch(
    characterId: string,
    itemSlug: string,
    dto: PatchInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    const row = await this.findItemOrFail(characterId, itemSlug);

    if (dto.quantity !== undefined) {
      row.quantity = dto.quantity;
    }

    const targetLocation = dto.location ?? row.location;
    const targetSlot = dto.equipmentSlot ?? row.equipmentSlot;

    if (targetLocation === 'backpack') {
      row.location = 'backpack';
      row.equipmentSlot = null;
    } else {
      if (!targetSlot) {
        throw new BadRequestException('equipmentSlot is required when equipping an item');
      }
      await this.clearSlotIfOccupied(characterId, targetSlot, itemSlug);
      row.location = 'equipped';
      row.equipmentSlot = targetSlot;
    }

    await this.items.save(row);
    return this.toDto(row);
  }

  async remove(characterId: string, itemSlug: string): Promise<void> {
    const row = await this.findItemOrFail(characterId, itemSlug);
    await this.items.remove(row);
  }

  private async findItemOrFail(
    characterId: string,
    itemSlug: string,
  ): Promise<PlayerCharacterItem> {
    const row = await this.items.findOne({ where: { characterId, itemSlug } });
    if (!row) {
      throw new NotFoundException(`Inventory item '${itemSlug}' not found on this character`);
    }
    return row;
  }

  private async assertItemExists(itemSlug: string): Promise<PhbItem> {
    const item = await this.catalogItems.findOne({ where: { slug: itemSlug } });
    if (!item) {
      throw new BadRequestException(`Item '${itemSlug}' not found in catalog`);
    }
    return item;
  }

  private async clearSlotIfOccupied(
    characterId: string,
    slot: EquipmentSlot,
    exceptItemSlug: string,
  ): Promise<void> {
    const occupant = await this.items.findOne({
      where: { characterId, location: 'equipped', equipmentSlot: slot },
    });
    if (occupant && occupant.itemSlug !== exceptItemSlug) {
      occupant.location = 'backpack';
      occupant.equipmentSlot = null;
      await this.items.save(occupant);
    }
  }

  private async toDto(row: PlayerCharacterItem): Promise<InventoryItemResponseDto> {
    const catalog = await this.catalogItems.findOne({ where: { slug: row.itemSlug } });
    return {
      itemSlug: row.itemSlug,
      itemName: catalog?.name ?? row.itemSlug,
      itemType: catalog?.itemType ?? 'unknown',
      quantity: row.quantity,
      location: row.location,
      equipmentSlot: row.equipmentSlot,
    };
  }
}
