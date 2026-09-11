import { psiEnergyDiceSchedule } from '../fighter/features';
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../feature-schedule';

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

/** O Perseguidor Aracnídeo pode trocar os d6 por d8 de dano Venenoso. */
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

export function hasSlipperyMind(level: number): boolean {
  return level >= 15;
}

/** Evasão (Ladino 7+): salvaguarda de Destreza que reduz dano à metade. */
export function hasEvasion(level: number): boolean {
  return level >= 7;
}

/** Assassino 9+: Mira Firme sem zerar Deslocamento (Mira Móvel). */
export function hasAssassinMobileAim(level: number): boolean {
  return level >= 9;
}

/** Soulknife usa a mesma progressão de dados psiônicos do Psi Warrior. */
export function soulknifePsiDiceSchedule(
  level: number,
  bands: readonly FeatureScheduleBand[],
): {
  faces: number;
  count: number;
} | null {
  return psiEnergyDiceSchedule(level, bands);
}
