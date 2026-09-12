import { BadRequestException } from '@nestjs/common';
import {
  CharacterSheetInput,
  CharacterSheetContext,
} from '../../character-sheet.types';
import { classLanguageGrant } from '../class-options/class-language-grant';
import { SPECIES_LANGUAGE_CHOICE_COUNT } from '../../origin/species-language';
import type { ValidateSheetInputDeps } from './types';
import { validateClassOptionsInput } from './validate-class-options-input';

export async function validateSheetInput(
  deps: ValidateSheetInputDeps,
  input: CharacterSheetInput,
  ctx: CharacterSheetContext,
): Promise<void> {
  if (input.classSkillSlugs !== undefined) {
    await deps.catalogLookup.validateClassSkillChoices(
      ctx.classSlug,
      input.classSkillSlugs,
    );
    if (ctx.backgroundSlug) {
      await deps.backgroundValidator.assertClassSkillsDoNotOverlapBackground(
        ctx.backgroundSlug,
        input.classSkillSlugs,
      );
    }
  }

  if (input.speciesChoices !== undefined || input.heritageChoices !== undefined) {
    await deps.classOptionsValidator.validateOriginChoices(ctx, input);
  }

  if (input.transformation !== undefined) {
    await deps.transformationValidator.validate(input.transformation);
  }

  if (input.subclassOptions !== undefined) {
    await deps.classOptionsValidator.validateSubclassOptions(
      ctx.subclassSlug,
      input.subclassOptions,
      ctx,
    );
    const feats = input.characterFeats ?? ctx.characterFeats ?? [];
    await deps.classOptionsValidator.validateFightingStyleSelections(
      ctx.classSlug,
      feats,
      input.subclassOptions,
      ctx.level,
    );
  }

  await validateClassOptionsInput(deps, input, ctx);

  const characterFeats = input.characterFeats ?? [];
  if (input.characterFeats !== undefined) {
    await deps.featsValidator.validateCharacterFeats(characterFeats);
  }

  if (input.featOptions !== undefined) {
    const feats = ctx.characterFeats ?? characterFeats;
    if (!feats.length) {
      throw new BadRequestException(
        'characterFeats required when updating featOptions',
      );
    }
    await deps.featsValidator.validateFeatOptions(
      feats,
      input.featOptions,
      ctx.level,
      ctx.classSlug,
    );
  }

  if (input.characterSpells !== undefined) {
    await deps.spellsValidator.validateCharacterSpells(
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
    await deps.equipmentValidator.validateEquipment(input.equipment, ctx);
  }

  if (input.languageSlugs !== undefined) {
    await deps.equipmentValidator.validateLanguageSlugs(input.languageSlugs);
    if (ctx.backgroundSlug) {
      const classExtra = classLanguageGrant(ctx.classSlug, ctx.level);
      const speciesChoice = ctx.speciesSlug
        ? SPECIES_LANGUAGE_CHOICE_COUNT
        : 0;
      await deps.backgroundValidator.validateBackgroundLanguages(
        ctx.backgroundSlug,
        input.languageSlugs,
        {
          extra: {
            grantedSlugs: classExtra.grantedSlugs,
            choiceCount: (classExtra.choiceCount ?? 0) + speciesChoice,
          },
        },
      );
    }
  }

  if (input.abilityGenerationMethodSlug !== undefined) {
    await deps.equipmentValidator.validateAbilityGenerationMethod(
      input.abilityGenerationMethodSlug,
    );
  }
}
