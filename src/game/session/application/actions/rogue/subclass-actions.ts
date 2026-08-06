import { rollDie } from '../../../../dice/domain/dice';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../core/table-action-guards';
import type {
  PlayerCharacter,
  RogueActionDeps,
  RogueTableActionResult,
} from './rogue-action-deps';

export async function resolveSpellThief(
  deps: RogueActionDeps,
  character: PlayerCharacter,
): Promise<RogueTableActionResult> {
  assertCharacterSubclass(character, 'arcane-trickster', 'Arcane Trickster');
  assertCharacterLevel(character, 17, 'Rogue', 'Spell Thief');
  const state = (
    await deps.state.useClassResource(character, 'spell-thief', 1)
  ).state;
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const saveDc =
    8 + abilityModifier(character.abilityScores.inteligencia) + pb;
  return {
    state,
    actionName: 'Ladrão de Magias',
    saveDc,
    resourceSpent: true,
    note: `Ladrão de Magias: o conjurador faz salvaguarda INT CD ${saveDc}; falha nega a magia e permite prepará-la conforme a característica.`,
  };
}

export async function resolveArachnoidWeb(
  deps: RogueActionDeps,
  character: PlayerCharacter,
): Promise<RogueTableActionResult> {
  assertCharacterSubclass(character, 'arachnoid-stalker', 'Arachnid Stalker');
  assertCharacterLevel(character, 3, 'Rogue', 'Webbing');
  const state = (
    await deps.state.useClassResource(character, 'arachnoid-web', 1)
  ).state;
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const saveDc = 8 + abilityModifier(character.abilityScores.destreza) + pb;
  return {
    state,
    actionName: 'Correia',
    saveDc,
    resourceSpent: true,
    note: `Correia: escolha puxar-se, balançar ou prender conforme a característica. CD ${saveDc} quando houver salvaguarda; aplique posição/teia na mesa.`,
  };
}

export async function resolveMagicDeviceCharge(
  deps: RogueActionDeps,
  character: PlayerCharacter,
): Promise<RogueTableActionResult> {
  assertCharacterSubclass(character, 'thief', 'Thief');
  assertCharacterLevel(character, 13, 'Rogue', 'Use Magic Device');
  const dieRoll = rollDie(6);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Usar Dispositivo Mágico — Cargas',
    expression: '1d6',
    roll: dieRoll,
    total: dieRoll,
    resourceSpent: false,
    note:
      dieRoll === 6
        ? 'Usar Dispositivo Mágico: resultado 6; a propriedade não gasta cargas.'
        : 'Usar Dispositivo Mágico: a propriedade gasta as cargas normalmente.',
  };
}
