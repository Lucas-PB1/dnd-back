import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import {
  applyResourceSpend,
} from '../../../session/domain/class-resources';
import { resolveClassResources } from '../../../session/infrastructure/character-state/class-resources';
import type { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import type { CheckRollResult } from '../../domain/dice';

export async function spendStrokeOfLuck(
  dataSource: DataSource,
  character: PlayerCharacter,
): Promise<void> {
  if (character.classSlug !== 'rogue' || character.level < 20) {
    throw new BadRequestException('Stroke of Luck requires Rogue level 20');
  }

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === 'strokeOfLuck');
  if (!resource) {
    throw new BadRequestException('Stroke of Luck is not available');
  }

  const rows = await dataSource.query<
    { resources_used: Record<string, number> }[]
  >(
    `SELECT resources_used
     FROM rpg.player_character_state
     WHERE character_id = $1
     LIMIT 1`,
    [character.id],
  );
  const used = rows[0]?.resources_used ?? {};

  let nextUsed: Record<string, number>;
  try {
    nextUsed = applyResourceSpend(used, resource.slug, resource.max, 1);
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Stroke of Luck',
    );
  }

  await dataSource.query(
    `UPDATE rpg.player_character_state
     SET resources_used = $2::jsonb
     WHERE character_id = $1`,
    [character.id, JSON.stringify(nextUsed)],
  );
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
