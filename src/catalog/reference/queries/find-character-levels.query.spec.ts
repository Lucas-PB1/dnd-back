import { FindCharacterLevelsQuery } from './find-character-levels.query';
import { asDep } from '@common/testing/as-dep';

describe('FindCharacterLevelsQuery', () => {
  it('paginates character levels', async () => {
    const levelsRepo = {
      find: jest.fn().mockResolvedValue([{ level: 1 }, { level: 2 }]),
    };
    const mapper = {
      toCharacterLevelDto: jest.fn((row) => ({ level: row.level })),
    };
    const query = new FindCharacterLevelsQuery(asDep(levelsRepo), asDep(mapper));
    const result = await query.execute(undefined, 1);
    expect(result.data).toEqual([{ level: 1 }]);
    expect(result.meta.hasMore).toBe(true);
    expect(result.meta.nextCursor).toBeTruthy();
  });
});
