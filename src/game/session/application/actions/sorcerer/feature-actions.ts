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

export const TIDES_OF_CHAOS_RESOURCE = 'tides-of-chaos';
export const RESTORE_BALANCE_RESOURCE = 'restore-balance';
export const DRAGON_WINGS_RESOURCE = 'dragon-wings';

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
  await deps.state.useClassResource(character, TIDES_OF_CHAOS_RESOURCE, 1);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Marés do Caos',
    resourceSpent: true,
    note: 'Marés do Caos: ganhe Vantagem em um Teste de D20 à sua escolha. Recarrega ao conjurar magia de Feiticeiro com espaço (Surto) ou no Descanso Longo.',
  };
}

export async function resolveBastionOfLaw(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  pointsSpent?: number,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'clockwork', 'Feitiçaria Mecânica');
  assertCharacterLevel(character, 6, 'Feiticeiro', 'Bastião da Lei');
  const cost = pointsSpent ?? 1;
  if (!Number.isInteger(cost) || cost < 1 || cost > 5) {
    throw new BadRequestException(
      'Bastião da Lei: gaste de 1 a 5 Pontos de Feitiçaria',
    );
  }
  const state = await spendPoints(deps, character, cost);

  return {
    state,
    actionName: 'Bastião da Lei',
    resourceSpent: true,
    total: cost,
    note: `Bastião da Lei: gastou ${cost} Pontos de Feitiçaria → ${cost}d8 de proteção a uma criatura a até 9 m (reduz dano até Descanso Longo ou novo uso).`,
  };
}

export async function resolveRestoreBalance(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'clockwork', 'Feitiçaria Mecânica');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Restaurar Equilíbrio');
  await deps.state.useClassResource(character, RESTORE_BALANCE_RESOURCE, 1);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Restaurar Equilíbrio',
    resourceSpent: true,
    note: 'Restaurar Equilíbrio: Reação — o Teste de D20 escolhido não é afetado por Vantagem nem Desvantagem.',
  };
}

export async function resolveDragonWings(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'draconic', 'Linhagem Dracônica');
  assertCharacterLevel(character, 14, 'Feiticeiro', 'Asas de Dragão');

  const wingsLeft = await remainingResource(
    deps,
    character,
    DRAGON_WINGS_RESOURCE,
  );

  let spentNote: string;
  if (wingsLeft > 0) {
    await deps.state.useClassResource(character, DRAGON_WINGS_RESOURCE, 1);
    spentNote = '1 uso';
  } else {
    await spendPoints(deps, character, 3);
    spentNote = '3 Pontos de Feitiçaria (restaurou o uso)';
  }

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Asas de Dragão',
    resourceSpent: true,
    note: `Asas de Dragão (${spentNote}): Ação Bônus — asas por 1 hora; Deslocamento de Voo 18 m.`,
  };
}

export async function resolveBendLuck(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'wild-magic', 'Feitiçaria Selvagem');
  assertCharacterLevel(character, 6, 'Feiticeiro', 'Distorcer a Sorte');
  const state = await spendPoints(deps, character, 1);

  return {
    state,
    actionName: 'Distorcer a Sorte',
    resourceSpent: true,
    total: 1,
    note: 'Distorcer a Sorte: Reação — gaste 1 Ponto de Feitiçaria e aplique +1d4 ou −1d4 ao Teste de D20 de outra criatura à sua vista.',
  };
}

export async function resolveHeroicSoul(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'heroic-sorcery', 'Feitiçaria Heróica');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Alma Heróica');
  const state = await spendPoints(deps, character, 1);
  const tempHpNote = `1d6 + ${character.level}`;

  return {
    state,
    actionName: 'Alma Heróica',
    resourceSpent: true,
    total: 1,
    note: `Alma Heróica: gastou 1 Ponto de Feitiçaria → PV temporários ${tempHpNote} (jogue na mesa).`,
  };
}

export async function resolveMysticalManeuver(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'heroic-sorcery', 'Feitiçaria Heróica');
  assertCharacterLevel(character, 14, 'Feiticeiro', 'Manobra Mística');
  const state = await spendPoints(deps, character, 2);

  return {
    state,
    actionName: 'Manobra Mística',
    resourceSpent: true,
    total: 2,
    note: 'Manobra Mística: gastou 2 Pontos de Feitiçaria (Ação Bônus após acertar) → +2d8 no dano e escolha Cegar, Ruinoso (−3 CA) ou Ferimento (sangramento).',
  };
}

export const WARP_IMPLOSION_RESOURCE = 'warp-implosion';

export async function resolveWarpImplosion(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'aberrant', 'Feitiçaria Aberrante');
  assertCharacterLevel(character, 18, 'Feiticeiro', 'Implosão de Distorção');
  await deps.state.useClassResource(character, WARP_IMPLOSION_RESOURCE, 1);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Implosão de Distorção',
    resourceSpent: true,
    note: 'Implosão de Distorção: ação Usar Magia — teleporte e dano espacial conforme a ficha (1×/Descanso Longo).',
  };
}
