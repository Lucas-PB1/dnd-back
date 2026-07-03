import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { BackgroundsService } from './backgrounds.service';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';

describe('BackgroundsService', () => {
  let service: BackgroundsService;
  let repo: jest.Mocked<Pick<Repository<VPhbBackground>, 'find' | 'findOne'>>;

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

  beforeEach(async () => {
    repo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        BackgroundsService,
        { provide: getRepositoryToken(VPhbBackground), useValue: repo },
      ],
    }).compile();
    service = module.get(BackgroundsService);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('acolyte');
    expect(result.name).toBe('Acólito');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
