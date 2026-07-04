import { VPhbBackground } from '../../../entities/views/v-phb-background.entity';

export function resolveBackgroundOriginFeatSlugs(
  background: Pick<VPhbBackground, 'featSlug'>,
  provided?: string[],
): string[] {
  const slugs = [...(provided ?? [])];
  const origin = background.featSlug?.trim();
  if (origin && !slugs.includes(origin)) {
    slugs.unshift(origin);
  }
  return slugs;
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
