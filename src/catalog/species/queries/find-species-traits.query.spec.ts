import { FindSpeciesTraitsQuery } from './find-species-traits.query';

describe('FindSpeciesTraitsQuery', () => {
  let traitsRepo: { find: jest.Mock };
  let catalogLookup: { findSpeciesOrFail: jest.Mock };
  let mapper: { toTraitDto: jest.Mock };
  let query: FindSpeciesTraitsQuery;

  beforeEach(() => {
    traitsRepo = { find: jest.fn().mockResolvedValue([{ name: 'Darkvision' }]) };
    catalogLookup = { findSpeciesOrFail: jest.fn().mockResolvedValue({}) };
    mapper = { toTraitDto: jest.fn().mockReturnValue({ name: 'Darkvision' }) };
    query = new FindSpeciesTraitsQuery(
      traitsRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps species traits', async () => {
    const result = await query.execute('elf');
    expect(catalogLookup.findSpeciesOrFail).toHaveBeenCalledWith('elf');
    expect(result.data).toEqual([{ name: 'Darkvision' }]);
  });

  it('allows empty trait list', async () => {
    traitsRepo.find.mockResolvedValue([]);
    const result = await query.execute('human');
    expect(result.data).toEqual([]);
  });
});
