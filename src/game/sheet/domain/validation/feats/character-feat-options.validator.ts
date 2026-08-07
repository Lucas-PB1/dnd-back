import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '../../../../../common/assert';
import {
  PhbFeatOptionDef,
  PhbFeatRef,
} from '../../../../../entities/phb-feat-option.entity';
import { PhbCharacterLevel } from '../../../../../entities/phb-character-level.entity';
import { FeatOptionDto, CharacterFeatDto } from '../../../dto/character-sheet.dto';
import { requiredAbilityScoreImprovementDefs } from './ability-score-improvement-feat-options';
import { CharacterFeatOptionValueValidator } from './character-feat-option-value.validator';
import {
  validateAbilityScoreImprovement,
  validateLinkedCastingAbilityMatchesAsi,
  validateMagicInitiateSpellLists,
  validateRitualCasterSpells,
} from './character-feat-option-rules';
import {
  requiredFeatOptionDefsForInstance,
  ritualSpellSlotIndex,
  RITUAL_CASTER_FEAT_SLUG,
} from './ritual-caster-feat-options';

@Injectable()
export class CharacterFeatOptionsValidator {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(PhbFeatRef)
    private readonly featRefRepo: Repository<PhbFeatRef>,
    @InjectRepository(PhbFeatOptionDef)
    private readonly featOptionDefRepo: Repository<PhbFeatOptionDef>,
    @InjectRepository(PhbCharacterLevel)
    private readonly characterLevelsRepo: Repository<PhbCharacterLevel>,
    private readonly optionValueValidator: CharacterFeatOptionValueValidator,
  ) {}

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
    const keys = options.map(
      (o) => `${o.featSlug}:${o.instanceIndex ?? 0}:${o.optionKey}`,
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
        requiredFeatOptionDefsForInstance(feat.featSlug, defs, proficiencyBonus),
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
        await this.optionValueValidator.validate(
          def,
          option,
          featOptions,
          feat.featSlug,
          classSavingThrowSlugs,
          classFightingStyleSlugs,
        );
      }
    }

    validateMagicInitiateSpellLists(characterFeats, options);
    validateRitualCasterSpells(characterFeats, options, proficiencyBonus);
    validateLinkedCastingAbilityMatchesAsi(characterFeats, options);
    validateAbilityScoreImprovement(characterFeats, options);
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

  private async loadFeatOptionDefs(featSlug: string): Promise<PhbFeatOptionDef[]> {
    const feat = await this.featRefRepo.findOne({ where: { slug: featSlug } });
    if (!feat) return [];
    return this.featOptionDefRepo.find({
      where: { scope: 'feat' as const, ownerId: feat.id },
      order: { sortOrder: 'ASC', optionKey: 'ASC' },
    });
  }
}
