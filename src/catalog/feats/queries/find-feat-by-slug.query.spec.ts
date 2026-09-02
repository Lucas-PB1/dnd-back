import { NotFoundException } from '@nestjs/common';
import { FindFeatBySlugQuery } from './find-feat-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindFeatBySlugQuery', () => {
  const originBackgroundsQuery = {
    execute: jest.fn().mockResolvedValue([]),
  };

  it('maps found feat', async () => {
    const catalogLookup = {
      findFeatOrFail: jest.fn().mockResolvedValue({ featSlug: 'alert' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'alert' }) };
    const query = new FindFeatBySlugQuery(
      asDep(catalogLookup),
      asDep(mapper),
      asDep(originBackgroundsQuery),
    );
    await expect(query.execute('alert')).resolves.toEqual({
      slug: 'alert',
      originBackgrounds: [],
    });
    expect(originBackgroundsQuery.execute).toHaveBeenCalledWith('alert');
  });

  it('throws when missing', async () => {
    const catalogLookup = {
      findFeatOrFail: jest.fn().mockRejectedValue(new NotFoundException()),
    };
    const query = new FindFeatBySlugQuery(
      asDep(catalogLookup),
      asDep({ toDto: jest.fn() }),
      asDep(originBackgroundsQuery),
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
