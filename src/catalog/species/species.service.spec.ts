import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { SpeciesService } from './species.service';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';

describe('SpeciesService', () => {
  let service: SpeciesService;
  let speciesRepo: jest.Mocked<Pick<Repository<PhbSpecies>, 'find' | 'findOne'>>;
  let traitsRepo: jest.Mocked<Pick<Repository<PhbSpeciesTrait>, 'find'>>;
  let traitChoicesRepo: jest.Mocked<Pick<Repository<VPhbSpeciesTraitChoices>, 'find'>>;

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
    traitChoicesRepo = { find: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SpeciesService,
        { provide: getRepositoryToken(PhbSpecies), useValue: speciesRepo },
        { provide: getRepositoryToken(PhbSpeciesTrait), useValue: traitsRepo },
        { provide: getRepositoryToken(VPhbSpeciesTraitChoices), useValue: traitChoicesRepo },
      ],
    }).compile();
    service = module.get(SpeciesService);
  });

  it('findTraitsBySpeciesSlug returns traits', async () => {
    speciesRepo.findOne.mockResolvedValue(sample);
    traitsRepo.find.mockResolvedValue([
      { id: '1', species: sample, name: 'Visão no Escuro', description: '...', choiceKind: null },
    ]);
    const result = await service.findTraitsBySpeciesSlug('dwarf', 1, 20);
    expect(result.data[0].name).toBe('Visão no Escuro');
  });

  it('findBySlug throws NotFoundException', async () => {
    speciesRepo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
