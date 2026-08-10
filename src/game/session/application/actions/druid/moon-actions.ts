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
import {
  recoverNamedResource,
  spendNamedResource,
} from './druid-action-deps';

const LUNAR_STEP_SLUG = 'lunar-step';

export async function resolveLunarStep(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'moon', 'Círculo da Lua');
  assertCharacterLevel(character, 10, 'Druida', 'Passo Lunar');
  const state = await spendNamedResource(deps, character, LUNAR_STEP_SLUG);
  const allyNote =
    character.level >= 14
      ? ' L14: também teleporte um aliado voluntário a 3 m.'
      : '';

  return {
    state,
    actionName: 'Passo Lunar',
    resourceSpent: true,
    note: `Passo Lunar: Ação Bônus — teleporte até 9 m; Vantagem no próximo ataque neste turno.${allyNote}`,
  };
}

export async function resolveRestoreLunarStep(
  deps: DruidActionDeps,
  character: PlayerCharacter,
  slotLevel?: number,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'moon', 'Círculo da Lua');
  assertCharacterLevel(character, 10, 'Druida', 'Passo Lunar');
  const level = slotLevel ?? 2;
  if (level < 2) {
    throw new BadRequestException(
      'Restaurar Passo Lunar exige espaço de 2º círculo ou superior',
    );
  }
  await deps.state.consumeSpellSlotLevel(character, level);
  const state = await recoverNamedResource(
    deps,
    character,
    LUNAR_STEP_SLUG,
    1,
  );

  return {
    state,
    actionName: 'Restaurar Passo Lunar',
    resourceSpent: true,
    note: `Restaurou 1 uso de Passo Lunar gastando 1 espaço de ${level}º círculo.`,
  };
}
