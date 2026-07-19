import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../../entities/phb-subclass-option-value.entity';
import { VPhbSpeciesTraitChoices } from '../../../entities/views/v-phb-species-trait-choices.entity';
import { CharacterSheetValidator } from './character-sheet.validator';
import { EMPTY_SHEET_DATA, type CharacterSheetInput } from './character-sheet.types';

const emptyInput = EMPTY_SHEET_DATA as CharacterSheetInput;

describe('CharacterSheetValidator.validateCreateRequiredFields', () => {
  let validator: CharacterSheetValidator;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findClassOrFail' | 'validateClassSkillChoices'>>;
  let speciesTraitChoicesRepo: jest.Mocked<Pick<Repository<VPhbSpeciesTraitChoices>, 'find'>>;
  let subclassRefRepo: jest.Mocked<Pick<Repository<PhbSubclassRef>, 'findOne'>>;
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
    };
    speciesTraitChoicesRepo = {
      find: jest.fn().mockResolvedValue([]),
    };
    subclassRefRepo = {
      findOne: jest.fn().mockResolvedValue({ id: '1', slug: 'champion' }),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('subclass_unlock_level')) {
          return Promise.resolve([{ subclass_unlock_level: 3 }]);
        }
        if (sql.includes('phb_subclass_option_def')) {
          return Promise.resolve([{ optionKey: 'fighting_style' }]);
        }
        return Promise.resolve([]);
      }),
    };

    validator = new CharacterSheetValidator(
      dataSource as unknown as DataSource,
      catalogLookup as unknown as CatalogLookupService,
      speciesTraitChoicesRepo as unknown as Repository<VPhbSpeciesTraitChoices>,
      {} as never,
      {} as never,
      subclassRefRepo as unknown as Repository<PhbSubclassRef>,
      {
        findOne: jest.fn().mockResolvedValue({
          subclassId: '1',
          optionKey: 'fighting_style',
          valueId: 'defense',
        }),
      } as unknown as Repository<PhbSubclassOptionValue>,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
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
          subclassOptions: [{ optionKey: 'fighting_style', valueId: 'defense' }],
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
