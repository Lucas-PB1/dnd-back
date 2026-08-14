import { FindClassSpellsQuery } from './find-class-spells.query';

describe('FindClassSpellsQuery', () => {
  let spellsRepo: { createQueryBuilder: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toClassSpellDto: jest.Mock };
  let query: FindClassSpellsQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      where: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([
        { spellLevel: 0, spellSlug: 'light', spellName: 'Light' },
      ]),
    };
    spellsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = {
      toClassSpellDto: jest.fn((row) => ({ name: row.spellName, slug: row.spellSlug })),
    };
    query = new FindClassSpellsQuery(
      spellsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('filters spells by maxLevel via SQL', async () => {
    const result = await query.execute('wizard', undefined, 20, 0);
    expect(qb.andWhere).toHaveBeenCalledWith('row.spellLevel <= :maxLevel', {
      maxLevel: 0,
    });
    expect(result.data).toEqual([{ name: 'Light', slug: 'light' }]);
    expect(result.meta.hasMore).toBe(false);
  });

  it('allows empty spell list', async () => {
    qb.getMany.mockResolvedValue([]);
    const result = await query.execute('fighter');
    expect(result.data).toEqual([]);
  });
});
