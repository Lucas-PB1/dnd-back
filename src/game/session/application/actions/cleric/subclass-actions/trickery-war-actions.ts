import type {
  ClericActionDeps,
  ClericTableActionResult,
  PlayerCharacter,
} from '../cleric-action-deps';
import {
  assertSubclassFeature,
  spendChannelDivinity,
} from '../cleric-action-deps';

export async function resolveTrickstersBlessing(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'trickery',
    'Domínio da Trapaça',
    'Bênção do Trapaceiro',
  );
  const state = (
    await deps.state.useClassResource(character, 'tricksters-blessing', 1)
  ).state;
  return {
    state,
    actionName: 'Bênção do Trapaceiro',
    resourceSpent: true,
    note: 'Bênção do Trapaceiro: você ou uma criatura voluntária a 9 m recebe Vantagem em Furtividade até o Descanso Longo ou uma nova bênção.',
  };
}

export async function resolveInvokeDuplicity(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'trickery',
    'Domínio da Trapaça',
    'Invocar Duplicidade',
  );
  const state = await spendChannelDivinity(deps, character);
  return {
    state,
    actionName: 'Invocar Duplicidade',
    resourceSpent: true,
    note: 'Invocar Duplicidade: Ação Bônus cria a ilusão por 1 minuto. Conjure a partir dela e obtenha Vantagem contra criaturas distraídas.',
  };
}

export async function resolveGuidedStrike(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'war',
    'Domínio da Guerra',
    'Ataque Direcionado',
  );
  const state = await spendChannelDivinity(deps, character);
  /** PHB: Ataque Direcionado concede +10 à jogada. */
  const GUIDED_STRIKE_ATTACK_BONUS = 10;
  return {
    state,
    actionName: 'Ataque Direcionado',
    total: GUIDED_STRIKE_ATTACK_BONUS,
    resourceSpent: true,
    note: 'Ataque Direcionado: some +10 à jogada de ataque que errou, potencialmente transformando-a em acerto.',
  };
}

export async function resolveWarPriest(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'war',
    'Domínio da Guerra',
    'Sacerdote da Guerra',
  );
  const state = (
    await deps.state.useClassResource(character, 'war-priest', 1)
  ).state;
  return {
    state,
    actionName: 'Sacerdote da Guerra',
    resourceSpent: true,
    note: 'Sacerdote da Guerra: use uma Ação Bônus para realizar um ataque com arma ou Ataque Desarmado.',
  };
}

export async function resolveWarGodsBlessing(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'war',
    'Domínio da Guerra',
    'Bênção do Deus da Guerra',
    6,
  );
  const state = await spendChannelDivinity(deps, character);
  return {
    state,
    actionName: 'Bênção do Deus da Guerra',
    resourceSpent: true,
    note: 'Bênção do Deus da Guerra: conjure Arma Espiritual ou Escudo da Fé sem espaço; não requer Concentração e dura até 1 minuto.',
  };
}
