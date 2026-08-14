import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSkill } from '@entities/phb-skill.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { SkillsMapper } from '../skills.mapper';

const SKILL_CURSOR_KEYS = [
  { expr: 'skill.name', name: 'name' },
  { expr: 'skill.slug', name: 'slug' },
] as const;

@Injectable()
export class FindSkillsQuery {
  constructor(
    @InjectRepository(PhbSkill)
    private readonly skillsRepo: Repository<PhbSkill>,
    private readonly mapper: SkillsMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    ability?: string,
  ): Promise<PaginatedResponseDto<SkillResponseDto>> {
    const qb = this.skillsRepo
      .createQueryBuilder('skill')
      .leftJoinAndSelect('skill.ability', 'ability')
      .orderBy('skill.name', 'ASC')
      .addOrderBy('skill.slug', 'ASC');

    applyIlikeSearch(qb, [
      'skill.name',
      'skill.slug',
      "COALESCE(skill.description, '')",
      'ability.name',
    ], q);

    const abilitySlug = ability?.trim();
    if (abilitySlug) {
      qb.andWhere('ability.slug = :abilitySlug', { abilitySlug });
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: SKILL_CURSOR_KEYS,
      encodeRow: (row) => ({ name: row.name, slug: row.slug }),
    });
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
