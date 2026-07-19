import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpecies } from '../../../entities/phb-species.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
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
    const qb = this.speciesRepo
      .createQueryBuilder('species')
      .orderBy('species.name', 'ASC');

    applyIlikeSearch(qb, [
      'species.name',
      'species.slug',
      "COALESCE(species.tagline, '')",
      "COALESCE(species.summary, '')",
      'species.creatureType',
      'species.size',
    ], q);

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
