import { FindClassFeaturesQuery } from './find-class-features.query';

describe('FindClassFeaturesQuery', () => {
  let featuresRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toClassFeatureDto: jest.Mock };
  let query: FindClassFeaturesQuery;

  beforeEach(() => {
    featuresRepo = {
      find: jest.fn().mockResolvedValue([
        { featureLevel: 1, featureName: 'A' },
        { featureLevel: 5, featureName: 'B' },
      ]),
    };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = {
      toClassFeatureDto: jest.fn((row) => ({ name: row.featureName })),
    };
    query = new FindClassFeaturesQuery(
      featuresRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('filters features by maxLevel', async () => {
    const result = await query.execute('', undefined, 50, 1);
    expect(result.data).toEqual([{ name: 'A' }]);
  });

  it('throws when no features data', async () => {
    featuresRepo.find.mockResolvedValue([]);
    await expect(query.execute('fighter')).rejects.toThrow(/no class features data/i);
  });
});
