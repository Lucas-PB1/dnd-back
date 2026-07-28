import { FindSubclassSpellSlotsQuery } from './find-subclass-spell-slots.query';

describe('FindSubclassSpellSlotsQuery', () => {
  let spellSlotsRepo: { find: jest.Mock };
  let catalogLookup: { findSubclassOrFail: jest.Mock };
  let query: FindSubclassSpellSlotsQuery;

  beforeEach(() => {
    spellSlotsRepo = {
      find: jest.fn().mockResolvedValue([
        {
          classLevel: 1,
          patternSlug: 'full',
          patternName: 'Full',
          proficiencyBonus: 2,
          cantrips: 2,
          preparedSpells: 2,
          spellListClassSlug: 'wizard',
          spellSlots: { '1': 2 },
        },
      ]),
    };
    catalogLookup = { findSubclassOrFail: jest.fn().mockResolvedValue({}) };
    query = new FindSubclassSpellSlotsQuery(
      spellSlotsRepo as never,
      catalogLookup as never,
    );
  });

  it('maps spell slot progression inline', async () => {
    const result = await query.execute('evoker');
    expect(result.data[0]).toMatchObject({ classLevel: 1, patternSlug: 'full' });
  });

  it('throws when no spell slot progression', async () => {
    spellSlotsRepo.find.mockResolvedValue([]);
    await expect(query.execute('evoker')).rejects.toThrow(/no spell slot progression/i);
  });
});
