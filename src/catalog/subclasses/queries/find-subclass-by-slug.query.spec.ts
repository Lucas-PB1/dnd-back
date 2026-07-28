import { FindSubclassBySlugQuery } from './find-subclass-by-slug.query';

describe('FindSubclassBySlugQuery', () => {
  it('maps found subclass', async () => {
    const catalogLookup = {
      findSubclassOrFail: jest.fn().mockResolvedValue({ subclassSlug: 'champion' }),
    };
    const mapper = { toSubclassDto: jest.fn().mockReturnValue({ slug: 'champion' }) };
    const query = new FindSubclassBySlugQuery(catalogLookup as never, mapper as never);
    await expect(query.execute('champion')).resolves.toEqual({ slug: 'champion' });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findSubclassOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindSubclassBySlugQuery(
      catalogLookup as never,
      { toSubclassDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
