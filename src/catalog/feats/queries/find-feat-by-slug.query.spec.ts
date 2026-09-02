import { NotFoundException } from '@nestjs/common';
import { FindFeatBySlugQuery } from './find-feat-by-slug.query';

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
      catalogLookup as never,
      mapper as never,
      originBackgroundsQuery as never,
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
      catalogLookup as never,
      { toDto: jest.fn() } as never,
      originBackgroundsQuery as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
