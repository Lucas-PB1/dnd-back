import type { CatalogEffect } from '../catalog-effect';
import {
  choiceKindForOptionKey,
  DWARF_CULTURE_KIND,
} from '@catalog/game-port';

export type EffectChoiceRef = {
  choiceKind: string;
  choiceSlug: string;
};

function choiceSlugForOptionKey(
  optionKey: string,
  choices: readonly EffectChoiceRef[],
): string | null {
  const choiceKind = choiceKindForOptionKey(optionKey);
  return (
    choices.find((choice) => choice.choiceKind === choiceKind)?.choiceSlug ??
    null
  );
}

/** Default culture/lineage when the player has not picked yet (PHB baseline). */
export function withDefaultSpeciesChoices(
  speciesSlug: string | null | undefined,
  choices: readonly EffectChoiceRef[],
): EffectChoiceRef[] {
  if (speciesSlug === 'dwarf') {
    if (!choices.some((choice) => choice.choiceKind === DWARF_CULTURE_KIND)) {
      return [
        ...choices,
        { choiceKind: DWARF_CULTURE_KIND, choiceSlug: 'phb' },
      ];
    }
  }
  return [...choices];
}

/** Drop effects whose requires_option_* gate does not match species choices. */
export function filterEffectsByOptionGates(
  effects: readonly CatalogEffect[],
  choices: readonly EffectChoiceRef[],
): CatalogEffect[] {
  return effects.filter((effect) => {
    const key = effect.requiresOptionKey;
    const value = effect.requiresOptionValue;
    if (!key || !value) return true;
    return choiceSlugForOptionKey(key, choices) === value;
  });
}
