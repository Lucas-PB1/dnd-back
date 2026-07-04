import { BadRequestException } from '@nestjs/common';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

const ABILITY_SCORE_CAP = 20;

export type BackgroundAbilityBoostInput = {
  plus2Slug: string;
  plus1Slug: string;
};

function abilityKey(slug: string): keyof AbilityScores {
  const keys: (keyof AbilityScores)[] = [
    'forca',
    'destreza',
    'constituicao',
    'inteligencia',
    'sabedoria',
    'carisma',
  ];
  if (!keys.includes(slug as keyof AbilityScores)) {
    throw new BadRequestException(`Invalid ability slug '${slug}'`);
  }
  return slug as keyof AbilityScores;
}

export function applyBackgroundAbilityBoosts(
  base: AbilityScores,
  boosts: BackgroundAbilityBoostInput,
): AbilityScores {
  if (boosts.plus2Slug === boosts.plus1Slug) {
    throw new BadRequestException(
      'Background +2 and +1 must be applied to different abilities',
    );
  }

  const plus2Key = abilityKey(boosts.plus2Slug);
  const plus1Key = abilityKey(boosts.plus1Slug);

  return {
    ...base,
    [plus2Key]: Math.min(ABILITY_SCORE_CAP, base[plus2Key] + 2),
    [plus1Key]: Math.min(ABILITY_SCORE_CAP, base[plus1Key] + 1),
  };
}

export function assertBackgroundBoostSlugsAllowed(
  allowedSlugs: string[],
  boosts: BackgroundAbilityBoostInput,
): void {
  if (allowedSlugs.length === 0) {
    throw new BadRequestException('Background has no ability boost options');
  }

  if (!boosts.plus2Slug?.trim() || !boosts.plus1Slug?.trim()) {
    throw new BadRequestException(
      'Background ability boosts (+2 and +1) are required',
    );
  }

  if (boosts.plus2Slug === boosts.plus1Slug) {
    throw new BadRequestException(
      'Background +2 and +1 must target different abilities',
    );
  }

  for (const slug of [boosts.plus2Slug, boosts.plus1Slug]) {
    if (!allowedSlugs.includes(slug)) {
      throw new BadRequestException(
        `Ability '${slug}' is not a valid boost option for this background`,
      );
    }
  }
}
