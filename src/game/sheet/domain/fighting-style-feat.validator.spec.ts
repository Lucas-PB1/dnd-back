import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../../entities/phb-feat-option.entity';
import { CharacterSheetValidator } from './character-sheet.validator';

describe('CharacterSheetValidator fighting styles', () => {
  let validator: CharacterSheetValidator;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'assertFeatInCatalog'>>;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let characterLevelsRepo: jest.Mocked<
    Pick<Repository<{ level: number; proficiencyBonus: number }>, 'findOne'>
  >;

  beforeEach(() => {
    catalogLookup = {
      assertFeatInCatalog: jest.fn().mockImplementation((slug: string) =>
        Promise.resolve({
          featSlug: slug,
          categorySlug: slug === 'dueling' ? 'fighting-style' : 'general',
        }),
      ),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('phb_class_fighting_style')) {
          return Promise.resolve([{ slug: 'defense' }, { slug: 'dueling' }]);
        }
        if (sql.includes('phb_fighting_style')) {
          return Promise.resolve([{ ok: 1 }]);
        }
        return Promise.resolve([]);
      }),
    };
    characterLevelsRepo = {
      findOne: jest.fn().mockResolvedValue({ level: 8, proficiencyBonus: 3 }),
    };

    validator = new CharacterSheetValidator(
      dataSource as unknown as DataSource,
      catalogLookup as unknown as CatalogLookupService,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      characterLevelsRepo as never,
    );
  });

  it('rejects duplicate fighting style from feat and subclass', async () => {
    await expect(
      validator.validateFightingStyleSelections(
        'fighter',
        [{ featSlug: 'dueling', instanceIndex: 0 }],
        [{ optionKey: 'additionalFightingStyle', valueId: 'dueling' }],
      ),
    ).rejects.toThrow(/Each fighting style can only be chosen once/i);
  });

  it('rejects fighting style feat not allowed for class', async () => {
    dataSource.query.mockImplementation((sql: string) => {
      if (sql.includes('phb_class_fighting_style')) {
        return Promise.resolve([{ slug: 'defense' }]);
      }
      return Promise.resolve([]);
    });

    await expect(
      validator.validateFightingStyleSelections(
        'fighter',
        [{ featSlug: 'dueling', instanceIndex: 0 }],
        undefined,
      ),
    ).rejects.toThrow(/not available for class/i);
  });

  it('accepts distinct styles from feat and subclass', async () => {
    await expect(
      validator.validateFightingStyleSelections(
        'fighter',
        [{ featSlug: 'dueling', instanceIndex: 0 }],
        [{ optionKey: 'additionalFightingStyle', valueId: 'defense' }],
      ),
    ).resolves.toBeUndefined();
  });
});

describe('CharacterSheetValidator fighting_style feat option value', () => {
  let validator: CharacterSheetValidator;
  let featRefRepo: jest.Mocked<Pick<Repository<PhbFeatRef>, 'findOne'>>;
  let featOptionDefRepo: jest.Mocked<Pick<Repository<PhbFeatOptionDef>, 'find'>>;
  let featOptionValueRepo: jest.Mocked<
    Pick<Repository<PhbFeatOptionValue>, 'findOne' | 'exists'>
  >;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let characterLevelsRepo: jest.Mocked<
    Pick<Repository<{ level: number; proficiencyBonus: number }>, 'findOne'>
  >;

  beforeEach(() => {
    featRefRepo = {
      findOne: jest.fn().mockResolvedValue({ id: '9', slug: 'style-picker' }),
    };
    featOptionDefRepo = {
      find: jest.fn().mockResolvedValue([
        {
          featId: '9',
          optionKey: 'fightingStyle',
          label: 'Estilo',
          valueType: 'fighting_style',
          sortOrder: 1,
          dependsOnOptionKey: null,
          spellMaxLevel: null,
          spellSchoolSlugs: null,
          spellRitualOnly: false,
        },
      ] as PhbFeatOptionDef[]),
    };
    featOptionValueRepo = {
      findOne: jest.fn(),
      exists: jest.fn().mockResolvedValue(false),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('phb_class_fighting_style')) {
          return Promise.resolve([{ slug: 'defense' }]);
        }
        if (sql.includes('phb_fighting_style')) {
          return Promise.resolve([{ ok: 1 }]);
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

  it('rejects fighting_style option outside class list', async () => {
    await expect(
      validator.validateFeatOptions(
        [{ featSlug: 'style-picker', instanceIndex: 0 }],
        [
          {
            featSlug: 'style-picker',
            instanceIndex: 0,
            optionKey: 'fightingStyle',
            valueId: 'dueling',
          },
        ],
        4,
        'fighter',
      ),
    ).rejects.toThrow(/not a valid fighting style for this class/i);
  });
});
