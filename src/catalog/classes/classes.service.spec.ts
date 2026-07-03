import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { ClassesService } from './classes.service';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';

describe('ClassesService', () => {
  let service: ClassesService;
  let repo: jest.Mocked<Pick<Repository<VPhbClass>, 'find' | 'findOne'>>;

  const sample: VPhbClass = {
    classSlug: 'fighter',
    className: 'Guerreiro',
    hitDie: 'D10',
    primaryAbilityLabel: null,
    primaryAbilityOperator: null,
    primaryAbilitySlugs: ['forca'],
    hpLevel1DieValue: 10,
    hpFixedPerLevel: 6,
    skillChoiceCount: 2,
    skillChoiceFrom: null,
    sourceChapter: 3,
    editionSlug: 'phb-2024-pt',
  };

  beforeEach(async () => {
    repo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ClassesService,
        { provide: getRepositoryToken(VPhbClass), useValue: repo },
      ],
    }).compile();
    service = module.get(ClassesService);
  });

  it('findAll returns paginated data', async () => {
    repo.find.mockResolvedValue([sample]);
    const result = await service.findAll(1, 20);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].slug).toBe('fighter');
    expect(result.meta.total).toBe(1);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('fighter');
    expect(result.name).toBe('Guerreiro');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
