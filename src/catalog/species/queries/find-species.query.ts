import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpecies } from '../../../entities/phb-species.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { SpeciesResponseDto } from '../dto/species-response.dto';
import { SpeciesMapper } from '../species.mapper';

@Injectable()
export class FindSpeciesQuery {
  constructor(
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
  ): Promise<PaginatedResponseDto<SpeciesResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.speciesRepo
      .createQueryBuilder('species')
      .orderBy('species.name', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(species.name ILIKE :q OR species.slug ILIKE :q OR COALESCE(species.tagline, \'\') ILIKE :q OR COALESCE(species.summary, \'\') ILIKE :q OR species.creatureType ILIKE :q OR species.size ILIKE :q)',
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
