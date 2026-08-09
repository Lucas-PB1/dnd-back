import { abjurerArcaneWardHp } from '@game/combat/domain/wizard';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  WizardActionDeps,
  WizardTableActionResult,
} from './wizard-action-deps';

export async function resolveArcaneWard(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
  assertCharacterLevel(character, 3, 'Mago', 'Proteção Arcana');
  const intMod = abilityModifier(character.abilityScores.inteligencia);
  const hp = abjurerArcaneWardHp(character.level, intMod);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Proteção Arcana',
    resourceSpent: false,
    total: hp,
    note: `Proteção Arcana: barreira mágica com ${hp} PV temporários ativa. Absorve dano sofrido e recarrega ao conjurar magias de Abjuração.`,
  };
}

export async function resolveArcaneWardRecharge(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
  assertCharacterLevel(character, 3, 'Mago', 'Proteção Arcana');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Recarregar Proteção Arcana',
    resourceSpent: false,
    note: 'Recarregar Proteção: Ação Bônus — gaste 1 espaço de magia; a Proteção recupera PV iguais ao dobro do círculo do espaço.',
  };
}

export async function resolveProjectedWard(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
  assertCharacterLevel(character, 6, 'Mago', 'Proteção Projetada');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Proteção Projetada',
    resourceSpent: false,
    note: 'Proteção Projetada: Reação — quando uma criatura à sua vista a até 9 m sofrer dano, sua Proteção Arcana pode absorvê-lo no lugar dela.',
  };
}

export async function resolveSpellBreaker(
  deps: WizardActionDeps,
  character: PlayerCharacter,
): Promise<WizardTableActionResult> {
  assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
  assertCharacterLevel(character, 10, 'Mago', 'Rompe-Magia');
  const pb = await deps.domain.getProficiencyBonus(character.level);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Rompe-Magia',
    resourceSpent: false,
    note: `Rompe-Magia: Dissipar Magia como Ação Bônus; some +${pb} (PB) ao teste. Contramagia e Dissipar sempre preparadas; se falharem ao interromper, o espaço não é gasto.`,
  };
}
