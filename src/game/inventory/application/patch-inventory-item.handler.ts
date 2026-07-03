import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../dto/inventory.dto';

@Injectable()
export class PatchInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly inventory: CharacterInventoryRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    itemSlug: string,
    dto: PatchInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findOwnedOrFail(userId, characterId);
    return this.inventory.patch(characterId, itemSlug, dto);
  }
}
