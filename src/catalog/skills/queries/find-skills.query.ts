import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSkill } from '../../../entities/phb-skill.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { SkillsMapper } from '../skills.mapper';

@Injectable()
export class FindSkillsQuery {
  constructor(
    @InjectRepository(PhbSkill)
    private readonly skillsRepo: Repository<PhbSkill>,
    private readonly mapper: SkillsMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    ability?: string,
  ): Promise<PaginatedResponseDto<SkillResponseDto>> {
    const qb = this.skillsRepo
      .createQueryBuilder('skill')
      .leftJoinAndSelect('skill.ability', 'ability')
      .orderBy('skill.name', 'ASC');

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

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
