import { BadRequestException } from '@nestjs/common';
import { CharacterEquipmentValidator } from './character-equipment.validator';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VPhbClassEquipment } from '@entities/views/v-phb-class-equipment.entity';
import { VPhbBackgroundEquipment } from '@entities/views/v-phb-background-equipment.entity';

describe('CharacterEquipmentValidator', () => {
  let validator: CharacterEquipmentValidator;
  let catalogLookup: jest.Mocked<
    Pick<
      CatalogLookupService,
      'findBackgroundOrFail' | 'assertItemInCatalog' | 'assertLanguageSlug' | 'assertAbilityGenerationMethodSlug'
    >
  >;
  let classEquipmentRepo: jest.Mocked<Pick<import('typeorm').Repository<VPhbClassEquipment>, 'find'>>;
  let backgroundEquipmentRepo: jest.Mocked<
    Pick<import('typeorm').Repository<VPhbBackgroundEquipment>, 'find'>
  >;

  const ctx = {
    classSlug: 'fighter',
    backgroundSlug: 'soldier',
    speciesSlug: 'human',
    subclassSlug: null,
    level: 1,
  };

  beforeEach(() => {
    catalogLookup = {
      findBackgroundOrFail: jest.fn(),
      assertItemInCatalog: jest.fn().mockResolvedValue(undefined),
      assertLanguageSlug: jest.fn().mockResolvedValue(undefined),
      assertAbilityGenerationMethodSlug: jest.fn().mockResolvedValue(undefined),
    };
    classEquipmentRepo = { find: jest.fn() };
    backgroundEquipmentRepo = { find: jest.fn() };
    validator = new CharacterEquipmentValidator(
      catalogLookup as unknown as CatalogLookupService,
      classEquipmentRepo as never,
      backgroundEquipmentRepo as never,
    );
  });

  describe('validateEquipment', () => {
    it('accepts background gold option when background offers gold', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({ equipmentGoldOption: 50 } as never);
      await expect(
        validator.validateEquipment(
          [{ source: 'background', packageSlug: 'gold' }],
          ctx,
        ),
      ).resolves.toBeUndefined();
    });

    it('rejects gold option when background has no gold', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({ equipmentGoldOption: null } as never);
      await expect(
        validator.validateEquipment(
          [{ source: 'background', packageSlug: 'gold' }],
          ctx,
        ),
      ).rejects.toThrow(/does not offer a gold equipment option/i);
    });

    it('rejects gold option when background gold is zero', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({ equipmentGoldOption: 0 } as never);
      await expect(
        validator.validateEquipment([{ source: 'background', packageSlug: 'gold' }], ctx),
      ).rejects.toThrow(/does not offer a gold equipment option/i);
    });

    it('rejects item rows on gold background package', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({ equipmentGoldOption: 50 } as never);
      await expect(
        validator.validateEquipment(
          [{ source: 'background', packageSlug: 'gold', itemSlug: 'longsword' }],
          ctx,
        ),
      ).rejects.toThrow(/cannot include item rows/i);
    });

    it('rejects unknown class equipment package', async () => {
      classEquipmentRepo.find.mockResolvedValue([]);
      await expect(
        validator.validateEquipment(
          [{ source: 'class', packageSlug: 'missing', itemSlug: 'longsword' }],
          ctx,
        ),
      ).rejects.toThrow(/Class equipment package 'missing'/i);
    });

    it('rejects unknown background equipment package', async () => {
      backgroundEquipmentRepo.find.mockResolvedValue([]);
      await expect(
        validator.validateEquipment(
          [{ source: 'background', packageSlug: 'missing', itemSlug: 'dagger' }],
          ctx,
        ),
      ).rejects.toThrow(/Background equipment package 'missing'/i);
    });

    it('accepts item listed in class package', async () => {
      classEquipmentRepo.find.mockResolvedValue([
        { itemSlug: 'longsword', choiceText: null },
      ] as never);
      await expect(
        validator.validateEquipment(
          [{ source: 'class', packageSlug: 'a', itemSlug: 'longsword' }],
          ctx,
        ),
      ).resolves.toBeUndefined();
    });

    it('allows custom item when package has choiceText rows', async () => {
      backgroundEquipmentRepo.find.mockResolvedValue([
        { itemSlug: null, choiceText: 'Any martial weapon' },
      ] as never);
      await expect(
        validator.validateEquipment(
          [{ source: 'background', packageSlug: 'gear', itemSlug: 'longsword' }],
          ctx,
        ),
      ).resolves.toBeUndefined();
      expect(catalogLookup.assertItemInCatalog).toHaveBeenCalledWith('longsword');
    });

    it('allows custom class item when package has choiceText rows', async () => {
      classEquipmentRepo.find.mockResolvedValue([
        { itemSlug: null, choiceText: 'Any simple weapon' },
      ] as never);
      await validator.validateEquipment(
        [{ source: 'class', packageSlug: 'b', itemSlug: 'club' }],
        ctx,
      );
      expect(catalogLookup.assertItemInCatalog).toHaveBeenCalledWith('club');
    });

    it('rejects item not in fixed background package', async () => {
      backgroundEquipmentRepo.find.mockResolvedValue([
        { itemSlug: 'dagger', choiceText: null },
      ] as never);
      await expect(
        validator.validateEquipment(
          [{ source: 'background', packageSlug: 'gear', itemSlug: 'longsword' }],
          ctx,
        ),
      ).rejects.toThrow(/not in background package/i);
    });

    it('accepts package row without itemSlug', async () => {
      classEquipmentRepo.find.mockResolvedValue([
        { itemSlug: 'shield', choiceText: null },
      ] as never);
      await expect(
        validator.validateEquipment([{ source: 'class', packageSlug: 'a' }], ctx),
      ).resolves.toBeUndefined();
    });
  });

  describe('validateLanguageSlugs', () => {
    it('rejects duplicate language slugs', async () => {
      await expect(
        validator.validateLanguageSlugs(['common', 'common']),
      ).rejects.toThrow(/Duplicate language/i);
    });

    it('validates each slug via catalog', async () => {
      await validator.validateLanguageSlugs(['common', 'elvish']);
      expect(catalogLookup.assertLanguageSlug).toHaveBeenCalledTimes(2);
    });
  });

  describe('validateAbilityGenerationMethod', () => {
    it('delegates to catalog lookup', async () => {
      await validator.validateAbilityGenerationMethod('standard-array');
      expect(catalogLookup.assertAbilityGenerationMethodSlug).toHaveBeenCalledWith(
        'standard-array',
      );
    });
  });
});
