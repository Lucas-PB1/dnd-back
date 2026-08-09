import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterStateResponseDto } from '@game/session/dto/character-state.dto';

@Injectable()
export class GetCharacterStateQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly characters: CharacterRepository,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(userId: string, characterId: string): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    return this.state.buildResponse(character);
  }
}
