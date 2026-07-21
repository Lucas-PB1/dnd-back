import { BadRequestException } from '@nestjs/common';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { FeatOptionDto } from '../dto/character-sheet.dto';
import {
  ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
  ASI_DISTRIBUTION_PLUS1PLUS1,
  ASI_DISTRIBUTION_PLUS2,
} from './ability-score-improvement-feat-options';
import {
  STANDARD_ABILITY_SCORE_CAP,
  abilityScoreCapForFeat,
} from './epic-boon-feat-options';

export type FeatAbilityIncreaseContext = {
  epicBoonFeatSlugs?: ReadonlySet<string>;
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

function bumpAbility(
  scores: AbilityScores,
  slug: string,
  delta: number,
  cap: number,
): AbilityScores {
  const key = abilityKey(slug);
  return {
    ...scores,
    [key]: Math.min(cap, scores[key] + delta),
  };
}

function asiInstanceKeys(featOptions: FeatOptionDto[]): string[] {
  const keys = new Set<string>();
  for (const option of featOptions) {
    if (option.featSlug !== ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG) continue;
    keys.add(`${option.featSlug}:${option.instanceIndex ?? 0}`);
  }
  return [...keys];
}

function applyAbilityScoreImprovementInstance(
  scores: AbilityScores,
  instanceOptions: FeatOptionDto[],
): AbilityScores {
  const mode = instanceOptions.find((o) => o.optionKey === 'distributionMode')?.valueId;
  const primary = instanceOptions.find((o) => o.optionKey === 'primaryAbility')?.valueId;
  if (!mode || !primary?.trim()) return scores;

  if (mode === ASI_DISTRIBUTION_PLUS2) {
    return bumpAbility(scores, primary.trim(), 2, STANDARD_ABILITY_SCORE_CAP);
  }
  if (mode === ASI_DISTRIBUTION_PLUS1PLUS1) {
    const secondary = instanceOptions.find(
      (o) => o.optionKey === 'secondaryAbility',
    )?.valueId;
    if (!secondary?.trim()) return scores;
    let next = bumpAbility(scores, primary.trim(), 1, STANDARD_ABILITY_SCORE_CAP);
    next = bumpAbility(next, secondary.trim(), 1, STANDARD_ABILITY_SCORE_CAP);
    return next;
  }
  return scores;
}

/** +1 (abilityIncrease) e ASI do talento Aumento no Valor de Atributo. */
export function applyFeatAbilityIncreases(
  scores: AbilityScores,
  featOptions: FeatOptionDto[] | undefined,
  context: FeatAbilityIncreaseContext = {},
): AbilityScores {
  if (!featOptions?.length) return scores;

  let result = { ...scores };

  for (const key of asiInstanceKeys(featOptions)) {
    const [featSlug, indexStr] = key.split(':');
    const instanceIndex = Number.parseInt(indexStr, 10);
    const instanceOptions = featOptions.filter(
      (o) =>
        o.featSlug === featSlug &&
        (o.instanceIndex ?? 0) === instanceIndex,
    );
    result = applyAbilityScoreImprovementInstance(result, instanceOptions);
  }

  for (const option of featOptions) {
    if (option.optionKey !== 'abilityIncrease' || !option.valueId?.trim()) {
      continue;
    }
    const cap = abilityScoreCapForFeat(
      option.featSlug,
      context.epicBoonFeatSlugs,
    );
    result = bumpAbility(result, option.valueId.trim(), 1, cap);
  }
  return result;
}
