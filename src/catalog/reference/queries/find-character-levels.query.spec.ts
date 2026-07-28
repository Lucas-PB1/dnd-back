import { FindCharacterLevelsQuery } from './find-character-levels.query';

describe('FindCharacterLevelsQuery', () => {
  it('paginates character levels', async () => {
    const levelsRepo = {
      find: jest.fn().mockResolvedValue([{ level: 1 }, { level: 2 }]),
    };
    const mapper = {
      toCharacterLevelDto: jest.fn((row) => ({ level: row.level })),
    };
    const query = new FindCharacterLevelsQuery(levelsRepo as never, mapper as never);
    const result = await query.execute(1, 1);
    expect(result.data).toEqual([{ level: 1 }]);
    expect(result.meta.total).toBe(2);
  });
});
