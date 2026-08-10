import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterSheetInput, CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterFeatDto, CharacterSpellDto } from '@game/sheet/dto/character-sheet.dto';
import {
  FIGHTING_STYLE_FEAT_CATEGORY,
  collectFightingStyleSlugsFromSubclassOptions,
} from './fighting-style-feat-options';
import { CharacterSpeciesChoicesValidator } from './character-species-choices.validator';
import { CharacterSubclassOptionsValidator } from './character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from './character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from './character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from './character-eldritch-invocations.validator';
import { CharacterMetamagicValidator } from './character-metamagic.validator';
import type { ClassProgressionMasteryRow } from './class-weapon-mastery-slots';

/** Facade estável: fighting styles + delegação para validators por concern. */
@Injectable()
export class CharacterClassOptionsValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    private readonly speciesChoicesValidator: CharacterSpeciesChoicesValidator,
    private readonly subclassOptionsValidator: CharacterSubclassOptionsValidator,
    private readonly expertiseValidator: CharacterClassExpertiseValidator,
    private readonly weaponMasteryValidator: CharacterWeaponMasteryValidator,
    private readonly spellMasteryValidator: CharacterSpellMasteryValidator,
    private readonly eldritchInvocationsValidator: CharacterEldritchInvocationsValidator,
    private readonly metamagicValidator: CharacterMetamagicValidator,
  ) {}

  async validateFightingStyleSelections(
    classSlug: string,
    characterFeats: CharacterFeatDto[],
    subclassOptions: CharacterSheetInput['subclassOptions'],
  ): Promise<void> {
    const allowedSlugs = await this.loadClassFightingStyleSlugs(classSlug);
    const allowed = new Set(allowedSlugs);
    const styleSlugs: string[] = [];

    for (const feat of characterFeats) {
      const meta = await this.catalogLookup.assertFeatInCatalog(feat.featSlug);
      if (meta.categorySlug !== FIGHTING_STYLE_FEAT_CATEGORY) continue;
      if (!allowed.has(feat.featSlug)) {
        throw new BadRequestException(
          `Fighting style feat '${feat.featSlug}' is not available for class '${classSlug}'`,
        );
      }
      styleSlugs.push(feat.featSlug);
    }

    for (const slug of collectFightingStyleSlugsFromSubclassOptions(subclassOptions)) {
      const exists = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok FROM rpg.phb_fighting_style WHERE slug = $1 LIMIT 1`,
        [slug],
      );
      if (exists.length === 0) {
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
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT fs.slug
       FROM rpg.phb_class_proficiency cp
       JOIN rpg.phb_class c ON c.id = cp.class_id
       JOIN rpg.phb_fighting_style fs ON fs.id = cp.ref_id
       WHERE c.slug = $1 AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
       ORDER BY fs.slug`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
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

  async validateSubclassOptions(
    subclassSlug: string | null,
    options: CharacterSheetInput['subclassOptions'],
  ): Promise<void> {
    return this.subclassOptionsValidator.validateSubclassOptions(subclassSlug, options);
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
  ): Promise<void> {
    return this.weaponMasteryValidator.validateClassWeaponMasteryOptions(ctx, options);
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
}
