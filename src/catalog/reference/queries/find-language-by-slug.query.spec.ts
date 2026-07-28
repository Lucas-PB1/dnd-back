import { NotFoundException } from '@nestjs/common';
import { FindLanguageBySlugQuery } from './find-language-by-slug.query';

describe('FindLanguageBySlugQuery', () => {
  it('maps found language', async () => {
    const languagesRepo = { findOne: jest.fn().mockResolvedValue({ slug: 'common' }) };
    const mapper = { toLanguageDto: jest.fn().mockReturnValue({ slug: 'common' }) };
    const query = new FindLanguageBySlugQuery(languagesRepo as never, mapper as never);
    await expect(query.execute('common')).resolves.toEqual({ slug: 'common' });
  });

  it('throws when missing', async () => {
    const languagesRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindLanguageBySlugQuery(
      languagesRepo as never,
      { toLanguageDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
