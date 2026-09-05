import type { CatalogEffect, EffectKind } from '../catalog-effect';

export function ownedFeatEffects(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
): CatalogEffect[] {
  const set = new Set(featSlugs);
  return effects.filter(
    (effect) =>
      effect.ownerKind === 'feat' &&
      effect.ownerSlug != null &&
      set.has(effect.ownerSlug),
  );
}

export function resolveNumericAmount(
  numeric: NonNullable<CatalogEffect['numeric']>,
  proficiencyBonus: number,
): number {
  if (numeric.amountFormula === 'fixed') return numeric.flat ?? 0;
  if (numeric.amountFormula === 'proficiency_bonus') return proficiencyBonus;
  return 0;
}

export function sumOwnedFeatNumericBonus(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
  kind: EffectKind,
  proficiencyBonus: number,
): number {
  let total = 0;
  for (const effect of ownedFeatEffects(effects, featSlugs)) {
    if (effect.kind !== kind || !effect.numeric) continue;
    total += resolveNumericAmount(effect.numeric, proficiencyBonus);
  }
  return total;
}

export function hasOwnedFeatKind(
  effects: readonly CatalogEffect[],
  featSlugs: readonly string[],
  kind: EffectKind,
): boolean {
  return ownedFeatEffects(effects, featSlugs).some(
    (effect) => effect.kind === kind,
  );
}
