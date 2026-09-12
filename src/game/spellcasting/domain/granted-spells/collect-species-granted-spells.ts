import type { CatalogEffect } from '@game/effects';
import { speciesGrantedSpellSlugsFromEffects } from '@game/effects';
import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

export function collectSpeciesGrantedSpellSlugs(
  speciesSlug: string | undefined,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  level: number,
  speciesEffects?: readonly CatalogEffect[],
): Set<string> {
  const slugs = new Set<string>();
  if (!speciesSlug) return slugs;

  for (const slug of speciesGrantedSpellSlugsFromEffects(
    speciesEffects ?? [],
    level,
    speciesChoices ?? [],
  )) {
    slugs.add(slug);
  }
  return slugs;
}
