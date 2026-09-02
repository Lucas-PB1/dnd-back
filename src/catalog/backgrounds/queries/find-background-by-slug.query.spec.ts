import { FindBackgroundBySlugQuery } from './find-background-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindBackgroundBySlugQuery', () => {
  it('maps found background', async () => {
    const catalogLookup = {
      findBackgroundOrFail: jest.fn().mockResolvedValue({ backgroundSlug: 'soldier' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'soldier' }) };
    const query = new FindBackgroundBySlugQuery(asDep(catalogLookup), asDep(mapper));
    await expect(query.execute('soldier')).resolves.toEqual({ slug: 'soldier' });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findBackgroundOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindBackgroundBySlugQuery(
      asDep(catalogLookup),
      asDep({ toDto: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
