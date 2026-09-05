import type { CatalogEffect } from "@game/effects";
import { combatNotesFromEffects } from "@game/effects";

export function featCombatNotes(input: {
  featSlugs: readonly string[];
  featEffects?: readonly CatalogEffect[];
}): string[] {
  return [...combatNotesFromEffects(input.featEffects ?? [], input.featSlugs)];
}
