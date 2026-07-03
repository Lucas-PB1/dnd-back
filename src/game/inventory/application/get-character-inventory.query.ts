import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import { CharacterInventoryResponseDto } from '../dto/inventory.dto';

@Injectable()
export class GetCharacterInventoryQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly inventory: CharacterInventoryRepository,
  ) {}

  async execute(userId: string, characterId: string): Promise<CharacterInventoryResponseDto> {
    await this.access.findOwnedOrFail(userId, characterId);
    return this.inventory.list(characterId);
  }
}
