import { CharacterFeatDto, SpeciesChoiceDto } from '../dto/character-sheet.dto';
import { nextFeatInstanceIndex } from './character-feat';

const HUMAN_ORIGIN_FEAT_KIND = 'human_origin_feat';

/** Talentos de origem do traço Versátil (humano). */
export function resolveHumanOriginCharacterFeats(
  speciesSlug: string,
  speciesChoices: SpeciesChoiceDto[] | undefined,
  provided: CharacterFeatDto[],
): CharacterFeatDto[] {
  if (speciesSlug !== 'human' || !speciesChoices?.length) {
    return provided;
  }

  const versatile = speciesChoices.find(
    (choice) => choice.choiceKind === HUMAN_ORIGIN_FEAT_KIND,
  );
  if (!versatile?.choiceSlug?.trim()) {
    return provided;
  }

  const feats = [...provided];
  const slug = versatile.choiceSlug.trim();
  if (!feats.some((feat) => feat.featSlug === slug)) {
    feats.push({
      featSlug: slug,
      instanceIndex: nextFeatInstanceIndex(feats, slug),
    });
  }
  return feats;
}

export function humanOriginFeatSlugFromChoices(
  speciesChoices: SpeciesChoiceDto[] | undefined,
): string | null {
  const match = speciesChoices?.find(
    (choice) => choice.choiceKind === HUMAN_ORIGIN_FEAT_KIND,
  );
  return match?.choiceSlug?.trim() || null;
}
