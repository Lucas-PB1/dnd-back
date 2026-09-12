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

/** Golpe Divino: N d8 — SSOT `divine_strike_dice_count`. */
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

/** Luz Divina (spark): N d8 — SSOT `divine_spark_dice_count`. */
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
