import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpell } from '../../../entities/views/v-phb-spell.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellsMapper } from '../spells.mapper';

@Injectable()
export class FindSpellsQuery {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
  ): Promise<PaginatedResponseDto<SpellResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.spellsRepo
      .createQueryBuilder('spell')
      .orderBy('spell.level', 'ASC')
      .addOrderBy('spell.name', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(spell.name ILIKE :q OR spell.slug ILIKE :q OR spell.schoolName ILIKE :q OR spell.levelLabel ILIKE :q)',
        { q: `%${term}%` },
      );
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
