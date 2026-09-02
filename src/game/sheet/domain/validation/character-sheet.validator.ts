import { Injectable } from '@nestjs/common';
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
import { CharacterTransformationValidator } from '../transformation/character-transformation.validator';
import type { ValidateSheetInputDeps } from './character-sheet/types';
import { validateSheetInput as runValidateSheetInput } from './character-sheet/validate-sheet-input';

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
    private readonly transformationValidator: CharacterTransformationValidator,
  ) {}

  private sheetInputDeps(): ValidateSheetInputDeps {
    return {
      catalogLookup: this.catalogLookup,
      backgroundValidator: this.backgroundValidator,
      equipmentValidator: this.equipmentValidator,
      spellsValidator: this.spellsValidator,
      classOptionsValidator: this.classOptionsValidator,
      featsValidator: this.featsValidator,
      extraSkillValidator: this.extraSkillValidator,
      mysticArcanumValidator: this.mysticArcanumValidator,
      signatureSpellsValidator: this.signatureSpellsValidator,
      transformationValidator: this.transformationValidator,
    };
  }

  async validateSheetInput(
    input: CharacterSheetInput,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    return runValidateSheetInput(this.sheetInputDeps(), input, ctx);
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
