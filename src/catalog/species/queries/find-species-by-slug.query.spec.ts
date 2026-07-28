import { FindSpeciesBySlugQuery } from './find-species-by-slug.query';

describe('FindSpeciesBySlugQuery', () => {
  it('maps found species', async () => {
    const catalogLookup = {
      findSpeciesOrFail: jest.fn().mockResolvedValue({ slug: 'human' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'human' }) };
    const query = new FindSpeciesBySlugQuery(catalogLookup as never, mapper as never);
    await expect(query.execute('human')).resolves.toEqual({ slug: 'human' });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findSpeciesOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindSpeciesBySlugQuery(
      catalogLookup as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
