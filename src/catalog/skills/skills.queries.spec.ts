import { Test, TestingModule } from '@nestjs/testing';
import { NotFoundException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbSkill } from '@entities/phb-skill.entity';
import { SkillsMapper } from './skills.mapper';
import { FindSkillBySlugQuery } from './queries/find-skill-by-slug.query';

describe('Skills queries', () => {
  let findSkillBySlug: FindSkillBySlugQuery;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findSkillOrFail'>>;

  const sample: PhbSkill = {
    id: '1',
    slug: 'athletics',
    name: 'Atletismo',
    description: null,
    ability: { id: '1', slug: 'forca', name: 'Força', sortOrder: 1 },
  };

  beforeEach(async () => {
    catalogLookup = { findSkillOrFail: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SkillsMapper,
        FindSkillBySlugQuery,
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();

    findSkillBySlug = module.get(FindSkillBySlugQuery);
  });

  it('findBySlug returns dto', async () => {
    catalogLookup.findSkillOrFail.mockResolvedValue(sample);
    const result = await findSkillBySlug.execute('athletics');
    expect(result.abilitySlug).toBe('forca');
  });

  it('findBySlug throws NotFoundException', async () => {
    catalogLookup.findSkillOrFail.mockRejectedValue(new NotFoundException());
    await expect(findSkillBySlug.execute('invalid')).rejects.toThrow(
      NotFoundException,
    );
  });
});
