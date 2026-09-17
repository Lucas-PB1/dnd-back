import { FindAbilityGenerationMethodsQuery } from './find-ability-generation-methods.query';
import { asDep } from '@common/testing/as-dep';

describe('FindAbilityGenerationMethodsQuery', () => {
  it('returns methods ordered by slug with generation rules', async () => {
    const methodsRepo = {
      find: jest.fn().mockResolvedValue([
        {
          slug: 'point-buy',
          name: 'Point Buy',
          description: 'Spend a budget',
        },
        {
          slug: 'roll',
          name: 'Roll',
          description: '4d6 drop lowest',
        },
        {
          slug: 'standard-array',
          name: 'Standard Array',
          description: 'Fixed scores',
        },
      ]),
    };
    const query = new FindAbilityGenerationMethodsQuery(asDep(methodsRepo));
    await expect(query.execute()).resolves.toEqual([
      {
        slug: 'point-buy',
        name: 'Point Buy',
        description: 'Spend a budget',
        pointBuy: {
          budget: 27,
          minScore: 8,
          maxScore: 15,
          costByScore: {
            '8': 0,
            '9': 1,
            '10': 2,
            '11': 3,
            '12': 4,
            '13': 5,
            '14': 7,
            '15': 9,
          },
        },
      },
      {
        slug: 'roll',
        name: 'Roll',
        description: '4d6 drop lowest',
        rollTotalMin: 72,
        rollTotalMax: 80,
        rollOptionCount: 3,
      },
      {
        slug: 'standard-array',
        name: 'Standard Array',
        description: 'Fixed scores',
        pool: [15, 14, 13, 12, 10, 8],
      },
    ]);
  });
});
