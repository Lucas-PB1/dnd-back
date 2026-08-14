import { FindAlignmentsQuery } from './find-alignments.query';

describe('FindAlignmentsQuery', () => {
  it('finds and paginates alignments', async () => {
    const alignmentsRepo = {
      find: jest.fn().mockResolvedValue([{ slug: 'lg', name: 'Leal e Bom' }]),
    };
    const mapper = {
      toAlignmentDto: jest.fn().mockReturnValue({
        slug: 'lg',
        name: 'Leal e Bom',
      }),
    };
    const query = new FindAlignmentsQuery(
      alignmentsRepo as never,
      mapper as never,
    );
    await expect(query.execute()).resolves.toEqual({
      data: [{ slug: 'lg', name: 'Leal e Bom' }],
      meta: { limit: 20, nextCursor: null, hasMore: false },
    });
  });
});
