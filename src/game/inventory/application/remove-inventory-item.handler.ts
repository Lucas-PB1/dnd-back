import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';

@Injectable()
export class RemoveInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly inventory: CharacterInventoryRepository,
  ) {}

  async execute(userId: string, characterId: string, itemSlug: string): Promise<void> {
    await this.access.findOwnedOrFail(userId, characterId);
    await this.inventory.remove(characterId, itemSlug);
  }
}
