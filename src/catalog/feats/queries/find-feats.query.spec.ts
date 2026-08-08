import { FindFeatsQuery } from './find-feats.query';

describe('FindFeatsQuery', () => {
  let featsRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock; toSummaryDto: jest.Mock };
  let query: FindFeatsQuery;
  let qb: {
    select: jest.Mock;
    orderBy: jest.Mock;
    andWhere: jest.Mock;
    getCount: jest.Mock;
    skip: jest.Mock;
    take: jest.Mock;
    getMany: jest.Mock;
  };

  beforeEach(() => {
    qb = {
      select: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ featSlug: 'alert' }]),
    };
    featsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = {
      toDto: jest.fn().mockReturnValue({ slug: 'alert' }),
      toSummaryDto: jest.fn().mockReturnValue({
        slug: 'alert',
        name: 'Alerta',
        categorySlug: 'origin',
      }),
    };
    query = new FindFeatsQuery(featsRepo as never, mapper as never);
  });

  it('paginates and maps feats with search', async () => {
    const result = await query.execute(1, 20, 'alerta', 'origin');
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('ILIKE :q'),
      { q: '%alerta%' },
    );
    expect(qb.andWhere).toHaveBeenCalledWith('feat.categorySlug = :categorySlug', {
      categorySlug: 'origin',
    });
    expect(result).toEqual({
      data: [{ slug: 'alert' }],
      meta: { page: 1, limit: 20, total: 1, totalPages: 1 },
    });
  });

  it('skips filters when absent', async () => {
    await query.execute();
    expect(qb.andWhere).not.toHaveBeenCalled();
  });

  it('maps summary when fields=summary', async () => {
    const result = await query.execute(
      1,
      20,
      undefined,
      undefined,
      undefined,
      'summary',
    );
    expect(qb.select).toHaveBeenCalled();
    expect(mapper.toSummaryDto).toHaveBeenCalled();
    expect(result.data[0]).toEqual({
      slug: 'alert',
      name: 'Alerta',
      categorySlug: 'origin',
    });
  });
});
