import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAbility } from '../../entities/phb-ability.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { AbilityResponseDto } from './dto/ability-response.dto';

@Injectable()
export class AbilitiesService {
  constructor(
    @InjectRepository(PhbAbility)
    private readonly abilitiesRepo: Repository<PhbAbility>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<AbilityResponseDto>> {
    const rows = await this.abilitiesRepo.find({ order: { sortOrder: 'ASC' } });
    return paginate(rows.map((row) => this.toDto(row)), page, limit);
  }

  private toDto(row: PhbAbility): AbilityResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      sortOrder: row.sortOrder,
    };
  }
}
