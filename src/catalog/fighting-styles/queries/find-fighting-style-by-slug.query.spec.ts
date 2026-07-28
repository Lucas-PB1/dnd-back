import { NotFoundException } from '@nestjs/common';
import { FindFightingStyleBySlugQuery } from './find-fighting-style-by-slug.query';

describe('FindFightingStyleBySlugQuery', () => {
  it('maps found fighting style', async () => {
    const stylesRepo = { findOne: jest.fn().mockResolvedValue({ slug: 'defense' }) };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'defense' }) };
    const query = new FindFightingStyleBySlugQuery(stylesRepo as never, mapper as never);
    await expect(query.execute('defense')).resolves.toEqual({ slug: 'defense' });
  });

  it('throws when missing', async () => {
    const stylesRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindFightingStyleBySlugQuery(
      stylesRepo as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
