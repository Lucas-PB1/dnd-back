/**
 * Máscaras do Colégio das Máscaras — validação.
 * Contagens: SSOT `phb_class_feature_schedule` (college-of-masks).
 * Catálogo de slugs: `rpg.phb_persona_mask`.
 */

import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export type PersonaMaskSlug = string;

/** Máscaras equipadas simultaneamente — SSOT `persona_masks_equipped`. */
export function maxEquippedPersonaMasks(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.personaMasksEquipped,
    level,
    1,
  );
}

/** Máscaras conhecidas — SSOT `persona_masks_known`. */
export function knownPersonaMaskCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.personaMasksKnown,
    level,
    3,
  );
}

export function isPersonaMaskSlug(
  catalogSlugs: readonly string[],
  slug: string,
): boolean {
  return catalogSlugs.includes(slug);
}

/**
 * Valida máscaras equipadas na mesa: slugs do catálogo, sem duplicata, até o máximo do nível.
 */
export function assertValidPersonaMasks(
  catalogSlugs: readonly string[],
  masks: string[],
  level: number,
  bands: readonly FeatureScheduleBand[],
): void {
  const max = maxEquippedPersonaMasks(level, bands);
  if (masks.length > max) {
    throw new Error(
      `College of Masks allows at most ${max} equipped mask(s) at level ${level}`,
    );
  }

  const seen = new Set<string>();
  for (const mask of masks) {
    if (!isPersonaMaskSlug(catalogSlugs, mask)) {
      throw new Error(`Unknown persona mask '${mask}'`);
    }
    if (seen.has(mask)) {
      throw new Error(`Duplicate persona mask '${mask}'`);
    }
    seen.add(mask);
  }
}
