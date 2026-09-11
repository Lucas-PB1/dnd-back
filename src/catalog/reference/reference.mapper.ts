import { Injectable } from '@nestjs/common';
import { PhbAlignment } from '@entities/reference/phb-alignment.entity';
import { PhbLanguage } from '@entities/reference/phb-language.entity';
import { PhbCharacterLevel } from '@entities/reference/phb-character-level.entity';
import { AlignmentResponseDto } from './dto/alignment-response.dto';
import { LanguageResponseDto } from './dto/language-response.dto';
import { CharacterLevelResponseDto } from './dto/character-level-response.dto';

@Injectable()
export class ReferenceMapper {
  toAlignmentDto(row: PhbAlignment): AlignmentResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      abbreviation: row.abbreviation,
      description: row.description,
    };
  }

  toLanguageDto(row: PhbLanguage): LanguageResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      script: row.script,
      typicalSpeakers: row.typicalSpeakers,
      isRare: row.isRare,
    };
  }

  toCharacterLevelDto(row: PhbCharacterLevel): CharacterLevelResponseDto {
    return {
      level: row.level,
      proficiencyBonus: row.proficiencyBonus,
      xpThreshold: row.xpThreshold,
    };
  }
}
