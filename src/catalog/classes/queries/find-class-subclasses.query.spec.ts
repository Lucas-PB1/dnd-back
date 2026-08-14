import { FindClassSubclassesQuery } from './find-class-subclasses.query';

describe('FindClassSubclassesQuery', () => {
  let subclassesRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toSubclassDto: jest.Mock };
  let query: FindClassSubclassesQuery;

  beforeEach(() => {
    subclassesRepo = {
      find: jest.fn().mockResolvedValue([{ subclassSlug: 'champion' }]),
    };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toSubclassDto: jest.fn().mockReturnValue({ slug: 'champion' }) };
    query = new FindClassSubclassesQuery(
      subclassesRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('validates class and paginates subclasses', async () => {
    const result = await query.execute('fighter', undefined, 20);
    expect(catalogLookup.findClassOrFail).toHaveBeenCalledWith('fighter');
    expect(result.data).toEqual([{ slug: 'champion' }]);
    expect(result.meta).toMatchObject({ hasMore: false, limit: 20 });
  });

  it('allows empty subclass list', async () => {
    subclassesRepo.find.mockResolvedValue([]);
    const result = await query.execute('fighter');
    expect(result.data).toEqual([]);
  });
});
