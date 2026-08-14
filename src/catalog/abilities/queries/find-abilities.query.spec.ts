import { FindAbilitiesQuery } from './find-abilities.query';

describe('FindAbilitiesQuery', () => {
  it('finds and paginates abilities', async () => {
    const abilitiesRepo = {
      find: jest.fn().mockResolvedValue([
        { slug: 'forca', sortOrder: 1 },
        { slug: 'destreza', sortOrder: 2 },
      ]),
    };
    const mapper = {
      toDto: jest.fn((row) => ({ slug: row.slug, sortOrder: row.sortOrder })),
    };
    const query = new FindAbilitiesQuery(abilitiesRepo as never, mapper as never);
    const result = await query.execute(undefined, 1);
    expect(result.data).toEqual([{ slug: 'forca', sortOrder: 1 }]);
    expect(result.meta.hasMore).toBe(true);
    expect(result.meta.nextCursor).toBeTruthy();
  });
});
