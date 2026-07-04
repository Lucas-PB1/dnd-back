import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundSkill } from '../../entities/views/v-phb-background-skill.entity';
import { CatalogLookupService } from '../catalog-lookup.service';
import { BackgroundsMapper } from './backgrounds.mapper';
import { FindBackgroundBySlugQuery } from './queries/find-background-by-slug.query';
import { FindBackgroundEquipmentQuery } from './queries/find-background-equipment.query';
import { FindBackgroundSkillsQuery } from './queries/find-background-skills.query';

describe('Backgrounds queries', () => {
  let findBackgroundBySlug: FindBackgroundBySlugQuery;
  let findBackgroundEquipment: FindBackgroundEquipmentQuery;
  let findBackgroundSkills: FindBackgroundSkillsQuery;
  let backgroundsRepo: jest.Mocked<Pick<Repository<VPhbBackground>, 'find' | 'findOne'>>;
  let equipmentRepo: jest.Mocked<Pick<Repository<VPhbBackgroundEquipment>, 'find'>>;
  let skillsRepo: jest.Mocked<Pick<Repository<VPhbBackgroundSkill>, 'find'>>;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findBackgroundOrFail'>>;

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

  const sampleSkill: VPhbBackgroundSkill = {
    backgroundSlug: 'acolyte',
    skillSlug: 'insight',
    skillName: 'Intuição',
  };

  beforeEach(async () => {
    backgroundsRepo = { find: jest.fn(), findOne: jest.fn() };
    equipmentRepo = { find: jest.fn() };
    skillsRepo = { find: jest.fn() };
    catalogLookup = {
      findBackgroundOrFail: jest.fn(async (slug) => {
        if (slug === 'invalid') throw new NotFoundException();
        return sample;
      }),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        BackgroundsMapper,
        FindBackgroundBySlugQuery,
        FindBackgroundEquipmentQuery,
        FindBackgroundSkillsQuery,
        { provide: getRepositoryToken(VPhbBackground), useValue: backgroundsRepo },
        { provide: getRepositoryToken(VPhbBackgroundEquipment), useValue: equipmentRepo },
        { provide: getRepositoryToken(VPhbBackgroundSkill), useValue: skillsRepo },
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();

    findBackgroundBySlug = module.get(FindBackgroundBySlugQuery);
    findBackgroundEquipment = module.get(FindBackgroundEquipmentQuery);
    findBackgroundSkills = module.get(FindBackgroundSkillsQuery);
  });

  it('findBySlug returns dto', async () => {
    const result = await findBackgroundBySlug.execute('acolyte');
    expect(result.name).toBe('Acólito');
  });

  it('findBySlug throws NotFoundException', async () => {
    await expect(findBackgroundBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findEquipmentByBackgroundSlug returns equipment', async () => {
    equipmentRepo.find.mockResolvedValue([sampleEquipment]);
    const result = await findBackgroundEquipment.execute('acolyte', 1, 20);
    expect(result.data[0].itemSlug).toBe('holy-symbol');
  });

  it('findSkillsByBackgroundSlug returns skills', async () => {
    skillsRepo.find.mockResolvedValue([sampleSkill]);
    const result = await findBackgroundSkills.execute('acolyte', 1, 20);
    expect(result.data[0].slug).toBe('insight');
  });
});
