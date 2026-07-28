import { FindConditionsQuery } from './find-conditions.query';

describe('FindConditionsQuery', () => {
  it('returns conditions ordered by name', async () => {
    const conditionsRepo = {
      find: jest.fn().mockResolvedValue([{ slug: 'blinded', name: 'Blinded' }]),
    };
    const query = new FindConditionsQuery(conditionsRepo as never);
    await expect(query.execute()).resolves.toEqual([
      { slug: 'blinded', name: 'Blinded' },
    ]);
  });
});
