export const NORTHLANDS_EDITION_SLUG = 'northlands-heroes-2024-en';
export const GOLIATH_SPECIES_SLUG = 'goliath';
export const GIANTKIN_SPECIES_SLUG = 'giantkin';

export function isNorthlandsEditionSlug(slug: string): boolean {
  const normalized = slug.trim();
  return (
    normalized === NORTHLANDS_EDITION_SLUG ||
    normalized.startsWith('northlands-')
  );
}

/**
 * Golias (PHB) é substituído por Giganteide (Northlands) quando conteúdo NL está no escopo.
 * Sem filtro de edição = todas as fontes ativas → Northlands no escopo.
 */
export function isNorthlandsCatalogInScope(editionSlugs?: string[]): boolean {
  const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
  if (!slugs?.length) return true;
  return slugs.some(isNorthlandsEditionSlug);
}

export function shouldExcludeGoliathFromCatalog(editionSlugs?: string[]): boolean {
  return isNorthlandsCatalogInScope(editionSlugs);
}

export function isSpeciesExcludedFromCatalog(
  speciesSlug: string,
  editionSlugs?: string[],
): boolean {
  return (
    speciesSlug === GOLIATH_SPECIES_SLUG &&
    shouldExcludeGoliathFromCatalog(editionSlugs)
  );
}
