import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { RestDto, RestResponseDto } from '@game/session/dto';

@Injectable()
export class RestHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: RestDto,
  ): Promise<RestResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );

    if (dto.type === 'long') {
      return this.state.applyLongRest(character);
    }

    return this.state.applyShortRest(character, dto.hitDiceSpent ?? 0);
  }
}
