import { rollDie } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  RogueActionDeps,
  RogueTableActionResult,
} from './rogue-action-deps';
import { psiDieFaces, resolveSoulknifeAction } from './soulknife-helpers';

/** PHB: Teleporte Psíquico = resultado do dado × 3 metros. */
const PSYCHIC_TELEPORT_METERS_PER_FACE = 3;

export async function resolvePsychicWhispers(
  deps: RogueActionDeps,
  character: PlayerCharacter,
  usePsiDie = false,
): Promise<RogueTableActionResult> {
  assertCharacterLevel(character, 3, 'Rogue', 'Psychic Whispers');
  const faces = psiDieFaces(character);
  const dieRoll = rollDie(faces);
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const tableAction = await resolveSoulknifeAction(
    deps,
    character,
    'psychic-whispers',
    { dieRoll, usePsiDice: usePsiDie },
  );
  const state = (
    await deps.state.useClassResource(
      character,
      tableAction.resourceSlug ?? 'psychic-whispers',
      tableAction.psiDiceCost || 1,
    )
  ).state;

  return {
    state,
    actionName: 'Sussurros Psíquicos',
    expression: `1d${faces}`,
    roll: dieRoll,
    total: dieRoll,
    resourceSpent: true,
    note: `Sussurros Psíquicos: conecte até ${pb} criaturas por ${dieRoll} hora(s). ${usePsiDie ? 'Dado psi gasto.' : 'Uso gratuito gasto.'}`,
  };
}

export async function resolvePsychicTeleport(
  deps: RogueActionDeps,
  character: PlayerCharacter,
): Promise<RogueTableActionResult> {
  assertCharacterLevel(character, 9, 'Rogue', 'Psychic Teleportation');
  const faces = psiDieFaces(character);
  const dieRoll = rollDie(faces);
  const tableAction = await resolveSoulknifeAction(
    deps,
    character,
    'psychic-teleport',
    { dieRoll },
  );
  const state = (
    await deps.state.useClassResource(
      character,
      tableAction.resourceSlug ?? 'soulknife-psi-dice',
      tableAction.psiDiceCost,
    )
  ).state;
  const rangeMeters = dieRoll * PSYCHIC_TELEPORT_METERS_PER_FACE;

  return {
    state,
    actionName: 'Teleporte Psíquico',
    expression: `1d${faces}`,
    roll: dieRoll,
    total: rangeMeters,
    resourceSpent: true,
    note: `Teleporte Psíquico: teleporte-se até ${rangeMeters} m para um espaço visível e desocupado.`,
  };
}

export async function resolvePsychicVeil(
  deps: RogueActionDeps,
  character: PlayerCharacter,
  usePsiDie = false,
): Promise<RogueTableActionResult> {
  assertCharacterLevel(character, 13, 'Rogue', 'Psychic Veil');
  const tableAction = await resolveSoulknifeAction(
    deps,
    character,
    'psychic-veil',
    { usePsiDice: usePsiDie },
  );
  const state = (
    await deps.state.useClassResource(
      character,
      tableAction.resourceSlug ?? 'psychic-veil',
      tableAction.psiDiceCost || 1,
    )
  ).state;
  return {
    state,
    actionName: 'Véu Psíquico',
    resourceSpent: true,
    note: `Véu Psíquico: Invisível por 1 hora, até causar dano/forçar salvaguarda ou encerrar. ${usePsiDie ? 'Dado psi gasto.' : 'Uso gratuito gasto.'}`,
  };
}

export async function resolveRendMind(
  deps: RogueActionDeps,
  character: PlayerCharacter,
  usePsiDie = false,
): Promise<RogueTableActionResult> {
  assertCharacterLevel(character, 17, 'Rogue', 'Rend Mind');
  const tableAction = await resolveSoulknifeAction(
    deps,
    character,
    'rend-mind',
    { usePsiDice: usePsiDie },
  );
  const state = (
    await deps.state.useClassResource(
      character,
      tableAction.resourceSlug ?? 'rend-mind',
      tableAction.psiDiceCost || 1,
    )
  ).state;
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const saveDc = 8 + abilityModifier(character.abilityScores.destreza) + pb;
  return {
    state,
    actionName: 'Rasgar Mente',
    saveDc,
    resourceSpent: true,
    note: `Rasgar Mente: após Ataque Furtivo com Lâmina Psíquica, salvaguarda SAB CD ${saveDc}; falha = Atordoado. ${usePsiDie ? '3 dados psi gastos.' : 'Uso gratuito gasto.'}`,
  };
}
