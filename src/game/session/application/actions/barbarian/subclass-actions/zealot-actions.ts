import {
  rageDamageBonus,
  zealotHealingDiceCount,
} from '@game/combat/domain/barbarian';
import { rollDamageParts } from '@game/dice/domain/dice';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import { BadRequestException } from '@nestjs/common';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from '../barbarian-action-deps';
import {
  DIVINE_FURY_DICE,
  RAGE_OF_THE_GODS,
  RAGE_RESOURCE,
  ZEALOUS_PRESENCE,
} from '../barbarian-action-deps';

export async function resolveFanaticalFocus(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 6, 'Bárbaro', 'Concentração Fanática');
  const bonus = rageDamageBonus(character.level);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Concentração Fanática',
    total: bonus,
    resourceSpent: false,
    note: `Concentração Fanática (1×/Fúria): ao falhar salvaguarda, rerrole com +${bonus} (bônus de Fúria) e use o novo resultado.`,
  };
}

export async function resolveChampionOfTheGods(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
  diceCount?: number,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Campeão dos Deuses');
  const maxDice = zealotHealingDiceCount(character.level);
  const spent = diceCount ?? 1;
  if (!Number.isInteger(spent) || spent < 1 || spent > maxDice) {
    throw new BadRequestException(
      `Campeão dos Deuses: escolha de 1 a ${maxDice} d12(s)`,
    );
  }
  const result = rollDamageParts(`${spent}d12`, 0);
  const state = (
    await deps.state.useClassResource(character, DIVINE_FURY_DICE, spent)
  ).state;
  return {
    state,
    actionName: 'Campeão dos Deuses',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Campeão dos Deuses: Ação Bônus — recupere ${result.total} PV (${result.expression}). Aplique na ficha.`,
  };
}

export async function resolveZealousPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 10, 'Bárbaro', 'Presença Zelosa');
  const state = (
    await deps.state.useClassResource(character, ZEALOUS_PRESENCE, 1)
  ).state;
  return {
    state,
    actionName: 'Presença Zelosa',
    resourceSpent: true,
    note: 'Presença Zelosa: Ação Bônus — até 10 aliados a 18 m têm Vantagem em ataques e salvaguardas até o início do seu próximo turno. Restaure gastando 1 Fúria.',
  };
}

export async function resolveRestoreZealousPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 10, 'Bárbaro', 'Presença Zelosa');
  await deps.state.useClassResource(character, RAGE_RESOURCE, 1);
  const state = await deps.state.recoverClassResource(
    character,
    ZEALOUS_PRESENCE,
    1,
  );
  return {
    state,
    actionName: 'Restaurar Presença Zelosa',
    resourceSpent: true,
    note: 'Restaurou Presença Zelosa gastando 1 uso de Fúria.',
  };
}

export async function resolveRageOfTheGods(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Fúria dos Deuses');
  const state = (
    await deps.state.useClassResource(character, RAGE_OF_THE_GODS, 1)
  ).state;
  return {
    state,
    actionName: 'Fúria dos Deuses',
    resourceSpent: true,
    note: `Fúria dos Deuses: ao ativar Fúria, forma divina 1 min — Resistência Necrótico/Psíquico/Radiante; Voo; Reação gasta Fúria para manter aliado a 9 m com ${character.level} PV.`,
  };
}
