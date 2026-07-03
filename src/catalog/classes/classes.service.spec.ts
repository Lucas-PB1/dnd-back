import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { ClassesService } from './classes.service';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { VPhbClassSkillChoice } from '../../entities/views/v-phb-class-skill-choice.entity';

describe('ClassesService', () => {
  let service: ClassesService;
  let classesRepo: jest.Mocked<Pick<Repository<VPhbClass>, 'find' | 'findOne'>>;
  let subclassesRepo: jest.Mocked<Pick<Repository<VPhbSubclass>, 'find'>>;
  let spellsByClassRepo: jest.Mocked<Pick<Repository<VSpellByClass>, 'find'>>;
  let spellSlotsRepo: jest.Mocked<Pick<Repository<VClassSpellSlots>, 'find'>>;
  let equipmentRepo: jest.Mocked<Pick<Repository<VPhbClassEquipment>, 'find'>>;
  let skillsRepo: jest.Mocked<Pick<Repository<VPhbClassSkillChoice>, 'find'>>;

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

  beforeEach(async () => {
    classesRepo = { find: jest.fn(), findOne: jest.fn() };
    subclassesRepo = { find: jest.fn() };
    spellsByClassRepo = { find: jest.fn() };
    spellSlotsRepo = { find: jest.fn() };
    equipmentRepo = { find: jest.fn() };
    skillsRepo = { find: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ClassesService,
        { provide: getRepositoryToken(VPhbClass), useValue: classesRepo },
        { provide: getRepositoryToken(VPhbSubclass), useValue: subclassesRepo },
        { provide: getRepositoryToken(VSpellByClass), useValue: spellsByClassRepo },
        { provide: getRepositoryToken(VClassSpellSlots), useValue: spellSlotsRepo },
        { provide: getRepositoryToken(VPhbClassEquipment), useValue: equipmentRepo },
        { provide: getRepositoryToken(VPhbClassSkillChoice), useValue: skillsRepo },
      ],
    }).compile();
    service = module.get(ClassesService);
  });

  it('findAll returns paginated data', async () => {
    classesRepo.find.mockResolvedValue([sample]);
    const result = await service.findAll(1, 20);
    expect(result.data[0].slug).toBe('fighter');
  });

  it('findBySlug throws NotFoundException', async () => {
    classesRepo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findSubclassesByClassSlug returns paginated subclasses', async () => {
    classesRepo.findOne.mockResolvedValue(sample);
    subclassesRepo.find.mockResolvedValue([sampleSubclass]);
    const result = await service.findSubclassesByClassSlug('fighter', 1, 20);
    expect(result.data[0].slug).toBe('champion');
  });

  it('findSpellsByClassSlug filters by maxLevel', async () => {
    classesRepo.findOne.mockResolvedValue(wizard);
    spellsByClassRepo.find.mockResolvedValue([
      sampleSpell,
      { ...sampleSpell, spellLevel: 5, spellSlug: 'cone-de-frio', spellName: 'Cone de Frio' },
    ]);
    const result = await service.findSpellsByClassSlug('wizard', 1, 20, 1);
    expect(result.data).toHaveLength(1);
    expect(result.data[0].slug).toBe('alarme');
  });

  it('findSpellSlotsByClassSlug returns slots', async () => {
    classesRepo.findOne.mockResolvedValue(wizard);
    spellSlotsRepo.find.mockResolvedValue([sampleSlots]);
    const result = await service.findSpellSlotsByClassSlug('wizard', 1, 20);
    expect(result.data[0].classLevel).toBe(5);
  });

  it('findSpellSlotsByClassSlug throws when no progression', async () => {
    classesRepo.findOne.mockResolvedValue(sample);
    spellSlotsRepo.find.mockResolvedValue([]);
    await expect(service.findSpellSlotsByClassSlug('fighter')).rejects.toThrow(NotFoundException);
  });

  it('findEquipmentByClassSlug returns equipment', async () => {
    classesRepo.findOne.mockResolvedValue(sample);
    equipmentRepo.find.mockResolvedValue([sampleEquipment]);
    const result = await service.findEquipmentByClassSlug('fighter', 1, 20);
    expect(result.data[0].itemSlug).toBe('longsword');
  });

  it('findSkillsByClassSlug returns skills', async () => {
    classesRepo.findOne.mockResolvedValue(sample);
    skillsRepo.find.mockResolvedValue([
      {
        classSlug: 'fighter',
        skillChoiceCount: 2,
        skillChoiceFrom: null,
        skillSlug: 'athletics',
        skillName: 'Atletismo',
      },
    ]);
    const result = await service.findSkillsByClassSlug('fighter', 1, 20);
    expect(result.data[0].slug).toBe('athletics');
  });
});
