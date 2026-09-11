import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PhbOptionDef } from '@entities/reference/phb-option.entity';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import { LORE_BONUS_SKILL_KEYS } from '../subclass-option-effects';
import {
  loadClassSkillChoiceSlugs,
  skillExists,
} from '@game/sheet/infrastructure/queries/skill-catalog.queries';

export async function validateSubclassOptionSkillList(
  dataSource: DataSource,
  def: PhbOptionDef,
  option: SubclassOptionDto,
  classSlug: string,
  options: SubclassOptionDto[],
): Promise<void> {
  if (!(await skillExists(dataSource, option.valueId))) {
    throw new BadRequestException(
      `Skill '${option.valueId}' is invalid for '${def.optionKey}'`,
    );
  }

  if (def.optionKey === 'warScholarSkill') {
    const pool = await loadClassSkillChoiceSlugs(dataSource, classSlug);
    if (!pool.includes(option.valueId)) {
      throw new BadRequestException(
        `Skill '${option.valueId}' is not in the fighter skill list for warScholarSkill`,
      );
    }
  }

  if (LORE_BONUS_SKILL_KEYS.has(def.optionKey)) {
    const siblings = options.filter((entry) =>
      LORE_BONUS_SKILL_KEYS.has(entry.optionKey),
    );
    const duplicates = siblings.filter(
      (entry) => entry.valueId === option.valueId,
    );
    if (duplicates.length > 1) {
      throw new BadRequestException(
        'Colégio do Saber bonus skills must be different',
      );
    }
  }
}
