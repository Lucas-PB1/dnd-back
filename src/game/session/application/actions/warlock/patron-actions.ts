import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type { WarlockTableActionResult } from './warlock-action-deps';
import type { PlayerCharacter, WarlockActionDeps } from './warlock-action-deps';

export async function resolveFeyStepEffect(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'archfey', 'Patrono Arquifada');
  assertCharacterLevel(character, 3, 'Bruxo', 'Passo de Bruma Aprimorado');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Passo de Bruma Aprimorado',
    resourceSpent: false,
    note: 'Passo de Bruma Aprimorado: ao teletransportar-se com Passo de Bruma, aplique um efeito de Passo Feérico (Provocar, Desorientar, Invisibilidade ou Refrancar).',
  };
}

export async function resolveAwakenedMind(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'great-old-one', 'Patrono Grande Antigo');
  assertCharacterLevel(character, 3, 'Bruxo', 'Mente Desperta');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Mente Desperta',
    resourceSpent: false,
    note: 'Mente Desperta: estabeleça elo telepático a 9 m. Suas magias do Hex/Maldição causam dano Psíquico e impõem Desvantagem.',
  };
}

export async function resolveFiendishResilience(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'fiend', 'Patrono Ínfero');
  assertCharacterLevel(character, 10, 'Bruxo', 'Resiliência Ínfera');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Resiliência Ínfera',
    resourceSpent: false,
    note: 'Resiliência Ínfera: escolha um tipo de dano após um descanso curto ou longo para ganhar Resistência a ele (armas mágicas ou de prata ignoram a resistência).',
  };
}
