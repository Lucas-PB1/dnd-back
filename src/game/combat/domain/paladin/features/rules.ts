/**
 * Regras numéricas de combate do Paladino (PHB 2024): Destruição Divina,
 * Golpes Radiantes e auras.
 */
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

/**
 * Destruição Divina (Divine Smite): 2d8 Radiante num espaço de 1º círculo,
 * +1d8 por círculo acima do 1º e +1d8 contra Corruptores/Mortos-vivos.
 */
export function divineSmiteDice(input: {
  slotLevel: number;
  vsUndeadOrFiend?: boolean;
}): string {
  const base = 1 + Math.max(1, input.slotLevel);
  const bonus = input.vsUndeadOrFiend ? 1 : 0;
  return `${base + bonus}d8`;
}

/** Golpes Radiantes: +Nd8 Radiante — SSOT `radiant_strikes_dice_count`. */
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

/** Aura de Proteção: você e aliados somam o mod. de Carisma às salvaguardas. */
export function hasAuraOfProtection(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function auraOfProtectionBonus(charismaModifier: number): number {
  return Math.max(1, charismaModifier);
}

/** Bônus de Aura de Proteção para a ficha/rolagem (0 se não aplicar). */
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

/** Ataque Extra — SSOT: `attacks_per_action`. */
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
