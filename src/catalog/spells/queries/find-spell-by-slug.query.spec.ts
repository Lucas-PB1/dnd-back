import { NotFoundException } from '@nestjs/common';
import { FindSpellBySlugQuery } from './find-spell-by-slug.query';

describe('FindSpellBySlugQuery', () => {
  it('maps found spell', async () => {
    const spellsRepo = { findOne: jest.fn().mockResolvedValue({ slug: 'fireball' }) };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'fireball' }) };
    const query = new FindSpellBySlugQuery(spellsRepo as never, mapper as never);
    await expect(query.execute('fireball')).resolves.toEqual({ slug: 'fireball' });
  });

  it('throws when missing', async () => {
    const spellsRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindSpellBySlugQuery(
      spellsRepo as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
