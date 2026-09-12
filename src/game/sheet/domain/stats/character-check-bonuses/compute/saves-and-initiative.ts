import type { AbilityKey } from '@game/build/domain/ability-generation';
import { RESILIENT_FEAT_SLUG } from '../../../validation/feats/resilient-feat-options';
import type { FeatOptionLike } from '../types';

export function collectSaveProficiencyAbilities(
  classSavingThrowSlugs: readonly string[],
  featOptions: readonly FeatOptionLike[] | undefined,
): AbilityKey[] {
  const set = new Set<string>(classSavingThrowSlugs);
  for (const option of featOptions ?? []) {
    if (
      option.featSlug === RESILIENT_FEAT_SLUG &&
      option.optionKey === 'abilityIncrease' &&
      option.valueId
    ) {
      set.add(option.valueId);
    }
  }
  return [...set] as AbilityKey[];
}
