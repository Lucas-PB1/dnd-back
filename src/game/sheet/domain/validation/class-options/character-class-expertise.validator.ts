import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { CharacterSheetInput, CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import {
  allowedExpertiseSkillSlugsForClass,
  classExpertiseSlotsAtLevel,
  isClassExpertiseOptionKey,
} from './class-expertise-slots';
import { collectProficientSkillSlugs } from '@game/sheet/domain/stats/character-check-bonuses';

@Injectable()
export class CharacterClassExpertiseValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateClassExpertiseOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    classSkillSlugs: CharacterSheetInput['classSkillSlugs'],
    speciesChoices: CharacterSheetInput['speciesChoices'],
    featOptions: CharacterSheetInput['featOptions'],
  ): Promise<void> {
    const expertiseOptions = options.filter((option) =>
      isClassExpertiseOptionKey(option.optionKey),
    );
    const unlocked = classExpertiseSlotsAtLevel(ctx.classSlug, ctx.level);
    const unlockedKeys = new Set(unlocked.map((slot) => slot.optionKey));

    assertUnique(
      expertiseOptions.map((option) => option.optionKey),
      'Duplicate class option keys are not allowed',
    );

    if (unlocked.length === 0) {
      if (expertiseOptions.length > 0) {
        throw new BadRequestException(
          `Class '${ctx.classSlug}' has no expertise options at level ${ctx.level}`,
        );
      }
      return;
    }

    for (const option of expertiseOptions) {
      if (!unlockedKeys.has(option.optionKey)) {
        throw new BadRequestException(
          `Class option '${option.optionKey}' is not unlocked for '${ctx.classSlug}' at level ${ctx.level}`,
        );
      }
    }

    const backgroundSkills = await this.dataSource.query<{ slug: string }[]>(
      `SELECT s.slug
       FROM rpg.phb_background_skill bs
       JOIN rpg.phb_background b ON b.id = bs.background_id
       JOIN rpg.phb_skill s ON s.id = bs.skill_id
       WHERE b.slug = $1`,
      [ctx.backgroundSlug],
    );

    const proficient = new Set(
      collectProficientSkillSlugs({
        classSkillSlugs: classSkillSlugs ?? [],
        backgroundSkillSlugs: backgroundSkills.map((row) => row.slug),
        speciesChoices,
        featOptions,
      }),
    );

    const whitelist = allowedExpertiseSkillSlugsForClass(ctx.classSlug);
    const chosen = expertiseOptions.map((option) => option.valueId);
    assertUnique(chosen, 'Expertise skill choices must be distinct');

    for (const option of expertiseOptions) {
      const skillRows = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok FROM rpg.phb_skill WHERE slug = $1 LIMIT 1`,
        [option.valueId],
      );
      if (skillRows.length === 0) {
        throw new BadRequestException(
          `Expertise skill '${option.valueId}' is not a valid skill`,
        );
      }
      if (whitelist && !whitelist.includes(option.valueId)) {
        throw new BadRequestException(
          `Expertise skill '${option.valueId}' is not allowed for '${ctx.classSlug}'`,
        );
      }
      if (!proficient.has(option.valueId)) {
        throw new BadRequestException(
          `Expertise skill '${option.valueId}' requires proficiency`,
        );
      }
    }
  }
}
