import { FindAlignmentsQuery } from './find-alignments.query';

describe('FindAlignmentsQuery', () => {
  it('finds and paginates alignments', async () => {
    const alignmentsRepo = {
      find: jest.fn().mockResolvedValue([{ slug: 'lg' }]),
    };
    const mapper = { toAlignmentDto: jest.fn().mockReturnValue({ slug: 'lg' }) };
    const query = new FindAlignmentsQuery(
      alignmentsRepo as never,
      mapper as never,
    );
    await expect(query.execute()).resolves.toEqual({
      data: [{ slug: 'lg' }],
      meta: { page: 1, limit: 20, total: 1, totalPages: 1 },
    });
  });
});
