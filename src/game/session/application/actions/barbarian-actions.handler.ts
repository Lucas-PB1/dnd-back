import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  CharacterStateResponseDto,
  ToggleRageDto,
  ToggleRecklessDto,
} from '@game/session/dto';

@Injectable()
export class BarbarianActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async toggleRage(
    userId: string,
    characterId: string,
    dto: ToggleRageDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.toggleRage(character, dto.active);
  }

  async toggleReckless(
    userId: string,
    characterId: string,
    dto: ToggleRecklessDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.toggleReckless(character, dto.active);
  }

  /** Fúria Persistente (nv.15): recupera todas as Fúrias (ex.: na iniciativa). */
  async recoverAllRage(
    userId: string,
    characterId: string,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.recoverAllRage(character);
  }
}
