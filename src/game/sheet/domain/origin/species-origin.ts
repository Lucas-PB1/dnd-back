import { CharacterFeatDto, SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import { nextFeatInstanceIndex } from '../validation/feats/character-feat';
import type { CatalogEffect } from '@game/effects';
import { featSlugsFromEffects } from '@game/effects';

const HUMAN_ORIGIN_FEAT_KIND = 'human_origin_feat';

/** Talentos de origem do traço Versátil — prefer `grant_feat`; fallback choice legado. */
export function resolveHumanOriginCharacterFeats(
  speciesSlug: string,
  speciesChoices: SpeciesChoiceDto[] | undefined,
  provided: CharacterFeatDto[],
  speciesEffects?: readonly CatalogEffect[],
): CharacterFeatDto[] {
  if (speciesSlug !== 'human' || !speciesChoices?.length) {
    return provided;
  }

  const fromEffects =
    speciesEffects && speciesEffects.length > 0
      ? featSlugsFromEffects(speciesEffects, speciesChoices)
      : [];
  const legacy =
    fromEffects.length === 0
      ? speciesChoices.find((choice) => choice.choiceKind === HUMAN_ORIGIN_FEAT_KIND)
          ?.choiceSlug?.trim()
      : undefined;
  const slugs = fromEffects.length > 0 ? fromEffects : legacy ? [legacy] : [];
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
