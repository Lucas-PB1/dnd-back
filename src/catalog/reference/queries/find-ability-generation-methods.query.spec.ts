import { FindAbilityGenerationMethodsQuery } from './find-ability-generation-methods.query';
import { asDep } from '@common/testing/as-dep';

describe('FindAbilityGenerationMethodsQuery', () => {
  it('returns methods ordered by slug', async () => {
    const methodsRepo = {
      find: jest.fn().mockResolvedValue([
        { slug: 'standard-array', name: 'Standard Array', description: 'Fixed scores' },
      ]),
    };
    const query = new FindAbilityGenerationMethodsQuery(asDep(methodsRepo));
    await expect(query.execute()).resolves.toEqual([
      {
        slug: 'standard-array',
        name: 'Standard Array',
        description: 'Fixed scores',
      },
    ]);
  });
});
