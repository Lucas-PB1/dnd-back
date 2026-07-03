import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpecies } from '../../../entities/phb-species.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { SpeciesResponseDto } from '../dto/species-response.dto';
import { SpeciesMapper } from '../species.mapper';

@Injectable()
export class FindSpeciesQuery {
  constructor(
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<SpeciesResponseDto>> {
    const rows = await this.speciesRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
