import { FindAbilitiesQuery } from './find-abilities.query';

describe('FindAbilitiesQuery', () => {
  it('finds and paginates abilities', async () => {
    const abilitiesRepo = {
      find: jest.fn().mockResolvedValue([{ slug: 'forca' }, { slug: 'destreza' }]),
    };
    const mapper = { toDto: jest.fn((row) => ({ slug: row.slug })) };
    const query = new FindAbilitiesQuery(abilitiesRepo as never, mapper as never);
    const result = await query.execute(1, 1);
    expect(result.data).toEqual([{ slug: 'forca' }]);
    expect(result.meta.total).toBe(2);
  });
});
