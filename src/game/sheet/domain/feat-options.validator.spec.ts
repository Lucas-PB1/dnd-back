import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../../entities/phb-subclass-option-value.entity';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../../entities/phb-feat-option.entity';
import { VPhbSpeciesTraitChoices } from '../../../entities/views/v-phb-species-trait-choices.entity';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { CharacterSheetValidator } from './character-sheet.validator';

describe('CharacterSheetValidator.validateFeatOptions', () => {
  let validator: CharacterSheetValidator;
  let featRefRepo: jest.Mocked<Pick<Repository<PhbFeatRef>, 'findOne'>>;
  let featOptionDefRepo: jest.Mocked<Pick<Repository<PhbFeatOptionDef>, 'find'>>;
  let featOptionValueRepo: jest.Mocked<Pick<Repository<PhbFeatOptionValue>, 'findOne'>>;
  let classSpellsRepo: jest.Mocked<Pick<Repository<VSpellByClass>, 'findOne'>>;
  let featsRepo: jest.Mocked<Pick<Repository<VPhbFeat>, 'findOne'>>;
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
    };
    classSpellsRepo = {
      findOne: jest.fn().mockResolvedValue({ spellLevel: 0 }),
    };
    featsRepo = {
      findOne: jest.fn().mockResolvedValue({ featSlug: 'magic-initiate', repeatable: true }),
    };
    dataSource = {
      query: jest.fn().mockResolvedValue([{ ok: 1 }]),
    };

    validator = new CharacterSheetValidator(
      dataSource as unknown as DataSource,
      {} as CatalogLookupService,
      {} as Repository<VPhbSpeciesTraitChoices>,
      featsRepo as unknown as Repository<VPhbFeat>,
      classSpellsRepo as unknown as Repository<VSpellByClass>,
      {} as never,
      {} as never,
      {} as never,
      {} as Repository<PhbSubclassRef>,
      {} as Repository<PhbSubclassOptionValue>,
      {} as never,
      {} as never,
      {} as never,
      featRefRepo as unknown as Repository<PhbFeatRef>,
      featOptionDefRepo as unknown as Repository<PhbFeatOptionDef>,
      featOptionValueRepo as unknown as Repository<PhbFeatOptionValue>,
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
