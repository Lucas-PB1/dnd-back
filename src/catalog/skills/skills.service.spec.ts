import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { SkillsService } from './skills.service';
import { PhbSkill } from '../../entities/phb-skill.entity';

describe('SkillsService', () => {
  let service: SkillsService;
  let repo: jest.Mocked<Pick<Repository<PhbSkill>, 'find' | 'findOne'>>;

  const sample: PhbSkill = {
    id: '1',
    slug: 'athletics',
    name: 'Atletismo',
    description: null,
    ability: { id: '1', slug: 'forca', name: 'Força', sortOrder: 1 },
  };

  beforeEach(async () => {
    repo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [SkillsService, { provide: getRepositoryToken(PhbSkill), useValue: repo }],
    }).compile();
    service = module.get(SkillsService);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('athletics');
    expect(result.abilitySlug).toBe('forca');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
