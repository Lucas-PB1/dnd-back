import { FindSubclassSpellsQuery } from './find-subclass-spells.query';
import { asDep } from '@common/testing/as-dep';

describe('FindSubclassSpellsQuery', () => {
  let spellsRepo: { find: jest.Mock };
  let catalogLookup: { findSubclassOrFail: jest.Mock };
  let mapper: { toSpellDto: jest.Mock };
  let query: FindSubclassSpellsQuery;

  beforeEach(() => {
    spellsRepo = { find: jest.fn().mockResolvedValue([{ spellSlug: 'fireball' }]) };
    catalogLookup = { findSubclassOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toSpellDto: jest.fn().mockReturnValue({ slug: 'fireball' }) };
    query = new FindSubclassSpellsQuery(
      asDep(spellsRepo),
      asDep(catalogLookup),
      asDep(mapper),
    );
  });

  it('maps prepared spells', async () => {
    const result = await query.execute('evoker');
    expect(result.data).toEqual([{ slug: 'fireball' }]);
  });

  it('throws when no prepared spells', async () => {
    spellsRepo.find.mockResolvedValue([]);
    await expect(query.execute('evoker')).rejects.toThrow(/no prepared spells/i);
  });
});
