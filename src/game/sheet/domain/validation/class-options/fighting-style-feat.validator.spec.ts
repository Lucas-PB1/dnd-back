import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { VPhbSpeciesTraitChoices } from '@entities/views/v-phb-species-trait-choices.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { CharacterClassOptionsValidator } from './character-class-options.validator';
import { CharacterSpeciesChoicesValidator } from './character-species-choices.validator';
import { CharacterSubclassOptionsValidator } from './character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from './character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from './character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from './character-eldritch-invocations.validator';
import { CharacterFeatOptionValueValidator } from '../feats/character-feat-option-value.validator';
import { CharacterFeatOptionsValidator } from '../feats/character-feat-options.validator';
import { CharacterFeatsValidator } from '../feats/character-feats.validator';

function buildClassOptionsValidator(
  dataSource: DataSource,
  catalogLookup: CatalogLookupService,
  speciesTraitChoicesRepo: Repository<VPhbSpeciesTraitChoices> = {} as Repository<VPhbSpeciesTraitChoices>,
  subclassRefRepo: Repository<PhbSubclassRef> = {} as Repository<PhbSubclassRef>,
  subclassOptionValuesRepo: Repository<PhbOptionValue> = {} as Repository<PhbOptionValue>,
): CharacterClassOptionsValidator {
  return new CharacterClassOptionsValidator(
    dataSource,
    catalogLookup,
    new CharacterSpeciesChoicesValidator(speciesTraitChoicesRepo, dataSource),
    new CharacterSubclassOptionsValidator(
      dataSource,
      catalogLookup,
      subclassRefRepo,
      subclassOptionValuesRepo,
    ),
    new CharacterClassExpertiseValidator(dataSource),
    new CharacterWeaponMasteryValidator(dataSource),
    new CharacterSpellMasteryValidator(dataSource),
    new CharacterEldritchInvocationsValidator(dataSource),
  );
}

describe('CharacterClassOptionsValidator fighting styles', () => {
  let validator: CharacterClassOptionsValidator;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'assertFeatInCatalog'>>;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;

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
        if (sql.includes('phb_class_proficiency') && sql.includes('fighting_style')) {
          return Promise.resolve([{ slug: 'defense' }, { slug: 'dueling' }]);
        }
        if (sql.includes('phb_fighting_style')) {
          return Promise.resolve([{ ok: 1 }]);
        }
        return Promise.resolve([]);
      }),
    };

    validator = buildClassOptionsValidator(
      dataSource as unknown as DataSource,
      catalogLookup as unknown as CatalogLookupService,
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
      if (sql.includes('phb_class_proficiency') && sql.includes('fighting_style')) {
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

describe('CharacterFeatsValidator fighting_style feat option value', () => {
  let validator: CharacterFeatsValidator;
  let featRefRepo: jest.Mocked<Pick<Repository<PhbFeatRef>, 'findOne'>>;
  let featOptionDefRepo: jest.Mocked<Pick<Repository<PhbOptionDef>, 'find'>>;
  let featOptionValueRepo: jest.Mocked<
    Pick<Repository<PhbOptionValue>, 'findOne' | 'exists'>
  >;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let characterLevelsRepo: jest.Mocked<Pick<Repository<PhbCharacterLevel>, 'findOne'>>;

  beforeEach(() => {
    featRefRepo = {
      findOne: jest.fn().mockResolvedValue({ id: '9', slug: 'style-picker' }),
    };
    featOptionDefRepo = {
      find: jest.fn().mockResolvedValue([
        {
          scope: 'feat',
          ownerId: '9',
          optionKey: 'fightingStyle',
          label: 'Estilo',
          valueType: 'fighting_style',
          sortOrder: 1,
          dependsOnOptionKey: null,
          spellMaxLevel: null,
          spellSchoolSlugs: null,
          spellRitualOnly: false,
        },
      ] as PhbOptionDef[]),
    };
    featOptionValueRepo = {
      findOne: jest.fn(),
      exists: jest.fn().mockResolvedValue(false),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('phb_class_proficiency') && sql.includes('fighting_style')) {
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

    const valueValidator = new CharacterFeatOptionValueValidator(
      dataSource as unknown as DataSource,
      {} as never,
      featOptionValueRepo as unknown as Repository<PhbOptionValue>,
    );
    const optionsValidator = new CharacterFeatOptionsValidator(
      dataSource as unknown as DataSource,
      featRefRepo as unknown as Repository<PhbFeatRef>,
      featOptionDefRepo as unknown as Repository<PhbOptionDef>,
      characterLevelsRepo as unknown as Repository<PhbCharacterLevel>,
      valueValidator,
    );
    validator = new CharacterFeatsValidator(
      {} as CatalogLookupService,
      optionsValidator,
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
