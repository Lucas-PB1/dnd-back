import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VPhbBackgroundToolOption } from '@entities/views/v-phb-background-tool-option.entity';
import { CharacterBackgroundValidator } from './character-background.validator';

describe('CharacterBackgroundValidator', () => {
  let validator: CharacterBackgroundValidator;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let catalogLookup: jest.Mocked<
    Pick<CatalogLookupService, 'findBackgroundOrFail' | 'findLanguageOrFail'>
  >;
  let backgroundToolOptionsRepo: jest.Mocked<Pick<Repository<VPhbBackgroundToolOption>, 'find'>>;

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    catalogLookup = {
      findBackgroundOrFail: jest.fn(),
      findLanguageOrFail: jest.fn().mockImplementation(async (slug: string) => ({
        slug,
        isRare: ['abyssal', 'druidic', 'thieves-cant'].includes(slug),
      })),
    };
    backgroundToolOptionsRepo = { find: jest.fn().mockResolvedValue([{ itemSlug: 'thieves-tools' }]) };
    validator = new CharacterBackgroundValidator(
      dataSource as unknown as DataSource,
      catalogLookup as unknown as CatalogLookupService,
      backgroundToolOptionsRepo as unknown as Repository<VPhbBackgroundToolOption>,
    );
  });

  describe('validateBackgroundAbilityBoosts', () => {
    it('skips when background has no ability options', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({
        abilityOptionSlugs: [],
      } as never);

      await expect(
        validator.validateBackgroundAbilityBoosts('acolyte', {}),
      ).resolves.toBeUndefined();
    });

    it('accepts valid plus2plus1 boosts', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({
        abilityOptionSlugs: ['sabedoria', 'carisma', 'inteligencia'],
      } as never);

      await expect(
        validator.validateBackgroundAbilityBoosts('acolyte', {
          mode: 'plus2plus1',
          plus2Slug: 'sabedoria',
          plus1Slug: 'carisma',
        }),
      ).resolves.toBeUndefined();
    });

    it('rejects disallowed ability slug', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({
        abilityOptionSlugs: ['sabedoria'],
      } as never);

      await expect(
        validator.validateBackgroundAbilityBoosts('acolyte', {
          plus2Slug: 'forca',
          plus1Slug: 'sabedoria',
        }),
      ).rejects.toThrow(/not a valid boost option/i);
    });
  });

  describe('assertClassSkillsDoNotOverlapBackground', () => {
    it('passes when class skills do not overlap background', async () => {
      dataSource.query.mockResolvedValue([{ slug: 'insight' }, { slug: 'religion' }]);

      await expect(
        validator.assertClassSkillsDoNotOverlapBackground('acolyte', ['stealth']),
      ).resolves.toBeUndefined();
    });

    it('rejects overlapping class skill', async () => {
      dataSource.query.mockResolvedValue([{ slug: 'insight' }]);
      await expect(
        validator.assertClassSkillsDoNotOverlapBackground('acolyte', ['insight']),
      ).rejects.toThrow(/already granted by background/i);
    });

    it('skips when no class skills provided', async () => {
      await validator.assertClassSkillsDoNotOverlapBackground('acolyte', []);
      expect(dataSource.query).not.toHaveBeenCalled();
    });
  });

  describe('validateBackgroundLanguages', () => {
    beforeEach(() => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({
        languageChoiceCount: 1,
      } as never);
      dataSource.query.mockResolvedValue([{ slug: 'common' }]);
    });

    it('accepts fixed language plus one choice', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', ['common', 'elvish']),
      ).resolves.toBeUndefined();
      expect(catalogLookup.findLanguageOrFail).toHaveBeenCalledWith('elvish');
    });

    it('rejects rare language as a choice', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', ['common', 'abyssal']),
      ).rejects.toThrow(/not available as a language choice/i);
    });

    it('rejects missing fixed language', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', ['elvish', 'dwarvish']),
      ).rejects.toThrow(/grants fixed language 'common'/i);
    });

    it('rejects duplicate slugs', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', ['common', 'common']),
      ).rejects.toThrow(/duplicate language/i);
    });

    it('requires languages when options.required and undefined', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', undefined, { required: true }),
      ).rejects.toThrow(/requires 2 language/i);
    });

    it('skips when background grants no languages', async () => {
      catalogLookup.findBackgroundOrFail.mockResolvedValue({
        languageChoiceCount: 0,
      } as never);
      dataSource.query.mockResolvedValue([]);

      await expect(
        validator.validateBackgroundLanguages('hermit', undefined),
      ).resolves.toBeUndefined();
    });

    it('rejects wrong total language count', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', ['common']),
      ).rejects.toThrow(/requires exactly 2 language/i);
      await expect(
        validator.validateBackgroundLanguages('acolyte', ['common', 'elvish', 'dwarvish']),
      ).rejects.toThrow(/requires exactly 2 language/i);
    });

    it('allows undefined languages when not required', async () => {
      await expect(
        validator.validateBackgroundLanguages('acolyte', undefined),
      ).resolves.toBeUndefined();
    });

    it('includes class extra languages in the required total', async () => {
      await expect(
        validator.validateBackgroundLanguages(
          'acolyte',
          ['common', 'thieves-cant', 'elvish', 'dwarvish'],
          {
            extra: { grantedSlugs: ['thieves-cant'], choiceCount: 1 },
          },
        ),
      ).resolves.toBeUndefined();
    });

    it('includes granted druidic without extra choices', async () => {
      await expect(
        validator.validateBackgroundLanguages(
          'acolyte',
          ['common', 'druidic', 'elvish'],
          {
            extra: { grantedSlugs: ['druidic'], choiceCount: 0 },
          },
        ),
      ).resolves.toBeUndefined();
    });
  });

  describe('validateBackgroundOriginFeat + validateBackgroundToolChoice', () => {
    it('validates origin feat and tool branches', async () => {
      await expect(
        validator.validateBackgroundOriginFeat({ featSlug: null }, []),
      ).resolves.toBeUndefined();
      await expect(
        validator.validateBackgroundOriginFeat({ featSlug: 'alert' }, []),
      ).rejects.toThrow(/origin feat 'alert'/i);
      await expect(
        validator.validateBackgroundOriginFeat(
          { featSlug: ' alert ' },
          [{ featSlug: 'alert', instanceIndex: 0 }],
        ),
      ).resolves.toBeUndefined();

      await expect(
        validator.validateBackgroundOriginFeat(
          {
            backgroundSlug: 'seafarer',
            featSlug: null,
            originFeatChoiceSlugs: ['fisher', 'northern-raider'],
          },
          [],
        ),
      ).rejects.toThrow(/exactly one origin feat/i);

      await expect(
        validator.validateBackgroundOriginFeat(
          {
            backgroundSlug: 'seafarer',
            featSlug: null,
            originFeatChoiceSlugs: ['fisher', 'northern-raider'],
          },
          [
            { featSlug: 'fisher', instanceIndex: 0 },
            { featSlug: 'northern-raider', instanceIndex: 0 },
          ],
        ),
      ).rejects.toThrow(/exactly one origin feat/i);

      await expect(
        validator.validateBackgroundOriginFeat(
          {
            backgroundSlug: 'seafarer',
            featSlug: null,
            originFeatChoiceSlugs: ['fisher', 'northern-raider'],
          },
          [{ featSlug: 'fisher', instanceIndex: 0 }],
        ),
      ).resolves.toBeUndefined();

      await expect(
        validator.validateBackgroundToolChoice(
          { backgroundSlug: 'criminal', toolProficiencyKind: 'choice', toolItemSlug: null },
          null,
        ),
      ).rejects.toThrow(/requires a tool proficiency choice/i);

      backgroundToolOptionsRepo.find.mockResolvedValue([]);
      await expect(
        validator.validateBackgroundToolChoice(
          { backgroundSlug: 'criminal', toolProficiencyKind: 'choice', toolItemSlug: null },
          'forgery-kit',
        ),
      ).rejects.toThrow(/not a valid choice/i);

      await expect(
        validator.validateBackgroundToolChoice(
          { backgroundSlug: 'soldier', toolProficiencyKind: 'fixed', toolItemSlug: 'gaming-set' },
          'thieves-tools',
        ),
      ).rejects.toThrow(/grants fixed tool 'gaming-set'/i);

      await expect(
        validator.validateBackgroundToolChoice(
          { backgroundSlug: 'soldier', toolProficiencyKind: 'fixed', toolItemSlug: 'gaming-set' },
          null,
        ),
      ).resolves.toBeUndefined();
    });
  });
});
