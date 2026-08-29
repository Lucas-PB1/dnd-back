import {
  GOLIATH_SPECIES_SLUG,
  isNorthlandsCatalogInScope,
  isSpeciesExcludedFromCatalog,
  NORTHLANDS_EDITION_SLUG,
  shouldExcludeGoliathFromCatalog,
} from './species-edition-gating';

describe('species-edition-gating', () => {
  describe('isNorthlandsCatalogInScope', () => {
    it('treats empty filter as all editions (Northlands in scope)', () => {
      expect(isNorthlandsCatalogInScope()).toBe(true);
      expect(isNorthlandsCatalogInScope([])).toBe(true);
    });

    it('detects Northlands in explicit filter', () => {
      expect(
        isNorthlandsCatalogInScope(['phb-2024-pt', NORTHLANDS_EDITION_SLUG]),
      ).toBe(true);
      expect(isNorthlandsCatalogInScope(['northlands-foo'])).toBe(true);
    });

    it('is false when only non-Northlands editions are selected', () => {
      expect(isNorthlandsCatalogInScope(['phb-2024-pt'])).toBe(false);
      expect(isNorthlandsCatalogInScope(['valdas-spire-2024-en'])).toBe(false);
    });
  });

  describe('shouldExcludeGoliathFromCatalog', () => {
    it('excludes Golias when Northlands is in scope', () => {
      expect(shouldExcludeGoliathFromCatalog()).toBe(true);
      expect(shouldExcludeGoliathFromCatalog([NORTHLANDS_EDITION_SLUG])).toBe(
        true,
      );
    });

    it('keeps Golias when only PHB is selected', () => {
      expect(shouldExcludeGoliathFromCatalog(['phb-2024-pt'])).toBe(false);
    });
  });

  describe('isSpeciesExcludedFromCatalog', () => {
    it('only excludes goliath slug', () => {
      expect(isSpeciesExcludedFromCatalog(GOLIATH_SPECIES_SLUG)).toBe(true);
      expect(
        isSpeciesExcludedFromCatalog(GOLIATH_SPECIES_SLUG, ['phb-2024-pt']),
      ).toBe(false);
      expect(isSpeciesExcludedFromCatalog('giantkin')).toBe(false);
    });
  });
});
