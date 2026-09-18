
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  scheduleIntOrNullAtLevel,
  scheduleValueAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';
import { meetsFeatureGate } from '../../feature-gates';

export type PaladinSubclassSlug =
  | 'devotion'
  | 'glory'
  | 'ancients'
  | 'vengeance'
  | 'oath-of-revelry';

export function isPaladinClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'paladin';
}

export function divineSmiteDice(input: {
  slotLevel: number;
  vsUndeadOrFiend?: boolean;
}): string {
  const base = 1 + Math.max(1, input.slotLevel);
  const bonus = input.vsUndeadOrFiend ? 1 : 0;
  return `${base + bonus}d8`;
}

/** Juramento da Devoção nv.15 — lembrete de UI (sem auto-aplicar cobertura). */
export const PROTECTIVE_SMITE_UNLOCK_LEVEL = 15;

export function protectiveSmiteAuraCoverNote(input: {
  subclassSlug: string | null | undefined;
  level: number;
}): string | null {
  if (
    input.subclassSlug !== 'devotion' ||
    input.level < PROTECTIVE_SMITE_UNLOCK_LEVEL
  ) {
    return null;
  }
  return (
    'Destruição Protetora: Cobertura Parcial na Aura de Proteção até o início ' +
    'do seu próximo turno (marque cobertura nos ataques contra você/aliados na aura)'
  );
}

export function radiantStrikesDie(
  level: number,
  bands: readonly FeatureScheduleBand[],
): string | null {
  const count = scheduleIntOrNullAtLevel(
    bands,
    FEATURE_SCHEDULE_KEYS.radiantStrikesDiceCount,
    level,
  );
  return count == null || count < 1 ? null : `${count}d8`;
}

export function hasAuraOfProtection(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function auraOfProtectionBonus(charismaModifier: number): number {
  return Math.max(1, charismaModifier);
}

export function sacredWeaponAttackBonus(input: {
  sacredWeaponActive?: boolean;
  mode: 'melee' | 'ranged';
  charismaModifier: number;
}): number {
  if (!input.sacredWeaponActive || input.mode !== 'melee') {
    return 0;
  }
  return Math.max(1, input.charismaModifier);
}

export function paladinSavingThrowAuraBonus(input: {
  classSlug?: string | null;
  level: number;
  charismaModifier: number;
  unlockLevel?: number | null;
}): number {
  if (
    !isPaladinClass(input.classSlug) ||
    !hasAuraOfProtection(input.level, input.unlockLevel)
  ) {
    return 0;
  }
  return auraOfProtectionBonus(input.charismaModifier);
}

export function auraRangeMeters(
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  return (
    scheduleValueAtLevel(bands, FEATURE_SCHEDULE_KEYS.auraRangeM, level) ?? 3
  );
}

export function paladinAttacksPerAction(
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
