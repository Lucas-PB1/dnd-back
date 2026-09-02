import type { AbilityKey } from '@game/build/domain/ability-generation';
import { RESILIENT_FEAT_SLUG } from '../../../validation/feats/resilient-feat-options';
import { ALERT_FEAT_SLUG, type CharacterFeatLike, type FeatOptionLike } from '../types';

/** Salvaguardas: classe + Resiliente (abilityIncrease). */
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

export function hasAlertFeat(
  characterFeats: readonly CharacterFeatLike[] | undefined,
): boolean {
  return (characterFeats ?? []).some(
    (feat) => feat.featSlug === ALERT_FEAT_SLUG,
  );
}

/** Iniciativa: mod DEX + PB se Alerta. */
export function initiativeBonus(
  dexterityModifier: number,
  proficiencyBonus: number,
  characterFeats: readonly CharacterFeatLike[] | undefined,
): number {
  return (
    dexterityModifier +
    (hasAlertFeat(characterFeats) ? proficiencyBonus : 0)
  );
}
