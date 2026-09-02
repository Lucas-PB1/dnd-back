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
import { loadBackgroundSkillSlugs } from '@game/sheet/infrastructure/queries/background-origin.queries';
import { skillExists } from '@game/sheet/infrastructure/queries/skill-catalog.queries';

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

    const backgroundSkills = await loadBackgroundSkillSlugs(
      this.dataSource,
      ctx.backgroundSlug,
    );

    const proficient = new Set(
      collectProficientSkillSlugs({
        classSkillSlugs: classSkillSlugs ?? [],
        backgroundSkillSlugs: backgroundSkills,
        speciesChoices,
        featOptions,
      }),
    );

    const whitelist = allowedExpertiseSkillSlugsForClass(ctx.classSlug);
    const chosen = expertiseOptions.map((option) => option.valueId);
    assertUnique(chosen, 'Expertise skill choices must be distinct');

    for (const option of expertiseOptions) {
      if (!(await skillExists(this.dataSource, option.valueId))) {
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
