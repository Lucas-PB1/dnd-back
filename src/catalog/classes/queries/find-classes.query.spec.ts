import { FindClassesQuery } from './find-classes.query';

describe('FindClassesQuery', () => {
  let classesRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toClassDto: jest.Mock };
  let query: FindClassesQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ classSlug: 'fighter' }]),
    };
    classesRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toClassDto: jest.fn().mockReturnValue({ slug: 'fighter' }) };
    query = new FindClassesQuery(classesRepo as never, mapper as never);
  });

  it('searches and maps', async () => {
    const result = await query.execute(1, 20, 'guer');
    expect(qb.andWhere).toHaveBeenCalled();
    expect(result.data).toEqual([{ slug: 'fighter' }]);
  });

  it('skips search when q absent', async () => {
    await query.execute();
    expect(qb.andWhere).not.toHaveBeenCalled();
  });
});
