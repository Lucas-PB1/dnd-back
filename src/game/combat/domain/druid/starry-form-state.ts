export type StellarConstellation = 'archer' | 'chalice' | 'dragon';

const STARRY_FORM_SLUGS: Record<StellarConstellation, string> = {
  archer: 'starry-form-archer',
  chalice: 'starry-form-chalice',
  dragon: 'starry-form-dragon',
};

export function starryFormSlugForConstellation(
  constellation: StellarConstellation,
): string {
  return STARRY_FORM_SLUGS[constellation];
}

export function constellationFromStarryFormSlug(
  slug: string,
): StellarConstellation | null {
  for (const [constellation, formSlug] of Object.entries(STARRY_FORM_SLUGS)) {
    if (formSlug === slug) {
      return constellation as StellarConstellation;
    }
  }
  return null;
}

export function stellarConstellationLabel(
  constellation: StellarConstellation,
): string {
  switch (constellation) {
    case 'archer':
      return 'Arqueiro';
    case 'chalice':
      return 'Taça';
    case 'dragon':
      return 'Dragão';
  }
}
