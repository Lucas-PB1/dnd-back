import { FindClassProgressionQuery } from './find-class-progression.query';

describe('FindClassProgressionQuery', () => {
  let progressionRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toProgressionDto: jest.Mock };
  let query: FindClassProgressionQuery;

  beforeEach(() => {
    progressionRepo = { find: jest.fn().mockResolvedValue([{ level: 1 }]) };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toProgressionDto: jest.fn().mockReturnValue({ level: 1 }) };
    query = new FindClassProgressionQuery(
      progressionRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps level progression', async () => {
    const result = await query.execute('fighter');
    expect(result.data).toEqual([{ level: 1 }]);
  });

  it('throws when no progression data', async () => {
    progressionRepo.find.mockResolvedValue([]);
    await expect(query.execute('fighter')).rejects.toThrow(/no level progression/i);
  });
});
