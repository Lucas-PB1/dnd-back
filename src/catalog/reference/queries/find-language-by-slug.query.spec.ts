import { NotFoundException } from '@nestjs/common';
import { FindLanguageBySlugQuery } from './find-language-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindLanguageBySlugQuery', () => {
  it('maps found language', async () => {
    const catalogLookup = {
      findLanguageOrFail: jest.fn().mockResolvedValue({ slug: 'common' }),
    };
    const mapper = {
      toLanguageDto: jest.fn().mockReturnValue({ slug: 'common' }),
    };
    const query = new FindLanguageBySlugQuery(
      asDep(catalogLookup),
      asDep(mapper),
    );
    await expect(query.execute('common')).resolves.toEqual({ slug: 'common' });
  });

  it('throws when missing', async () => {
    const catalogLookup = {
      findLanguageOrFail: jest.fn().mockRejectedValue(new NotFoundException()),
    };
    const query = new FindLanguageBySlugQuery(
      asDep(catalogLookup),
      asDep({ toLanguageDto: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
