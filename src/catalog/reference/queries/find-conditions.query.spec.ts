import { FindConditionsQuery } from './find-conditions.query';
import { asDep } from '@common/testing/as-dep';

describe('FindConditionsQuery', () => {
  it('returns conditions ordered by name', async () => {
    const conditionsRepo = {
      find: jest.fn().mockResolvedValue([{ slug: 'blinded', name: 'Blinded' }]),
    };
    const query = new FindConditionsQuery(asDep(conditionsRepo));
    await expect(query.execute()).resolves.toEqual([
      { slug: 'blinded', name: 'Blinded' },
    ]);
  });
});
