import { BadRequestException } from '@nestjs/common';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  aberrantMutationLabel,
  aberrantMutationNote,
  isAberrantMutationEconomyAction,
  isAberrantMutationSlug,
  type AberrantMutationSlug,
} from '@game/session/domain/transformation/aberrant-mutation';

export type AberrantMutationResolveResult = {
  handled: boolean;
  response?: TableActionResponseDto;
  activateSlug?: AberrantMutationSlug;
};


export async function resolveAberrantMutationSidePath(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  action: ClassEconomyActionRecord;
  mutationSlug: string | null | undefined;
}): Promise<AberrantMutationResolveResult> {
  if (!isAberrantMutationEconomyAction(input.action)) {
    return { handled: false };
  }

  if (input.mutationSlug == null || input.mutationSlug === '') {
    const state = await input.state.setAberrantMutation(input.character, null);
    return {
      handled: true,
      response: {
        state,
        actionName: input.action.name,
        resourceSpent: false,
        note: 'Mutação Aberrante encerrada (ação bônus).',
      },
    };
  }

  if (!isAberrantMutationSlug(input.mutationSlug)) {
    throw new BadRequestException(
      `Mutação Aberrante desconhecida: ${input.mutationSlug}`,
    );
  }

  return { handled: false, activateSlug: input.mutationSlug };
}

export async function applyAberrantMutationAfterSpend(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  actionName: string;
  mutationSlug: AberrantMutationSlug;
}): Promise<TableActionResponseDto> {
  const state = await input.state.setAberrantMutation(
    input.character,
    input.mutationSlug,
  );
  const label = aberrantMutationLabel(input.mutationSlug);
  const detail = aberrantMutationNote(input.mutationSlug);
  return {
    state,
    actionName: input.actionName,
    resourceSpent: true,
    note: `${label} ativa. ${detail}`,
  };
}
