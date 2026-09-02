import { NotFoundException } from '@nestjs/common';
import { FindSpellBySlugQuery } from './find-spell-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindSpellBySlugQuery', () => {
  it('maps found spell', async () => {
    const catalogLookup = {
      findSpellOrFail: jest.fn().mockResolvedValue({ slug: 'fireball' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'fireball' }) };
    const query = new FindSpellBySlugQuery(
      asDep(catalogLookup),
      asDep(mapper),
    );
    await expect(query.execute('fireball')).resolves.toEqual({
      slug: 'fireball',
    });
  });

  it('throws when missing', async () => {
    const catalogLookup = {
      findSpellOrFail: jest.fn().mockRejectedValue(new NotFoundException()),
    };
    const query = new FindSpellBySlugQuery(
      asDep(catalogLookup),
      asDep({ toDto: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
