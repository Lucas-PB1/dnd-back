import { NotFoundException } from '@nestjs/common';
import { FindSkillBySlugQuery } from './find-skill-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindSkillBySlugQuery', () => {
  it('maps found skill', async () => {
    const catalogLookup = {
      findSkillOrFail: jest.fn().mockResolvedValue({ slug: 'athletics' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'athletics' }) };
    const query = new FindSkillBySlugQuery(
      asDep(catalogLookup),
      asDep(mapper),
    );
    await expect(query.execute('athletics')).resolves.toEqual({
      slug: 'athletics',
    });
  });

  it('throws when missing', async () => {
    const catalogLookup = {
      findSkillOrFail: jest.fn().mockRejectedValue(new NotFoundException()),
    };
    const query = new FindSkillBySlugQuery(
      asDep(catalogLookup),
      asDep({ toDto: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
