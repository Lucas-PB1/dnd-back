import { FindClassSpellsQuery } from './find-class-spells.query';

describe('FindClassSpellsQuery', () => {
  let spellsRepo: { find: jest.Mock };
  let catalogLookup: { findClassOrFail: jest.Mock };
  let mapper: { toClassSpellDto: jest.Mock };
  let query: FindClassSpellsQuery;

  beforeEach(() => {
    spellsRepo = {
      find: jest.fn().mockResolvedValue([
        { spellLevel: 0, spellName: 'Light' },
        { spellLevel: 3, spellName: 'Fireball' },
      ]),
    };
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = {
      toClassSpellDto: jest.fn((row) => ({ name: row.spellName })),
    };
    query = new FindClassSpellsQuery(
      spellsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('filters spells by maxLevel', async () => {
    const result = await query.execute('wizard', 1, 20, 0);
    expect(result.data).toEqual([{ name: 'Light' }]);
  });

  it('allows empty spell list', async () => {
    spellsRepo.find.mockResolvedValue([]);
    const result = await query.execute('fighter');
    expect(result.data).toEqual([]);
  });
});
