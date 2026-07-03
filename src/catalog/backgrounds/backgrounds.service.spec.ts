import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { BackgroundsService } from './backgrounds.service';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';

describe('BackgroundsService', () => {
  let service: BackgroundsService;
  let backgroundsRepo: jest.Mocked<Pick<Repository<VPhbBackground>, 'find' | 'findOne'>>;
  let equipmentRepo: jest.Mocked<Pick<Repository<VPhbBackgroundEquipment>, 'find'>>;

  const sample: VPhbBackground = {
    backgroundSlug: 'acolyte',
    backgroundName: 'Acólito',
    equipmentGoldOption: 50,
    sourceChapter: 4,
    sourceChapterTitle: null,
    editionSlug: 'phb-2024-pt',
    abilityOptionSlugs: ['sabedoria'],
    abilityOptionNames: ['Sabedoria'],
  };

  const sampleEquipment: VPhbBackgroundEquipment = {
    backgroundSlug: 'acolyte',
    packageSlug: 'a',
    packageLabel: 'A',
    packageGold: null,
    sortOrder: 1,
    itemSlug: 'holy-symbol',
    itemName: 'Símbolo sagrado',
    quantity: 1,
    choiceText: null,
  };

  beforeEach(async () => {
    backgroundsRepo = { find: jest.fn(), findOne: jest.fn() };
    equipmentRepo = { find: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        BackgroundsService,
        { provide: getRepositoryToken(VPhbBackground), useValue: backgroundsRepo },
        { provide: getRepositoryToken(VPhbBackgroundEquipment), useValue: equipmentRepo },
      ],
    }).compile();
    service = module.get(BackgroundsService);
  });

  it('findBySlug returns dto', async () => {
    backgroundsRepo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('acolyte');
    expect(result.name).toBe('Acólito');
  });

  it('findBySlug throws NotFoundException', async () => {
    backgroundsRepo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findEquipmentByBackgroundSlug returns equipment', async () => {
    backgroundsRepo.findOne.mockResolvedValue(sample);
    equipmentRepo.find.mockResolvedValue([sampleEquipment]);
    const result = await service.findEquipmentByBackgroundSlug('acolyte', 1, 20);
    expect(result.data[0].itemSlug).toBe('holy-symbol');
  });
});
