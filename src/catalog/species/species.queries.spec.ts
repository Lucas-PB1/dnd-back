import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { CatalogLookupService } from '../catalog-lookup.service';
import { SpeciesMapper } from './species.mapper';
import { FindSpeciesTraitsQuery } from './queries/find-species-traits.query';
import { FindSpeciesBySlugQuery } from './queries/find-species-by-slug.query';

describe('Species queries', () => {
  let findSpeciesTraits: FindSpeciesTraitsQuery;
  let findSpeciesBySlug: FindSpeciesBySlugQuery;
  let speciesRepo: jest.Mocked<Pick<Repository<PhbSpecies>, 'find' | 'findOne'>>;
  let traitsRepo: jest.Mocked<Pick<Repository<PhbSpeciesTrait>, 'find'>>;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findSpeciesOrFail'>>;

  const sample: PhbSpecies = {
    id: '1',
    slug: 'dwarf',
    name: 'Anão',
    creatureType: 'Humanoide',
    size: 'Médio',
    speed: '9 metros',
    description: 'Test',
    sourceMeta: null,
  };

  beforeEach(async () => {
    speciesRepo = { find: jest.fn(), findOne: jest.fn() };
    traitsRepo = { find: jest.fn() };
    catalogLookup = {
      findSpeciesOrFail: jest.fn(async (slug) => {
        if (slug === 'invalid') throw new NotFoundException();
        return sample;
      }),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SpeciesMapper,
        FindSpeciesTraitsQuery,
        FindSpeciesBySlugQuery,
        { provide: getRepositoryToken(PhbSpecies), useValue: speciesRepo },
        { provide: getRepositoryToken(PhbSpeciesTrait), useValue: traitsRepo },
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();

    findSpeciesTraits = module.get(FindSpeciesTraitsQuery);
    findSpeciesBySlug = module.get(FindSpeciesBySlugQuery);
  });

  it('findTraitsBySpeciesSlug returns traits', async () => {
    traitsRepo.find.mockResolvedValue([
      { id: '1', species: sample, name: 'Visão no Escuro', description: '...', choiceKind: null },
    ]);
    const result = await findSpeciesTraits.execute('dwarf', 1, 20);
    expect(result.data[0].name).toBe('Visão no Escuro');
  });

  it('findBySlug throws NotFoundException', async () => {
    await expect(findSpeciesBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });
});
