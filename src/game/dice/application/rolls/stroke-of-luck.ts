import { BadRequestException } from '@nestjs/common';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CheckRollResult } from '@game/dice/domain/dice';

export async function spendStrokeOfLuck(
  spender: CharacterResourceSpender,
  character: PlayerCharacter,
): Promise<void> {
  if (character.classSlug !== 'rogue' || character.level < 20) {
    throw new BadRequestException('Stroke of Luck requires Rogue level 20');
  }

  try {
    await spender.spendClassResource(character, 'strokeOfLuck', 1);
  } catch (error) {
    if (error instanceof BadRequestException) {
      const response = error.getResponse();
      const text =
        typeof response === 'string'
          ? response
          : Array.isArray((response as { message?: unknown }).message)
            ? ((response as { message: string[] }).message).join(' ')
            : String((response as { message?: unknown }).message ?? '');
      if (/strokeOfLuck|not available/i.test(text)) {
        throw new BadRequestException('Stroke of Luck is not available');
      }
    }
    throw error;
  }
}

export function turnCheckIntoNaturalTwenty(
  result: CheckRollResult,
): CheckRollResult {
  return {
    ...result,
    expression: `20${formatSigned(result.modifier)} (Golpe de Sorte)`,
    total: 20 + result.modifier,
    d20: {
      ...result.d20,
      rolls: [...result.d20.rolls, 20],
      kept: [20],
    },
  };
}

function formatSigned(value: number): string {
  if (value === 0) return '';
  return value > 0 ? `+${value}` : String(value);
}

/** Aplica Golpe de Sorte quando solicitado no DTO, mutando notes. */
export async function applyStrokeOfLuckIfRequested(input: {
  requested: boolean | undefined;
  spender: CharacterResourceSpender;
  character: PlayerCharacter;
  result: CheckRollResult;
  notes: string[];
}): Promise<CheckRollResult> {
  if (!input.requested) {
    return input.result;
  }
  await spendStrokeOfLuck(input.spender, input.character);
  input.notes.push('Golpe de Sorte: resultado do d20 transformado em 20');
  return turnCheckIntoNaturalTwenty(input.result);
}
