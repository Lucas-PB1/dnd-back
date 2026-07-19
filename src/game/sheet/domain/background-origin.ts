import { CharacterFeatDto } from '../dto/character-sheet.dto';
import { VPhbBackground } from '../../../entities/views/v-phb-background.entity';
import { nextFeatInstanceIndex } from './character-feat';

export function resolveBackgroundOriginCharacterFeats(
  background: Pick<VPhbBackground, 'featSlug'>,
  provided?: CharacterFeatDto[],
): CharacterFeatDto[] {
  const feats = provided?.length ? [...provided] : [];

  const origin = background.featSlug?.trim();
  if (origin && !feats.some((feat) => feat.featSlug === origin)) {
    feats.unshift({
      featSlug: origin,
      instanceIndex: nextFeatInstanceIndex(feats, origin),
    });
  }

  return feats;
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
