import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { ClassProficienciesQuery } from '@catalog/classes/queries/class-proficiencies.query';
import { CharacterSheetInput, CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterFeatDto, CharacterSpellDto } from '@game/sheet/dto/character-sheet.dto';
import { isGeneralFeatFightingStylePick } from '@game/shared/domain/fighting-style-general-feat';
import {
  FIGHTING_STYLE_FEAT_CATEGORY,
  collectFightingStyleSlugsFromSubclassOptions,
} from './fighting-style-feat-options';
import { CharacterSpeciesChoicesValidator } from './character-species-choices.validator';
import { CharacterHeritageChoicesValidator } from './character-heritage-choices.validator';
import { CharacterSubclassOptionsValidator } from './character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from './character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from './character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from './character-eldritch-invocations.validator';
import { CharacterMetamagicValidator } from './character-metamagic.validator';
import { CharacterClassFeatureOptionsValidator } from './character-class-feature-options.validator';
import type { ClassProgressionMasteryRow } from './class-weapon-mastery-slots';
import {
  fightingStyleExists,
  loadClassFightingStyleSlugs,
} from '@game/sheet/infrastructure/queries/feat-option.queries';

/** Facade estável: fighting styles + delegação para validators por concern. */
@Injectable()
export class CharacterClassOptionsValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly proficiencies: ClassProficienciesQuery,
    private readonly catalogLookup: CatalogLookupService,
    private readonly speciesChoicesValidator: CharacterSpeciesChoicesValidator,
    private readonly heritageChoicesValidator: CharacterHeritageChoicesValidator,
    private readonly subclassOptionsValidator: CharacterSubclassOptionsValidator,
    private readonly expertiseValidator: CharacterClassExpertiseValidator,
    private readonly weaponMasteryValidator: CharacterWeaponMasteryValidator,
    private readonly spellMasteryValidator: CharacterSpellMasteryValidator,
    private readonly eldritchInvocationsValidator: CharacterEldritchInvocationsValidator,
    private readonly metamagicValidator: CharacterMetamagicValidator,
    private readonly classFeatureOptionsValidator: CharacterClassFeatureOptionsValidator,
  ) {}

  async validateFightingStyleSelections(
    classSlug: string,
    characterFeats: CharacterFeatDto[],
    subclassOptions: CharacterSheetInput['subclassOptions'],
    level = 1,
  ): Promise<void> {
    const allowedSlugs = await loadClassFightingStyleSlugs(
      this.proficiencies,
      classSlug,
    );
    const allowed = new Set(allowedSlugs);
    const styleSlugs: string[] = [];

    for (const feat of characterFeats) {
      const meta = await this.catalogLookup.assertFeatInCatalog(feat.featSlug);
      if (meta.categorySlug !== FIGHTING_STYLE_FEAT_CATEGORY) continue;
      if (isGeneralFeatFightingStylePick(feat.featSlug, level)) {
        styleSlugs.push(feat.featSlug);
        continue;
      }
      if (!allowed.has(feat.featSlug)) {
        throw new BadRequestException(
          `Fighting style feat '${feat.featSlug}' is not available for class '${classSlug}'`,
        );
      }
      styleSlugs.push(feat.featSlug);
    }

    for (const slug of collectFightingStyleSlugsFromSubclassOptions(subclassOptions)) {
      if (!(await fightingStyleExists(this.dataSource, slug))) {
        throw new BadRequestException(`Unknown fighting style '${slug}'`);
      }
      if (!allowed.has(slug)) {
        throw new BadRequestException(
          `Fighting style '${slug}' is not available for class '${classSlug}'`,
        );
      }
      styleSlugs.push(slug);
    }

    if (styleSlugs.length > 0) {
      assertUnique(styleSlugs, 'Each fighting style can only be chosen once');
    }
  }

  async loadClassFightingStyleSlugs(classSlug: string): Promise<string[]> {
    return loadClassFightingStyleSlugs(this.proficiencies, classSlug);
  }

  async validateLevelRules(ctx: CharacterSheetContext): Promise<void> {
    return this.subclassOptionsValidator.validateLevelRules(ctx);
  }

  async resolveSubclassUnlockLevel(classSlug: string): Promise<number> {
    return this.subclassOptionsValidator.resolveSubclassUnlockLevel(classSlug);
  }

  async loadSubclassOptionKeysAtLevel(
    subclassSlug: string,
    level: number,
  ): Promise<string[]> {
    return this.subclassOptionsValidator.loadSubclassOptionKeysAtLevel(subclassSlug, level);
  }

  async validateSpeciesChoices(
    speciesSlug: string,
    choices: CharacterSheetInput['speciesChoices'],
  ): Promise<void> {
    return this.speciesChoicesValidator.validateSpeciesChoices(speciesSlug, choices);
  }

  async validateHeritageChoices(
    heritageSlug: string,
    choices: CharacterSheetInput['heritageChoices'],
  ): Promise<void> {
    return this.heritageChoicesValidator.validateHeritageChoices(heritageSlug, choices);
  }

  async validateOriginChoices(
    ctx: Pick<CharacterSheetContext, 'speciesSlug' | 'heritageSlug'>,
    input: Pick<CharacterSheetInput, 'speciesChoices' | 'heritageChoices'>,
  ): Promise<void> {
    if (ctx.heritageSlug?.trim()) {
      await this.validateHeritageChoices(ctx.heritageSlug, input.heritageChoices);
      return;
    }
    if (!ctx.speciesSlug?.trim()) return;
    await this.validateSpeciesChoices(ctx.speciesSlug, input.speciesChoices);
  }

  async validateSubclassOptions(
    subclassSlug: string | null,
    options: CharacterSheetInput['subclassOptions'],
    ctx?: Pick<CharacterSheetContext, 'classSlug' | 'level'>,
  ): Promise<void> {
    return this.subclassOptionsValidator.validateSubclassOptions(
      subclassSlug,
      options,
      ctx,
    );
  }

  async validateClassExpertiseOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    classSkillSlugs: CharacterSheetInput['classSkillSlugs'],
    speciesChoices: CharacterSheetInput['speciesChoices'],
    featOptions: CharacterSheetInput['featOptions'],
  ): Promise<void> {
    return this.expertiseValidator.validateClassExpertiseOptions(
      ctx,
      options,
      classSkillSlugs,
      speciesChoices,
      featOptions,
    );
  }

  async validateClassWeaponMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    sheet?: Pick<CharacterSheetInput, 'characterFeats' | 'subclassOptions'>,
  ): Promise<void> {
    return this.weaponMasteryValidator.validateClassWeaponMasteryOptions(
      ctx,
      options,
      sheet,
    );
  }

  async validateSpellMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells: CharacterSheetInput['characterSpells'],
  ): Promise<void> {
    return this.spellMasteryValidator.validateSpellMasteryOptions(
      ctx,
      options,
      characterSpells,
    );
  }

  async validateEldritchInvocationOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells?: CharacterSpellDto[],
    characterFeats?: CharacterFeatDto[],
  ): Promise<void> {
    return this.eldritchInvocationsValidator.validateEldritchInvocationOptions(
      ctx,
      options,
      characterSpells,
      characterFeats,
    );
  }

  async validateMetamagicOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    return this.metamagicValidator.validateMetamagicOptions(ctx, options);
  }

  async loadWeaponMasteryProgression(
    classSlug: string,
  ): Promise<ClassProgressionMasteryRow[]> {
    return this.weaponMasteryValidator.loadWeaponMasteryProgression(classSlug);
  }

  async loadClassFeatureOptionKeysAtLevel(
    classSlug: string,
    level: number,
  ): Promise<string[]> {
    return this.classFeatureOptionsValidator.loadOptionKeysAtLevel(classSlug, level);
  }

  async validateClassFeatureOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    return this.classFeatureOptionsValidator.validate(ctx, options);
  }
}
