import { Injectable } from '@nestjs/common';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundSkill } from '../../entities/views/v-phb-background-skill.entity';
import { BackgroundResponseDto } from './dto/background-response.dto';
import { BackgroundEquipmentResponseDto } from './dto/background-equipment-response.dto';
import { BackgroundSkillResponseDto } from './dto/background-skill-response.dto';

@Injectable()
export class BackgroundsMapper {
  toDto(row: VPhbBackground): BackgroundResponseDto {
    return {
      slug: row.backgroundSlug,
      name: row.backgroundName,
      equipmentGoldOption: row.equipmentGoldOption,
      abilityOptionSlugs: row.abilityOptionSlugs ?? [],
      abilityOptionNames: row.abilityOptionNames ?? [],
      sourceChapter: row.sourceChapter,
      sourceChapterTitle: row.sourceChapterTitle,
      editionSlug: row.editionSlug,
    };
  }

  toEquipmentDto(row: VPhbBackgroundEquipment): BackgroundEquipmentResponseDto {
    return {
      packageSlug: row.packageSlug,
      packageLabel: row.packageLabel,
      packageGold: row.packageGold,
      sortOrder: row.sortOrder,
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      quantity: row.quantity,
      choiceText: row.choiceText,
    };
  }

  toSkillDto(row: VPhbBackgroundSkill): BackgroundSkillResponseDto {
    return {
      slug: row.skillSlug,
      name: row.skillName,
    };
  }
}
