import { BadRequestException, Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterSheetInput } from '../character-sheet.types';
import { assertCreateProgressionPicks } from './class-options/assert-create-progression-picks';
import { classLanguageGrant } from './class-options/class-language-grant';
import { CharacterBackgroundValidator } from './background/character-background.validator';
import { CharacterClassOptionsValidator } from './class-options/character-class-options.validator';
import { CharacterClassExtraSkillValidator } from './class-options/character-class-extra-skill.validator';
import { CharacterMysticArcanumValidator } from './class-options/character-mystic-arcanum.validator';
import { CharacterSignatureSpellsValidator } from './class-options/character-signature-spells.validator';
import { classHasFightingStylePick } from './class-options/fighting-style-unlock';
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
    private readonly extraSkillValidator: CharacterClassExtraSkillValidator,
    private readonly mysticArcanumValidator: CharacterMysticArcanumValidator,
    private readonly signatureSpellsValidator: CharacterSignatureSpellsValidator,
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

    await this.classOptionsValidator.validateOriginChoices(ctx, input);

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
          ctx,
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
      ctx.level,
    );

    const classFeatureKeys =
      await this.classOptionsValidator.loadClassFeatureOptionKeysAtLevel(
        ctx.classSlug,
        ctx.level,
      );
    if (classFeatureKeys.length > 0) {
      const provided = input.classOptions ?? [];
      const providedKeys = new Set(provided.map((option) => option.optionKey));
      const missing = classFeatureKeys.filter((key) => !providedKeys.has(key));
      if (missing.length > 0) {
        throw new BadRequestException(
          `Classe '${ctx.classSlug}' exige as opções: ${missing.join(', ')}.`,
        );
      }
      await this.classOptionsValidator.validateClassFeatureOptions(ctx, provided);
    }

    if (classHasFightingStylePick(ctx.classSlug, ctx.level)) {
      const hasFightingStyleFeat = await this.hasFightingStyleFeat(createFeats);
      if (!hasFightingStyleFeat) {
        throw new BadRequestException(
          `Classe '${ctx.classSlug}' exige um talento de Estilo de Luta.`,
        );
      }
    }

    await this.backgroundValidator.validateBackgroundLanguages(
      ctx.backgroundSlug,
      input.languageSlugs,
      {
        required: true,
        extra: classLanguageGrant(ctx.classSlug, ctx.level),
      },
    );

    await assertCreateProgressionPicks({
      ctx,
      sheet: input,
      classOptionsValidator: this.classOptionsValidator,
      extraSkillValidator: this.extraSkillValidator,
      mysticArcanumValidator: this.mysticArcanumValidator,
      signatureSpellsValidator: this.signatureSpellsValidator,
    });
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
