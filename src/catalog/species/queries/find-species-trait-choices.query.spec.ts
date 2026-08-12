import { FindSpeciesTraitChoicesQuery } from './find-species-trait-choices.query';

describe('FindSpeciesTraitChoicesQuery', () => {
  let traitChoicesRepo: {
    createQueryBuilder: jest.Mock;
  };
  let qb: {
    where: jest.Mock;
    andWhere: jest.Mock;
    orderBy: jest.Mock;
    addOrderBy: jest.Mock;
    getMany: jest.Mock;
  };
  let catalogLookup: { findSpeciesOrFail: jest.Mock };
  let mapper: { toTraitChoiceDto: jest.Mock };
  let query: FindSpeciesTraitChoicesQuery;

  beforeEach(() => {
    qb = {
      where: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      getMany: jest.fn(),
    };
    traitChoicesRepo = {
      createQueryBuilder: jest.fn().mockReturnValue(qb),
    };
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
    qb.getMany.mockResolvedValue([{ choiceSlug: 'small' }]);
    const result = await query.execute('human');
    expect(catalogLookup.findSpeciesOrFail).toHaveBeenCalledWith('human');
    expect(traitChoicesRepo.createQueryBuilder).toHaveBeenCalledWith('c');
    expect(qb.andWhere).not.toHaveBeenCalled();
    expect(result.data).toEqual([{ choiceSlug: 'small' }]);
  });

  it('filters by editionSlugs when provided', async () => {
    qb.getMany.mockResolvedValue([{ choiceSlug: 'drow' }]);
    await query.execute('elf', 1, 100, ['phb-2024-pt']);
    expect(qb.andWhere).toHaveBeenCalledWith(
      '(c.edition_slug IS NULL OR c.edition_slug IN (:...editionSlugs))',
      { editionSlugs: ['phb-2024-pt'] },
    );
  });

  it('throws when species has no trait choices', async () => {
    qb.getMany.mockResolvedValue([]);
    await expect(query.execute('elf')).rejects.toThrow(/no trait choices/i);
  });
});
