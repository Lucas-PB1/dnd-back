import { FindToolPoolsQuery } from './find-tool-pools.query';
import { asDep } from '@common/testing/as-dep';

describe('FindToolPoolsQuery', () => {
  it('groups items by pool in stable order', async () => {
    const items = {
      find: jest.fn().mockResolvedValue([
        { slug: 'alaude', name: 'Alaúde', pool: 'instrument' },
        { slug: 'baralho', name: 'Baralho', pool: 'gaming' },
        { slug: 'ferramentas-de-carpinteiro', name: 'Ferramentas de Carpinteiro', pool: 'artisan' },
      ]),
    };
    const query = new FindToolPoolsQuery(asDep(items));
    const result = await query.execute();
    expect(result.map((row) => row.pool)).toEqual([
      'instrument',
      'gaming',
      'artisan',
    ]);
    expect(result[0].items).toEqual([{ slug: 'alaude', name: 'Alaúde' }]);
    expect(result[2].items[0].slug).toBe('ferramentas-de-carpinteiro');
  });
});
