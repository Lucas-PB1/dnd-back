import { Injectable } from '@nestjs/common';
import { VPhbSpell } from '../../entities/views/v-phb-spell.entity';
import { SpellResponseDto } from './dto/spell-response.dto';

@Injectable()
export class SpellsMapper {
  toDto(row: VPhbSpell): SpellResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      level: row.level,
      levelLabel: row.levelLabel,
      schoolSlug: row.schoolSlug,
      schoolName: row.schoolName,
      castingTime: row.castingTime,
      range: row.range,
      hasVerbal: row.hasVerbal,
      hasSomatic: row.hasSomatic,
      hasMaterial: row.hasMaterial,
      materialDescription: row.materialDescription,
      componentsLabel: row.componentsLabel,
      duration: row.duration,
      concentration: row.concentration,
      ritual: row.ritual,
      description: row.description,
      higherLevels: row.higherLevels,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
    };
  }
}
