import { BadRequestException } from '@nestjs/common';
import {
  INNATE_SORCERY_RESOURCE,
  SORCEROUS_RESTORATION_RESOURCE,
} from '@game/combat/domain/sorcerer';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  SorcererActionDeps,
  SorcererTableActionResult,
} from '../sorcerer-action-deps';
import { SORCERY_POINTS_SLUG, spendPoints } from '../sorcerer-action-deps';

export async function remainingResource(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  slug: string,
): Promise<number> {
  const state = await deps.state.buildResponse(character);
  return (
    state.classResources.find((resource) => resource.slug === slug)
      ?.remaining ?? 0
  );
}

export async function resolveInnateSorcery(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 1, 'Feiticeiro', 'Feitiçaria Inata');

  const innateLeft = await remainingResource(
    deps,
    character,
    INNATE_SORCERY_RESOURCE,
  );

  let spentNote: string;
  if (innateLeft > 0) {
    await deps.state.useClassResource(character, INNATE_SORCERY_RESOURCE, 1);
    spentNote = '1 uso';
  } else if (character.level >= 7) {
    await spendPoints(deps, character, 2);
    spentNote = 'Feitiçaria Encarnada: 2 Pontos de Feitiçaria';
  } else {
    throw new BadRequestException(
      'Sem usos de Feitiçaria Inata (recupera no Descanso Longo)',
    );
  }

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Feitiçaria Inata',
    resourceSpent: true,
    note: `Feitiçaria Inata (${spentNote}): Ação Bônus libera a magia por 1 minuto (+1 na CD das suas magias de Feiticeiro e Vantagem nas jogadas de ataque das magias de Feiticeiro).`,
  };
}

export async function resolveSorcerousRestoration(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 5, 'Feiticeiro', 'Restauração Feiticeira');
  await deps.state.useClassResource(
    character,
    SORCEROUS_RESTORATION_RESOURCE,
    1,
  );
  const pointsToRecover = Math.floor(character.level / 2);
  const state = await deps.state.recoverClassResource(
    character,
    SORCERY_POINTS_SLUG,
    pointsToRecover,
  );

  return {
    state,
    actionName: 'Restauração Feiticeira',
    resourceSpent: true,
    total: pointsToRecover,
    note: `Restauração Feiticeira: recuperou ${pointsToRecover} Pontos de Feitiçaria no Descanso Curto (1×/Descanso Longo).`,
  };
}
