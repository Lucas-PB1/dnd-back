import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntOrNullAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export function isClericClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'cleric';
}

export function divineStrikeDice(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string | null {
  const count = scheduleIntOrNullAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.divineStrikeDiceCount,
    level,
  );
  return count == null || count < 1 ? null : `${count}d8`;
}
