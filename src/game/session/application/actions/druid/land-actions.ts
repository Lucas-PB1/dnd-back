import { landAidDice } from '@game/combat/domain/druid';
import { rollDamageParts } from '@game/dice/domain/dice';
import { BadRequestException } from '@nestjs/common';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from './druid-action-deps';
import { spendWildShape } from './druid-action-deps';

export async function resolveLandAid(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'land', 'Círculo da Terra');
  assertCharacterLevel(character, 3, 'Druida', 'Auxílio da Terra');
  const dice = landAidDice(character.level);
  const damage = rollDamageParts(`${dice}d6`, 0);
  const heal = rollDamageParts(`${dice}d6`, 0);
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Auxílio da Terra',
    expression: `${damage.expression} / ${heal.expression}`,
    total: damage.total,
    resourceSpent: true,
    note: `Auxílio da Terra: Esfera 3 m a até 18 m. Salvaguarda CON — ${damage.total} Necrótico (${damage.expression}) ou metade. Uma criatura à escolha recupera ${heal.total} PV (${heal.expression}).`,
  };
}

export async function resolveNatureSanctuary(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'land', 'Círculo da Terra');
  assertCharacterLevel(character, 14, 'Druida', 'Santuário Natural');
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Santuário Natural',
    resourceSpent: true,
    note: 'Santuário Natural: Cubo 4,5 m a até 36 m por 1 min — você e aliados têm Cobertura Parcial; aliados ganham sua Resistência de Proteção Natural. Ação Bônus: mover o cubo até 18 m.',
  };
}

/** Como Recuperação Arcana do Mago: recupera 1 slot; limite de soma = mesa (± `natural-recovery`). */
export async function resolveNaturalRecovery(
  deps: DruidActionDeps,
  character: PlayerCharacter,
  slotLevel: number,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'land', 'Círculo da Terra');
  assertCharacterLevel(character, 6, 'Druida', 'Recuperação Natural');
  if (slotLevel < 1 || slotLevel > 5) {
    throw new BadRequestException(
      'Recuperação Natural: escolha um espaço de 1º a 5º círculo',
    );
  }
  const maxCircles = Math.ceil(character.level / 2);
  if (slotLevel > maxCircles) {
    throw new BadRequestException(
      `Recuperação Natural: no nível ${character.level} a soma máxima é ${maxCircles} círculos`,
    );
  }

  await deps.state.recoverSpellSlotLevel(character, slotLevel);
  const state = await deps.state.buildResponse(character);

  return {
    state,
    actionName: `Recuperação Natural (Slot ${slotLevel}º)`,
    resourceSpent: true,
    note: `Recuperação Natural: recuperou 1 Slot de ${slotLevel}º círculo no Descanso Curto (soma de círculos ≤ ${maxCircles}, sem 6+; 1×/DL — marque ± natural-recovery).`,
  };
}
