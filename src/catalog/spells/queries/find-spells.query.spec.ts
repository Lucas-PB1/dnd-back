import { FindSpellsQuery } from './find-spells.query';

describe('FindSpellsQuery', () => {
  let spellsRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let query: FindSpellsQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ slug: 'fireball' }]),
    };
    spellsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toDto: jest.fn().mockReturnValue({ slug: 'fireball' }) };
    query = new FindSpellsQuery(spellsRepo as never, mapper as never);
  });

  it('filters by level and school', async () => {
    const result = await query.execute(undefined, 20, 'bola', 3, 'evocation');
    expect(qb.andWhere).toHaveBeenCalledWith('spell.level = :level', { level: 3 });
    expect(qb.andWhere).toHaveBeenCalledWith('spell.schoolSlug = :schoolSlug', {
      schoolSlug: 'evocation',
    });
    expect(result.data).toEqual([{ slug: 'fireball' }]);
  });

  it('skips optional filters when absent', async () => {
    await query.execute();
    expect(qb.andWhere).not.toHaveBeenCalled();
  });
});
