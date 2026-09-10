/**
 * Sabujo de Sangue (Blood Hound) — constantes e gates de produto.
 * Defs tipadas: phb_effect (strikeOption) + option_value. Motor: strike-option /
 * spendStrikeSelfCost / resolveStrikeHitPackage / pending-combat-effect.
 */

export const BLOOD_STRIKE_RESOURCE_SLUG = 'blood-strike';
export const BLOOD_HOUND_SUBCLASS_SLUG = 'blood-hound';
export const BLOOD_STRIKE_TABLE_ACTION = 'blood-strike';

/** Pending kinds (seed `on_*_pending_kind`). */
export const BLOOD_CONDITION_WITHERING = 'blood-withering';
export const BLOOD_CONDITION_CONSTRAIN = 'blood-constrain';
export const BLOOD_CONDITION_EXILE = 'blood-exile';

export type BloodArmamentDamageType = 'acid' | 'necrotic' | 'poison';

/** Sangue da Criação (L10): rerrolar custo e ficar com o menor. */
export function canTakeLowerBloodCost(level: number): boolean {
  return level >= 10;
}

export function canUseBloodArmament(level: number): boolean {
  return level >= 7;
}

export function canUseBloodExplosion(level: number): boolean {
  return level >= 7;
}

export function canBloodSymphonyHeal(level: number): boolean {
  return level >= 15;
}

export function canBloodSymphonyRefund(level: number): boolean {
  return level >= 15;
}

/** Sinfonia de Sangue (L15): cura = mod. CON (mín. 1) ao usar golpe. */
export function bloodSymphonyHealAmount(constitutionModifier: number): number {
  return Math.max(1, constitutionModifier);
}

export function isBloodHoundSubclass(
  subclassSlug: string | null | undefined,
): boolean {
  return subclassSlug === BLOOD_HOUND_SUBCLASS_SLUG;
}
