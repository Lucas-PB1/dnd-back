/**
 * Regras numéricas de combate do Patrulheiro (PHB 2024): Marca do Predador e dados de arquétipo.
 */
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';
import { meetsFeatureGate } from '../../feature-gates';

export type RangerSubclassSlug =
  | 'hunter'
  | 'beast-master'
  | 'fey-wanderer'
  | 'gloom-stalker'
  | 'beastborne';

export const HUNTERS_MARK_SPELL_SLUG = 'marca-do-predador';

export function isRangerClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'ranger';
}

/** Marca do Predador: 1d6 Energético; Matador de Inimigos Favoritos (nv.20) → d10. */
export function huntersMarkDie(level: number): string {
  return level >= 20 ? '1d10' : '1d6';
}

/** Golpes Terríveis (Andarilho Feérico): 1d4 → 1d6 no nível 11. */
export function feyDreadfulStrikesDie(level: number): string {
  return level >= 11 ? '1d6' : '1d4';
}

/** Golpe Terrível (Vigilante das Sombras): 2d6 → 2d8 no nível 11. */
export function gloomDreadAmbusherDie(level: number): string {
  return level >= 11 ? '2d8' : '2d6';
}

export function hasPreciseHunter(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function hasRelentlessHunter(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

/** Ataque Extra — SSOT: `attacks_per_action`. */
export function rangerAttacksPerAction(
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

/** Errante (nível 6): +3 m sem armadura pesada. */
export function rangerSpeedBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isRangerClass(input.classSlug) || (input.level ?? 0) < 6) return 0;
  return 3;
}
