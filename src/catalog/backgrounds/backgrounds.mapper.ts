import { Injectable } from '@nestjs/common';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundSkill } from '../../entities/views/v-phb-background-skill.entity';
import { VPhbBackgroundToolOption } from '../../entities/views/v-phb-background-tool-option.entity';
import { BackgroundResponseDto } from './dto/background-response.dto';
import { BackgroundEquipmentResponseDto } from './dto/background-equipment-response.dto';
import { BackgroundSkillResponseDto } from './dto/background-skill-response.dto';
import { BackgroundToolResponseDto } from './dto/background-tool-response.dto';

@Injectable()
export class BackgroundsMapper {
  toDto(row: VPhbBackground): BackgroundResponseDto {
    return {
      slug: row.backgroundSlug,
      name: row.backgroundName,
      tagline: row.tagline,
      summary: row.summary,
      description: row.description,
      equipmentGoldOption: row.equipmentGoldOption,
      abilityOptionSlugs: row.abilityOptionSlugs ?? [],
      abilityOptionNames: row.abilityOptionNames ?? [],
      sourceChapter: row.sourceChapter,
      sourceChapterTitle: row.sourceChapterTitle,
      editionSlug: row.editionSlug,
      originFeatSlug: row.featSlug,
      originFeatName: row.featName,
      toolProficiencyKind: row.toolProficiencyKind,
      toolProficiencyDescription: row.toolProficiencyDescription,
      toolItemSlug: row.toolItemSlug,
      toolItemName: row.toolItemName,
      toolCategorySlug: row.toolCategorySlug,
      toolCategoryName: row.toolCategoryName,
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

  toToolDto(row: VPhbBackgroundToolOption): BackgroundToolResponseDto {
    return {
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      categorySlug: row.categorySlug,
      categoryName: row.categoryName,
    };
  }
}
