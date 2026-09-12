import { BadRequestException } from '@nestjs/common';
import type { AdvantageMode } from '@game/dice/domain/dice';
import { readEldritchInvocationPicks } from '@game/combat/domain/warlock/eldritch-invocations/read';
import {
  DEVIL_SIGHT_INVOCATION_SLUG,
  hasMagicalDarkness,
} from './arena-effects';

const ACTION_BLOCKING_CONDITIONS = new Set([
  'incapacitated',
  'stunned',
  'paralyzed',
  'unconscious',
  'petrified',
]);

export function assertCanTakeDuelAction(conditions: readonly string[]): void {
  const blocked = conditions.find((c) => ACTION_BLOCKING_CONDITIONS.has(c));
  if (blocked) {
    throw new BadRequestException(`Cannot act while ${blocked}`);
  }
}

export function characterSeesInMagicalDarkness(input: {
  classOptions: readonly { optionKey: string; valueId: string }[] | null | undefined;
}): boolean {
  return readEldritchInvocationPicks(input.classOptions).some(
    (pick) => pick.slug === DEVIL_SIGHT_INVOCATION_SLUG,
  );
}


export function resolveDuelAttackVisionMode(input: {
  arenaEffects: readonly string[] | null | undefined;
  attackerSeesMagicalDarkness: boolean;
  defenderSeesMagicalDarkness: boolean;
}): AdvantageMode {
  if (!hasMagicalDarkness(input.arenaEffects)) return 'normal';

  const attackerSees = input.attackerSeesMagicalDarkness;
  const defenderSees = input.defenderSeesMagicalDarkness;

  if (attackerSees && !defenderSees) return 'advantage';
  if (!attackerSees && defenderSees) return 'disadvantage';
  return 'normal';
}
