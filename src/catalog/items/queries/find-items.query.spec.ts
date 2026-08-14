import { FindItemsQuery } from './find-items.query';

describe('FindItemsQuery', () => {
  let itemsRepo: { createQueryBuilder: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let query: FindItemsQuery;
  let qb: Record<string, jest.Mock>;

  beforeEach(() => {
    qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([{ slug: 'rope' }]),
    };
    itemsRepo = { createQueryBuilder: jest.fn().mockReturnValue(qb) };
    mapper = { toDto: jest.fn().mockReturnValue({ slug: 'rope' }) };
    query = new FindItemsQuery(itemsRepo as never, mapper as never);
  });

  it('searches and filters by item type', async () => {
    const result = await query.execute(undefined, 20, 'corda', { itemType: 'gear' });
    expect(qb.andWhere).toHaveBeenCalledWith('item.itemType = :itemType', {
      itemType: 'gear',
    });
    expect(result.data).toEqual([{ slug: 'rope' }]);
  });

  it('filters multiple item types', async () => {
    await query.execute(undefined, 20, undefined, { itemType: 'gear,tool' });
    expect(qb.andWhere).toHaveBeenCalledWith('item.itemType IN (:...types)', {
      types: ['gear', 'tool'],
    });
  });

  it('always excludes class-granted catalog items', async () => {
    await query.execute();
    expect(qb.andWhere).toHaveBeenCalledWith(
      `(item.properties->>'grantedBySubclass' IS NULL AND item.properties->>'grantedByClass' IS NULL)`,
    );
  });

  it('can exclude coverage overlays', async () => {
    await query.execute(undefined, 20, undefined, { excludeCoverage: true });
    expect(qb.andWhere).toHaveBeenCalledWith(
      `(item.properties->>'kind' IS NULL OR (item.properties->>'kind') <> 'coverage')`,
    );
  });

  it('can filter attunement and sort by cost', async () => {
    await query.execute(undefined, 20, undefined, {
      requiresAttunement: true,
      sort: 'cost_desc',
    });
    expect(qb.andWhere).toHaveBeenCalledWith(
      `(item.properties->>'requiresAttunement') = 'true'`,
    );
    expect(qb.orderBy).toHaveBeenCalled();
    expect(qb.addOrderBy).toHaveBeenCalledWith('item.name', 'ASC');
  });
});
