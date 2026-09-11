import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  scheduleIntOrNullAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';

/**
 * Regras numéricas de combate do Guerreiro (PHB 2024) e efeitos de subclasse.
 * Números: SSOT `phb_class_feature_schedule` (bands obrigatórios).
 */

export function isFighterClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'fighter';
}

export function attacksPerAction(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.attacksPerAction,
    level,
    1,
  );
}

/** Cura de Recuperar Fôlego: 1d10 + nível de Guerreiro. */
export function secondWindHealDice(level: number): string {
  return `1d10+${Math.max(1, level)}`;
}

export function indomitableMaxUses(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.indomitableMaxUses,
    level,
    0,
  );
}

export function superiorityDiceCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.superiorityDiceCount,
    level,
    0,
  );
}

export function superiorityDieFaces(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number | null {
  return scheduleIntOrNullAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.superiorityDieFaces,
    level,
  );
}

export function superiorityDieLabel(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string | null {
  const faces = superiorityDieFaces(level, bands);
  return faces == null ? null : `d${faces}`;
}

export function psiEnergyDiceSchedule(
  level: number,
  bands: readonly FeatureScheduleBand[],
): {
  faces: number;
  count: number;
} | null {
  const faces = scheduleIntOrNullAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.psiEnergyDieFaces,
    level,
  );
  const count = scheduleIntOrNullAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.psiEnergyDiceCount,
    level,
  );
  if (faces == null || count == null) return null;
  return { faces, count };
}

export function psiEnergyDiceCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return psiEnergyDiceSchedule(level, bands)?.count ?? 0;
}

export function psiEnergyDieFaces(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number | null {
  return psiEnergyDiceSchedule(level, bands)?.faces ?? null;
}

export function psiEnergyDieLabel(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string | null {
  const faces = psiEnergyDieFaces(level, bands);
  return faces == null ? null : `d${faces}`;
}

export function championCritThreshold(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.championCritThreshold,
    level,
    20,
  );
}

export function resolveFighterAttackCritThreshold(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  featureSchedules: readonly FeatureScheduleBand[];
}): number {
  if (
    !isFighterClass(input.classSlug) ||
    input.subclassSlug !== 'champion' ||
    input.level == null
  ) {
    return 20;
  }
  return championCritThreshold(input.level, input.featureSchedules);
}

export function hasStudiedAttacks(level: number): boolean {
  return level >= 13;
}

export function hasTacticalMaster(level: number): boolean {
  return level >= 9;
}

export function hasTacticalShift(level: number): boolean {
  return level >= 5;
}

export function hasTacticalMind(level: number): boolean {
  return level >= 2;
}
