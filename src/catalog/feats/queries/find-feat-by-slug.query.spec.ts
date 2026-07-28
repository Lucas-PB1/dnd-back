import { NotFoundException } from '@nestjs/common';
import { FindFeatBySlugQuery } from './find-feat-by-slug.query';

describe('FindFeatBySlugQuery', () => {
  it('maps found feat', async () => {
    const featsRepo = {
      findOne: jest.fn().mockResolvedValue({ featSlug: 'alert' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'alert' }) };
    const query = new FindFeatBySlugQuery(featsRepo as never, mapper as never);
    await expect(query.execute('alert')).resolves.toEqual({ slug: 'alert' });
  });

  it('throws when missing', async () => {
    const featsRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindFeatBySlugQuery(
      featsRepo as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
