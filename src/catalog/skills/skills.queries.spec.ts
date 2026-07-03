import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { PhbSkill } from '../../entities/phb-skill.entity';
import { SkillsMapper } from './skills.mapper';
import { FindSkillBySlugQuery } from './queries/find-skill-by-slug.query';

describe('Skills queries', () => {
  let findSkillBySlug: FindSkillBySlugQuery;
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
      providers: [
        SkillsMapper,
        FindSkillBySlugQuery,
        { provide: getRepositoryToken(PhbSkill), useValue: repo },
      ],
    }).compile();

    findSkillBySlug = module.get(FindSkillBySlugQuery);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await findSkillBySlug.execute('athletics');
    expect(result.abilitySlug).toBe('forca');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(findSkillBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });
});
