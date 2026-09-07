import type { CatalogEffect, EffectKind } from '../catalog-effect';
import {
  resolveNumericAmount,
  sumOwnedFeatNumericBonus,
} from './shared';

export function numericBonusFromOwnerEffect(
  effects: readonly CatalogEffect[],
  ownedSlugs: readonly string[],
  ownerSlug: string,
  kind: EffectKind,
  proficiencyBonus: number,
): number | null {
  if (!ownedSlugs.includes(ownerSlug)) return null;
  let total = 0;
  let found = false;
  for (const effect of effects) {
    if (effect.kind !== kind) continue;
    if (effect.ownerKind !== 'feat' || effect.ownerSlug !== ownerSlug) continue;
    if (!effect.numeric) continue;
    found = true;
    total += resolveNumericAmount(effect.numeric, proficiencyBonus);
  }
  return found ? total : null;
}

export function hasOwnerEffectKind(
  effects: readonly CatalogEffect[],
  ownedSlugs: readonly string[],
  ownerSlug: string,
  kind: EffectKind,
): boolean {
  if (!ownedSlugs.includes(ownerSlug)) return false;
  return effects.some(
    (effect) =>
      effect.kind === kind &&
      effect.ownerKind === 'feat' &&
      effect.ownerSlug === ownerSlug,
  );
}

export function styleOrFeatNumericBonus(input: {
  effects: readonly CatalogEffect[];
  ownedSlugs: readonly string[];
  ownerSlug: string;
  kind: EffectKind;
  proficiencyBonus: number;
}): number {
  return (
    numericBonusFromOwnerEffect(
      input.effects,
      input.ownedSlugs,
      input.ownerSlug,
      input.kind,
      input.proficiencyBonus,
    ) ?? 0
  );
}

export function styleOrFeatHasKind(input: {
  effects: readonly CatalogEffect[];
  ownedSlugs: readonly string[];
  ownerSlug: string;
  kind: EffectKind;
}): boolean {
  return hasOwnerEffectKind(
    input.effects,
    input.ownedSlugs,
    input.ownerSlug,
    input.kind,
  );
}

export function ownedStyleOrFeatSlugs(context: {
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
}): string[] {
  return [
    ...(context.featSlugs ?? []),
    ...(context.fightingStyleSlugs ?? []),
  ];
}

export function scaledDamageDiceFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
  level: number,
): string | null {
  const owned = new Set(featSlugs);
  const hit = effects.find(
    (effect) =>
      effect.kind === 'scaled_damage_dice' &&
      effect.ownerKind === 'feat' &&
      effect.ownerSlug != null &&
      owned.has(effect.ownerSlug),
  );
  if (!hit) return null;
  if (level >= 16) return '4d4';
  if (level >= 9) return '2d4';
  return '1d4';
}

export function flatDamageBonusFromEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
  proficiencyBonus: number,
): number {
  return sumOwnedFeatNumericBonus(
    effects,
    featSlugs,
    'damage_bonus',
    proficiencyBonus,
  );
}
