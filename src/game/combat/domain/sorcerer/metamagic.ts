

import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export const METAMAGIC_OPTION_KEY = 'metamagic';

export type MetamagicCatalogRow = {
  slug: string;
  name: string;
  cost: number;
  description: string;
  stacksWithOther: boolean;
};

export function sorcererMetamagicLimit(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.sorcererMetamagicLimit,
    level,
    0,
  );
}

export type ClassOptionLike = {
  optionKey: string;
  valueId: string;
  instanceIndex?: number;
};

export function readMetamagicPicks(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): { slug: string; instanceIndex: number }[] {
  const picks: { slug: string; instanceIndex: number }[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== METAMAGIC_OPTION_KEY) continue;
    picks.push({
      slug: option.valueId,
      instanceIndex: option.instanceIndex ?? 0,
    });
  }
  return picks.sort((a, b) => a.instanceIndex - b.instanceIndex);
}

export function validateMetamagicPicks(input: {
  level: number;
  picks: readonly { slug: string }[];
  catalog: readonly MetamagicCatalogRow[];
  featureSchedules: readonly FeatureScheduleBand[];
}): string[] {
  const errors: string[] = [];
  const limit = sorcererMetamagicLimit(input.level, input.featureSchedules);
  if (input.picks.length > limit) {
    errors.push(
      `Feiticeiro nível ${input.level} pode ter no máximo ${limit} opção(ões) de Metamagia`,
    );
  }
  const known = new Set(input.catalog.map((row) => row.slug));
  const seen = new Set<string>();
  for (const pick of input.picks) {
    if (!known.has(pick.slug)) {
      errors.push(`Opção de Metamagia desconhecida: '${pick.slug}'`);
      continue;
    }
    if (seen.has(pick.slug)) {
      errors.push(`Metamagia duplicada: '${pick.slug}'`);
    }
    seen.add(pick.slug);
  }
  return errors;
}
