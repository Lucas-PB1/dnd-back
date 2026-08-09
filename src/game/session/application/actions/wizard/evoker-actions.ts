import { SCULPT_SPELLS_UNLOCK_LEVEL } from '@game/combat/domain/wizard';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  WizardActionDeps,
  WizardTableActionResult,
} from './wizard-action-deps';

export async function resolveSculptSpells(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'evoker', 'Escola de Evocação');
  assertCharacterLevel(
    character,
    SCULPT_SPELLS_UNLOCK_LEVEL,
    'Mago',
    'Esculpir Magias',
  );

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Esculpir Magias',
    resourceSpent: false,
    note: 'Esculpir Magias: escolha até 1 + nível da magia aliados na área de Evocação. Eles passam automaticamente na salvaguarda e não sofrem dano.',
  };
}

export async function resolveOverchannel(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'evoker', 'Escola de Evocação');
  assertCharacterLevel(character, 14, 'Mago', 'Sobrecarga');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Sobrecarga',
    resourceSpent: false,
    note: 'Sobrecarga: ao conjurar magia de Mago com dano (espaço 1º–5º), pode causar dano máximo. 1ª vez no dia sem custo; usos seguintes antes do Descanso Longo causam 2d12 Necrótico por círculo (+1d12 por uso extra), ignorando Resistência/Imunidade.',
  };
}
