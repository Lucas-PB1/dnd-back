import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '../../../common/assert';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VPhbSpeciesTraitChoices } from '../../../entities/views/v-phb-species-trait-choices.entity';
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../../entities/phb-subclass-option-value.entity';
import { VPhbClassEquipment } from '../../../entities/views/v-phb-class-equipment.entity';
import { VPhbBackgroundEquipment } from '../../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundToolOption } from '../../../entities/views/v-phb-background-tool-option.entity';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../../entities/phb-feat-option.entity';
import { PhbCharacterLevel } from '../../../entities/phb-character-level.entity';
import { CharacterSheetInput } from './character-sheet.types';
import { FeatOptionDto, CharacterFeatDto } from '../dto/character-sheet.dto';
import {
  applyBackgroundAbilityBoosts,
  assertBackgroundBoostSlugsAllowed,
} from './background-ability-boost';
import { featInstanceKey } from './character-feat';
import {
  requiredFeatOptionDefsForInstance,
  ritualSpellSlotIndex,
  RITUAL_CASTER_FEAT_SLUG,
} from './ritual-caster-feat-options';
import { isFeatCastingLinkedToAsi } from './linked-casting-feat-options';
import {
  ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
  ASI_DISTRIBUTION_PLUS1PLUS1,
  ASI_DISTRIBUTION_PLUS2,
  requiredAbilityScoreImprovementDefs,
} from './ability-score-improvement-feat-options';
import { RESILIENT_FEAT_SLUG } from './resilient-feat-options';
import {
  FIGHTING_STYLE_FEAT_CATEGORY,
  collectFightingStyleSlugsFromSubclassOptions,
  isFightingStyleSubclassOptionKey,
} from './fighting-style-feat-options';

export interface CharacterSheetContext {
  level: number;
  classSlug: string;
  speciesSlug: string;
  backgroundSlug: string;
  subclassSlug: string | null;
  characterFeats?: CharacterFeatDto[];
}

