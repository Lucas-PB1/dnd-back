import { FindSpeciesQuery } from './find-species.query';

describe('FindSpeciesQuery', () => {
  let speciesRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let query: FindSpeciesQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ slug: 'human' }]),
    };
    speciesRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toDto: jest.fn().mockReturnValue({ slug: 'human' }) };
    query = new FindSpeciesQuery(speciesRepo as never, mapper as never);
  });

  it('searches and maps species', async () => {
    const result = await query.execute(undefined, 20, 'humano');
    expect(qb.andWhere).toHaveBeenCalled();
    expect(result.data).toEqual([{ slug: 'human' }]);
  });

  it('skips search when q absent', async () => {
    await query.execute();
    expect(qb.andWhere).toHaveBeenCalledWith(
      `COALESCE(species.source_meta->>'variantOf', '') = ''`,
    );
  });

  it('excludes goliath when Northlands is in catalog scope', async () => {
    await query.execute(undefined, 20, undefined, ['northlands-heroes-2024-en']);
    expect(qb.andWhere).toHaveBeenCalledWith(
      'species.slug <> :excludedGoliathSlug',
      { excludedGoliathSlug: 'goliath' },
    );
  });

  it('keeps goliath when only PHB is selected', async () => {
    qb.andWhere.mockClear();
    await query.execute(undefined, 20, undefined, ['phb-2024-pt']);
    expect(qb.andWhere).not.toHaveBeenCalledWith(
      'species.slug <> :excludedGoliathSlug',
      { excludedGoliathSlug: 'goliath' },
    );
  });
});
