import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export function isBardClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'bard';
}

export function bardicInspirationDie(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string {
  const faces = scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.bardicInspirationDieFaces,
    level,
    6,
  );
  return `d${faces}`;
}

export function bardicInspirationMaxUses(charismaScore: number): number {
  return Math.max(1, abilityModifier(charismaScore));
}

export function bardicInspirationRestRecovery(level: number): 'short' | 'long' {
  return level >= 5 ? 'short' : 'long';
}
