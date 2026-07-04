import { CharacterFeatDto } from '../dto/character-sheet.dto';
import { VPhbBackground } from '../../../entities/views/v-phb-background.entity';
import {
  characterFeatsFromSlugs,
  nextFeatInstanceIndex,
} from './character-feat';

export function resolveBackgroundOriginCharacterFeats(
  background: Pick<VPhbBackground, 'featSlug'>,
  provided?: CharacterFeatDto[],
  legacyFeatSlugs?: string[],
): CharacterFeatDto[] {
  const feats = provided?.length
    ? [...provided]
    : characterFeatsFromSlugs(legacyFeatSlugs);

  const origin = background.featSlug?.trim();
  if (origin && !feats.some((feat) => feat.featSlug === origin)) {
    feats.unshift({
      featSlug: origin,
      instanceIndex: nextFeatInstanceIndex(feats, origin),
    });
  }

  return feats;
}

/** @deprecated Use resolveBackgroundOriginCharacterFeats */
export function resolveBackgroundOriginFeatSlugs(
  background: Pick<VPhbBackground, 'featSlug'>,
  provided?: string[],
): string[] {
  return resolveBackgroundOriginCharacterFeats(background, undefined, provided).map(
    (feat) => feat.featSlug,
  );
}

export function resolveBackgroundToolItemSlug(
  background: Pick<VPhbBackground, 'toolProficiencyKind' | 'toolItemSlug'>,
  provided?: string | null,
): string | null {
  if (background.toolProficiencyKind === 'fixed') {
    return background.toolItemSlug ?? null;
  }
  if (background.toolProficiencyKind === 'choice') {
    return provided?.trim() || null;
  }
  return null;
}
