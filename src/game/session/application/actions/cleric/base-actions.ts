import {
  destroyUndeadDice,
  divineSparkDice,
} from '../../../../combat/domain/cleric-features';
import { rollDamageParts } from '../../../../dice/domain/dice';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import { assertCharacterLevel } from '../../core/table-action-guards';
import type {
  ClericActionDeps,
  ClericTableActionResult,
  PlayerCharacter,
} from './cleric-action-deps';
import {
  assertSubclassFeature,
  spendChannelDivinity,
  spellSaveDc,
} from './cleric-action-deps';

export async function resolveDivineSpark(
  deps: ClericActionDeps,
  character: PlayerCharacter,
  mode: 'heal' | 'damage',
): Promise<ClericTableActionResult> {
  assertCharacterLevel(character, 2, 'Clérigo', 'Centelha Divina');
  const dice = divineSparkDice(character.level);
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const result = rollDamageParts(dice, wisdom);
  const state = await spendChannelDivinity(deps, character);
  const saveDc =
    mode === 'damage' ? await spellSaveDc(deps, character) : undefined;

  return {
    state,
    actionName:
      mode === 'heal' ? 'Centelha Divina — Cura' : 'Centelha Divina — Dano',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    ...(saveDc != null ? { saveDc } : {}),
    note:
      mode === 'heal'
        ? `Centelha Divina: restaure ${result.total} PV (${result.expression}).`
        : `Centelha Divina: CD ${saveDc} de CON; ${result.total} Necrótico ou Radiante (${result.expression}), metade no sucesso.`,
  };
}

export async function resolveTurnUndead(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertCharacterLevel(character, 2, 'Clérigo', 'Expulsar Mortos-Vivos');
  const saveDc = await spellSaveDc(deps, character);
  const state = await spendChannelDivinity(deps, character);

  if (character.level < 5) {
    return {
      state,
      actionName: 'Expulsar Mortos-Vivos',
      saveDc,
      resourceSpent: true,
      note: `Expulsar Mortos-Vivos: CD ${saveDc} de SAB; falha deixa Mortos-Vivos Amedrontados e Incapacitados por 1 minuto (encerra ao sofrer dano).`,
    };
  }

  const dice = destroyUndeadDice(character.abilityScores.sabedoria);
  const result = rollDamageParts(dice, 0);
  return {
    state,
    actionName: 'Expulsar e Fulminar Mortos-Vivos',
    expression: result.expression,
    total: result.total,
    saveDc,
    resourceSpent: true,
    note: `Expulsar Mortos-Vivos + Fulminar: CD ${saveDc} de SAB; na falha, sofre ${result.total} Radiante (${dice}) e fica Amedrontado/Incapacitado.`,
  };
}

export async function resolveDivineIntervention(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertCharacterLevel(character, 10, 'Clérigo', 'Intervenção Divina');
  const state = (
    await deps.state.useClassResource(character, 'divineIntervention', 1)
  ).state;
  return {
    state,
    actionName: 'Intervenção Divina',
    resourceSpent: true,
    note:
      character.level >= 20
        ? 'Intervenção Divina Maior: conjure uma magia de Clérigo de até 5º círculo ou Desejo sem espaço/material. Desejo bloqueia a característica por 2d4 Descansos Longos.'
        : 'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo, sem Reação, espaço ou componente Material.',
  };
}

export async function resolvePreserveLife(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'life',
    'Domínio da Vida',
    'Preservar a Vida',
  );
  const state = await spendChannelDivinity(deps, character);
  /** PHB: Preservar a Vida = 5 × nível de Clérigo. */
  const PRESERVE_LIFE_HP_PER_LEVEL = 5;
  const total = PRESERVE_LIFE_HP_PER_LEVEL * character.level;
  return {
    state,
    actionName: 'Preservar a Vida',
    total,
    resourceSpent: true,
    note: `Preservar a Vida: distribua até ${total} PV entre criaturas Sangrando a 9 m; nenhuma passa da metade dos PV máximos.`,
  };
}
