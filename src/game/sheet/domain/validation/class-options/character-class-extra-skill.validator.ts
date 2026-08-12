import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { collectProficientSkillSlugs } from '@game/sheet/domain/stats/character-check-bonuses';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import {
  classExtraSkillSlotsAtLevel,
  isClassExtraSkillOptionKey,
} from './class-extra-skill-slots';

@Injectable()
export class CharacterClassExtraSkillValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateClassExtraSkillOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    classSkillSlugs: CharacterSheetInput['classSkillSlugs'],
    speciesChoices: CharacterSheetInput['speciesChoices'],
    featOptions: CharacterSheetInput['featOptions'],
  ): Promise<void> {
    const extraOptions = options.filter((option) =>
      isClassExtraSkillOptionKey(option.optionKey),
    );
    const unlocked = classExtraSkillSlotsAtLevel(ctx.classSlug, ctx.level);
    const unlockedKeys = new Set(unlocked.map((slot) => slot.optionKey));

    assertUnique(
      extraOptions.map((option) => option.optionKey),
      'Opções de perícia extra duplicadas não são permitidas.',
    );

    if (unlocked.length === 0) {
      if (extraOptions.length > 0) {
        throw new BadRequestException(
          `Classe '${ctx.classSlug}' não tem perícia extra no nível ${ctx.level}.`,
        );
      }
      return;
    }

    for (const option of extraOptions) {
      if (!unlockedKeys.has(option.optionKey)) {
        throw new BadRequestException(
          `Opção '${option.optionKey}' desbloqueia depois do nível ${ctx.level}.`,
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
    const poolRows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT skill_slug AS slug
       FROM rpg.v_phb_class_skill_choice
       WHERE class_slug = $1`,
      [ctx.classSlug],
    );
    const pool = new Set(poolRows.map((row) => row.slug));

    for (const option of extraOptions) {
      if (!pool.has(option.valueId)) {
        throw new BadRequestException(
          `Perícia '${option.valueId}' não está na lista de '${ctx.classSlug}'.`,
        );
      }
      if (proficient.has(option.valueId)) {
        throw new BadRequestException(
          `Perícia extra '${option.valueId}' já é proficiente.`,
        );
      }
    }
  }
}
