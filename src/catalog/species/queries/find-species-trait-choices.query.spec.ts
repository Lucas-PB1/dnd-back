import { FindSpeciesTraitChoicesQuery } from './find-species-trait-choices.query';

describe('FindSpeciesTraitChoicesQuery', () => {
  let traitChoicesRepo: { find: jest.Mock };
  let catalogLookup: { findSpeciesOrFail: jest.Mock };
  let mapper: { toTraitChoiceDto: jest.Mock };
  let query: FindSpeciesTraitChoicesQuery;

  beforeEach(() => {
    traitChoicesRepo = { find: jest.fn() };
    catalogLookup = { findSpeciesOrFail: jest.fn().mockResolvedValue({}) };
    mapper = {
      toTraitChoiceDto: jest.fn().mockReturnValue({ choiceSlug: 'small' }),
    };
    query = new FindSpeciesTraitChoicesQuery(
      traitChoicesRepo as never,
      catalogLookup as never,
      mapper as never,
    );
  });

  it('maps trait choices', async () => {
    traitChoicesRepo.find.mockResolvedValue([{ choiceSlug: 'small' }]);
    const result = await query.execute('human');
    expect(catalogLookup.findSpeciesOrFail).toHaveBeenCalledWith('human');
    expect(result.data).toEqual([{ choiceSlug: 'small' }]);
  });

  it('throws when species has no trait choices', async () => {
    traitChoicesRepo.find.mockResolvedValue([]);
    await expect(query.execute('elf')).rejects.toThrow(/no trait choices/i);
  });
});
