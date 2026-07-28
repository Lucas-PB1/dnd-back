import { FindFightingStylesQuery } from './find-fighting-styles.query';

describe('FindFightingStylesQuery', () => {
  let stylesRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let query: FindFightingStylesQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ slug: 'defense' }]),
    };
    stylesRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toDto: jest.fn().mockReturnValue({ slug: 'defense' }) };
    query = new FindFightingStylesQuery(stylesRepo as never, mapper as never);
  });

  it('filters by class and search', async () => {
    const result = await query.execute(1, 20, 'fighter', 'defesa');
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('ILIKE :q'),
      { q: '%defesa%' },
    );
    expect(qb.andWhere).toHaveBeenCalledWith(
      expect.stringContaining('EXISTS'),
      { classSlug: 'fighter' },
    );
    expect(result.data).toEqual([{ slug: 'defense' }]);
  });

  it('skips filters when absent', async () => {
    await query.execute();
    expect(qb.andWhere).not.toHaveBeenCalled();
  });
});
