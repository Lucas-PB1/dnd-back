import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { ClassesService } from './classes.service';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';

describe('ClassesService', () => {
  let service: ClassesService;
  let classesRepo: jest.Mocked<Pick<Repository<VPhbClass>, 'find' | 'findOne'>>;
  let subclassesRepo: jest.Mocked<Pick<Repository<VPhbSubclass>, 'find'>>;

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

  const sampleSubclass: VPhbSubclass = {
    subclassSlug: 'champion',
    subclassName: 'Campeão',
    classSlug: 'fighter',
    className: 'Guerreiro',
    tagline: 'Busque o auge da proeza no combate',
    summary: 'Buscar o auge da proeza no combate.',
    sourceChapter: 3,
    editionSlug: 'phb-2024-pt',
    spellSourceSlug: null,
    spellSourceLabel: null,
  };

  beforeEach(async () => {
    classesRepo = { find: jest.fn(), findOne: jest.fn() };
    subclassesRepo = { find: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ClassesService,
        { provide: getRepositoryToken(VPhbClass), useValue: classesRepo },
        { provide: getRepositoryToken(VPhbSubclass), useValue: subclassesRepo },
      ],
    }).compile();
    service = module.get(ClassesService);
  });

  it('findAll returns paginated data', async () => {
    classesRepo.find.mockResolvedValue([sample]);
    const result = await service.findAll(1, 20);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].slug).toBe('fighter');
    expect(result.meta.total).toBe(1);
  });

  it('findBySlug returns dto', async () => {
    classesRepo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('fighter');
    expect(result.name).toBe('Guerreiro');
  });

  it('findBySlug throws NotFoundException', async () => {
    classesRepo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findSubclassesByClassSlug returns paginated subclasses', async () => {
    classesRepo.findOne.mockResolvedValue(sample);
    subclassesRepo.find.mockResolvedValue([sampleSubclass]);
    const result = await service.findSubclassesByClassSlug('fighter', 1, 20);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].slug).toBe('champion');
    expect(result.meta.total).toBe(1);
  });

  it('findSubclassesByClassSlug throws when class not found', async () => {
    classesRepo.findOne.mockResolvedValue(null);
    await expect(service.findSubclassesByClassSlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