@Injectable()
export class CharacterSheetValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(VPhbSpeciesTraitChoices)
    private readonly speciesTraitChoicesRepo: Repository<VPhbSpeciesTraitChoices>,
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRefRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbSubclassOptionValue)
    private readonly subclassOptionValuesRepo: Repository<PhbSubclassOptionValue>,
    @InjectRepository(VPhbClassEquipment)
    private readonly classEquipmentRepo: Repository<VPhbClassEquipment>,
    @InjectRepository(VPhbBackgroundEquipment)
    private readonly backgroundEquipmentRepo: Repository<VPhbBackgroundEquipment>,
    @InjectRepository(VPhbBackgroundToolOption)
    private readonly backgroundToolOptionsRepo: Repository<VPhbBackgroundToolOption>,
    @InjectRepository(PhbFeatRef)
    private readonly featRefRepo: Repository<PhbFeatRef>,
    @InjectRepository(PhbFeatOptionDef)
    private readonly featOptionDefRepo: Repository<PhbFeatOptionDef>,
    @InjectRepository(PhbFeatOptionValue)
    private readonly featOptionValueRepo: Repository<PhbFeatOptionValue>,
    @InjectRepository(PhbCharacterLevel)
    private readonly characterLevelsRepo: Repository<PhbCharacterLevel>,
  ) {}

  async validateSheetInput(
    input: CharacterSheetInput,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    if (input.classSkillSlugs !== undefined) {
      await this.catalogLookup.validateClassSkillChoices(ctx.classSlug, input.classSkillSlugs);
    }

    if (input.speciesChoices !== undefined) {
      await this.validateSpeciesChoices(ctx.speciesSlug, input.speciesChoices);
    }

    if (input.subclassOptions !== undefined) {
      await this.validateSubclassOptions(ctx.subclassSlug, input.subclassOptions);
      const feats = input.characterFeats ?? ctx.characterFeats ?? [];
      await this.validateFightingStyleSelections(
        ctx.classSlug,
        feats,
        input.subclassOptions,
      );
    }

    const characterFeats = input.characterFeats ?? [];
    if (input.characterFeats !== undefined) {
      await this.validateCharacterFeats(characterFeats);
    }

    if (input.featOptions !== undefined) {
      const feats = ctx.characterFeats ?? characterFeats;
      if (!feats.length) {
        throw new BadRequestException('characterFeats required when updating featOptions');
      }
      await this.validateFeatOptions(feats, input.featOptions, ctx.level, ctx.classSlug);
    }

    if (input.characterSpells !== undefined) {
      await this.validateCharacterSpells(input.characterSpells, ctx);
    }

    if (input.equipment !== undefined) {
      await this.validateEquipment(input.equipment, ctx);
    }

    if (input.languageSlugs !== undefined) {
      await this.validateLanguageSlugs(input.languageSlugs);
    }

    if (input.abilityGenerationMethodSlug !== undefined) {
      await this.validateAbilityGenerationMethod(input.abilityGenerationMethodSlug);
    }
  }

  /** Exige escolhas obrigatórias no POST /characters quando o catálogo exige. */
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
    }

    const traitRows = await this.speciesTraitChoicesRepo.find({
      where: { speciesSlug: ctx.speciesSlug },
    });
    if (traitRows.length > 0) {
      if (!input.speciesChoices?.length) {
        throw new BadRequestException(
          `Species '${ctx.speciesSlug}' requires trait choices`,
        );
      }
      await this.validateSpeciesChoices(ctx.speciesSlug, input.speciesChoices);
    }

    const unlockLevel = await this.resolveSubclassUnlockLevel(ctx.classSlug);
    if (ctx.subclassSlug && ctx.level >= unlockLevel) {
      const requiredOptionKeys = await this.loadSubclassOptionKeysAtLevel(
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
        await this.validateSubclassOptions(ctx.subclassSlug, provided);
      }
    }

    const createFeats = input.characterFeats ?? [];
    if (createFeats.length > 0) {
      await this.validateFeatOptions(
        createFeats,
        input.featOptions ?? [],
        ctx.level,
        ctx.classSlug,
      );
    }

    await this.validateFightingStyleSelections(
      ctx.classSlug,
      createFeats,
      input.subclassOptions,
    );
  }

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

  async validateBackgroundAbilityBoosts(
    backgroundSlug: string,
    boosts: { plus2Slug?: string; plus1Slug?: string },
  ): Promise<void> {
    const background = await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const allowed = background.abilityOptionSlugs ?? [];
    if (allowed.length === 0) return;

    assertBackgroundBoostSlugsAllowed(allowed, {
      plus2Slug: boosts.plus2Slug ?? '',
      plus1Slug: boosts.plus1Slug ?? '',
    });
  }

  async validateBackgroundOriginFeat(
    background: { featSlug: string | null },
    characterFeats: CharacterFeatDto[],
  ): Promise<void> {
    const origin = background.featSlug?.trim();
    if (!origin) return;
    if (!characterFeats.some((feat) => feat.featSlug === origin)) {
      throw new BadRequestException(
        `Background origin feat '${origin}' must be included in characterFeats`,
      );
    }
  }

  async validateBackgroundToolChoice(
    background: {
      backgroundSlug: string;
      toolProficiencyKind: string | null;
      toolItemSlug: string | null;
    },
    toolItemSlug: string | null,
  ): Promise<void> {
    if (background.toolProficiencyKind === 'choice') {
      if (!toolItemSlug) {
        throw new BadRequestException(
          `Background '${background.backgroundSlug}' requires a tool proficiency choice`,
        );
      }
      const allowed = await this.backgroundToolOptionsRepo.find({
        where: { backgroundSlug: background.backgroundSlug, itemSlug: toolItemSlug },
      });
      if (allowed.length === 0) {
        throw new BadRequestException(
          `Tool '${toolItemSlug}' is not a valid choice for background '${background.backgroundSlug}'`,
        );
      }
      return;
    }

    if (background.toolProficiencyKind === 'fixed') {
      const expected = background.toolItemSlug;
      if (expected && toolItemSlug && toolItemSlug !== expected) {
        throw new BadRequestException(
          `Background '${background.backgroundSlug}' grants fixed tool '${expected}'`,
        );
      }
    }
  }

  async validateLevelRules(ctx: CharacterSheetContext): Promise<void> {
    const phbClass = await this.catalogLookup.findClassOrFail(ctx.classSlug);
    const unlockLevel = await this.resolveSubclassUnlockLevel(ctx.classSlug);

    if (ctx.level >= unlockLevel && !ctx.subclassSlug) {
      throw new BadRequestException(
        `Subclass is required at level ${ctx.level} for class '${ctx.classSlug}'`,
      );
    }

    if (ctx.subclassSlug && ctx.level < unlockLevel) {
      throw new BadRequestException(
        `Subclass '${ctx.subclassSlug}' unlocks at level ${unlockLevel} for class '${ctx.classSlug}'`,
      );
    }

    void phbClass;
  }

  private async resolveSubclassUnlockLevel(classSlug: string): Promise<number> {
    const rows = await this.dataSource.query<{ subclass_unlock_level: number }[]>(
      `SELECT subclass_unlock_level FROM rpg.phb_class WHERE slug = $1`,
      [classSlug],
    );
    return rows[0]?.subclass_unlock_level ?? 3;
  }

  private async loadSubclassOptionKeysAtLevel(
    subclassSlug: string,
    level: number,
  ): Promise<string[]> {
    const subclass = await this.subclassRefRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) return [];

    const rows = await this.dataSource.query<{ optionKey: string }[]>(
      `SELECT DISTINCT def.option_key AS "optionKey"
       FROM rpg.phb_subclass_option_def def
       WHERE def.subclass_id = $1
         AND def.unlock_level <= $2
       ORDER BY def.option_key ASC`,
      [subclass.id, level],
    );
    return rows.map((row) => row.optionKey);
  }

  private async validateSpeciesChoices(
    speciesSlug: string,
    choices: CharacterSheetInput['speciesChoices'],
  ): Promise<void> {
    if (!choices) return;

    const rows = await this.speciesTraitChoicesRepo.find({ where: { speciesSlug } });
    if (rows.length === 0 && choices.length > 0) {
      throw new BadRequestException(`Species '${speciesSlug}' has no trait choices`);
    }

    const requiredKinds = [...new Set(rows.map((row) => row.choiceKind))];
    const providedKinds = choices.map((choice) => choice.choiceKind);

    assertUnique(providedKinds, 'Duplicate species choice kinds are not allowed');

    for (const kind of requiredKinds) {
      if (!providedKinds.includes(kind)) {
        throw new BadRequestException(`Missing species choice for kind '${kind}'`);
      }
    }

    for (const choice of choices) {
      const valid = rows.some(
        (row) => row.choiceKind === choice.choiceKind && row.choiceSlug === choice.choiceSlug,
      );
      if (!valid) {
        throw new BadRequestException(
          `Species choice '${choice.choiceKind}/${choice.choiceSlug}' is invalid for '${speciesSlug}'`,
        );
      }
    }

    for (const kind of providedKinds) {
      if (!requiredKinds.includes(kind)) {
        throw new BadRequestException(`Species choice kind '${kind}' is not valid for '${speciesSlug}'`);
      }
    }
  }

  private async validateSubclassOptions(
    subclassSlug: string | null,
    options: CharacterSheetInput['subclassOptions'],
  ): Promise<void> {
    if (!options) return;

    if (!subclassSlug) {
      throw new BadRequestException('Subclass must be set before choosing subclass options');
    }

    assertUnique(
      options.map((o) => o.optionKey),
      'Duplicate subclass option keys are not allowed',
    );

    const subclass = await this.subclassRefRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) {
      throw new BadRequestException(`Subclass '${subclassSlug}' not found in catalog`);
    }

    for (const option of options) {
      const valid = await this.subclassOptionValuesRepo.findOne({
        where: {
          subclassId: subclass.id,
          optionKey: option.optionKey,
          valueId: option.valueId,
        },
      });
      if (!valid) {
        throw new BadRequestException(
          `Subclass option '${option.optionKey}/${option.valueId}' is invalid for '${subclassSlug}'`,
        );
      }

      if (isFightingStyleSubclassOptionKey(option.optionKey)) {
        const exists = await this.dataSource.query<{ ok: number }[]>(
          `SELECT 1 AS ok FROM rpg.phb_fighting_style WHERE slug = $1 LIMIT 1`,
          [option.valueId],
        );
        if (exists.length === 0) {
          throw new BadRequestException(
            `Subclass option '${option.optionKey}/${option.valueId}' is not a valid fighting style`,
          );
        }
      }
    }
  }

  private async validateCharacterFeats(feats: CharacterFeatDto[]): Promise<void> {
    const keys = feats.map((feat) => featInstanceKey(feat.featSlug, feat.instanceIndex));
    assertUnique(keys, 'Duplicate feat instances are not allowed');

    const bySlug = new Map<string, CharacterFeatDto[]>();
    for (const feat of feats) {
      const list = bySlug.get(feat.featSlug) ?? [];
      list.push(feat);
      bySlug.set(feat.featSlug, list);
    }

    for (const [slug, instances] of bySlug) {
      const feat = await this.catalogLookup.assertFeatInCatalog(slug);

      if (!feat.repeatable && instances.length > 1) {
        throw new BadRequestException(`Feat '${slug}' is not repeatable`);
      }

      const indices = [...instances.map((item) => item.instanceIndex)].sort((a, b) => a - b);
      for (let i = 0; i < indices.length; i += 1) {
        if (indices[i] !== i) {
          throw new BadRequestException(
            `Feat '${slug}' instance indices must be contiguous starting at 0`,
          );
        }
      }
    }
  }

  private async validateCharacterSpells(
    spells: NonNullable<CharacterSheetInput['characterSpells']>,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    const keys = spells.map((s) => `${s.spellSlug}:${s.listType}`);
    assertUnique(keys, 'Duplicate character spell entries are not allowed');

    for (const spell of spells) {
      const inClass = await this.classSpellsRepo.findOne({
        where: {
          classSlug: ctx.classSlug,
          spellSlug: spell.spellSlug,
        },
      });

      const inSubclass =
        ctx.subclassSlug &&
        (await this.subclassSpellsRepo.findOne({
          where: {
            subclassSlug: ctx.subclassSlug,
            spellSlug: spell.spellSlug,
          },
        }));

      if (!inClass && !inSubclass) {
        throw new BadRequestException(
          `Spell '${spell.spellSlug}' is not available for this character's class/subclass`,
        );
      }
    }
  }

  private async validateEquipment(
    items: NonNullable<CharacterSheetInput['equipment']>,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    for (const item of items) {
      if (
        item.source === 'background' &&
        item.packageSlug === 'gold'
      ) {
        const background = await this.catalogLookup.findBackgroundOrFail(
          ctx.backgroundSlug,
        );
        if (
          background.equipmentGoldOption == null ||
          background.equipmentGoldOption <= 0
        ) {
          throw new BadRequestException(
            `Background '${ctx.backgroundSlug}' does not offer a gold equipment option`,
          );
        }
        if (item.itemSlug) {
          throw new BadRequestException(
            'Gold background equipment option cannot include item rows',
          );
        }
        continue;
      }

      if (item.source === 'class') {
        await this.assertEquipmentPackage(
          await this.classEquipmentRepo.find({
            where: { classSlug: ctx.classSlug, packageSlug: item.packageSlug },
          }),
          item.packageSlug,
          item.itemSlug,
          'class',
          ctx.classSlug,
        );
      } else {
        await this.assertEquipmentPackage(
          await this.backgroundEquipmentRepo.find({
            where: { backgroundSlug: ctx.backgroundSlug, packageSlug: item.packageSlug },
          }),
          item.packageSlug,
          item.itemSlug,
          'background',
          ctx.backgroundSlug,
        );
      }
    }
  }

  private assertEquipmentPackage(
    rows: { itemSlug: string | null }[],
    packageSlug: string,
    itemSlug: string | undefined,
    source: 'class' | 'background',
    ownerSlug: string,
  ): void {
    if (rows.length === 0) {
      throw new BadRequestException(
        `${source === 'class' ? 'Class' : 'Background'} equipment package '${packageSlug}' not found for '${ownerSlug}'`,
      );
    }
    if (itemSlug && !rows.some((row) => row.itemSlug === itemSlug)) {
      throw new BadRequestException(
        `Item '${itemSlug}' is not in ${source} package '${packageSlug}'`,
      );
    }
  }

  private async validateLanguageSlugs(languageSlugs: string[]): Promise<void> {
    assertUnique(languageSlugs, 'Duplicate language slugs are not allowed');
    for (const slug of languageSlugs) {
      await this.catalogLookup.assertLanguageSlug(slug);
    }
  }

  private async validateAbilityGenerationMethod(slug: string): Promise<void> {
    await this.catalogLookup.assertAbilityGenerationMethodSlug(slug);
  }

  async validateFeatOptions(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
    characterLevel = 1,
    classSlug?: string,
  ): Promise<void> {
    const proficiencyBonus = await this.resolveProficiencyBonus(characterLevel);
    const classSavingThrowSlugs = classSlug
      ? await this.loadClassSavingThrowSlugs(classSlug)
      : [];
    const classFightingStyleSlugs = classSlug
      ? await this.loadClassFightingStyleSlugs(classSlug)
      : [];
    const keys = options.map((o) =>
      `${o.featSlug}:${o.instanceIndex ?? 0}:${o.optionKey}`,
    );
    assertUnique(keys, 'Duplicate feat option keys are not allowed');

    for (const option of options) {
      const match = characterFeats.find(
        (feat) =>
          feat.featSlug === option.featSlug &&
          feat.instanceIndex === (option.instanceIndex ?? 0),
      );
      if (!match) {
        throw new BadRequestException(
          `Feat option for '${option.featSlug}' instance ${option.instanceIndex ?? 0} but feat is not selected`,
        );
      }
    }

    for (const feat of characterFeats) {
      const defs = await this.loadFeatOptionDefs(feat.featSlug);
      if (defs.length === 0) continue;

      const featOptions = options.filter(
        (o) =>
          o.featSlug === feat.featSlug &&
          (o.instanceIndex ?? 0) === feat.instanceIndex,
      );
      const providedKeys = new Set(featOptions.map((o) => o.optionKey));
      const requiredDefs = requiredAbilityScoreImprovementDefs(
        feat.featSlug,
        requiredFeatOptionDefsForInstance(
          feat.featSlug,
          defs,
          proficiencyBonus,
        ),
        featOptions,
      );
      const missing = requiredDefs.filter((def) => !providedKeys.has(def.optionKey));
      if (missing.length > 0) {
        throw new BadRequestException(
          `Feat '${feat.featSlug}' instance ${feat.instanceIndex} requires options: ${missing.map((d) => d.optionKey).join(', ')}`,
        );
      }

      for (const option of featOptions) {
        const def = defs.find((d) => d.optionKey === option.optionKey);
        if (!def) {
          if (
            feat.featSlug === RITUAL_CASTER_FEAT_SLUG &&
            ritualSpellSlotIndex(option.optionKey) !== null
          ) {
            const slot = ritualSpellSlotIndex(option.optionKey)!;
            if (slot > proficiencyBonus) {
              throw new BadRequestException(
                `Feat 'ritual-caster' allows ${proficiencyBonus} ritual spell choice(s) at level ${characterLevel}`,
              );
            }
          }
          throw new BadRequestException(
            `Unknown feat option '${option.optionKey}' for '${feat.featSlug}'`,
          );
        }
        await this.validateFeatOptionValue(
          def,
          option,
          featOptions,
          feat.featSlug,
          classSavingThrowSlugs,
          classFightingStyleSlugs,
        );
      }
    }

    this.validateMagicInitiateSpellLists(characterFeats, options);
    this.validateRitualCasterSpells(characterFeats, options, proficiencyBonus);
    this.validateLinkedCastingAbilityMatchesAsi(characterFeats, options);
    this.validateAbilityScoreImprovement(characterFeats, options);
  }

  private validateAbilityScoreImprovement(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
  ): void {
    for (const feat of characterFeats.filter(
      (f) => f.featSlug === ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
    )) {
      const featOptions = options.filter(
        (o) =>
          o.featSlug === ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG &&
          (o.instanceIndex ?? 0) === feat.instanceIndex,
      );
      const mode = featOptions.find((o) => o.optionKey === 'distributionMode')?.valueId;
      const primary = featOptions.find((o) => o.optionKey === 'primaryAbility')?.valueId;
      const secondary = featOptions.find(
        (o) => o.optionKey === 'secondaryAbility',
      )?.valueId;

      if (mode && mode !== ASI_DISTRIBUTION_PLUS2 && mode !== ASI_DISTRIBUTION_PLUS1PLUS1) {
        throw new BadRequestException(
          `Invalid distributionMode '${mode}' for ability-score-improvement`,
        );
      }

      if (mode === ASI_DISTRIBUTION_PLUS2 && secondary) {
        throw new BadRequestException(
          'secondaryAbility is not used when distribution is +2 on one ability',
        );
      }

      if (mode === ASI_DISTRIBUTION_PLUS1PLUS1 && primary && secondary && primary === secondary) {
        throw new BadRequestException(
          'Ability Score Improvement +1/+1 choices must be different abilities',
        );
      }
    }
  }

  private validateLinkedCastingAbilityMatchesAsi(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
  ): void {
    for (const feat of characterFeats.filter((f) => isFeatCastingLinkedToAsi(f.featSlug))) {
      const featOptions = options.filter(
        (o) =>
          o.featSlug === feat.featSlug &&
          (o.instanceIndex ?? 0) === feat.instanceIndex,
      );
      const asi = featOptions.find((o) => o.optionKey === 'abilityIncrease')?.valueId;
      const casting = featOptions.find((o) => o.optionKey === 'castingAbility')?.valueId;
      if (!asi || !casting) continue;
      if (asi !== casting) {
        throw new BadRequestException(
          `Feat '${feat.featSlug}' requires the same attribute for +1 and spell casting`,
        );
      }
    }
  }

  private async loadClassFightingStyleSlugs(classSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT fs.slug
       FROM rpg.phb_class_fighting_style cfs
       JOIN rpg.phb_class c ON c.id = cfs.class_id
       JOIN rpg.phb_fighting_style fs ON fs.id = cfs.fighting_style_id
       WHERE c.slug = $1
       ORDER BY fs.slug`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }

  private async loadClassSavingThrowSlugs(classSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT a.slug
       FROM rpg.phb_class_saving_throw cst
       JOIN rpg.phb_class c ON c.id = cst.class_id
       JOIN rpg.phb_ability a ON a.id = cst.ability_id
       WHERE c.slug = $1
       ORDER BY a.slug`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }

  private async resolveProficiencyBonus(level: number): Promise<number> {
    const row = await this.characterLevelsRepo.findOne({ where: { level } });
    if (!row) {
      throw new BadRequestException(`Character level '${level}' not found in catalog`);
    }
    return row.proficiencyBonus;
  }

  private validateRitualCasterSpells(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
    proficiencyBonus: number,
  ): void {
    for (const feat of characterFeats.filter((f) => f.featSlug === RITUAL_CASTER_FEAT_SLUG)) {
      const featOptions = options.filter(
        (o) =>
          o.featSlug === RITUAL_CASTER_FEAT_SLUG &&
          (o.instanceIndex ?? 0) === feat.instanceIndex,
      );
      const ritualSlugs = featOptions
        .filter((o) => ritualSpellSlotIndex(o.optionKey) !== null)
        .map((o) => o.valueId);
      if (ritualSlugs.some((value) => !value)) continue;
      assertUnique(ritualSlugs, 'Ritual Caster spell choices must be distinct');
      const extra = featOptions.filter((o) => {
        const slot = ritualSpellSlotIndex(o.optionKey);
        return slot !== null && slot > proficiencyBonus;
      });
      if (extra.length > 0) {
        throw new BadRequestException(
          `Feat 'ritual-caster' allows ${proficiencyBonus} ritual spell choice(s) at this level`,
        );
      }
    }
  }

  private validateMagicInitiateSpellLists(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
  ): void {
    const instances = characterFeats.filter((feat) => feat.featSlug === 'magic-initiate');
    if (instances.length <= 1) return;

    const spellLists = instances.map((instance) =>
      options.find(
        (option) =>
          option.featSlug === 'magic-initiate' &&
          (option.instanceIndex ?? 0) === instance.instanceIndex &&
          option.optionKey === 'spellList',
      )?.valueId,
    );

    if (spellLists.some((value) => !value)) return;
    assertUnique(
      spellLists,
      'Each Magic Initiate instance must choose a different spell list',
    );
  }

  private async loadFeatOptionDefs(featSlug: string): Promise<PhbFeatOptionDef[]> {
    const feat = await this.featRefRepo.findOne({ where: { slug: featSlug } });
    if (!feat) return [];
    return this.featOptionDefRepo.find({
      where: { featId: feat.id },
      order: { sortOrder: 'ASC', optionKey: 'ASC' },
    });
  }

  private async validateFeatOptionValue(
    def: PhbFeatOptionDef,
    option: FeatOptionDto,
    featOptions: FeatOptionDto[],
    featSlug: string,
    classSavingThrowSlugs: string[],
    classFightingStyleSlugs: string[],
  ): Promise<void> {
    if (def.valueType === 'fighting_style') {
      if (!classFightingStyleSlugs.includes(option.valueId)) {
        throw new BadRequestException(
          `Feat option '${def.optionKey}/${option.valueId}' is not a valid fighting style for this class`,
        );
      }
      const exists = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok FROM rpg.phb_fighting_style WHERE slug = $1 LIMIT 1`,
        [option.valueId],
      );
      if (exists.length === 0) {
        throw new BadRequestException(
          `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
        );
      }
      return;
    }

    if (def.valueType === 'catalog') {
      const valid = await this.featOptionValueRepo.findOne({
        where: {
          featId: def.featId,
          optionKey: def.optionKey,
          valueId: option.valueId,
        },
      });
      if (!valid) {
        throw new BadRequestException(
          `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
        );
      }
      return;
    }

    if (def.valueType === 'ability') {
      const valid = await this.featOptionValueRepo.findOne({
        where: {
          featId: def.featId,
          optionKey: def.optionKey,
          valueId: option.valueId,
        },
      });
      if (!valid) {
        throw new BadRequestException(
          `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
        );
      }
      if (
        featSlug === RESILIENT_FEAT_SLUG &&
        def.optionKey === 'abilityIncrease' &&
        classSavingThrowSlugs.includes(option.valueId)
      ) {
        throw new BadRequestException(
          'Resilient must choose an ability without save proficiency from your class',
        );
      }
      return;
    }

    if (def.valueType === 'spell') {
      if (def.spellRitualOnly) {
        const ritualRows = await this.dataSource.query<{ ok: number }[]>(
          `SELECT 1 AS ok
           FROM rpg.phb_spell s
           WHERE s.slug = $1
             AND s.level = $2
             AND s.ritual = TRUE
           LIMIT 1`,
          [option.valueId, def.spellMaxLevel ?? 1],
        );
        if (ritualRows.length === 0) {
          throw new BadRequestException(
            `Spell '${option.valueId}' must be a level ${def.spellMaxLevel ?? 1} ritual for '${def.optionKey}'`,
          );
        }
        return;
      }

      if (def.spellSchoolSlugs?.length) {
        const schoolRows = await this.dataSource.query<{ ok: number }[]>(
          `SELECT 1 AS ok
           FROM rpg.phb_spell s
           JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
           WHERE s.slug = $1
             AND s.level = $2
             AND sch.slug = ANY($3::text[])
           LIMIT 1`,
          [option.valueId, def.spellMaxLevel ?? 1, def.spellSchoolSlugs],
        );
        if (schoolRows.length === 0) {
          throw new BadRequestException(
            `Spell '${option.valueId}' is not a valid choice for '${def.optionKey}'`,
          );
        }
        return;
      }

      const spellList = featOptions.find((o) => o.optionKey === def.dependsOnOptionKey)?.valueId;
      if (!spellList) {
        throw new BadRequestException(
          `Feat option '${def.optionKey}' requires '${def.dependsOnOptionKey}' first`,
        );
      }
      const spell = await this.classSpellsRepo.findOne({
        where: { classSlug: spellList, spellSlug: option.valueId },
      });
      if (!spell) {
        throw new BadRequestException(
          `Spell '${option.valueId}' is not on the '${spellList}' list`,
        );
      }
      if (def.spellMaxLevel !== null && spell.spellLevel !== def.spellMaxLevel) {
        throw new BadRequestException(
          `Spell '${option.valueId}' must be level ${def.spellMaxLevel} for '${def.optionKey}'`,
        );
      }
      if (def.optionKey === 'cantrip2') {
        const first = featOptions.find((o) => o.optionKey === 'cantrip1')?.valueId;
        if (first && first === option.valueId) {
          throw new BadRequestException('Cantrip choices must be different');
        }
      }
      return;
    }

    if (def.valueType === 'proficiency') {
      const allowed = await this.featOptionValueRepo.findOne({
        where: {
          featId: def.featId,
          optionKey: def.optionKey,
          valueId: option.valueId,
        },
      });
      if (!allowed) {
        const hasWhitelist = await this.featOptionValueRepo.exists({
          where: { featId: def.featId, optionKey: def.optionKey },
        });
        if (hasWhitelist) {
          throw new BadRequestException(
            `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
          );
        }
        const rows = await this.dataSource.query<{ ok: number }[]>(
          `SELECT 1 AS ok
           FROM rpg.phb_skill WHERE slug = $1
           UNION ALL
           SELECT 1 FROM rpg.phb_item WHERE slug = $1 AND item_type = 'tool'::rpg.item_type
           LIMIT 1`,
          [option.valueId],
        );
        if (rows.length === 0) {
          throw new BadRequestException(
            `Proficiency '${option.valueId}' is not a valid skill or tool`,
          );
        }
      }
      const skilledValues = featOptions
        .filter((o) => o.optionKey.startsWith('proficiency'))
        .map((o) => o.valueId);
      assertUnique(skilledValues, 'Skilled proficiencies must be distinct');
      const artisanTools = featOptions
        .filter((o) => o.optionKey.startsWith('artisanTool'))
        .map((o) => o.valueId);
      assertUnique(artisanTools, 'Artisan tool choices must be distinct');
      const instruments = featOptions
        .filter((o) => o.optionKey.startsWith('musicalInstrument'))
        .map((o) => o.valueId);
      assertUnique(instruments, 'Musical instrument choices must be distinct');
    }
  }
}
