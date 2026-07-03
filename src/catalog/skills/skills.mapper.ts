import { Injectable } from '@nestjs/common';
import { PhbSkill } from '../../entities/phb-skill.entity';
import { SkillResponseDto } from './dto/skill-response.dto';

@Injectable()
export class SkillsMapper {
  toDto(row: PhbSkill): SkillResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      abilitySlug: row.ability.slug,
      abilityName: row.ability.name,
      description: row.description,
    };
  }
}
