import type { CatalogEffect } from '../catalog-effect';
import { hasOwnedFeatKind } from './shared';

export function hasInitiativePbFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'initiative_pb');
}

export function purchaseDiscountPercentFromEffects(
  effects: readonly CatalogEffect[],
): { percentOff: number; nonMagicOnly: boolean; foodDrinkOnly: boolean } | null {
  let best: {
    percentOff: number;
    nonMagicOnly: boolean;
    foodDrinkOnly: boolean;
  } | null = null;
  for (const effect of effects) {
    if (effect.kind !== 'purchase_discount' || !effect.purchaseDiscount) {
      continue;
    }
    const row = effect.purchaseDiscount;
    if (!best || row.percentOff > best.percentOff) {
      best = {
        percentOff: row.percentOff,
        nonMagicOnly: row.nonMagicOnly,
        foodDrinkOnly: row.foodDrinkOnly,
      };
    }
  }
  return best;
}

export function hasDamageRerollChoice(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): boolean {
  return hasOwnedFeatKind(effects, featSlugs, 'damage_reroll_choice');
}

export function unarmedDamageDieFromEffects(
  effects: readonly CatalogEffect[],
): string | null {
  for (const effect of effects) {
    if (effect.kind !== 'damage_die_override' || !effect.damageDie) continue;
    if (effect.damageDie.appliesTo === 'unarmed') {
      return effect.damageDie.die;
    }
  }
  return null;
}

export function combatNotesFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): string[] {
  const set = new Set(featSlugs);
  const notes: string[] = [];
  for (const effect of effects) {
    if (effect.ownerKind !== 'feat' || !effect.ownerSlug) continue;
    if (!set.has(effect.ownerSlug)) continue;
    const note = effect.note?.note?.trim();
    if (!note) continue;
    notes.push(note);
  }
  return notes;
}

export function speedBonusMetersFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): number {
  const set = new Set(featSlugs);
  let feet = 0;
  for (const effect of effects) {
    if (effect.kind !== 'speed_bonus') continue;
    if (effect.ownerKind !== 'feat' || !effect.ownerSlug) continue;
    if (!set.has(effect.ownerSlug)) continue;
    if (!effect.numeric || effect.numeric.amountFormula !== 'fixed') continue;
    feet += effect.numeric.flat ?? 0;
  }
  if (feet === 0) return 0;
  return (feet / 5) * 1.5;
}
