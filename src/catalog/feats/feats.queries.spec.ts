import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { FeatsMapper } from './feats.mapper';
import { FindFeatBySlugQuery } from './queries/find-feat-by-slug.query';

describe('Feats queries', () => {
  let findFeatBySlug: FindFeatBySlugQuery;
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
      providers: [
        FeatsMapper,
        FindFeatBySlugQuery,
        { provide: getRepositoryToken(VPhbFeat), useValue: repo },
      ],
    }).compile();

    findFeatBySlug = module.get(FindFeatBySlugQuery);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await findFeatBySlug.execute('alert');
    expect(result.name).toBe('Alerta');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(findFeatBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });
});
