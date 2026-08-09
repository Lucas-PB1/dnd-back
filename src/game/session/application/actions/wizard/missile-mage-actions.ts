import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  WizardActionDeps,
  WizardTableActionResult,
} from './wizard-action-deps';

export async function resolveMissileFlag(
  deps: WizardActionDeps,
  character: PlayerCharacter,
  kind: 'shield' | 'giga',
  armed: boolean,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'magic-missile-mage', 'Mago dos Mísseis');
  if (kind === 'shield') {
    assertCharacterLevel(character, 10, 'Mago', 'Escudo de Mísseis');
  } else {
    assertCharacterLevel(character, 14, 'Mago', 'Giga-Míssil');
  }

  const state = await deps.state.setMissileMageArmedFlags(character, {
    missileShieldArmed: kind === 'shield' ? armed : undefined,
    gigaMissileArmed: kind === 'giga' ? armed : undefined,
  });

  const label = kind === 'shield' ? 'Escudo de Mísseis' : 'Giga-Míssil';
  return {
    state: await deps.state.buildResponse(character, state),
    actionName: label,
    resourceSpent: false,
    note: armed
      ? `${label} armado: aplica no próximo Mísseis Mágicos (gasta o uso no cast).`
      : `${label} desarmado.`,
  };
}
