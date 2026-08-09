import { BadRequestException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterSheetContext } from '../character-sheet.types';
import { CharacterBackgroundValidator } from './background/character-background.validator';
import { CharacterClassOptionsValidator } from './class-options/character-class-options.validator';
import { CharacterCreateRequirementsValidator } from './character-create-requirements.validator';
import { CharacterFeatsValidator } from './feats/character-feats.validator';

describe('CharacterCreateRequirementsValidator', () => {
  let validator: CharacterCreateRequirementsValidator;
  let catalogLookup: jest.Mocked<
    Pick<
      CatalogLookupService,
      'findClassOrFail' | 'validateClassSkillChoices' | 'assertFeatInCatalog'
    >
  >;
  let backgroundValidator: jest.Mocked<
    Pick<
      CharacterBackgroundValidator,
      'assertClassSkillsDoNotOverlapBackground' | 'validateBackgroundLanguages'
    >
  >;
  let classOptionsValidator: jest.Mocked<
    Pick<
      CharacterClassOptionsValidator,
      | 'validateSpeciesChoices'
      | 'resolveSubclassUnlockLevel'
      | 'loadSubclassOptionKeysAtLevel'
      | 'validateSubclassOptions'
      | 'validateFightingStyleSelections'
      | 'validateClassExpertiseOptions'
      | 'loadWeaponMasteryProgression'
      | 'validateClassWeaponMasteryOptions'
    >
  >;
  let featsValidator: jest.Mocked<Pick<CharacterFeatsValidator, 'validateFeatOptions'>>;

  const ctx: CharacterSheetContext = {
    level: 1,
    classSlug: 'rogue',
    speciesSlug: 'human',
    backgroundSlug: 'criminal',
    subclassSlug: 'thief',
  };

  beforeEach(() => {
    catalogLookup = {
      findClassOrFail: jest.fn().mockResolvedValue({ skillChoiceCount: 2 }),
      validateClassSkillChoices: jest.fn().mockResolvedValue(undefined),
      assertFeatInCatalog: jest.fn().mockImplementation((slug: string) =>
        Promise.resolve({
          featSlug: slug,
          categorySlug: slug === 'dueling' ? 'fighting-style' : 'general',
        }),
      ),
    };
    backgroundValidator = {
      assertClassSkillsDoNotOverlapBackground: jest.fn().mockResolvedValue(undefined),
      validateBackgroundLanguages: jest.fn().mockResolvedValue(undefined),
    };
    classOptionsValidator = {
      validateSpeciesChoices: jest.fn().mockResolvedValue(undefined),
      resolveSubclassUnlockLevel: jest.fn().mockResolvedValue(3),
      loadSubclassOptionKeysAtLevel: jest.fn().mockResolvedValue([]),
      validateSubclassOptions: jest.fn().mockResolvedValue(undefined),
      validateFightingStyleSelections: jest.fn().mockResolvedValue(undefined),
      validateClassExpertiseOptions: jest.fn().mockResolvedValue(undefined),
      loadWeaponMasteryProgression: jest.fn().mockResolvedValue([]),
      validateClassWeaponMasteryOptions: jest.fn().mockResolvedValue(undefined),
    };
    featsValidator = { validateFeatOptions: jest.fn().mockResolvedValue(undefined) };
    validator = new CharacterCreateRequirementsValidator(
      catalogLookup as unknown as CatalogLookupService,
      backgroundValidator as unknown as CharacterBackgroundValidator,
      classOptionsValidator as unknown as CharacterClassOptionsValidator,
      featsValidator as unknown as CharacterFeatsValidator,
    );
  });

  it('rejects wrong class skill count', async () => {
    await expect(
      validator.validateCreateRequiredFields({ classSkillSlugs: ['stealth'] }, ctx),
    ).rejects.toThrow(/requires exactly 2 skill/i);
  });

  it('validates class skills when count matches', async () => {
    const fighterCtx = { ...ctx, classSlug: 'fighter', subclassSlug: null };
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 2 } as never);
    await validator.validateCreateRequiredFields(
      {
        classSkillSlugs: ['stealth', 'perception'],
        characterFeats: [{ featSlug: 'dueling', instanceIndex: 0 }],
      },
      fighterCtx,
    );
    expect(catalogLookup.validateClassSkillChoices).toHaveBeenCalledWith('fighter', [
      'stealth',
      'perception',
    ]);
    expect(backgroundValidator.assertClassSkillsDoNotOverlapBackground).toHaveBeenCalled();
  });

  it('skips skill validation when class requires none', async () => {
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 0 } as never);
    await validator.validateCreateRequiredFields(
      {
        classOptions: [
          { optionKey: 'expertiseSkill1', valueId: 'stealth' },
          { optionKey: 'expertiseSkill2', valueId: 'perception' },
        ],
      },
      ctx,
    );
    expect(catalogLookup.validateClassSkillChoices).not.toHaveBeenCalled();
  });

  it('requires missing subclass options at unlock level', async () => {
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 0 } as never);
    classOptionsValidator.resolveSubclassUnlockLevel.mockResolvedValue(1);
    classOptionsValidator.loadSubclassOptionKeysAtLevel.mockResolvedValue(['thievesCant']);
    await expect(
      validator.validateCreateRequiredFields({}, { ...ctx, level: 3 }),
    ).rejects.toThrow(/requires options: thievesCant/i);
  });

  it('validates subclass options when provided', async () => {
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 0 } as never);
    classOptionsValidator.resolveSubclassUnlockLevel.mockResolvedValue(1);
    classOptionsValidator.loadSubclassOptionKeysAtLevel.mockResolvedValue(['thievesCant']);
    await validator.validateCreateRequiredFields(
      {
        subclassOptions: [{ optionKey: 'thievesCant', valueId: 'yes' }],
        classOptions: [
          { optionKey: 'expertiseSkill1', valueId: 'stealth' },
          { optionKey: 'expertiseSkill2', valueId: 'perception' },
        ],
      },
      { ...ctx, level: 3 },
    );
    expect(classOptionsValidator.validateSubclassOptions).toHaveBeenCalled();
  });

  it('validates feat options when feats are present', async () => {
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 0 } as never);
    await validator.validateCreateRequiredFields(
      {
        characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
        featOptions: [{ featSlug: 'alert', optionKey: 'pick', valueId: 'perception' }],
        classOptions: [
          { optionKey: 'expertiseSkill1', valueId: 'stealth' },
          { optionKey: 'expertiseSkill2', valueId: 'perception' },
        ],
      },
      ctx,
    );
    expect(featsValidator.validateFeatOptions).toHaveBeenCalled();
  });

  it('requires expertise options for rogue at level 1', async () => {
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 0 } as never);
    await expect(validator.validateCreateRequiredFields({}, ctx)).rejects.toThrow(
      /requires expertise options/i,
    );
  });

  it('requires weapon mastery options when progression grants slots', async () => {
    catalogLookup.findClassOrFail.mockResolvedValue({ skillChoiceCount: 0 } as never);
    classOptionsValidator.loadWeaponMasteryProgression.mockResolvedValue([
      { level: 1, weaponMastery: 1 },
    ]);
    await expect(
      validator.validateCreateRequiredFields(
        {
          classOptions: [
            { optionKey: 'expertiseSkill1', valueId: 'stealth' },
            { optionKey: 'expertiseSkill2', valueId: 'perception' },
          ],
        },
        ctx,
      ),
    ).rejects.toThrow(/requires weapon mastery options/i);
  });
});
