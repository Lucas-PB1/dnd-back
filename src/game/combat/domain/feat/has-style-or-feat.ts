export type StyleOrFeatContext = {
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
};

export function hasStyleOrFeat(
  context: StyleOrFeatContext | undefined,
  slug: string,
): boolean {
  return (
    (context?.featSlugs ?? []).includes(slug) ||
    (context?.fightingStyleSlugs ?? []).includes(slug)
  );
}
