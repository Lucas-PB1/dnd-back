import type { CatalogEffect } from '../catalog-effect';
import {
  hasOwnedFeatKind,
  ownedFeatEffects,
  sumOwnedFeatNumericBonus,
} from './shared';

export function acBonusFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
  proficiencyBonus: number,
): number {
  return sumOwnedFeatNumericBonus(
    effects,
    featSlugs,
    'ac_bonus',
    proficiencyBonus,
  );
}

export function grantedWeaponPropertySlugsFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): string[] {
  const props = new Set<string>();
  for (const effect of ownedFeatEffects(effects, featSlugs)) {
    if (effect.kind !== 'grant_weapon_property') continue;
    const slug = effect.weapon?.propertySlug?.trim().toLowerCase();
    if (slug) props.add(slug);
  }
  return [...props];
}

export function overrideWeaponRangeFtFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): { normalFt: number; longFt: number } | null {
  for (const effect of ownedFeatEffects(effects, featSlugs)) {
    if (effect.kind !== 'override_weapon_range') continue;
    const normalFt = effect.weapon?.rangeNormalFt;
    const longFt = effect.weapon?.rangeLongFt;
    if (normalFt != null && longFt != null) {
      return { normalFt, longFt };
    }
  }
  return null;
}

export function hasInspirationRefundOnFail(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'inspiration_refund_on_fail');
}

export function hasDamageDieFloor(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'damage_die_floor');
}

export function hasDamageDieFlip(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'damage_die_flip');
}

export function hasDamageDieExplode(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'damage_die_explode');
}

export function hasImproveCritical(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'improve_critical');
}

export function hasSlotElevate(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'slot_elevate');
}

export function hasSlotReduce(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'slot_reduce');
}

export function hasWieldTwoHandedOneHand(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'wield_two_handed_one_hand');
}

export function hasVersatileOneHandFullDamage(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'versatile_one_hand_full_damage');
}
