import { BadRequestException } from '@nestjs/common';
import { AbilityScores } from '../../shared/infrastructure/player-character.entity';

export type AbilityGenerationMethodSlug = 'standard-array' | 'roll' | 'point-buy';

export const STANDARD_ARRAY = [15, 14, 13, 12, 10, 8] as const;

/** Custo PHB point-buy (score final 8–15 antes de bônus raciais). */
export const POINT_BUY_COST: Record<number, number> = {
  8: 0,
  9: 1,
  10: 2,
  11: 3,
  12: 4,
  13: 5,
  14: 7,
  15: 9,
};

export const POINT_BUY_BUDGET = 27;
export const POINT_BUY_MIN = 8;
export const POINT_BUY_MAX = 15;

export type AbilityKey = keyof AbilityScores;

export const ABILITY_KEYS: AbilityKey[] = [
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
];

export function roll4d6DropLowest(rng: () => number = Math.random): number {
  const rolls = Array.from({ length: 4 }, () => 1 + Math.floor(rng() * 6));
  rolls.sort((a, b) => a - b);
  return rolls[1] + rolls[2] + rolls[3];
}

export function rollAbilityScores(rng?: () => number): number[] {
  return Array.from({ length: 6 }, () => roll4d6DropLowest(rng));
}

export function standardArrayScores(): number[] {
  return [...STANDARD_ARRAY];
}

export function validatePointBuy(scores: AbilityScores): void {
  let spent = 0;
  for (const key of ABILITY_KEYS) {
    const value = scores[key];
    if (value < POINT_BUY_MIN || value > POINT_BUY_MAX) {
      throw new BadRequestException(
        `Point-buy scores must be between ${POINT_BUY_MIN} and ${POINT_BUY_MAX}`,
      );
    }
    const cost = POINT_BUY_COST[value];
    if (cost === undefined) {
      throw new BadRequestException(`Invalid point-buy score: ${value}`);
    }
    spent += cost;
  }
  if (spent !== POINT_BUY_BUDGET) {
    throw new BadRequestException(
      `Point-buy must spend exactly ${POINT_BUY_BUDGET} points (spent ${spent})`,
    );
  }
}

export function assignScoresToAbilities(
  values: number[],
  order: AbilityKey[] = ABILITY_KEYS,
): AbilityScores {
  if (values.length !== 6) {
    throw new BadRequestException('Ability generation requires exactly 6 values');
  }
  const result = {} as AbilityScores;
  for (let i = 0; i < 6; i++) {
    result[order[i]] = values[i];
  }
  return result;
}

export function generateAbilityScores(
  method: AbilityGenerationMethodSlug,
  options?: { abilityScores?: AbilityScores; rng?: () => number },
): AbilityScores {
  switch (method) {
    case 'standard-array':
      return assignScoresToAbilities(standardArrayScores());
    case 'roll':
      return assignScoresToAbilities(rollAbilityScores(options?.rng));
    case 'point-buy':
      if (!options?.abilityScores) {
        throw new BadRequestException('Point-buy requires abilityScores in the request body');
      }
      validatePointBuy(options.abilityScores);
      return { ...options.abilityScores };
    default:
      throw new BadRequestException(`Unknown ability generation method: ${method}`);
  }
}
