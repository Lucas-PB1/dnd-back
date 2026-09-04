import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  UseClassResourceDto,
  UseClassResourceResponseDto,
} from '@game/session/dto/core/session-commands.dto';
import { applyOriginResourceSpendEffects } from './apply-origin-resource-spend-effects';
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
    const origin = await applyOriginResourceSpendEffects({
      state: this.state,
      character,
      resourceSlug,
      currentState: spent.state,
    });
    const thread = await applyThreadResourceSpendSideEffects({
      state: this.state,
      character,
      resourceSlug,
      currentState: origin.state,
    });
    const notes = [origin.note, thread.note].filter(
      (note): note is string => Boolean(note?.trim()),
    );
    const roll = origin.roll ?? spent.roll ?? null;
    return {
      ...spent,
      state: thread.state,
      ...(roll ? { roll } : {}),
      ...(notes.length > 0 ? { note: notes.join(' ') } : {}),
    };
  }
}
