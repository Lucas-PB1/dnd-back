import { Injectable } from '@nestjs/common';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { VPhbClassSkillChoice } from '../../entities/views/v-phb-class-skill-choice.entity';
import { VPhbClassFeature } from '../../entities/views/v-phb-class-feature.entity';
import { ClassResponseDto } from './dto/class-response.dto';
import { SubclassResponseDto } from '../subclasses/dto/subclass-response.dto';
import { ClassSpellResponseDto } from './dto/class-spell-response.dto';
import { ClassSpellSlotsResponseDto } from './dto/class-spell-slots-response.dto';
import { ClassEquipmentResponseDto } from './dto/class-equipment-response.dto';
import { ClassSkillResponseDto } from './dto/class-skill-response.dto';
import { ClassFeatureResponseDto } from './dto/class-feature-response.dto';

@Injectable()
export class ClassesMapper {
  toClassDto(row: VPhbClass): ClassResponseDto {
    return {
      slug: row.classSlug,
      name: row.className,
      hitDie: row.hitDie,
      primaryAbilityLabel: row.primaryAbilityLabel,
      primaryAbilityOperator: row.primaryAbilityOperator,
      primaryAbilitySlugs: row.primaryAbilitySlugs ?? [],
      hpLevel1DieValue: row.hpLevel1DieValue,
      hpFixedPerLevel: row.hpFixedPerLevel,
      skillChoiceCount: row.skillChoiceCount,
      skillChoiceFrom: row.skillChoiceFrom,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
    };
  }

  toSubclassDto(row: VPhbSubclass): SubclassResponseDto {
    return {
      slug: row.subclassSlug,
      name: row.subclassName,
      classSlug: row.classSlug,
      className: row.className,
      tagline: row.tagline,
      summary: row.summary,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
      spellSourceSlug: row.spellSourceSlug,
      spellSourceLabel: row.spellSourceLabel,
    };
  }

  toClassSpellDto(row: VSpellByClass): ClassSpellResponseDto {
    return {
      slug: row.spellSlug,
      name: row.spellName,
      level: row.spellLevel,
      schoolSlug: row.schoolSlug,
      schoolName: row.schoolName,
    };
  }

  toSpellSlotsDto(row: VClassSpellSlots): ClassSpellSlotsResponseDto {
    return {
      classLevel: row.classLevel,
      patternSlug: row.patternSlug,
      patternName: row.patternName,
      spellSlots: row.spellSlots,
    };
  }

  toEquipmentDto(row: VPhbClassEquipment): ClassEquipmentResponseDto {
    return {
      packageSlug: row.packageSlug,
      packageLabel: row.packageLabel,
      sortOrder: row.sortOrder,
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      quantity: row.quantity,
      choiceText: row.choiceText,
      goldAmount: row.goldAmount,
    };
  }

  toClassSkillDto(row: VPhbClassSkillChoice): ClassSkillResponseDto {
    return {
      slug: row.skillSlug,
      name: row.skillName,
      skillChoiceCount: row.skillChoiceCount,
      skillChoiceFrom: row.skillChoiceFrom,
    };
  }

  toClassFeatureDto(row: VPhbClassFeature): ClassFeatureResponseDto {
    return {
      classSlug: row.classSlug,
      featureLevel: row.featureLevel,
      featureName: row.featureName,
      featureDescription: row.featureDescription,
    };
  }
}
