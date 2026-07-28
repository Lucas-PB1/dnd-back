import { NotFoundException } from '@nestjs/common';
import { FindArmorBySlugQuery } from './find-armor-by-slug.query';

describe('FindArmorBySlugQuery', () => {
  it('maps found armor', async () => {
    const armorRepo = {
      findOne: jest.fn().mockResolvedValue({ itemSlug: 'chain-mail' }),
    };
    const mapper = { toArmorDto: jest.fn().mockReturnValue({ slug: 'chain-mail' }) };
    const query = new FindArmorBySlugQuery(armorRepo as never, mapper as never);
    await expect(query.execute('chain-mail')).resolves.toEqual({ slug: 'chain-mail' });
  });

  it('throws when missing', async () => {
    const armorRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindArmorBySlugQuery(
      armorRepo as never,
      { toArmorDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
