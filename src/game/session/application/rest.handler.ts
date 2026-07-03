import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { RestDto, RestResponseDto } from '../dto/character-state.dto';

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
    const character = await this.access.findOwnedOrFail(userId, characterId);

    const state =
      dto.type === 'long'
        ? await this.state.applyLongRest(character)
        : await this.state.applyShortRest(character);

    return { type: dto.type, state };
  }
}
