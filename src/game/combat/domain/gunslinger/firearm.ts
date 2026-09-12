

import { resolveFighterAttackCritThreshold } from '../fighter/features';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

export function gunslingerCritThreshold(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.gunslingerCritThreshold,
    level,
    20,
  );
}

export function isGunslingerClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'gunslinger';
}

export function firearmAbilityDamageBonus(_abilityMod: number): number {
  return 0;
}

export function applyOverkillDamageBonus(input: {
  level: number;
  isFirearm: boolean;
  abilityMod: number;
}): { abilityDamageBonus: number; extraDamageDice: string | null } {
  if (input.level < 11) {
    return {
      abilityDamageBonus: input.isFirearm
        ? firearmAbilityDamageBonus(input.abilityMod)
        : input.abilityMod,
      extraDamageDice: null,
    };
  }
  if (input.isFirearm) {
    return {
      abilityDamageBonus: input.abilityMod,
      extraDamageDice: null,
    };
  }
  return {
    abilityDamageBonus: input.abilityMod,
    extraDamageDice: '1d8',
  };
}

export function resolveAttackCritThreshold(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  mode: 'melee' | 'ranged';
  featureSchedules: readonly FeatureScheduleBand[];
}): number {
  let threshold = 20;

  if (
    input.mode === 'ranged' &&
    isGunslingerClass(input.classSlug) &&
    input.level != null
  ) {
    threshold = Math.min(
      threshold,
      gunslingerCritThreshold(input.level, input.featureSchedules),
    );
  }

  threshold = Math.min(
    threshold,
    resolveFighterAttackCritThreshold({
      classSlug: input.classSlug,
      subclassSlug: input.subclassSlug,
      level: input.level,
      featureSchedules: input.featureSchedules,
    }),
  );

  return threshold;
}
