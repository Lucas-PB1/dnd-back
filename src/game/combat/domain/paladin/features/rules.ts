/**
 * Regras numéricas de combate do Paladino (PHB 2024): Destruição Divina,
 * Golpes Radiantes e auras.
 */
import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  type FeatureScheduleBand,
} from '../../feature-schedule';

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

/** Golpes Radiantes (nível 11): +1d8 Radiante em ataques corpo a corpo. */
export function radiantStrikesDie(level: number): string | null {
  return level >= 11 ? '1d8' : null;
}

/** Aura de Proteção (nível 6+): você e aliados somam o mod. de Carisma às salvaguardas. */
export function hasAuraOfProtection(level: number): boolean {
  return level >= 6;
}

export function auraOfProtectionBonus(charismaModifier: number): number {
  return Math.max(1, charismaModifier);
}

/** Bônus de Aura de Proteção para a ficha/rolagem (0 se não aplicar). */
export function paladinSavingThrowAuraBonus(input: {
  classSlug?: string | null;
  level: number;
  charismaModifier: number;
}): number {
  if (!isPaladinClass(input.classSlug) || !hasAuraOfProtection(input.level)) {
    return 0;
  }
  return auraOfProtectionBonus(input.charismaModifier);
}

export function auraRangeMeters(level: number): number {
  return level >= 18 ? 9 : 3;
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
