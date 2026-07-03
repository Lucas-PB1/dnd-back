import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { SpeciesService } from './species.service';
import { PhbSpecies } from '../../entities/phb-species.entity';

describe('SpeciesService', () => {
  let service: SpeciesService;
  let repo: jest.Mocked<Pick<Repository<PhbSpecies>, 'find' | 'findOne'>>;

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
    repo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SpeciesService,
        { provide: getRepositoryToken(PhbSpecies), useValue: repo },
      ],
    }).compile();
    service = module.get(SpeciesService);
  });

  it('findAll returns paginated data', async () => {
    repo.find.mockResolvedValue([sample]);
    const result = await service.findAll(1, 20);
    expect(result.data[0].slug).toBe('dwarf');
    expect(result.meta.total).toBe(1);
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
