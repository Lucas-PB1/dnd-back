import type { CatalogEffect } from '@game/effects';
import { speciesPassiveNotesFromEffects } from '@game/effects';

export type SpeciesChoiceLike = {
  choiceKind: string;
  choiceSlug: string;
};


export function speciesCombatNotes(input: {
  speciesSlug?: string | null;
  speciesChoices?: readonly SpeciesChoiceLike[];
  speciesEffects?: readonly CatalogEffect[];
  optionDamageTypes?: ReadonlyMap<string, string>;
  damageTypeLabels?: ReadonlyMap<string, string>;
}): string[] {
  if (!input.speciesSlug) return [];
  return speciesPassiveNotesFromEffects(
    input.speciesEffects ?? [],
    input.speciesChoices ?? [],
    input.optionDamageTypes,
    input.damageTypeLabels,
  );
}
