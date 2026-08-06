import { martialArtsDie } from '../../../../combat/domain/monk-features';
import { assertCharacterLevel } from '../../core/table-action-guards';
import type {
  MonkActionDeps,
  MonkTableActionResult,
  PlayerCharacter,
} from './monk-action-deps';
import { focusDc, spendFocus } from './monk-action-deps';

export async function resolveFlurryOfBlows(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterLevel(character, 2, 'Monk', 'Torrente de Golpes');
  const strikes = character.level >= 10 ? 3 : 2;
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Torrente de Golpes',
    resourceSpent: true,
    note: `Torrente de Golpes: gaste 1 Foco para fazer ${strikes} Ataques Desarmados como Ação Bônus (${martialArtsDie(
      character.level,
    )} cada).`,
  };
}

export async function resolvePatientDefense(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterLevel(character, 2, 'Monk', 'Defesa Paciente');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Defesa Paciente',
    resourceSpent: true,
    note: 'Defesa Paciente: gaste 1 Foco para usar Esquivar e Desengajar como Ação Bônus (Desengajar é gratuito sem gastar Foco).',
  };
}

export async function resolveStepOfTheWind(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterLevel(character, 2, 'Monk', 'Passo do Vento');
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Passo do Vento',
    resourceSpent: true,
    note: 'Passo do Vento: gaste 1 Foco para usar Disparar e Desengajar como Ação Bônus; distância de salto dobra neste turno.',
  };
}

export async function resolveStunningStrike(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterLevel(character, 5, 'Monk', 'Golpe Atordoante');
  const saveDc = await focusDc(deps, character);
  const state = await spendFocus(deps, character, 1);
  return {
    state,
    actionName: 'Golpe Atordoante',
    saveDc,
    resourceSpent: true,
    note: `Golpe Atordoante: no acerto, gaste 1 Foco; o alvo faz salvaguarda de Constituição CD ${saveDc}. Falha = Atordoado até o fim do seu próximo turno; sucesso = metade do Deslocamento e Vantagem no seu próximo ataque contra ele.`,
  };
}
