

import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';

export function isWarlockClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'warlock';
}

export function warlockPactSlotLevel(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.warlockPactSlotLevel,
    level,
    1,
  );
}

export function warlockPactSlotCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.warlockPactSlotCount,
    level,
    1,
  );
}

export function magicalCunningSlotRecoveryCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  const max = warlockPactSlotCount(level, bands);
  if (level >= 20) return max;
  return Math.ceil(max / 2);
}

export function warlockInvocationLimit(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.warlockInvocationLimit,
    level,
    0,
  );
}

export const ELDRITCH_INVOCATION_OPTION_KEY = 'eldritch-invocation';
export const ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY =
  'eldritch-invocation-cantrip';

export const ELDRITCH_INVOCATION_ORIGIN_FEAT_OPTION_KEY =
  'eldritch-invocation-origin-feat';

export const LESSONS_OF_THE_FIRST_ONES_SLUG = 'lessons-of-the-first-ones';

export const BLAST_INVOCATION_SLUGS = [
  'agonizing-blast',
  'repelling-blast',
  'eldritch-spear',
] as const;

export type BlastInvocationSlug = (typeof BLAST_INVOCATION_SLUGS)[number];

export function isBlastInvocationSlug(
  slug: string,
): slug is BlastInvocationSlug {
  return (BLAST_INVOCATION_SLUGS as readonly string[]).includes(slug);
}

export function isLessonsOfTheFirstOnesSlug(slug: string): boolean {
  return slug === LESSONS_OF_THE_FIRST_ONES_SLUG;
}

export const MAGICAL_CUNNING_RESOURCE = 'magical-cunning';
export const DARK_ONES_LUCK_RESOURCE = 'dark-ones-luck';
export const FEY_STEPS_RESOURCE = 'fey-steps';
export const HURL_THROUGH_HELL_RESOURCE = 'hurl-through-hell';
export const SEARING_VENGEANCE_RESOURCE = 'searing-vengeance';
export const BEGUILING_DEFENSES_RESOURCE = 'beguiling-defenses';
export const CLAIRVOYANT_COMBATANT_RESOURCE = 'clairvoyant-competitor';

export function healingLightDiceMax(level: number): number {
  return 1 + level;
}
