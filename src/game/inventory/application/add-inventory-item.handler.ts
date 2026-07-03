import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  AddInventoryItemDto,
  InventoryItemResponseDto,
} from '../dto/inventory.dto';

@Injectable()
export class AddInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly inventory: CharacterInventoryRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: AddInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findOwnedOrFail(userId, characterId);
    return this.inventory.add(characterId, dto);
  }
}
