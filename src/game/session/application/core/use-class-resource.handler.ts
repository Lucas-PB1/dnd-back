import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  UseClassResourceDto,
  UseClassResourceResponseDto,
} from '@game/session/dto/core/session-commands.dto';
import { applySpeciesResourceSpendSideEffects } from './apply-species-resource-spend-side-effects';
import { applyThreadResourceSpendSideEffects } from './apply-thread-resource-spend-side-effects';

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
    const species = await applySpeciesResourceSpendSideEffects({
      state: this.state,
      character,
      resourceSlug,
      currentState: spent.state,
    });
    const thread = await applyThreadResourceSpendSideEffects({
      state: this.state,
      character,
      resourceSlug,
      currentState: species.state,
    });
    const notes = [species.note, thread.note].filter(
      (note): note is string => Boolean(note?.trim()),
    );
    return {
      ...spent,
      state: thread.state,
      ...(notes.length > 0 ? { note: notes.join(' ') } : {}),
    };
  }
}
