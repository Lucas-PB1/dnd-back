

import { meetsFeatureGate } from '../feature-gates';

export { meetsFeatureGate } from '../feature-gates';

export const BLOOD_STRIKE_RESOURCE_SLUG = 'blood-strike';
export const BLOOD_HOUND_SUBCLASS_SLUG = 'blood-hound';
export const BLOOD_STRIKE_TABLE_ACTION = 'blood-strike';

export const BLOOD_GATE_ARMAMENT = 'blood-armament';
export const BLOOD_GATE_EXPLOSION = 'blood-explosion';
export const BLOOD_GATE_LOWER_COST = 'blood-lower-cost';
export const BLOOD_GATE_SYMPHONY = 'blood-symphony';

export const BLOOD_CONDITION_WITHERING = 'blood-withering';
export const BLOOD_CONDITION_CONSTRAIN = 'blood-constrain';
export const BLOOD_CONDITION_EXILE = 'blood-exile';

export type BloodArmamentDamageType = 'acid' | 'necrotic' | 'poison';

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

export function bloodSymphonyHealAmount(constitutionModifier: number): number {
  return Math.max(1, constitutionModifier);
}

export function isBloodHoundSubclass(
  subclassSlug: string | null | undefined,
): boolean {
  return subclassSlug === BLOOD_HOUND_SUBCLASS_SLUG;
}
