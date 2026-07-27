import { BadRequestException } from '@nestjs/common';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

const ABILITY_SCORE_CAP = 20;

export const BACKGROUND_BOOST_MODE_PLUS2_PLUS1 = 'plus2plus1' as const;
export const BACKGROUND_BOOST_MODE_PLUS1X3 = 'plus1x3' as const;

export type BackgroundBoostMode =
  | typeof BACKGROUND_BOOST_MODE_PLUS2_PLUS1
  | typeof BACKGROUND_BOOST_MODE_PLUS1X3;

export type BackgroundAbilityBoostInput =
  | {
      mode: typeof BACKGROUND_BOOST_MODE_PLUS2_PLUS1;
      plus2Slug: string;
      plus1Slug: string;
    }
  | {
      mode: typeof BACKGROUND_BOOST_MODE_PLUS1X3;
      plus1Slugs: string[];
    };

const ABILITY_KEYS: (keyof AbilityScores)[] = [
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
];

function abilityKey(slug: string): keyof AbilityScores {
  if (!ABILITY_KEYS.includes(slug as keyof AbilityScores)) {
    throw new BadRequestException(`Invalid ability slug '${slug}'`);
  }
  return slug as keyof AbilityScores;
}

function bump(
  scores: AbilityScores,
  slug: string,
  amount: number,
): AbilityScores {
  const key = abilityKey(slug);
  return {
    ...scores,
    [key]: Math.min(ABILITY_SCORE_CAP, scores[key] + amount),
  };
}

export function applyBackgroundAbilityBoosts(
  base: AbilityScores,
  boosts: BackgroundAbilityBoostInput,
): AbilityScores {
  if (boosts.mode === BACKGROUND_BOOST_MODE_PLUS1X3) {
    assertDistinctPlus1x3(boosts.plus1Slugs);
    return boosts.plus1Slugs.reduce(
      (scores, slug) => bump(scores, slug, 1),
      { ...base },
    );
  }

  if (boosts.plus2Slug === boosts.plus1Slug) {
    throw new BadRequestException(
      'Background +2 and +1 must be applied to different abilities',
    );
  }

  return bump(bump(base, boosts.plus2Slug, 2), boosts.plus1Slug, 1);
}

function assertDistinctPlus1x3(slugs: string[]): void {
  if (slugs.length !== 3) {
    throw new BadRequestException(
      'Background +1×3 requires exactly three ability slugs',
    );
  }
  if (new Set(slugs).size !== 3) {
    throw new BadRequestException(
      'Background +1×3 must target three different abilities',
    );
  }
}

export function assertBackgroundBoostSlugsAllowed(
  allowedSlugs: string[],
  boosts: BackgroundAbilityBoostInput,
): void {
  if (allowedSlugs.length === 0) {
    throw new BadRequestException('Background has no ability boost options');
  }

  if (boosts.mode === BACKGROUND_BOOST_MODE_PLUS1X3) {
    assertDistinctPlus1x3(boosts.plus1Slugs);
    for (const slug of boosts.plus1Slugs) {
      if (!slug?.trim()) {
        throw new BadRequestException(
          'Background +1×3 requires three ability selections',
        );
      }
      if (!allowedSlugs.includes(slug)) {
        throw new BadRequestException(
          `Ability '${slug}' is not a valid boost option for this background`,
        );
      }
    }
    return;
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

/** Normaliza payload parcial da API para o input de domínio. */
export function resolveBackgroundAbilityBoostInput(input: {
  mode?: string | null;
  plus2Slug?: string | null;
  plus1Slug?: string | null;
  plus1Slugs?: string[] | null;
}): BackgroundAbilityBoostInput {
  const mode =
    input.mode === BACKGROUND_BOOST_MODE_PLUS1X3
      ? BACKGROUND_BOOST_MODE_PLUS1X3
      : BACKGROUND_BOOST_MODE_PLUS2_PLUS1;

  if (mode === BACKGROUND_BOOST_MODE_PLUS1X3) {
    const fromArray = (input.plus1Slugs ?? [])
      .map((slug) => slug?.trim())
      .filter((slug): slug is string => !!slug);
    return { mode, plus1Slugs: fromArray };
  }

  return {
    mode,
    plus2Slug: input.plus2Slug?.trim() ?? '',
    plus1Slug: input.plus1Slug?.trim() ?? '',
  };
}
