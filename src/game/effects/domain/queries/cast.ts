import type {
  CatalogEffect,
  EffectCastEconomyKind,
} from '../catalog-effect';
import { resolveCastMaxUses } from '../resolve-effect-amount';

export function resolveFeatCastEconomyFromEffects(input: {
  effects: readonly CatalogEffect[];
  featSlug: string;
  optionKey: string | null;
}): EffectCastEconomyKind | null {
  const effect = findFeatSpellCastEffect(input);
  return effect?.castEconomy?.economy ?? null;
}

export function resolveFeatFreeCastMaxUsesFromEffects(input: {
  effects: readonly CatalogEffect[];
  featSlug: string;
  optionKey: string | null;
  proficiencyBonus: number;
}): number | null {
  const effect = findFeatSpellCastEffect(input);
  if (!effect?.castEconomy) return null;
  if (effect.castEconomy.economy !== 'once_per_long_rest') return 0;
  return resolveCastMaxUses({
    economy: effect.castEconomy.economy,
    usesFormula: effect.castEconomy.usesFormula,
    fixedUses: effect.castEconomy.fixedUses,
    proficiencyBonus: input.proficiencyBonus,
  });
}

function findFeatSpellCastEffect(input: {
  effects: readonly CatalogEffect[];
  featSlug: string;
  optionKey: string | null;
}): CatalogEffect | null {
  if (!input.optionKey) return null;
  for (const effect of input.effects) {
    if (effect.ownerKind !== 'feat') continue;
    if (effect.ownerSlug !== input.featSlug) continue;
    if (
      effect.kind !== 'grant_spell' &&
      effect.kind !== 'free_cast' &&
      effect.kind !== 'grant_spell_by_level'
    ) {
      continue;
    }
    if (effect.spell?.optionKey !== input.optionKey) continue;
    if (!effect.castEconomy) continue;
    return effect;
  }
  return null;
}

export function filterEffectsByTrigger(
  effects: readonly CatalogEffect[],
  trigger: CatalogEffect['trigger'],
): CatalogEffect[] {
  return effects.filter((effect) => effect.trigger === trigger);
}

export function filterEffectsByResourceSpend(
  effects: readonly CatalogEffect[],
  resourceSlug: string,
): CatalogEffect[] {
  return effects.filter(
    (effect) =>
      effect.trigger === 'on_resource_spend' &&
      effect.resourceSlug === resourceSlug,
  );
}

export function filterEffectsByActionSlug(
  effects: readonly CatalogEffect[],
  actionSlug: string,
): CatalogEffect[] {
  return effects.filter(
    (effect) =>
      effect.trigger === 'on_table_action' &&
      effect.actionSlug === actionSlug,
  );
}
