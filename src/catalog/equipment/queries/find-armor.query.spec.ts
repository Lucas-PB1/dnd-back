import { FindArmorQuery } from './find-armor.query';

describe('FindArmorQuery', () => {
  let armorRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toArmorDto: jest.Mock };
  let query: FindArmorQuery;
  let qb: {
    orderBy: jest.Mock;
    andWhere: jest.Mock;
    getCount: jest.Mock;
    skip: jest.Mock;
    take: jest.Mock;
    getMany: jest.Mock;
  };

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(1),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ itemSlug: 'leather-armor' }]),
    };
    armorRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toArmorDto: jest.fn().mockReturnValue({ slug: 'leather-armor' }) };
    query = new FindArmorQuery(armorRepo as never, mapper as never);
  });

  it('filters by category and maps', async () => {
    const result = await query.execute(1, 20, 'couro', 'light');
    expect(qb.andWhere).toHaveBeenCalledWith('armor.category_slug = :categorySlug', {
      categorySlug: 'light',
    });
    expect(result.data).toEqual([{ slug: 'leather-armor' }]);
  });

  it('skips category when absent', async () => {
    await query.execute();
    expect(qb.andWhere).not.toHaveBeenCalled();
  });
});
