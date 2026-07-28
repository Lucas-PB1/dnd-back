import { FindAbilityGenerationMethodsQuery } from './find-ability-generation-methods.query';

describe('FindAbilityGenerationMethodsQuery', () => {
  it('returns methods ordered by slug', async () => {
    const methodsRepo = {
      find: jest.fn().mockResolvedValue([
        { slug: 'standard-array', name: 'Standard Array', description: 'Fixed scores' },
      ]),
    };
    const query = new FindAbilityGenerationMethodsQuery(methodsRepo as never);
    await expect(query.execute()).resolves.toEqual([
      {
        slug: 'standard-array',
        name: 'Standard Array',
        description: 'Fixed scores',
      },
    ]);
  });
});
