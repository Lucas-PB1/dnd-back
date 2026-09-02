import { FindFeatsBySlugsQuery } from './find-feats-by-slugs.query';
import { asDep } from '@common/testing/as-dep';

describe('FindFeatsBySlugsQuery', () => {
  it('returns feats in requested slug order and skips missing', async () => {
    const featsRepo = {
      find: jest.fn().mockResolvedValue([
        { featSlug: 'alert', featName: 'Alerta' },
        { featSlug: 'tough', featName: 'Robusto' },
      ]),
    };
    const mapper = {
      toDto: jest.fn((row: { featSlug: string }) => ({ slug: row.featSlug })),
    };
    const query = new FindFeatsBySlugsQuery(
      asDep(featsRepo),
      asDep(mapper),
    );

    const result = await query.execute(['tough', 'missing', 'alert']);
    expect(result.map((row) => row.slug)).toEqual(['tough', 'alert']);
  });

  it('returns empty for empty input', async () => {
    const featsRepo = { find: jest.fn() };
    const query = new FindFeatsBySlugsQuery(
      asDep(featsRepo),
      asDep({ toDto: jest.fn() }),
    );
    await expect(query.execute([])).resolves.toEqual([]);
    expect(featsRepo.find).not.toHaveBeenCalled();
  });
});
