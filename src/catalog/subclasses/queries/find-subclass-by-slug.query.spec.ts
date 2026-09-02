import { FindSubclassBySlugQuery } from './find-subclass-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindSubclassBySlugQuery', () => {
  it('maps found subclass', async () => {
    const catalogLookup = {
      findSubclassOrFail: jest.fn().mockResolvedValue({ subclassSlug: 'champion' }),
    };
    const mapper = { toSubclassDto: jest.fn().mockReturnValue({ slug: 'champion' }) };
    const query = new FindSubclassBySlugQuery(asDep(catalogLookup), asDep(mapper));
    await expect(query.execute('champion')).resolves.toEqual({ slug: 'champion' });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findSubclassOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindSubclassBySlugQuery(
      asDep(catalogLookup),
      asDep({ toSubclassDto: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
