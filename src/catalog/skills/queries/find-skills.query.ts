import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSkill } from '../../../entities/phb-skill.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
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
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.skillsRepo
      .createQueryBuilder('skill')
      .leftJoinAndSelect('skill.ability', 'ability')
      .orderBy('skill.name', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(skill.name ILIKE :q OR skill.slug ILIKE :q OR COALESCE(skill.description, \'\') ILIKE :q OR ability.name ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    const abilitySlug = ability?.trim();
    if (abilitySlug) {
      qb.andWhere('ability.slug = :abilitySlug', { abilitySlug });
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
