import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { CharacterFeatOptionValueValidator } from './character-feat-option-value.validator';
import { CharacterFeatOptionsValidator } from './character-feat-options.validator';
import { CharacterFeatsValidator } from './character-feats.validator';

describe('CharacterFeatsValidator resilient feat', () => {
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
      findOne: jest.fn().mockResolvedValue({ id: '5', slug: 'resilient' }),
    };
    featOptionDefRepo = {
      find: jest.fn().mockResolvedValue([
        {
          scope: 'feat',
          ownerId: '5',
          optionKey: 'abilityIncrease',
          label: 'Atributo',
          valueType: 'ability',
          sortOrder: 1,
          dependsOnOptionKey: null,
          spellMaxLevel: null,
          spellSchoolSlugs: null,
          spellRitualOnly: false,
        },
      ] as PhbOptionDef[]),
    };
    featOptionValueRepo = {
      findOne: jest.fn().mockResolvedValue({ valueId: 'forca' }),
      exists: jest.fn().mockResolvedValue(false),
    };
    dataSource = {
      query: jest.fn().mockImplementation((sql: string) => {
        if (sql.includes('phb_class_proficiency') && sql.includes('saving_throw')) {
          return Promise.resolve([{ slug: 'forca' }, { slug: 'constituicao' }]);
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
