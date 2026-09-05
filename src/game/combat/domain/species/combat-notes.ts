import type { CatalogEffect } from '@game/effects';
import { speciesPassiveNotesFromEffects } from '@game/effects';

export type SpeciesChoiceLike = {
  choiceKind: string;
  choiceSlug: string;
};

/**
 * Passivas de espécie — SSOT = `phb_effect` (já filtrado por gates).
 * Sem efeitos, retorna vazio (mapa TS legado removido).
 */
export function speciesCombatNotes(input: {
  speciesSlug?: string | null;
  speciesChoices?: readonly SpeciesChoiceLike[];
  speciesEffects?: readonly CatalogEffect[];
}): string[] {
  if (!input.speciesSlug) return [];
  return speciesPassiveNotesFromEffects(
    input.speciesEffects ?? [],
    input.speciesChoices ?? [],
  );
}
