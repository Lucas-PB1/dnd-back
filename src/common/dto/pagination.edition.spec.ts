import {
  DEFAULT_PHB_EDITION_SLUG,
  filterRowsByEditionSlug,
  normalizePagination,
  parseEditionSlugsParam,
} from './pagination.dto';

describe('edition slug catalog helpers', () => {
  it('parses CSV and repeated values', () => {
    expect(parseEditionSlugsParam('phb-2024-pt,valdas-spire-2024-en')).toEqual([
      'phb-2024-pt',
      'valdas-spire-2024-en',
    ]);
    expect(parseEditionSlugsParam(['phb-2024-pt', 'valdas-spire-2024-en'])).toEqual([
      'phb-2024-pt',
      'valdas-spire-2024-en',
    ]);
    expect(parseEditionSlugsParam('')).toBeUndefined();
  });

  it('filters rows with PHB default when editionSlug is null', () => {
    const rows = [
      { slug: 'fighter', editionSlug: 'phb-2024-pt' },
      { slug: 'gunslinger', editionSlug: 'valdas-spire-2024-en' },
      { slug: 'human', editionSlug: null },
    ];
    expect(
      filterRowsByEditionSlug(rows, ['phb-2024-pt']).map((row) => row.slug),
    ).toEqual(['fighter', 'human']);
    expect(
      filterRowsByEditionSlug(rows, ['valdas-spire-2024-en']).map((row) => row.slug),
    ).toEqual(['gunslinger']);
  });

  it('exports default PHB edition constant', () => {
    expect(DEFAULT_PHB_EDITION_SLUG).toBe('phb-2024-pt');
  });
});

describe('normalizePagination', () => {
  it('clamps page and limit', () => {
    expect(normalizePagination(0, 0)).toEqual({ page: 1, limit: 1 });
    expect(normalizePagination(2, 200)).toEqual({ page: 2, limit: 100 });
  });
});
