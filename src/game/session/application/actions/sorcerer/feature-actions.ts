import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../core/table-action-guards';
import type {
  PlayerCharacter,
  SorcererActionDeps,
  SorcererTableActionResult,
} from './sorcerer-action-deps';
import { SORCERY_POINTS_SLUG, spendPoints } from './sorcerer-action-deps';

export async function resolveInnateSorcery(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 1, 'Feiticeiro', 'Inato Feiticeiro');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Ira Feiticeira',
    resourceSpent: false,
    note: 'Inato Feiticeiro: Ação Bônus ativa Ira Feiticeira por 1 minuto (+1 na CD das suas magias e Vantagem nas jogadas de ataque com truques de Feiticeiro).',
  };
}

export async function resolveSorcerousRestoration(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterLevel(character, 5, 'Feiticeiro', 'Restauração Feiticeira');
  const pointsToRecover = Math.floor(character.level / 2);
  const state = await deps.state.recoverClassResource(
    character,
    SORCERY_POINTS_SLUG,
    pointsToRecover,
  );

  return {
    state,
    actionName: 'Restauração Feiticeira',
    resourceSpent: false,
    total: pointsToRecover,
    note: `Restauração Feiticeira: recuperou ${pointsToRecover} Pontos de Feitiçaria no Descanso Curto.`,
  };
}

export async function resolveTidesOfChaos(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'wild-magic', 'Magia Selvagem');
  assertCharacterLevel(character, 3, 'Feiticeiro', 'Maré de Caos');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Maré de Caos',
    resourceSpent: false,
    note: 'Maré de Caos: ganhe Vantagem em uma jogada de ataque, teste de habilidade ou salvaguarda. O Mestre pode disparar um Surto de Magia Selvagem a qualquer momento antes do próximo descanso longo para recarregar esta característica.',
  };
}

export async function resolveBastionOfLaw(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
): Promise<SorcererTableActionResult> {
  assertCharacterSubclass(character, 'clockwork', 'Mapeamento Mecânico');
  assertCharacterLevel(character, 6, 'Feiticeiro', 'Baluarte da Ordem');
  const state = await spendPoints(deps, character, 2);

  return {
    state,
    actionName: 'Baluarte da Ordem',
    resourceSpent: true,
    total: 2,
    note: 'Baluarte da Ordem: gastou 2 Pontos de Feitiçaria para conceder 2d8 de dados de proteção a uma criatura a até 9 m. Ao sofrer dano, a criatura pode gastar os dados para reduzir o dano sofrido.',
  };
}
