import { CharacterFeatDto } from '../dto/character-sheet.dto';

export function featInstanceKey(featSlug: string, instanceIndex: number): string {
  return `${featSlug}:${instanceIndex}`;
}

export function nextFeatInstanceIndex(
  feats: CharacterFeatDto[],
  featSlug: string,
): number {
  const indices = feats
    .filter((feat) => feat.featSlug === featSlug)
    .map((feat) => feat.instanceIndex);
  if (indices.length === 0) return 0;
  return Math.max(...indices) + 1;
}

export function appendCharacterFeat(
  feats: CharacterFeatDto[],
  featSlug: string,
): CharacterFeatDto[] {
  return [
    ...feats,
    { featSlug, instanceIndex: nextFeatInstanceIndex(feats, featSlug) },
  ];
}
