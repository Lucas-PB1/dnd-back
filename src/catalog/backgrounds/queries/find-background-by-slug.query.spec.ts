import { FindBackgroundBySlugQuery } from './find-background-by-slug.query';

describe('FindBackgroundBySlugQuery', () => {
  it('maps found background', async () => {
    const catalogLookup = {
      findBackgroundOrFail: jest.fn().mockResolvedValue({ backgroundSlug: 'soldier' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'soldier' }) };
    const query = new FindBackgroundBySlugQuery(catalogLookup as never, mapper as never);
    await expect(query.execute('soldier')).resolves.toEqual({ slug: 'soldier' });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findBackgroundOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindBackgroundBySlugQuery(
      catalogLookup as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
