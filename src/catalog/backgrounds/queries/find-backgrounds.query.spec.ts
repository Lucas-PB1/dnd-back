import { FindBackgroundsQuery } from './find-backgrounds.query';

describe('FindBackgroundsQuery', () => {
  let backgroundsRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let query: FindBackgroundsQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ backgroundSlug: 'soldier' }]),
    };
    backgroundsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toDto: jest.fn().mockReturnValue({ slug: 'soldier' }) };
    query = new FindBackgroundsQuery(backgroundsRepo as never, mapper as never);
  });

  it('searches and maps backgrounds', async () => {
    const result = await query.execute(undefined, 20, 'soldado');
    expect(qb.andWhere).toHaveBeenCalled();
    expect(result.data).toEqual([{ slug: 'soldier' }]);
  });

  it('does not filter GH backgrounds by slug prefix', async () => {
    await query.execute();
    const slugFilters = qb.andWhere.mock.calls.filter(([clause]) =>
      String(clause).includes('gh-%'),
    );
    expect(slugFilters).toHaveLength(0);
  });
});
