import { CharacterFeatDto, SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import { nextFeatInstanceIndex } from '../validation/feats/character-feat';
import type { CatalogEffect } from '@game/effects';
import { featSlugsFromEffects } from '@game/effects';

/** Talentos de origem do traço Versátil — só `grant_feat` do catálogo. */
export function resolveHumanOriginCharacterFeats(
  speciesSlug: string,
  speciesChoices: SpeciesChoiceDto[] | undefined,
  provided: CharacterFeatDto[],
  speciesEffects?: readonly CatalogEffect[],
): CharacterFeatDto[] {
  if (speciesSlug !== 'human' || !speciesChoices?.length) {
    return provided;
  }
  if (!speciesEffects?.length) return provided;

  const slugs = featSlugsFromEffects(speciesEffects, speciesChoices);
  if (slugs.length === 0) return provided;

  const feats = [...provided];
  for (const slug of slugs) {
    if (!feats.some((feat) => feat.featSlug === slug)) {
      feats.push({
        featSlug: slug,
        instanceIndex: nextFeatInstanceIndex(feats, slug),
      });
    }
  }
  return feats;
}
