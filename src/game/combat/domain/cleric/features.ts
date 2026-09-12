import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntOrNullAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export function isClericClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'cleric';
}

export function destroyUndeadDice(wisdomScore: number): string {
  return `${Math.max(1, abilityModifier(wisdomScore))}d8`;
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

export function divineSparkDiceCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return (
    scheduleIntOrNullAtLevel(
      bands,
      FEATURE_SCHEDULE_KEYS.divineSparkDiceCount,
      level,
    ) ?? 1
  );
}
