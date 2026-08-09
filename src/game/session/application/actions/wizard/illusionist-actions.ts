import {
  ILLUSORY_SELF_RESOURCE,
  SPECTRAL_SUMMON_RESOURCE,
} from '@game/combat/domain/wizard';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  WizardActionDeps,
  WizardTableActionResult,
} from './wizard-action-deps';

export async function resolveImprovedIllusions(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
  assertCharacterLevel(character, 3, 'Mago', 'Ilusão Aprimorada');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Ilusão Aprimorada',
    resourceSpent: false,
    note: 'Ilusão Aprimorada: conjure truques de Ilusão e Imagem Silenciosa como Ação Bônus sem componentes V e com o dobro do alcance.',
  };
}

export async function resolveSpectralSummon(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
  assertCharacterLevel(character, 6, 'Mago', 'Criaturas Espectrais');
  const state = (
    await deps.state.useClassResource(character, SPECTRAL_SUMMON_RESOURCE, 1)
  ).state;

  return {
    state,
    actionName: 'Criaturas Espectrais',
    resourceSpent: true,
    note: 'Criaturas Espectrais: Ação — Convocar Feérico ou Invocar Fera (versão Ilusão) sem espaço; PV da criatura pela metade. Recupera no Descanso Longo.',
  };
}

export async function resolveIllusorySelf(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
  assertCharacterLevel(character, 10, 'Mago', 'Autoimagem Ilusória');
  const state = (
    await deps.state.useClassResource(character, ILLUSORY_SELF_RESOURCE, 1)
  ).state;

  return {
    state,
    actionName: 'Autoimagem Ilusória',
    resourceSpent: true,
    note: 'Autoimagem Ilusória: Reação ao ser atingido — o ataque erra. Restaure no Descanso Curto/Longo ou gastando um espaço de 2º+ (sem ação).',
  };
}

export async function resolveIllusoryReality(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
  assertCharacterLevel(character, 14, 'Mago', 'Realidade Ilusória');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Realidade Ilusória',
    resourceSpent: false,
    note: 'Realidade Ilusória: Ação Bônus — enquanto uma Ilusão conjurada com espaço estiver ativa, torne real 1 objeto inanimado não mágico dela por 1 minuto (não causa dano nem condições).',
  };
}
