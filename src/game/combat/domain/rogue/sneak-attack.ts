import { psiEnergyDiceSchedule } from '../fighter/features';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';
import { meetsFeatureGate } from '../feature-gates';

export function isRogueClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'rogue';
}

export function sneakAttackDiceCount(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return scheduleIntAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.sneakAttackDiceCount,
    level,
    0,
  );
}

export function sneakAttackDieFaces(
  subclassSlug?: string | null,
  usePoisonousStrike = false,
): 6 | 8 {
  return subclassSlug === 'arachnoid-stalker' && usePoisonousStrike ? 8 : 6;
}

export function sneakAttackDiceExpression(input: {
  level: number;
  subclassSlug?: string | null;
  usePoisonousStrike?: boolean;
  featureSchedules: readonly FeatureScheduleBand[];
}): string {
  return `${sneakAttackDiceCount(input.level, input.featureSchedules)}d${sneakAttackDieFaces(
    input.subclassSlug,
    input.usePoisonousStrike,
  )}`;
}

export function hasSlipperyMind(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function hasEvasion(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function hasAssassinMobileAim(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function soulknifePsiDiceSchedule(
  level: number,
  bands: readonly FeatureScheduleBand[],
): {
  faces: number;
  count: number;
} | null {
  return psiEnergyDiceSchedule(level, bands);
}
