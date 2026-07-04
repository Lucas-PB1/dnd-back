import { CharacterFeatDto } from '../dto/character-sheet.dto';

export function featInstanceKey(featSlug: string, instanceIndex: number): string {
  return `${featSlug}:${instanceIndex}`;
}

/** Converte lista legada (com repetições) em instâncias indexadas. */
export function characterFeatsFromSlugs(featSlugs?: string[]): CharacterFeatDto[] {
  if (!featSlugs?.length) return [];
  const counts = new Map<string, number>();
  return featSlugs.map((featSlug) => {
    const instanceIndex = counts.get(featSlug) ?? 0;
    counts.set(featSlug, instanceIndex + 1);
    return { featSlug, instanceIndex };
  });
}

export function resolveCharacterFeats(input: {
  characterFeats?: CharacterFeatDto[];
  featSlugs?: string[];
}): CharacterFeatDto[] {
  if (input.characterFeats !== undefined) {
    return input.characterFeats;
  }
  if (input.featSlugs !== undefined) {
    return characterFeatsFromSlugs(input.featSlugs);
  }
  return [];
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

export function characterFeatSlugs(feats: CharacterFeatDto[]): string[] {
  return feats.map((feat) => feat.featSlug);
}
