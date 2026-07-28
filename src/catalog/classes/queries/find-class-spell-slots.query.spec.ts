import { FindClassSpellSlotsQuery } from './find-class-spell-slots.query';

describe('FindClassSpellSlotsQuery', () => {
  let spellSlotsRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toSpellSlotsDto: jest.Mock };
  let query: FindClassSpellSlotsQuery;

  beforeEach(() => {
    spellSlotsRepo = { find: jest.fn().mockResolvedValue([{ classLevel: 1 }]) };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toSpellSlotsDto: jest.fn().mockReturnValue({ classLevel: 1 }) };
    query = new FindClassSpellSlotsQuery(
      spellSlotsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps spell slot progression', async () => {
    const result = await query.execute('wizard');
    expect(result.data).toEqual([{ classLevel: 1 }]);
  });

  it('throws when no spell slots', async () => {
    spellSlotsRepo.find.mockResolvedValue([]);
    await expect(query.execute('wizard')).rejects.toThrow(/no spell slot progression/i);
  });
});
