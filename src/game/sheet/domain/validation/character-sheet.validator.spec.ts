import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbOptionValue } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { VPhbSpeciesTraitChoices } from '@entities/views/v-phb-species-trait-choices.entity';
import { VPhbBackgroundToolOption } from '@entities/views/v-phb-background-tool-option.entity';
import { CharacterSheetValidator } from './character-sheet.validator';
import { CharacterBackgroundValidator } from './background/character-background.validator';
import { CharacterEquipmentValidator } from './equipment/character-equipment.validator';
import { CharacterSpellsValidator } from './spells/character-spells.validator';
import { CharacterClassOptionsValidator } from './class-options/character-class-options.validator';
import { CharacterSpeciesChoicesValidator } from './class-options/character-species-choices.validator';
import { CharacterSubclassOptionsValidator } from './class-options/character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from './class-options/character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './class-options/character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from './class-options/character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from './class-options/character-eldritch-invocations.validator';
import { CharacterFeatsValidator } from './feats/character-feats.validator';
import { CharacterCreateRequirementsValidator } from './character-create-requirements.validator';
import { EMPTY_SHEET_DATA, type CharacterSheetInput } from '../character-sheet.types';

const emptyInput = EMPTY_SHEET_DATA as CharacterSheetInput;

describe('CharacterSheetValidator.validateCreateRequiredFields', () => {
  let validator: CharacterSheetValidator;
  let catalogLookup: jest.Mocked<
    Pick<
      CatalogLookupService,
      | 'findClassOrFail'
      | 'validateClassSkillChoices'
      | 'assertFeatInCatalog'
      | 'findBackgroundOrFail'
      | 'assertLanguageSlug'
    >
  >;
  let speciesTraitChoicesRepo: jest.Mocked<Pick<Repository<VPhbSpeciesTraitChoices>, 'find'>>;
  let subclassRefRepo: jest.Mocked<Pick<Repository<PhbSubclassRef>, 'findOne'>>;
  let subclassOptionValuesRepo: jest.Mocked<Pick<Repository<PhbOptionValue>, 'findOne'>>;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;

  const ctx = {
    level: 5,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'acolyte',
    subclassSlug: 'champion',
  };

  beforeEach(() => {
    catalogLookup = {
      findClassOrFail: jest.fn().mockResolvedValue({ skillChoiceCount: 2 }),
      validateClassSkillChoices: jest.fn().mockResolvedValue(undefined),
      assertFeatInCatalog: jest.fn().mockImplementation((slug: string) =>
        Promise.resolve({
          categorySlug:
            slug === 'dueling' || slug === 'defense' ? 'fighting-style' : 'general',
        }),
      ),
      findBackgroundOrFail: jest.fn().mockResolvedValue({
        languageChoiceCount: 0,
        abilityOptionSlugs: [],
      }),
      assertLanguageSlug: jest.fn().mockResolvedValue(undefined),
    };
    speciesTraitChoicesRepo = {
      find: jest.fn().mockResolvedValue([]),
    };
    subclassRefRepo = {
      findOne: jest.fn().mockResolvedValue({ id: '1', slug: 'champion' }),
    };
    subclassOptionValuesRepo = {
      findOne: jest.fn().mockResolvedValue({
        subclassId: '1',
        optionKey: 'fighting_style',
        valueId: 'defense',
      }),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('subclass_unlock_level')) {
          return Promise.resolve([{ subclass_unlock_level: 3 }]);
        }
        if (sql.includes('phb_option_def')) {
          return Promise.resolve([{ optionKey: 'fighting_style' }]);
        }
        if (sql.includes('phb_class_proficiency') || sql.includes('phb_fighting_style')) {
          return Promise.resolve([
            { slug: 'defense' },
            { slug: 'archery' },
            { ok: 1 },
          ]);
        }
        return Promise.resolve([]);
      }),
    };

    const backgroundValidator = new CharacterBackgroundValidator(
      dataSource as unknown as DataSource,
      catalogLookup as unknown as CatalogLookupService,
      {} as unknown as Repository<VPhbBackgroundToolOption>,
    );

    const classOptionsValidator = new CharacterClassOptionsValidator(
      dataSource as unknown as DataSource,
      catalogLookup as unknown as CatalogLookupService,
      new CharacterSpeciesChoicesValidator(
        speciesTraitChoicesRepo as unknown as Repository<VPhbSpeciesTraitChoices>,
        dataSource as unknown as DataSource,
      ),
      new CharacterSubclassOptionsValidator(
        dataSource as unknown as DataSource,
        catalogLookup as unknown as CatalogLookupService,
        subclassRefRepo as unknown as Repository<PhbSubclassRef>,
        subclassOptionValuesRepo as unknown as Repository<PhbOptionValue>,
      ),
      new CharacterClassExpertiseValidator(dataSource as unknown as DataSource),
      new CharacterWeaponMasteryValidator(dataSource as unknown as DataSource),
      new CharacterSpellMasteryValidator(dataSource as unknown as DataSource),
      new CharacterEldritchInvocationsValidator(dataSource as unknown as DataSource),
    );

    const featsValidator = {
      validateCharacterFeats: jest.fn().mockResolvedValue(undefined),
      validateFeatOptions: jest.fn().mockResolvedValue(undefined),
    } as unknown as CharacterFeatsValidator;

    const spellsValidator = {
      validateCharacterSpells: jest.fn().mockResolvedValue(undefined),
    } as unknown as CharacterSpellsValidator;

    const equipmentValidator = {
      validateEquipment: jest.fn().mockResolvedValue(undefined),
      validateLanguageSlugs: jest.fn().mockResolvedValue(undefined),
      validateAbilityGenerationMethod: jest.fn().mockResolvedValue(undefined),
    } as unknown as CharacterEquipmentValidator;

    const createRequirementsValidator = new CharacterCreateRequirementsValidator(
      catalogLookup as unknown as CatalogLookupService,
      backgroundValidator,
      classOptionsValidator,
      featsValidator,
    );

    validator = new CharacterSheetValidator(
      catalogLookup as unknown as CatalogLookupService,
      backgroundValidator,
      equipmentValidator,
      spellsValidator,
      classOptionsValidator,
      featsValidator,
      createRequirementsValidator,
    );
  });

  it('requires class skills when class has a skill pool', async () => {
    await expect(
      validator.validateCreateRequiredFields(emptyInput, ctx),
    ).rejects.toThrow(/requires exactly 2 skill choice/i);
  });

  it('requires subclass options unlocked at level', async () => {
    await expect(
      validator.validateCreateRequiredFields(
        {
          ...emptyInput,
          classSkillSlugs: ['athletics', 'perception'],
        },
        ctx,
      ),
    ).rejects.toThrow(/requires options: fighting_style/i);
  });

  it('accepts complete create input', async () => {
    await expect(
      validator.validateCreateRequiredFields(
        {
          ...emptyInput,
          classSkillSlugs: ['athletics', 'perception'],
          characterFeats: [{ featSlug: 'defense', instanceIndex: 0 }],
          subclassOptions: [{ optionKey: 'fighting_style', valueId: 'archery' }],
        },
        ctx,
      ),
    ).resolves.toBeUndefined();
  });

  it('requires species trait choices when catalog has options', async () => {
    speciesTraitChoicesRepo.find.mockResolvedValue([
      {
        speciesSlug: 'elf',
        choiceKind: 'lineage',
        choiceSlug: 'drow',
        traitName: 'Linagem',
        choiceName: 'Drow',
      } as VPhbSpeciesTraitChoices,
    ]);

    await expect(
      validator.validateCreateRequiredFields(
        {
          ...emptyInput,
          classSkillSlugs: ['athletics', 'perception'],
        },
        { ...ctx, speciesSlug: 'elf', subclassSlug: null, level: 1 },
      ),
    ).rejects.toThrow(BadRequestException);
  });
});
