import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { ClassProficienciesQuery } from '@catalog/game-port';
import {
  CharacterSheetInput,
  CharacterSheetContext,
} from '@game/sheet/domain/character-sheet.types';
import {
  CharacterFeatDto,
  CharacterSpellDto,
} from '@game/sheet/dto/character-sheet.dto';
import { CharacterSpeciesChoicesValidator } from '../character-species-choices.validator';
import { CharacterHeritageChoicesValidator } from '../character-heritage-choices.validator';
import { CharacterSubclassOptionsValidator } from '../character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from '../character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from '../character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from '../character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from '../character-eldritch-invocations.validator';
import { CharacterMetamagicValidator } from '../character-metamagic.validator';
import { CharacterClassFeatureOptionsValidator } from '../character-class-feature-options.validator';
import type { ClassProgressionMasteryRow } from '../class-weapon-mastery-slots';
import { loadClassFightingStyleSlugs } from '@game/sheet/infrastructure/queries/feat-option.queries';
import { resolveFightingStyleUnlockLevel } from '@game/sheet/infrastructure/queries/class-meta.queries';
import { validateFightingStyleSelections } from './validate-fighting-styles';
import {
  validateHeritageChoices,
  validateOriginChoices,
  validateSpeciesChoices,
} from './validate-origin-choices';

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

  private get originDeps() {
    return {
      speciesChoicesValidator: this.speciesChoicesValidator,
      heritageChoicesValidator: this.heritageChoicesValidator,
    };
  }
  async validateFightingStyleSelections(
    classSlug: string,
    characterFeats: CharacterFeatDto[],
    subclassOptions: CharacterSheetInput['subclassOptions'],
    level = 1,
  ): Promise<void> {
    return validateFightingStyleSelections(
      {
        dataSource: this.dataSource,
        proficiencies: this.proficiencies,
        catalogLookup: this.catalogLookup,
      },
      classSlug,
      characterFeats,
      subclassOptions,
      level,
    );
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

  async resolveFightingStyleUnlockLevel(
    classSlug: string,
  ): Promise<number | null> {
    return resolveFightingStyleUnlockLevel(this.dataSource, classSlug);
  }

  async loadSubclassOptionKeysAtLevel(
    subclassSlug: string,
    level: number,
  ): Promise<string[]> {
    return this.subclassOptionsValidator.loadSubclassOptionKeysAtLevel(
      subclassSlug,
      level,
    );
  }

  async validateSpeciesChoices(
    speciesSlug: string,
    choices: CharacterSheetInput['speciesChoices'],
  ): Promise<void> {
    return validateSpeciesChoices(this.originDeps, speciesSlug, choices);
  }

  async validateHeritageChoices(
    heritageSlug: string,
    choices: CharacterSheetInput['heritageChoices'],
  ): Promise<void> {
    return validateHeritageChoices(this.originDeps, heritageSlug, choices);
  }

  async validateOriginChoices(
    ctx: Pick<CharacterSheetContext, 'speciesSlug' | 'heritageSlug'>,
    input: Pick<CharacterSheetInput, 'speciesChoices' | 'heritageChoices'>,
  ): Promise<void> {
    return validateOriginChoices(this.originDeps, ctx, input);
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
      ctx, options, classSkillSlugs, speciesChoices, featOptions,
    );
  }

  async validateClassWeaponMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    sheet?: Pick<CharacterSheetInput, 'characterFeats' | 'subclassOptions'>,
  ): Promise<void> {
    return this.weaponMasteryValidator.validateClassWeaponMasteryOptions(
      ctx, options, sheet,
    );
  }

  async validateSpellMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells: CharacterSheetInput['characterSpells'],
  ): Promise<void> {
    return this.spellMasteryValidator.validateSpellMasteryOptions(
      ctx, options, characterSpells,
    );
  }

  async validateEldritchInvocationOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells?: CharacterSpellDto[],
    characterFeats?: CharacterFeatDto[],
  ): Promise<void> {
    return this.eldritchInvocationsValidator.validateEldritchInvocationOptions(
      ctx, options, characterSpells, characterFeats,
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
    return this.classFeatureOptionsValidator.loadOptionKeysAtLevel(
      classSlug, level,
    );
  }

  async validateClassFeatureOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    return this.classFeatureOptionsValidator.validate(ctx, options);
  }
}
