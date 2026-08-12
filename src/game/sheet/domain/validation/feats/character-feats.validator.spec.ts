import { BadRequestException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterFeatsValidator } from './character-feats.validator';
import { CharacterFeatOptionsValidator } from './character-feat-options.validator';

describe('CharacterFeatsValidator', () => {
  let validator: CharacterFeatsValidator;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'assertFeatInCatalog'>>;
  let featOptionsValidator: jest.Mocked<Pick<CharacterFeatOptionsValidator, 'validateFeatOptions'>>;

  beforeEach(() => {
    catalogLookup = {
      assertFeatInCatalog: jest.fn().mockResolvedValue({
        repeatable: false,
        requiredFeatSlugs: [],
      }),
    };
    featOptionsValidator = {
      validateFeatOptions: jest.fn().mockResolvedValue(undefined),
    };
    validator = new CharacterFeatsValidator(
      catalogLookup as unknown as CatalogLookupService,
      featOptionsValidator as unknown as CharacterFeatOptionsValidator,
    );
  });

  describe('validateCharacterFeats', () => {
    it('rejects duplicate feat instances', async () => {
      await expect(
        validator.validateCharacterFeats([
          { featSlug: 'alert', instanceIndex: 0 },
          { featSlug: 'alert', instanceIndex: 0 },
        ]),
      ).rejects.toThrow(/duplicate feat instances/i);
    });

    it('rejects non-repeatable feat taken twice', async () => {
      await expect(
        validator.validateCharacterFeats([
          { featSlug: 'alert', instanceIndex: 0 },
          { featSlug: 'alert', instanceIndex: 1 },
        ]),
      ).rejects.toThrow(/not repeatable/i);
    });

    it('rejects non-contiguous instance indices for repeatable feat', async () => {
      catalogLookup.assertFeatInCatalog.mockResolvedValue({
        repeatable: true,
        requiredFeatSlugs: [],
      } as never);
      await expect(
        validator.validateCharacterFeats([
          { featSlug: 'lucky', instanceIndex: 0 },
          { featSlug: 'lucky', instanceIndex: 2 },
        ]),
      ).rejects.toThrow(/contiguous starting at 0/i);
    });

    it('accepts repeatable feat with contiguous indices', async () => {
      catalogLookup.assertFeatInCatalog.mockResolvedValue({
        repeatable: true,
        requiredFeatSlugs: [],
      } as never);
      await expect(
        validator.validateCharacterFeats([
          { featSlug: 'lucky', instanceIndex: 0 },
          { featSlug: 'lucky', instanceIndex: 1 },
        ]),
      ).resolves.toBeUndefined();
    });

    it('rejects feat missing required prerequisite feat', async () => {
      catalogLookup.assertFeatInCatalog.mockImplementation(async (slug: string) => {
        if (slug === 'greater-blessing-of-baldur') {
          return {
            repeatable: false,
            requiredFeatSlugs: ['blessing-of-baldur'],
          } as never;
        }
        return { repeatable: false, requiredFeatSlugs: [] } as never;
      });
      await expect(
        validator.validateCharacterFeats([
          { featSlug: 'greater-blessing-of-baldur', instanceIndex: 0 },
        ]),
      ).rejects.toThrow(/requires feat 'blessing-of-baldur'/i);
    });

    it('accepts feat when required prerequisite feat is present', async () => {
      catalogLookup.assertFeatInCatalog.mockImplementation(async (slug: string) => {
        if (slug === 'greater-blessing-of-baldur') {
          return {
            repeatable: false,
            requiredFeatSlugs: ['blessing-of-baldur'],
          } as never;
        }
        return { repeatable: false, requiredFeatSlugs: [] } as never;
      });
      await expect(
        validator.validateCharacterFeats([
          { featSlug: 'blessing-of-baldur', instanceIndex: 0 },
          { featSlug: 'greater-blessing-of-baldur', instanceIndex: 0 },
        ]),
      ).resolves.toBeUndefined();
    });
  });

  describe('validateFeatOptions', () => {
    it('delegates to CharacterFeatOptionsValidator', async () => {
      const feats = [{ featSlug: 'alert', instanceIndex: 0 }];
      const options = [{ featSlug: 'alert', optionKey: 'pick', valueId: 'perception' }];
      await validator.validateFeatOptions(feats, options, 4, 'fighter');
      expect(featOptionsValidator.validateFeatOptions).toHaveBeenCalledWith(
        feats,
        options,
        4,
        'fighter',
      );
    });
  });
});
