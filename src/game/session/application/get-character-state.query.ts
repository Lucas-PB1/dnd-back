import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { CharacterStateResponseDto } from '../dto/character-state.dto';

@Injectable()
export class GetCharacterStateQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly characters: CharacterRepository,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(userId: string, characterId: string): Promise<CharacterStateResponseDto> {
    const character = await this.access.findOwnedOrFail(userId, characterId);
    return this.state.buildResponse(character);
  }
}
