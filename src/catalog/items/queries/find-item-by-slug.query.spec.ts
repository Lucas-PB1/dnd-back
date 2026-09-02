import { NotFoundException } from '@nestjs/common';
import { FindItemBySlugQuery } from './find-item-by-slug.query';

describe('FindItemBySlugQuery', () => {
  it('maps found item', async () => {
    const catalogLookup = {
      findItemOrFail: jest.fn().mockResolvedValue({ slug: 'rope' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'rope' }) };
    const query = new FindItemBySlugQuery(
      catalogLookup as never,
      mapper as never,
    );
    await expect(query.execute('rope')).resolves.toEqual({ slug: 'rope' });
  });

  it('throws when missing', async () => {
    const catalogLookup = {
      findItemOrFail: jest.fn().mockRejectedValue(new NotFoundException()),
    };
    const query = new FindItemBySlugQuery(
      catalogLookup as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
