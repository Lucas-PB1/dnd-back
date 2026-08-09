import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterSheetValidator } from './character-sheet.validator';
import { CharacterBackgroundValidator } from './background/character-background.validator';
import { CharacterEquipmentValidator } from './equipment/character-equipment.validator';
import { CharacterSpellsValidator } from './spells/character-spells.validator';
import { CharacterClassOptionsValidator } from './class-options/character-class-options.validator';
import { CharacterFeatsValidator } from './feats/character-feats.validator';
import { CharacterCreateRequirementsValidator } from './character-create-requirements.validator';

describe('CharacterSheetValidator.validateSheetInput', () => {
  let validator: CharacterSheetValidator;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'validateClassSkillChoices'>>;
  let backgroundValidator: jest.Mocked<
    Pick<
      CharacterBackgroundValidator,
      'assertClassSkillsDoNotOverlapBackground' | 'validateBackgroundLanguages'
    >
  >;
  let equipmentValidator: jest.Mocked<
    Pick<
      CharacterEquipmentValidator,
      'validateEquipment' | 'validateLanguageSlugs' | 'validateAbilityGenerationMethod'
    >
  >;
  let spellsValidator: jest.Mocked<
    Pick<CharacterSpellsValidator, 'validateCharacterSpells'>
  >;
  let classOptionsValidator: jest.Mocked<
    Pick<
      CharacterClassOptionsValidator,
      | 'validateSpeciesChoices'
      | 'validateSubclassOptions'
      | 'validateFightingStyleSelections'
      | 'validateClassExpertiseOptions'
      | 'validateClassWeaponMasteryOptions'
      | 'validateSpellMasteryOptions'
      | 'validateEldritchInvocationOptions'
      | 'validateMetamagicOptions'
    >
  >;
  let featsValidator: jest.Mocked<
    Pick<CharacterFeatsValidator, 'validateCharacterFeats' | 'validateFeatOptions'>
  >;

  const ctx = {
    level: 5,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'acolyte',
    subclassSlug: 'champion',
    characterFeats: [{ featSlug: 'magic-initiate', instanceIndex: 0 }],
  };

  beforeEach(() => {
    catalogLookup = { validateClassSkillChoices: jest.fn().mockResolvedValue(undefined) };
    backgroundValidator = {
      assertClassSkillsDoNotOverlapBackground: jest.fn().mockResolvedValue(undefined),
      validateBackgroundLanguages: jest.fn().mockResolvedValue(undefined),
    };
    equipmentValidator = {
      validateEquipment: jest.fn().mockResolvedValue(undefined),
      validateLanguageSlugs: jest.fn().mockResolvedValue(undefined),
      validateAbilityGenerationMethod: jest.fn().mockResolvedValue(undefined),
    };
    spellsValidator = { validateCharacterSpells: jest.fn().mockResolvedValue(undefined) };
    classOptionsValidator = {
      validateSpeciesChoices: jest.fn().mockResolvedValue(undefined),
      validateSubclassOptions: jest.fn().mockResolvedValue(undefined),
      validateFightingStyleSelections: jest.fn().mockResolvedValue(undefined),
      validateClassExpertiseOptions: jest.fn().mockResolvedValue(undefined),
      validateClassWeaponMasteryOptions: jest.fn().mockResolvedValue(undefined),
      validateSpellMasteryOptions: jest.fn().mockResolvedValue(undefined),
      validateEldritchInvocationOptions: jest.fn().mockResolvedValue(undefined),
      validateMetamagicOptions: jest.fn().mockResolvedValue(undefined),
    };
    featsValidator = {
      validateCharacterFeats: jest.fn().mockResolvedValue(undefined),
      validateFeatOptions: jest.fn().mockResolvedValue(undefined),
    };

    validator = new CharacterSheetValidator(
      catalogLookup as unknown as CatalogLookupService,
      backgroundValidator as unknown as CharacterBackgroundValidator,
      equipmentValidator as unknown as CharacterEquipmentValidator,
      spellsValidator as unknown as CharacterSpellsValidator,
      classOptionsValidator as unknown as CharacterClassOptionsValidator,
      featsValidator as unknown as CharacterFeatsValidator,
      {} as CharacterCreateRequirementsValidator,
    );
  });

  it('validates class skills and background overlap when both present', async () => {
    await validator.validateSheetInput({ classSkillSlugs: ['athletics'] }, ctx);
    expect(catalogLookup.validateClassSkillChoices).toHaveBeenCalledWith('fighter', ['athletics']);
    expect(backgroundValidator.assertClassSkillsDoNotOverlapBackground).toHaveBeenCalled();
  });

  it('skips background overlap when backgroundSlug is missing', async () => {
    await validator.validateSheetInput(
      { classSkillSlugs: ['athletics'] },
      { ...ctx, backgroundSlug: '' },
    );
    expect(backgroundValidator.assertClassSkillsDoNotOverlapBackground).not.toHaveBeenCalled();
  });

  it('validates subclass options and fighting styles together', async () => {
    const subclassOptions = [{ optionKey: 'fighting_style', valueId: 'defense' }];
    await validator.validateSheetInput({ subclassOptions }, ctx);
    expect(classOptionsValidator.validateSubclassOptions).toHaveBeenCalledWith(
      'champion',
      subclassOptions,
    );
    expect(classOptionsValidator.validateFightingStyleSelections).toHaveBeenCalledWith(
      'fighter',
      ctx.characterFeats,
      subclassOptions,
    );
  });

  it('requires characterFeats when updating featOptions alone', async () => {
    await expect(
      validator.validateSheetInput(
        { featOptions: [{ featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'cleric' }] },
        { ...ctx, characterFeats: undefined },
      ),
    ).rejects.toThrow(/characterFeats required when updating featOptions/i);
  });

  it('uses ctx.characterFeats for featOptions when input omits feats', async () => {
    await validator.validateSheetInput(
      { featOptions: [{ featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'cleric' }] },
      ctx,
    );
    expect(featsValidator.validateFeatOptions).toHaveBeenCalledWith(
      ctx.characterFeats,
      expect.any(Array),
      ctx.level,
      ctx.classSlug,
    );
  });

  it('delegates spells, equipment, languages and ability method updates', async () => {
    const input = {
      characterSpells: [{ spellSlug: 'shield', listType: 'known' as const }],
      equipment: [{ source: 'class' as const, packageSlug: 'a' }],
      languageSlugs: ['common'],
      abilityGenerationMethodSlug: 'standard-array',
      speciesChoices: [{ choiceKind: 'lineage', choiceSlug: 'high-elf' }],
      classOptions: [{ optionKey: 'expertiseSkill1', valueId: 'stealth' }],
      characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
    };
    await validator.validateSheetInput(input, ctx);
    expect(classOptionsValidator.validateSpeciesChoices).toHaveBeenCalled();
    expect(classOptionsValidator.validateClassExpertiseOptions).toHaveBeenCalled();
    expect(classOptionsValidator.validateClassWeaponMasteryOptions).toHaveBeenCalled();
    expect(featsValidator.validateCharacterFeats).toHaveBeenCalled();
    expect(spellsValidator.validateCharacterSpells).toHaveBeenCalled();
    expect(equipmentValidator.validateEquipment).toHaveBeenCalled();
    expect(equipmentValidator.validateLanguageSlugs).toHaveBeenCalled();
    expect(backgroundValidator.validateBackgroundLanguages).toHaveBeenCalled();
    expect(equipmentValidator.validateAbilityGenerationMethod).toHaveBeenCalled();
  });

  it('no-ops on empty partial update', async () => {
    await validator.validateSheetInput({}, ctx);
    expect(catalogLookup.validateClassSkillChoices).not.toHaveBeenCalled();
    expect(featsValidator.validateFeatOptions).not.toHaveBeenCalled();
  });
});
