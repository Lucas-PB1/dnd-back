import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../../entities/phb-feat-option.entity';
import { CharacterSheetValidator } from './character-sheet.validator';

describe('CharacterSheetValidator resilient feat', () => {
  let validator: CharacterSheetValidator;
  let featRefRepo: jest.Mocked<Pick<Repository<PhbFeatRef>, 'findOne'>>;
  let featOptionDefRepo: jest.Mocked<Pick<Repository<PhbFeatOptionDef>, 'find'>>;
  let featOptionValueRepo: jest.Mocked<
    Pick<Repository<PhbFeatOptionValue>, 'findOne' | 'exists'>
  >;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let characterLevelsRepo: jest.Mocked<Pick<Repository<{ level: number; proficiencyBonus: number }>, 'findOne'>>;

  beforeEach(() => {
    featRefRepo = {
      findOne: jest.fn().mockResolvedValue({ id: '5', slug: 'resilient' }),
    };
    featOptionDefRepo = {
      find: jest.fn().mockResolvedValue([
        {
          featId: '5',
          optionKey: 'abilityIncrease',
          label: 'Atributo',
          valueType: 'ability',
          sortOrder: 1,
          dependsOnOptionKey: null,
          spellMaxLevel: null,
          spellSchoolSlugs: null,
          spellRitualOnly: false,
        },
      ] as PhbFeatOptionDef[]),
    };
    featOptionValueRepo = {
      findOne: jest.fn().mockResolvedValue({ valueId: 'forca' }),
      exists: jest.fn().mockResolvedValue(false),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('phb_class_saving_throw')) {
          return Promise.resolve([{ slug: 'forca' }, { slug: 'constituicao' }]);
        }
        return Promise.resolve([]);
      }),
    };
    characterLevelsRepo = {
      findOne: jest.fn().mockResolvedValue({ level: 4, proficiencyBonus: 2 }),
    };

    validator = new CharacterSheetValidator(
      dataSource as unknown as DataSource,
      {} as CatalogLookupService,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      featRefRepo as unknown as Repository<PhbFeatRef>,
      featOptionDefRepo as unknown as Repository<PhbFeatOptionDef>,
      featOptionValueRepo as unknown as Repository<PhbFeatOptionValue>,
      characterLevelsRepo as never,
    );
  });

  it('rejects resilient +1 on a class save proficiency', async () => {
    await expect(
      validator.validateFeatOptions(
        [{ featSlug: 'resilient', instanceIndex: 0 }],
        [
          {
            featSlug: 'resilient',
            instanceIndex: 0,
            optionKey: 'abilityIncrease',
            valueId: 'forca',
          },
        ],
        4,
        'fighter',
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('accepts resilient on a non-proficient save ability', async () => {
    await expect(
      validator.validateFeatOptions(
        [{ featSlug: 'resilient', instanceIndex: 0 }],
        [
          {
            featSlug: 'resilient',
            instanceIndex: 0,
            optionKey: 'abilityIncrease',
            valueId: 'destreza',
          },
        ],
        4,
        'fighter',
      ),
    ).resolves.toBeUndefined();
  });
});
