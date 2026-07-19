import {
  applyIlikeSearch,
  normalizePagination,
  paginate,
  paginateQb,
} from './pagination.dto';

describe('pagination helpers', () => {
  it('normalizePagination clamps page and limit', () => {
    expect(normalizePagination(0, 0)).toEqual({ page: 1, limit: 1 });
    expect(normalizePagination(2, 500)).toEqual({ page: 2, limit: 100 });
  });

  it('paginate clamps page to totalPages', () => {
    const result = paginate(['a', 'b', 'c'], 99, 2);
    expect(result.meta).toEqual({
      page: 2,
      limit: 2,
      total: 3,
      totalPages: 2,
    });
    expect(result.data).toEqual(['c']);
  });

  it('applyIlikeSearch skips blank terms', () => {
    const qb = { andWhere: jest.fn() };
    applyIlikeSearch(qb as never, ['name'], '  ');
    expect(qb.andWhere).not.toHaveBeenCalled();
  });

  it('applyIlikeSearch builds OR ILIKE clause', () => {
    const qb = { andWhere: jest.fn() };
    applyIlikeSearch(qb as never, ['a.name', 'a.slug'], 'sword');
    expect(qb.andWhere).toHaveBeenCalledWith('(a.name ILIKE :q OR a.slug ILIKE :q)', {
      q: '%sword%',
    });
  });

  it('paginateQb counts then pages with clamp', async () => {
    const qb = {
      getCount: jest.fn().mockResolvedValue(3),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue(['c']),
    };

    const result = await paginateQb(qb as never, 99, 2);
    expect(qb.skip).toHaveBeenCalledWith(2);
    expect(qb.take).toHaveBeenCalledWith(2);
    expect(result).toEqual({
      rows: ['c'],
      meta: { page: 2, limit: 2, total: 3, totalPages: 2 },
    });
  });
});
