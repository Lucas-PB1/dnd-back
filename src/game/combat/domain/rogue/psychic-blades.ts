
import { isRogueClass } from './sneak-attack';
import { meetsFeatureGate } from '../feature-gates';

export const PSYCHIC_BLADE_ITEM_SLUG = 'psychic-blade';

export const PSYCHIC_BLADE_BONUS_ITEM_SLUG = 'psychic-blade-bonus';

export const PSYCHIC_BLADE_ITEM_SLUGS = [
  PSYCHIC_BLADE_ITEM_SLUG,
  PSYCHIC_BLADE_BONUS_ITEM_SLUG,
] as const;

export function isSoulknifeSubclass(
  classSlug: string | null | undefined,
  subclassSlug: string | null | undefined,
): boolean {
  return isRogueClass(classSlug) && subclassSlug === 'soulknife';
}

export function hasPsychicBlades(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  unlockLevel?: number | null;
}): boolean {
  return (
    isSoulknifeSubclass(input.classSlug, input.subclassSlug) &&
    meetsFeatureGate(input.level ?? 0, input.unlockLevel)
  );
}

export function isPsychicBladeItemSlug(slug: string): boolean {
  return (
    slug === PSYCHIC_BLADE_ITEM_SLUG || slug === PSYCHIC_BLADE_BONUS_ITEM_SLUG
  );
}

export function psychicBladeEquipmentSlot(
  slug: string,
): 'main_hand' | 'off_hand' {
  return slug === PSYCHIC_BLADE_BONUS_ITEM_SLUG ? 'off_hand' : 'main_hand';
}
