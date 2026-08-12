import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  UseClassResourceDto,
  UseClassResourceResponseDto,
} from '@game/session/dto';
import { applySpeciesResourceSpendSideEffects } from './apply-species-resource-spend-side-effects';

@Injectable()
export class UseClassResourceHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: UseClassResourceDto,
  ): Promise<UseClassResourceResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const resourceSlug = dto.resourceSlug;
    const spent = await this.state.useClassResource(
      character,
      resourceSlug,
      dto.amount ?? 1,
    );
    const side = await applySpeciesResourceSpendSideEffects({
      state: this.state,
      character,
      resourceSlug,
      currentState: spent.state,
    });
    return {
      ...spent,
      state: side.state,
      ...(side.note ? { note: side.note } : {}),
    };
  }
}
