import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VPhbSpeciesTraitChoices } from '../../../entities/views/v-phb-species-trait-choices.entity';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { PhbLanguage } from '../../../entities/phb-language.entity';
import { PhbAbilityGenerationMethod } from '../../../entities/phb-ability-generation-method.entity';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../../entities/phb-subclass-option-value.entity';
import { VPhbClassEquipment } from '../../../entities/views/v-phb-class-equipment.entity';
import { VPhbBackgroundEquipment } from '../../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundToolOption } from '../../../entities/views/v-phb-background-tool-option.entity';
import { CharacterSheetInput } from './character-sheet.types';
import {
  applyBackgroundAbilityBoosts,
  assertBackgroundBoostSlugsAllowed,
} from './background-ability-boost';

export interface CharacterSheetContext {
  level: number;
  classSlug: string;
  speciesSlug: string;
  backgroundSlug: string;
  subclassSlug: string | null;
}

@Injectable()
export class CharacterSheetValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(VPhbSpeciesTraitChoices)
    private readonly speciesTraitChoicesRepo: Repository<VPhbSpeciesTraitChoices>,
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    @InjectRepository(PhbAbilityGenerationMethod)
    private readonly abilityMethodsRepo: Repository<PhbAbilityGenerationMethod>,
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
    }

    if (input.featSlugs !== undefined) {
      await this.validateFeatSlugs(input.featSlugs);
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
    featSlugs: string[],
  ): Promise<void> {
    const origin = background.featSlug?.trim();
    if (!origin) return;
    if (!featSlugs.includes(origin)) {
      throw new BadRequestException(
        `Background origin feat '${origin}' must be included in featSlugs`,
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

    if (new Set(providedKinds).size !== providedKinds.length) {
      throw new BadRequestException('Duplicate species choice kinds are not allowed');
    }

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

    if (new Set(options.map((o) => o.optionKey)).size !== options.length) {
      throw new BadRequestException('Duplicate subclass option keys are not allowed');
    }

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
    }
  }

  private async validateFeatSlugs(featSlugs: string[]): Promise<void> {
    if (new Set(featSlugs).size !== featSlugs.length) {
      throw new BadRequestException('Duplicate feat slugs are not allowed');
    }

    for (const slug of featSlugs) {
      const feat = await this.featsRepo.findOne({ where: { featSlug: slug } });
      if (!feat) {
        throw new BadRequestException(`Feat '${slug}' not found in catalog`);
      }
    }
  }

  private async validateCharacterSpells(
    spells: NonNullable<CharacterSheetInput['characterSpells']>,
    ctx: CharacterSheetContext,
  ): Promise<void> {
    const keys = spells.map((s) => `${s.spellSlug}:${s.listType}`);
    if (new Set(keys).size !== keys.length) {
      throw new BadRequestException('Duplicate character spell entries are not allowed');
    }

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
    for (const [index, item] of items.entries()) {
      const sortOrder = item.sortOrder ?? index;
      const quantity = item.quantity ?? 1;

      if (item.source === 'class') {
        const rows = await this.classEquipmentRepo.find({
          where: { classSlug: ctx.classSlug, packageSlug: item.packageSlug },
        });
        if (rows.length === 0) {
          throw new BadRequestException(
            `Class equipment package '${item.packageSlug}' not found for '${ctx.classSlug}'`,
          );
        }
        if (item.itemSlug) {
          const match = rows.some((row) => row.itemSlug === item.itemSlug);
          if (!match) {
            throw new BadRequestException(
              `Item '${item.itemSlug}' is not in class package '${item.packageSlug}'`,
            );
          }
        }
      } else {
        const rows = await this.backgroundEquipmentRepo.find({
          where: { backgroundSlug: ctx.backgroundSlug, packageSlug: item.packageSlug },
        });
        if (rows.length === 0) {
          throw new BadRequestException(
            `Background equipment package '${item.packageSlug}' not found for '${ctx.backgroundSlug}'`,
          );
        }
        if (item.itemSlug) {
          const match = rows.some((row) => row.itemSlug === item.itemSlug);
          if (!match) {
            throw new BadRequestException(
              `Item '${item.itemSlug}' is not in background package '${item.packageSlug}'`,
            );
          }
        }
      }

      void sortOrder;
      void quantity;
    }
  }

  private async validateLanguageSlugs(languageSlugs: string[]): Promise<void> {
    if (new Set(languageSlugs).size !== languageSlugs.length) {
      throw new BadRequestException('Duplicate language slugs are not allowed');
    }

    for (const slug of languageSlugs) {
      const row = await this.languagesRepo.findOne({ where: { slug } });
      if (!row) {
        throw new BadRequestException(`Language '${slug}' not found in catalog`);
      }
    }
  }

  private async validateAbilityGenerationMethod(slug: string): Promise<void> {
    const row = await this.abilityMethodsRepo.findOne({ where: { slug } });
    if (!row) {
      throw new BadRequestException(`Ability generation method '${slug}' not found in catalog`);
    }
  }
}
