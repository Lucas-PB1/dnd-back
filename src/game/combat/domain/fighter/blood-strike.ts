/**
 * Sabujo de Sangue (Blood Hound) — constantes e gates de produto.
 * Níveis vêm de `phb_subclass_feature_gate`; predicados puros recebem unlock.
 * Defs tipadas: phb_effect (strikeOption). Motor: strike-option /
 * spendStrikeSelfCost / resolveStrikeHitPackage / pending-combat-effect.
 */

import { meetsFeatureGate } from '../feature-gates';

export { meetsFeatureGate } from '../feature-gates';

export const BLOOD_STRIKE_RESOURCE_SLUG = 'blood-strike';
export const BLOOD_HOUND_SUBCLASS_SLUG = 'blood-hound';
export const BLOOD_STRIKE_TABLE_ACTION = 'blood-strike';

export const BLOOD_GATE_ARMAMENT = 'blood-armament';
export const BLOOD_GATE_EXPLOSION = 'blood-explosion';
export const BLOOD_GATE_LOWER_COST = 'blood-lower-cost';
export const BLOOD_GATE_SYMPHONY = 'blood-symphony';

/** Pending kinds (seed `on_*_pending_kind`). */
export const BLOOD_CONDITION_WITHERING = 'blood-withering';
export const BLOOD_CONDITION_CONSTRAIN = 'blood-constrain';
export const BLOOD_CONDITION_EXILE = 'blood-exile';

export type BloodArmamentDamageType = 'acid' | 'necrotic' | 'poison';

/** Sangue da Criação: rerrolar custo e ficar com o menor. */
export function canTakeLowerBloodCost(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function canUseBloodArmament(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function canUseBloodExplosion(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function canBloodSymphonyHeal(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

export function canBloodSymphonyRefund(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return meetsFeatureGate(level, unlockLevel);
}

/** Sinfonia de Sangue: cura = mod. CON (mín. 1) ao usar golpe. */
export function bloodSymphonyHealAmount(constitutionModifier: number): number {
  return Math.max(1, constitutionModifier);
}

export function isBloodHoundSubclass(
  subclassSlug: string | null | undefined,
): boolean {
  return subclassSlug === BLOOD_HOUND_SUBCLASS_SLUG;
}
