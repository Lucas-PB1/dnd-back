import { asDep } from '@common/testing/as-dep';
jest.mock('@game/sheet/infrastructure/queries/feat-option.queries', () => ({
  ...jest.requireActual('@game/sheet/infrastructure/queries/feat-option.queries'),
  fightingStyleExists: jest.fn().mockResolvedValue(true),
}));

import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbFightingStyle } from '@entities/class/phb-fighting-style.entity';
import { PhbOptionDef, PhbOptionValue } from '@entities/reference/phb-option.entity';
import { PhbFeatRef } from '@entities/feat/phb-feat-ref.entity';
import { VPhbSpeciesTraitChoices } from '@entities/views/v-phb-species-trait-choices.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import { PhbCharacterLevel } from '@entities/reference/phb-character-level.entity';
import { CharacterClassOptionsValidator } from './character-class-options.validator';
import { CharacterSpeciesChoicesValidator } from './character-species-choices.validator';
import { CharacterHeritageChoicesValidator } from './character-heritage-choices.validator';
import { CharacterSubclassOptionsValidator } from './character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from './character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from './character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from './character-eldritch-invocations.validator';
import { CharacterMetamagicValidator } from './character-metamagic.validator';
import { CharacterClassFeatureOptionsValidator } from './character-class-feature-options.validator';
import { ClassProficienciesQuery } from '@catalog/game-port';
import { CharacterFeatOptionValueValidator } from '../feats/character-feat-option-value.validator';
import { CharacterFeatOptionsValidator } from '../feats/character-feat-options.validator';
import { CharacterFeatsValidator } from '../feats/character-feats.validator';
import { mockClassProficienciesQuery } from '../testing/class-validation.spec.helpers';
import { fightingStyleExists } from '@game/sheet/infrastructure/queries/feat-option.queries';

function buildClassOptionsValidator(
  dataSource: DataSource,
  catalogLookup: CatalogLookupService,
  proficiencies = mockClassProficienciesQuery(),
  speciesTraitChoicesRepo: Repository<VPhbSpeciesTraitChoices> = {} as Repository<VPhbSpeciesTraitChoices>,
  subclassRefRepo: Repository<PhbSubclassRef> = {} as Repository<PhbSubclassRef>,
  subclassOptionValuesRepo: Repository<PhbOptionValue> = {} as Repository<PhbOptionValue>,
): CharacterClassOptionsValidator {
  return new CharacterClassOptionsValidator(
    dataSource,
    proficiencies.query,
    catalogLookup,
    new CharacterSpeciesChoicesValidator(speciesTraitChoicesRepo, dataSource),
    {
      validateHeritageChoices: jest.fn().mockResolvedValue(undefined),
    } as unknown as CharacterHeritageChoicesValidator,
    new CharacterSubclassOptionsValidator(
      dataSource,
      catalogLookup,
      subclassRefRepo,
      subclassOptionValuesRepo,
      asDep({}),
    ),
    new CharacterClassExpertiseValidator(dataSource),
    new CharacterWeaponMasteryValidator(dataSource, proficiencies.query),
    new CharacterSpellMasteryValidator(dataSource),
    new CharacterEldritchInvocationsValidator(dataSource, asDep({
      find: jest.fn(),
    })),
    new CharacterMetamagicValidator(dataSource),
    new CharacterClassFeatureOptionsValidator(dataSource),
  );
}

describe('CharacterClassOptionsValidator fighting styles', () => {
  let validator: CharacterClassOptionsValidator;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'assertFeatInCatalog'>>;
  let proficiencies: ReturnType<typeof mockClassProficienciesQuery>;
  let dataSource: DataSource;

  beforeEach(() => {
    jest.mocked(fightingStyleExists).mockResolvedValue(true);
    catalogLookup = {
      assertFeatInCatalog: jest.fn().mockImplementation((slug: string) =>
        Promise.resolve({
          featSlug: slug,
          categorySlug: slug === 'dueling' ? 'fighting-style' : 'general',
        }),
      ),
    };
    proficiencies = mockClassProficienciesQuery();
    dataSource = {} as DataSource;

    validator = buildClassOptionsValidator(
      dataSource,
      catalogLookup as unknown as CatalogLookupService,
      proficiencies,
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
    proficiencies.forClassSlug.mockResolvedValue({
      savingThrowSlugs: [],
      savingThrowNames: [],
      armorTrainingSlugs: [],
      armorTrainingNames: [],
      weaponProficiencySlugs: [],
      weaponProficiencyNames: [],
      fightingStyleSlugs: ['defense'],
      fightingStyleNames: [],
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
  let dataSource: { getRepository: jest.Mock };
  let fightingStyleRepo: { exists: jest.Mock };
  let proficiencies: ReturnType<typeof mockClassProficienciesQuery>;
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
    fightingStyleRepo = { exists: jest.fn().mockResolvedValue(true) };
    dataSource = {
      getRepository: jest.fn((entity) => {
        if (entity === PhbFightingStyle) return fightingStyleRepo;
        throw new Error(`Unexpected entity ${String(entity)}`);
      }),
    };
    proficiencies = mockClassProficienciesQuery({
      fightingStyleSlugs: ['defense'],
    });
    proficiencies.forClassSlug.mockResolvedValue({
      savingThrowSlugs: [],
      savingThrowNames: [],
      armorTrainingSlugs: [],
      armorTrainingNames: [],
      weaponProficiencySlugs: [],
      weaponProficiencyNames: [],
      fightingStyleSlugs: ['defense'],
      fightingStyleNames: [],
    });
    characterLevelsRepo = {
      findOne: jest.fn().mockResolvedValue({ level: 4, proficiencyBonus: 2 }),
    };

    const valueValidator = new CharacterFeatOptionValueValidator(
      dataSource as unknown as DataSource,
      asDep({}),
      featOptionValueRepo as unknown as Repository<PhbOptionValue>,
    );
    const optionsValidator = new CharacterFeatOptionsValidator(
      proficiencies.query,
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
