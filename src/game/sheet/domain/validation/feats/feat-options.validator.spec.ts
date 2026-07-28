import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../../../../entities/phb-feat-option.entity';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { PhbCharacterLevel } from '../../../../../entities/phb-character-level.entity';
import { CharacterFeatOptionValueValidator } from './character-feat-option-value.validator';
import { CharacterFeatOptionsValidator } from './character-feat-options.validator';
import { CharacterFeatsValidator } from './character-feats.validator';

describe('CharacterFeatsValidator.validateFeatOptions', () => {
  let validator: CharacterFeatsValidator;
  let featRefRepo: jest.Mocked<Pick<Repository<PhbFeatRef>, 'findOne'>>;
  let featOptionDefRepo: jest.Mocked<Pick<Repository<PhbFeatOptionDef>, 'find'>>;
  let featOptionValueRepo: jest.Mocked<Pick<Repository<PhbFeatOptionValue>, 'findOne'>>;
  let classSpellsRepo: jest.Mocked<Pick<Repository<VSpellByClass>, 'findOne'>>;
  let characterLevelsRepo: jest.Mocked<Pick<Repository<PhbCharacterLevel>, 'findOne'>>;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;

  beforeEach(() => {
    featRefRepo = {
      findOne: jest.fn().mockResolvedValue({ id: '10', slug: 'magic-initiate' }),
    };
    featOptionDefRepo = {
      find: jest.fn().mockResolvedValue([
        {
          featId: '10',
          optionKey: 'spellList',
          label: 'Lista',
          valueType: 'catalog',
          sortOrder: 1,
          dependsOnOptionKey: null,
          spellMaxLevel: null,
          spellSchoolSlugs: null,
        },
        {
          featId: '10',
          optionKey: 'cantrip1',
          label: 'Truque',
          valueType: 'spell',
          sortOrder: 2,
          dependsOnOptionKey: 'spellList',
          spellMaxLevel: 0,
          spellSchoolSlugs: null,
        },
      ] as PhbFeatOptionDef[]),
    };
    featOptionValueRepo = {
      findOne: jest.fn().mockResolvedValue({ valueId: 'cleric' }),
      exists: jest.fn().mockResolvedValue(false),
    } as unknown as jest.Mocked<Pick<Repository<PhbFeatOptionValue>, 'findOne'>>;
    characterLevelsRepo = {
      findOne: jest.fn().mockResolvedValue({ level: 1, proficiencyBonus: 2 }),
    };
    classSpellsRepo = {
      findOne: jest.fn().mockResolvedValue({ spellLevel: 0 }),
    };
    dataSource = {
      query: jest.fn().mockResolvedValue([{ ok: 1 }]),
    };

    const valueValidator = new CharacterFeatOptionValueValidator(
      dataSource as unknown as DataSource,
      classSpellsRepo as unknown as Repository<VSpellByClass>,
      featOptionValueRepo as unknown as Repository<PhbFeatOptionValue>,
    );
    const optionsValidator = new CharacterFeatOptionsValidator(
      dataSource as unknown as DataSource,
      featRefRepo as unknown as Repository<PhbFeatRef>,
      featOptionDefRepo as unknown as Repository<PhbFeatOptionDef>,
      characterLevelsRepo as unknown as Repository<PhbCharacterLevel>,
      valueValidator,
    );
    validator = new CharacterFeatsValidator(
      {} as CatalogLookupService,
      optionsValidator,
    );
  });

  it('requires all feat option keys per instance', async () => {
    await expect(
      validator.validateFeatOptions(
        [{ featSlug: 'magic-initiate', instanceIndex: 0 }],
        [],
      ),
    ).rejects.toThrow(/requires options/i);
  });

  it('accepts valid magic-initiate options', async () => {
    await expect(
      validator.validateFeatOptions(
        [{ featSlug: 'magic-initiate', instanceIndex: 0 }],
        [
          { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'spellList', valueId: 'cleric' },
          { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'cantrip1', valueId: 'guidance' },
        ],
      ),
    ).resolves.toBeUndefined();
  });

  it('requires different spell lists for repeated magic-initiate', async () => {
    await expect(
      validator.validateFeatOptions(
        [
          { featSlug: 'magic-initiate', instanceIndex: 0 },
          { featSlug: 'magic-initiate', instanceIndex: 1 },
        ],
        [
          { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'spellList', valueId: 'cleric' },
          { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'cantrip1', valueId: 'guidance' },
          { featSlug: 'magic-initiate', instanceIndex: 1, optionKey: 'spellList', valueId: 'cleric' },
          { featSlug: 'magic-initiate', instanceIndex: 1, optionKey: 'cantrip1', valueId: 'guidance' },
        ],
      ),
    ).rejects.toThrow(/different spell list/i);
  });

  it('rejects options for unselected feat instances', async () => {
    await expect(
      validator.validateFeatOptions(
        [{ featSlug: 'alert', instanceIndex: 0 }],
        [
          { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'spellList', valueId: 'cleric' },
        ],
      ),
    ).rejects.toThrow(BadRequestException);
  });
});
