import { BadRequestException } from '@nestjs/common';
import {
  INNATE_SORCERY_RESOURCE,
  SORCEROUS_RESTORATION_RESOURCE,
} from '@game/combat/domain/sorcerer';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  SorcererActionDeps,
  SorcererTableActionResult,
} from './sorcerer-action-deps';
import { SORCERY_POINTS_SLUG, spendPoints } from './sorcerer-action-deps';

async function remainingResource(
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

export async function resolveTidesOfChaos(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'wild-magic', 'Feitiçaria Selvagem');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Marés do Caos');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Marés do Caos',
    resourceSpent: false,
    note: 'Marés do Caos: ganhe Vantagem em um Teste de D20 à sua escolha. O Mestre pode disparar um Surto de Magia Selvagem a qualquer momento antes do próximo Descanso Longo para recarregar esta característica.',
  };
}

export async function resolveBastionOfLaw(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'clockwork', 'Feitiçaria Mecânica');
  assertCharacterLevel(character, 6, 'Feiticeiro', 'Bastião da Lei');
  const state = await spendPoints(deps, character, 2);

  return {
    state,
    actionName: 'Bastião da Lei',
    resourceSpent: true,
    total: 2,
    note: 'Bastião da Lei: gastou 2 Pontos de Feitiçaria para conceder 2d8 de dados de proteção a uma criatura a até 9 m. Ao sofrer dano, a criatura pode gastar os dados para reduzir o dano sofrido.',
  };
}
