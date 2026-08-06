import type { CunningStrikeEffect } from './types';
import { sneakAttackDiceCount } from './sneak-attack';

/**
 * Golpe Astuto — lookups.
 * Catálogo: `rpg.phb_cunning_strike_effect` / `v_phb_cunning_strike_effect`.
 */

export function cunningStrikeSaveDc(input: {
  dexterityModifier: number;
  proficiencyBonus: number;
}): number {
  return 8 + input.dexterityModifier + input.proficiencyBonus;
}

export function findCunningStrikeEffect(
  catalog: readonly CunningStrikeEffect[],
  slug: string,
): CunningStrikeEffect | undefined {
  return catalog.find((effect) => effect.slug === slug);
}

export function availableCunningStrikeEffects(
  catalog: readonly CunningStrikeEffect[],
  input: { level: number; subclassSlug?: string | null },
): CunningStrikeEffect[] {
  return catalog.filter(
    (effect) =>
      input.level >= effect.unlockLevel &&
      (!effect.subclassSlug || effect.subclassSlug === input.subclassSlug),
  );
}

export function validateCunningStrikeSelection(
  catalog: readonly CunningStrikeEffect[],
  input: {
    level: number;
    effectSlugs: readonly string[];
    subclassSlug?: string | null;
  },
): {
  effects: CunningStrikeEffect[];
  diceCost: number;
  remainingSneakAttackDice: number;
} {
  const maximumEffects = input.level >= 11 ? 2 : 1;
  if (input.effectSlugs.length > maximumEffects) {
    throw new Error(
      `Rogue level ${input.level} can apply at most ${maximumEffects} Cunning Strike effect(s)`,
    );
  }

  const effects = input.effectSlugs.map((slug) => {
    const effect = findCunningStrikeEffect(catalog, slug);
    if (!effect) {
      throw new Error(`Unknown Cunning Strike effect '${slug}'`);
    }
    if (input.level < effect.unlockLevel) {
      throw new Error(
        `${effect.name} requires Rogue level ${effect.unlockLevel}+`,
      );
    }
    if (
      effect.subclassSlug !== undefined &&
      effect.subclassSlug !== input.subclassSlug
    ) {
      throw new Error(
        `${effect.name} requires Rogue subclass ${effect.subclassSlug}`,
      );
    }
    return effect;
  });

  const diceCost = effects.reduce((total, effect) => total + effect.cost, 0);
  const sneakAttackDice = sneakAttackDiceCount(input.level);
  if (diceCost > sneakAttackDice) {
    throw new Error(
      `Cunning Strike costs ${diceCost} dice, but Sneak Attack has only ${sneakAttackDice}`,
    );
  }

  return {
    effects,
    diceCost,
    remainingSneakAttackDice: sneakAttackDice - diceCost,
  };
}

export type { CunningStrikeEffectSlug } from './types';
