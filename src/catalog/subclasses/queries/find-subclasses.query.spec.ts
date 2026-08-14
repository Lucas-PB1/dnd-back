import { FindSubclassesQuery } from './find-subclasses.query';

describe('FindSubclassesQuery', () => {
  let subclassesRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toSubclassDto: jest.Mock };
  let query: FindSubclassesQuery;
  let qb: {
    orderBy: jest.Mock;
    addOrderBy: jest.Mock;
    andWhere: jest.Mock;
    take: jest.Mock;
    getMany: jest.Mock;
  };

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ subclassSlug: 'champion' }]),
    };
    subclassesRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toSubclassDto: jest.fn().mockReturnValue({ slug: 'champion' }) };
    query = new FindSubclassesQuery(subclassesRepo as never, mapper as never);
  });

  it('filters by class and maps', async () => {
    const result = await query.execute(undefined, 20, 'campe', 'fighter');
    expect(qb.andWhere).toHaveBeenCalledWith('sc.classSlug = :classSlug', {
      classSlug: 'fighter',
    });
    expect(result.data).toEqual([{ slug: 'champion' }]);
  });

  it('skips class filter when blank', async () => {
    await query.execute(undefined, 20);
    expect(qb.andWhere).not.toHaveBeenCalledWith(
      'sc.classSlug = :classSlug',
      expect.anything(),
    );
  });
});
