import {
  rageDamageBonus,
  zealotHealingDiceCount,
} from '@game/combat/domain/barbarian';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
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
} from '../barbarian-action-deps';

export async function resolveFanaticalFocus(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 6, 'Bárbaro', 'Concentração Fanática');

  const catalog = await deps.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const bonus = rageDamageBonus(character.level, bands);

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

  const catalog = await deps.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const maxDice = zealotHealingDiceCount(character.level, bands);
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
