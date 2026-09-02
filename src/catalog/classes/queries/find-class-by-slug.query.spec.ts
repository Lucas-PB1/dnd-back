import { FindClassBySlugQuery } from './find-class-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindClassBySlugQuery', () => {
  it('merges class dto with proficiencies', async () => {
    const catalogLookup = {
      findClassOrFail: jest.fn().mockResolvedValue({ classSlug: 'fighter' }),
    };
    const mapper = { toClassDto: jest.fn().mockReturnValue({ slug: 'fighter' }) };
    const proficiencies = {
      forClassSlug: jest.fn().mockResolvedValue({ armor: ['light'] }),
    };
    const query = new FindClassBySlugQuery(
      asDep(catalogLookup),
      asDep(mapper),
      asDep(proficiencies),
    );
    await expect(query.execute('fighter')).resolves.toEqual({
      slug: 'fighter',
      armor: ['light'],
    });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findClassOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindClassBySlugQuery(
      asDep(catalogLookup),
      asDep({ toClassDto: jest.fn() }),
      asDep({ forClassSlug: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
