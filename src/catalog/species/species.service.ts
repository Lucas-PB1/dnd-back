import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { SpeciesResponseDto } from './dto/species-response.dto';

@Injectable()
export class SpeciesService {
  constructor(
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<SpeciesResponseDto>> {
    const rows = await this.speciesRepo.find({ order: { name: 'ASC' } });
    const dtos = rows.map((row) => this.toDto(row));
    return paginate(dtos, page, limit);
  }

  async findBySlug(slug: string): Promise<SpeciesResponseDto> {
    const row = await this.speciesRepo.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Species '${slug}' not found`);
    }
    return this.toDto(row);
  }

  private toDto(row: PhbSpecies): SpeciesResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      creatureType: row.creatureType,
      size: row.size,
      speed: row.speed,
      description: row.description,
    };
  }
}
