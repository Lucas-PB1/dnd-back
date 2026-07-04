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
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { CharacterSheetValidator } from './character-sheet.validator';
import { EMPTY_SHEET_DATA, type CharacterSheetInput } from './character-sheet.types';

describe('CharacterSheetValidator.validateFeatOptions', () => {
  let validator: CharacterSheetValidator;
  let featRefRepo: jest.Mocked<Pick<Repository<PhbFeatRef>, 'findOne'>>;
  let featOptionDefRepo: jest.Mocked<Pick<Repository<PhbFeatOptionDef>, 'find'>>;
  let featOptionValueRepo: jest.Mocked<Pick<Repository<PhbFeatOptionValue>, 'findOne'>>;
  let classSpellsRepo: jest.Mocked<Pick<Repository<VSpellByClass>, 'findOne'>>;
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
        },
        {
          featId: '10',
          optionKey: 'cantrip1',
          label: 'Truque',
          valueType: 'spell',
          sortOrder: 2,
          dependsOnOptionKey: 'spellList',
          spellMaxLevel: 0,
        },
      ] as PhbFeatOptionDef[]),
    };
    featOptionValueRepo = {
      findOne: jest.fn().mockResolvedValue({ valueId: 'cleric' }),
    };
    classSpellsRepo = {
      findOne: jest.fn().mockResolvedValue({ spellLevel: 0 }),
    };
    dataSource = {
      query: jest.fn().mockResolvedValue([{ ok: 1 }]),
    };

    validator = new CharacterSheetValidator(
      dataSource as unknown as DataSource,
      {} as CatalogLookupService,
      {} as Repository<VPhbSpeciesTraitChoices>,
      {} as never,
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

  it('requires all feat option keys', async () => {
    await expect(
      validator.validateFeatOptions(['magic-initiate'], []),
    ).rejects.toThrow(/requires options/i);
  });

  it('accepts valid magic-initiate options', async () => {
    await expect(
      validator.validateFeatOptions(['magic-initiate'], [
        { featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'cleric' },
        { featSlug: 'magic-initiate', optionKey: 'cantrip1', valueId: 'guidance' },
      ]),
    ).resolves.toBeUndefined();
  });

  it('rejects options for unselected feats', async () => {
    await expect(
      validator.validateFeatOptions(['alert'], [
        { featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'cleric' },
      ]),
    ).rejects.toThrow(BadRequestException);
  });
});
