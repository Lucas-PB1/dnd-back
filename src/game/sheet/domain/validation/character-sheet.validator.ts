import { BadRequestException, Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterSheetInput, CharacterSheetContext } from '../character-sheet.types';
import { FeatOptionDto, CharacterFeatDto } from '@game/sheet/dto/character-sheet.dto';
import { CharacterBackgroundValidator } from './background/character-background.validator';
import { CharacterEquipmentValidator } from './equipment/character-equipment.validator';
import { CharacterSpellsValidator } from './spells/character-spells.validator';
import { CharacterClassOptionsValidator } from './class-options/character-class-options.validator';
import { CharacterFeatsValidator } from './feats/character-feats.validator';
import { CharacterCreateRequirementsValidator } from './character-create-requirements.validator';
import { CharacterClassExtraSkillValidator } from './class-options/character-class-extra-skill.validator';
import { CharacterMysticArcanumValidator } from './class-options/character-mystic-arcanum.validator';
import { CharacterSignatureSpellsValidator } from './class-options/character-signature-spells.validator';
import { classLanguageGrant } from './class-options/class-language-grant';

export type { CharacterSheetContext } from '../character-sheet.types';

@Injectable()
export class CharacterSheetValidator {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly backgroundValidator: CharacterBackgroundValidator,
    private readonly equipmentValidator: CharacterEquipmentValidator,
    private readonly spellsValidator: CharacterSpellsValidator,
    private readonly classOptionsValidator: CharacterClassOptionsValidator,
    private readonly featsValidator: CharacterFeatsValidator,
    private readonly createRequirementsValidator: CharacterCreateRequirementsValidator,
    private readonly extraSkillValidator: CharacterClassExtraSkillValidator,
    private readonly mysticArcanumValidator: CharacterMysticArcanumValidator,
    private readonly signatureSpellsValidator: CharacterSignatureSpellsValidator,
  ) {}

  async validateSheetInput(
    input: CharacterSheetInput,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    if (input.classSkillSlugs !== undefined) {
      await this.catalogLookup.validateClassSkillChoices(ctx.classSlug, input.classSkillSlugs);
      if (ctx.backgroundSlug) {
        await this.backgroundValidator.assertClassSkillsDoNotOverlapBackground(
          ctx.backgroundSlug,
          input.classSkillSlugs,
        );
      }
    }

    if (input.speciesChoices !== undefined) {
      await this.classOptionsValidator.validateSpeciesChoices(ctx.speciesSlug, input.speciesChoices);
    }

    if (input.subclassOptions !== undefined) {
      await this.classOptionsValidator.validateSubclassOptions(
        ctx.subclassSlug,
        input.subclassOptions,
        ctx,
      );
      const feats = input.characterFeats ?? ctx.characterFeats ?? [];
      await this.classOptionsValidator.validateFightingStyleSelections(
        ctx.classSlug,
        feats,
        input.subclassOptions,
        ctx.level,
      );
    }

    if (input.classOptions !== undefined) {
      await this.classOptionsValidator.validateClassExpertiseOptions(
        ctx,
        input.classOptions,
        input.classSkillSlugs,
        input.speciesChoices,
        input.featOptions,
      );
      await this.classOptionsValidator.validateClassWeaponMasteryOptions(
        ctx,
        input.classOptions,
        {
          characterFeats: input.characterFeats ?? ctx.characterFeats,
          subclassOptions: input.subclassOptions,
        },
      );
      await this.classOptionsValidator.validateSpellMasteryOptions(
        ctx,
        input.classOptions,
        input.characterSpells,
      );
      await this.classOptionsValidator.validateEldritchInvocationOptions(
        ctx,
        input.classOptions,
        input.characterSpells,
        input.characterFeats ?? ctx.characterFeats,
      );
      await this.classOptionsValidator.validateMetamagicOptions(
        ctx,
        input.classOptions,
      );
      await this.classOptionsValidator.validateClassFeatureOptions(
        ctx,
        input.classOptions,
      );
      await this.extraSkillValidator.validateClassExtraSkillOptions(
        ctx,
        input.classOptions,
        input.classSkillSlugs,
        input.speciesChoices,
        input.featOptions,
      );
      await this.mysticArcanumValidator.validateMysticArcanumOptions(
        ctx,
        input.classOptions,
      );
      await this.signatureSpellsValidator.validateSignatureSpellOptions(
        ctx,
        input.classOptions,
        input.characterSpells,
      );
    }

    const characterFeats = input.characterFeats ?? [];
    if (input.characterFeats !== undefined) {
      await this.featsValidator.validateCharacterFeats(characterFeats);
    }

    if (input.featOptions !== undefined) {
      const feats = ctx.characterFeats ?? characterFeats;
      if (!feats.length) {
        throw new BadRequestException('characterFeats required when updating featOptions');
      }
      await this.featsValidator.validateFeatOptions(feats, input.featOptions, ctx.level, ctx.classSlug);
    }

    if (input.characterSpells !== undefined) {
      await this.spellsValidator.validateCharacterSpells(
        input.characterSpells,
        ctx,
        input.featOptions,
        input.characterFeats ?? ctx.characterFeats,
        input.speciesChoices,
        input.classOptions,
        input.subclassOptions,
      );
    }

    if (input.equipment !== undefined) {
      await this.equipmentValidator.validateEquipment(input.equipment, ctx);
    }

    if (input.languageSlugs !== undefined) {
      await this.equipmentValidator.validateLanguageSlugs(input.languageSlugs);
      if (ctx.backgroundSlug) {
        await this.backgroundValidator.validateBackgroundLanguages(
          ctx.backgroundSlug,
          input.languageSlugs,
          { extra: classLanguageGrant(ctx.classSlug, ctx.level) },
        );
      }
    }

    if (input.abilityGenerationMethodSlug !== undefined) {
      await this.equipmentValidator.validateAbilityGenerationMethod(
        input.abilityGenerationMethodSlug,
      );
    }
  }

  async validateCreateRequiredFields(
    input: CharacterSheetInput,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    return this.createRequirementsValidator.validateCreateRequiredFields(input, ctx);
  }

  async validateFightingStyleSelections(
    classSlug: string,
    characterFeats: CharacterFeatDto[],
    subclassOptions: CharacterSheetInput['subclassOptions'],
    level = 1,
  ): Promise<void> {
    return this.classOptionsValidator.validateFightingStyleSelections(
      classSlug,
      characterFeats,
      subclassOptions,
      level,
    );
  }

  async validateBackgroundAbilityBoosts(
    backgroundSlug: string,
    boosts: {
      mode?: string | null;
      plus2Slug?: string | null;
      plus1Slug?: string | null;
      plus1Slugs?: string[] | null;
    },
  ): Promise<void> {
    return this.backgroundValidator.validateBackgroundAbilityBoosts(backgroundSlug, boosts);
  }

  async assertClassSkillsDoNotOverlapBackground(
    backgroundSlug: string,
    classSkillSlugs: string[],
  ): Promise<void> {
    return this.backgroundValidator.assertClassSkillsDoNotOverlapBackground(
      backgroundSlug,
      classSkillSlugs,
    );
  }

  async validateBackgroundOriginFeat(
    background: { featSlug: string | null },
    characterFeats: CharacterFeatDto[],
  ): Promise<void> {
    return this.backgroundValidator.validateBackgroundOriginFeat(background, characterFeats);
  }

  async validateBackgroundToolChoice(
    background: {
      backgroundSlug: string;
      toolProficiencyKind: string | null;
      toolItemSlug: string | null;
    },
    toolItemSlug: string | null,
  ): Promise<void> {
    return this.backgroundValidator.validateBackgroundToolChoice(background, toolItemSlug);
  }

  async validateLevelRules(ctx: CharacterSheetContext): Promise<void> {
    return this.classOptionsValidator.validateLevelRules(ctx);
  }

  async validateFeatOptions(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
    characterLevel?: number,
    classSlug?: string,
  ): Promise<void> {
    return this.featsValidator.validateFeatOptions(
      characterFeats,
      options,
      characterLevel,
      classSlug,
    );
  }

  resolveStartingGold(
    equipment: CharacterSheetInput['equipment'],
    ctx: Pick<CharacterSheetContext, 'classSlug' | 'backgroundSlug'>,
  ): Promise<number> {
    return this.equipmentValidator.resolveStartingGold(equipment, ctx);
  }
}
