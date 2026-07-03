import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { FeatsService } from './feats.service';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';

describe('FeatsService', () => {
  let service: FeatsService;
  let repo: jest.Mocked<Pick<Repository<VPhbFeat>, 'find' | 'findOne'>>;

  const sample: VPhbFeat = {
    featSlug: 'alert',
    featName: 'Alerta',
    categorySlug: 'origin',
    categoryName: 'Origem',
    categoryTypeLabel: 'Talento de Origem',
    repeatable: false,
    prerequisite: null,
    sourceChapter: 5,
    sourceChapterTitle: null,
    editionSlug: 'phb-2024-pt',
    benefits: [{ description: 'Benefício' }],
  };

  beforeEach(async () => {
    repo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [FeatsService, { provide: getRepositoryToken(VPhbFeat), useValue: repo }],
    }).compile();
    service = module.get(FeatsService);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('alert');
    expect(result.name).toBe('Alerta');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
