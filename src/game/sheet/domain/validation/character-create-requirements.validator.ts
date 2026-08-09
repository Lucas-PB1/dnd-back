import { BadRequestException, Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterSheetInput } from '../character-sheet.types';
import { classExpertiseSlotsAtLevel } from './class-options/class-expertise-slots';
import { classWeaponMasterySlotsAtLevel } from './class-options/class-weapon-mastery-slots';
import { CharacterBackgroundValidator } from './background/character-background.validator';
import { CharacterClassOptionsValidator } from './class-options/character-class-options.validator';
import { FIGHTING_STYLE_FEAT_CATEGORY } from './class-options/fighting-style-feat-options';
import { CharacterFeatsValidator } from './feats/character-feats.validator';
import { CharacterSheetContext } from '../character-sheet.types';
import type { CharacterFeatDto } from '@game/sheet/dto/character-sheet.dto';

/**
 * Valida escolhas obrigatórias no POST /characters quando o catálogo exige.
 */
@Injectable()
export class CharacterCreateRequirementsValidator {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly backgroundValidator: CharacterBackgroundValidator,
    private readonly classOptionsValidator: CharacterClassOptionsValidator,
    private readonly featsValidator: CharacterFeatsValidator,
  ) {}

  async validateCreateRequiredFields(
    input: CharacterSheetInput,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    const phbClass = await this.catalogLookup.findClassOrFail(ctx.classSlug);
    const requiredSkills = phbClass.skillChoiceCount ?? 0;

    if (requiredSkills > 0) {
      const slugs = input.classSkillSlugs ?? [];
      if (slugs.length !== requiredSkills) {
        throw new BadRequestException(
          `Class '${ctx.classSlug}' requires exactly ${requiredSkills} skill choice(s)`,
        );
      }
      await this.catalogLookup.validateClassSkillChoices(ctx.classSlug, slugs);
      await this.backgroundValidator.assertClassSkillsDoNotOverlapBackground(
        ctx.backgroundSlug,
        slugs,
      );
    }

    await this.classOptionsValidator.validateSpeciesChoices(
      ctx.speciesSlug,
      input.speciesChoices,
    );

    const unlockLevel = await this.classOptionsValidator.resolveSubclassUnlockLevel(
      ctx.classSlug,
    );
    if (ctx.subclassSlug && ctx.level >= unlockLevel) {
      const requiredOptionKeys =
        await this.classOptionsValidator.loadSubclassOptionKeysAtLevel(
          ctx.subclassSlug,
          ctx.level,
        );
      if (requiredOptionKeys.length > 0) {
        const provided = input.subclassOptions ?? [];
        const providedKeys = new Set(provided.map((option) => option.optionKey));
        const missing = requiredOptionKeys.filter((key) => !providedKeys.has(key));
        if (missing.length > 0) {
          throw new BadRequestException(
            `Subclass '${ctx.subclassSlug}' requires options: ${missing.join(', ')}`,
          );
        }
        await this.classOptionsValidator.validateSubclassOptions(
          ctx.subclassSlug,
          provided,
        );
      }
    }

    const createFeats = input.characterFeats ?? [];
    if (createFeats.length > 0) {
      await this.featsValidator.validateFeatOptions(
        createFeats,
        input.featOptions ?? [],
        ctx.level,
        ctx.classSlug,
      );
    }

    await this.classOptionsValidator.validateFightingStyleSelections(
      ctx.classSlug,
      createFeats,
      input.subclassOptions,
    );

    if (ctx.classSlug === 'fighter') {
      const hasFightingStyleFeat = await this.hasFightingStyleFeat(createFeats);
      if (!hasFightingStyleFeat) {
        throw new BadRequestException(
          `Class '${ctx.classSlug}' requires a Fighting Style feat at level 1`,
        );
      }
    }

    await this.backgroundValidator.validateBackgroundLanguages(
      ctx.backgroundSlug,
      input.languageSlugs,
      { required: true },
    );

    const expertiseSlots = classExpertiseSlotsAtLevel(ctx.classSlug, ctx.level);
    if (expertiseSlots.length > 0) {
      const provided = input.classOptions ?? [];
      const providedKeys = new Set(provided.map((option) => option.optionKey));
      const missing = expertiseSlots
        .map((slot) => slot.optionKey)
        .filter((key) => !providedKeys.has(key));
      if (missing.length > 0) {
        throw new BadRequestException(
          `Class '${ctx.classSlug}' requires expertise options: ${missing.join(', ')}`,
        );
      }
      await this.classOptionsValidator.validateClassExpertiseOptions(
        ctx,
        provided,
        input.classSkillSlugs,
        input.speciesChoices,
        input.featOptions,
      );
    }

    const masterySlots = classWeaponMasterySlotsAtLevel(
      await this.classOptionsValidator.loadWeaponMasteryProgression(ctx.classSlug),
      ctx.level,
    );
    if (masterySlots.length > 0) {
      const provided = input.classOptions ?? [];
      const providedKeys = new Set(provided.map((option) => option.optionKey));
      const missing = masterySlots
        .map((slot) => slot.optionKey)
        .filter((key) => !providedKeys.has(key));
      if (missing.length > 0) {
        throw new BadRequestException(
          `Class '${ctx.classSlug}' requires weapon mastery options: ${missing.join(', ')}`,
        );
      }
      await this.classOptionsValidator.validateClassWeaponMasteryOptions(ctx, provided);
    }
  }

  private async hasFightingStyleFeat(
    feats: CharacterFeatDto[],
  ): Promise<boolean> {
    for (const feat of feats) {
      const meta = await this.catalogLookup.assertFeatInCatalog(feat.featSlug);
      if (meta.categorySlug === FIGHTING_STYLE_FEAT_CATEGORY) return true;
    }
    return false;
  }
}
