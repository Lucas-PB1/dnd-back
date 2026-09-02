import { FindEditionsQuery } from './find-editions.query';
import { asDep } from '@common/testing/as-dep';

describe('FindEditionsQuery', () => {
  it('returns editions ordered by slug', async () => {
    const editionsRepo = {
      find: jest.fn().mockResolvedValue([
        {
          slug: '2024',
          label: 'PHB 2024',
          book: 'PHB',
          language: 'en',
          notes: null,
        },
      ]),
    };
    const query = new FindEditionsQuery(asDep(editionsRepo));
    await expect(query.execute()).resolves.toEqual([
      {
        slug: '2024',
        label: 'PHB 2024',
        book: 'PHB',
        language: 'en',
        notes: null,
      },
    ]);
  });
});
