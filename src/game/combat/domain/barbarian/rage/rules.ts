

import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  scheduleIntOrNullAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';
import { meetsFeatureGate } from '../../feature-gates';

export function isBarbarianClass(
  classSlug: string | null | undefined,
): boolean {
  return classSlug === 'barbarian';
}

export function rageDamageBonus(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.rageDamageBonus,
    level,
    0,
  );
}

export function brutalStrikeDice(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string | null {
  const count = scheduleIntOrNullAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.brutalStrikeDiceCount,
    level,
  );
  return count == null || count <= 0 ? null : `${count}d10`;
}

export const RAGE_DAMAGE_RESISTANCES = [
  'Contundente',
  'Cortante',
  'Perfurante',
] as const;

export function appliesRageDamageBonus(input: {
  classSlug?: string | null;
  level?: number;
  rageActive?: boolean;
  mode: 'melee' | 'ranged';
  abilitySlug: 'forca' | 'destreza';
  featureSchedules: readonly FeatureScheduleBand[];
}): number {
  if (
    !input.rageActive ||
    !isBarbarianClass(input.classSlug) ||
    input.mode !== 'melee' ||
    input.abilitySlug !== 'forca' ||
    input.level == null
  ) {
    return 0;
  }
  return rageDamageBonus(input.level, input.featureSchedules);
}

export function fastMovementBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isBarbarianClass(input.classSlug) || (input.level ?? 0) < 5) return 0;
  return 3;
}

export function divineFuryExtraDice(level: number): string {
  const half = Math.floor(level / 2);
  return half > 0 ? `1d6+${half}` : '1d6';
}

export function hasDivineFury(input: {
  subclassSlug?: string | null;
  level?: number;
  unlockLevel?: number | null;
}): boolean {
  return (
    input.subclassSlug === 'zealot' &&
    meetsFeatureGate(input.level ?? 0, input.unlockLevel)
  );
}

export function zealotHealingDiceCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.zealotHealingDiceCount,
    level,
    0,
  );
}
