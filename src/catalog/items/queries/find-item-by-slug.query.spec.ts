import { NotFoundException } from '@nestjs/common';
import { FindItemBySlugQuery } from './find-item-by-slug.query';

describe('FindItemBySlugQuery', () => {
  it('maps found item', async () => {
    const itemsRepo = { findOne: jest.fn().mockResolvedValue({ slug: 'rope' }) };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'rope' }) };
    const query = new FindItemBySlugQuery(itemsRepo as never, mapper as never);
    await expect(query.execute('rope')).resolves.toEqual({ slug: 'rope' });
  });

  it('throws when missing', async () => {
    const itemsRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindItemBySlugQuery(
      itemsRepo as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
