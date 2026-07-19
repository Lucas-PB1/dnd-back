import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { VPhbClassSkillChoice } from '../../entities/views/v-phb-class-skill-choice.entity';
import { VPhbClassFeature } from '../../entities/views/v-phb-class-feature.entity';
import { CatalogLookupService } from '../catalog-lookup.service';
import { ClassesMapper } from './classes.mapper';
import { FindClassesQuery } from './queries/find-classes.query';
import { FindClassBySlugQuery } from './queries/find-class-by-slug.query';
import { FindClassSubclassesQuery } from './queries/find-class-subclasses.query';
import { FindClassSpellsQuery } from './queries/find-class-spells.query';
import { FindClassSpellSlotsQuery } from './queries/find-class-spell-slots.query';
import { FindClassEquipmentQuery } from './queries/find-class-equipment.query';
import { FindClassSkillsQuery } from './queries/find-class-skills.query';
import { FindClassFeaturesQuery } from './queries/find-class-features.query';

describe('Classes queries', () => {
  let findClasses: FindClassesQuery;
  let findClassBySlug: FindClassBySlugQuery;
  let findClassSubclasses: FindClassSubclassesQuery;
  let findClassSpells: FindClassSpellsQuery;
  let findClassSpellSlots: FindClassSpellSlotsQuery;
  let findClassEquipment: FindClassEquipmentQuery;
  let findClassSkills: FindClassSkillsQuery;
  let findClassFeatures: FindClassFeaturesQuery;
  let classesRepo: jest.Mocked<
    Pick<Repository<VPhbClass>, 'find' | 'findOne' | 'createQueryBuilder'>
  >;
  let subclassesRepo: jest.Mocked<Pick<Repository<VPhbSubclass>, 'find'>>;
  let spellsByClassRepo: jest.Mocked<Pick<Repository<VSpellByClass>, 'find'>>;
  let spellSlotsRepo: jest.Mocked<Pick<Repository<VClassSpellSlots>, 'find'>>;
  let equipmentRepo: jest.Mocked<Pick<Repository<VPhbClassEquipment>, 'find'>>;
  let skillsRepo: jest.Mocked<Pick<Repository<VPhbClassSkillChoice>, 'find'>>;
  let featuresRepo: jest.Mocked<Pick<Repository<VPhbClassFeature>, 'find'>>;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findClassOrFail'>>;

  const sample: VPhbClass = {
    classSlug: 'fighter',
    className: 'Guerreiro',
    tagline: 'Mestre de armas e armaduras',
    summary: 'Domine todas as armas e armaduras.',
    description: null,
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

  const wizard: VPhbClass = { ...sample, classSlug: 'wizard', className: 'Mago' };

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

  const sampleSpell: VSpellByClass = {
    classSlug: 'wizard',
    className: 'Mago',
    spellLevel: 1,
    spellSlug: 'alarme',
    spellName: 'Alarme',
    schoolSlug: 'abjuracao',
    schoolName: 'Abjuração',
  };

  const sampleSlots: VClassSpellSlots = {
    classSlug: 'wizard',
    classLevel: 5,
    patternSlug: 'full-caster',
    patternName: 'Conjurador completo',
    spellSlots: { '1': 4, '2': 3, '3': 2 },
  };

  const sampleEquipment: VPhbClassEquipment = {
    classSlug: 'fighter',
    packageSlug: 'a',
    packageLabel: 'A',
    sortOrder: 1,
    itemSlug: 'longsword',
    itemName: 'Espada longa',
    quantity: 1,
    choiceText: null,
    goldAmount: null,
  };

  const sampleFeature: VPhbClassFeature = {
    classSlug: 'bard',
    featureLevel: 1,
    featureName: 'Conjuração',
    featureDescription: 'Você aprendeu a conjurar magias.',
  };

  beforeEach(async () => {
    const qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getManyAndCount: jest.fn().mockResolvedValue([[sample], 1]),
    };
    classesRepo = {
      find: jest.fn(),
      findOne: jest.fn(),
      createQueryBuilder: jest.fn().mockReturnValue(qb as never),
    };
    subclassesRepo = { find: jest.fn() };
    spellsByClassRepo = { find: jest.fn() };
    spellSlotsRepo = { find: jest.fn() };
    equipmentRepo = { find: jest.fn() };
    skillsRepo = { find: jest.fn() };
    featuresRepo = { find: jest.fn() };
    catalogLookup = {
      findClassOrFail: jest.fn(async (slug) => {
        if (slug === 'invalid') throw new NotFoundException();
        return slug === 'wizard' ? wizard : sample;
      }),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ClassesMapper,
        FindClassesQuery,
        FindClassBySlugQuery,
        FindClassSubclassesQuery,
        FindClassSpellsQuery,
        FindClassSpellSlotsQuery,
        FindClassEquipmentQuery,
        FindClassSkillsQuery,
        FindClassFeaturesQuery,
        { provide: getRepositoryToken(VPhbClass), useValue: classesRepo },
        { provide: getRepositoryToken(VPhbSubclass), useValue: subclassesRepo },
        { provide: getRepositoryToken(VSpellByClass), useValue: spellsByClassRepo },
        { provide: getRepositoryToken(VClassSpellSlots), useValue: spellSlotsRepo },
        { provide: getRepositoryToken(VPhbClassEquipment), useValue: equipmentRepo },
        { provide: getRepositoryToken(VPhbClassSkillChoice), useValue: skillsRepo },
        { provide: getRepositoryToken(VPhbClassFeature), useValue: featuresRepo },
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();

    findClasses = module.get(FindClassesQuery);
    findClassBySlug = module.get(FindClassBySlugQuery);
    findClassSubclasses = module.get(FindClassSubclassesQuery);
    findClassSpells = module.get(FindClassSpellsQuery);
    findClassSpellSlots = module.get(FindClassSpellSlotsQuery);
    findClassEquipment = module.get(FindClassEquipmentQuery);
    findClassSkills = module.get(FindClassSkillsQuery);
    findClassFeatures = module.get(FindClassFeaturesQuery);
  });

  it('findAll returns paginated data', async () => {
    const result = await findClasses.execute(1, 20);
    expect(result.data[0].slug).toBe('fighter');
  });

  it('findAll applies search filter', async () => {
    const qb = {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getManyAndCount: jest.fn().mockResolvedValue([[sample], 1]),
    };
    classesRepo.createQueryBuilder.mockReturnValue(qb as never);
    await findClasses.execute(1, 20, 'fighter');
    expect(qb.andWhere).toHaveBeenCalled();
  });

  it('findBySlug throws NotFoundException', async () => {
    await expect(findClassBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findSubclassesByClassSlug returns paginated subclasses', async () => {
    subclassesRepo.find.mockResolvedValue([sampleSubclass]);
    const result = await findClassSubclasses.execute('fighter', 1, 20);
    expect(result.data[0].slug).toBe('champion');
  });

  it('findSpellsByClassSlug filters by maxLevel', async () => {
    spellsByClassRepo.find.mockResolvedValue([
      sampleSpell,
      { ...sampleSpell, spellLevel: 5, spellSlug: 'cone-de-frio', spellName: 'Cone de Frio' },
    ]);
    const result = await findClassSpells.execute('wizard', 1, 20, 1);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].slug).toBe('alarme');
  });

  it('findSpellSlotsByClassSlug returns slots', async () => {
    spellSlotsRepo.find.mockResolvedValue([sampleSlots]);
    const result = await findClassSpellSlots.execute('wizard', 1, 20);
    expect(result.data[0].classLevel).toBe(5);
  });

  it('findSpellSlotsByClassSlug throws when no progression', async () => {
    spellSlotsRepo.find.mockResolvedValue([]);
    await expect(findClassSpellSlots.execute('fighter')).rejects.toThrow(NotFoundException);
  });

  it('findEquipmentByClassSlug returns equipment', async () => {
    equipmentRepo.find.mockResolvedValue([sampleEquipment]);
    const result = await findClassEquipment.execute('fighter', 1, 20);
    expect(result.data[0].itemSlug).toBe('longsword');
  });

  it('findSkillsByClassSlug returns skills', async () => {
    skillsRepo.find.mockResolvedValue([
      {
        classSlug: 'fighter',
        skillChoiceCount: 2,
        skillChoiceFrom: null,
        skillSlug: 'athletics',
        skillName: 'Atletismo',
      },
    ]);
    const result = await findClassSkills.execute('fighter', 1, 20);
    expect(result.data[0].slug).toBe('athletics');
  });

  it('findFeaturesByClassSlug filters by maxLevel', async () => {
    featuresRepo.find.mockResolvedValue([
      sampleFeature,
      { ...sampleFeature, featureLevel: 5, featureName: 'Inspiração Bárdica' },
    ]);
    const result = await findClassFeatures.execute('bard', 1, 50, 1);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].featureName).toBe('Conjuração');
  });

  it('findFeaturesByClassSlug throws when empty', async () => {
    featuresRepo.find.mockResolvedValue([]);
    await expect(findClassFeatures.execute('bard')).rejects.toThrow(NotFoundException);
  });
});
