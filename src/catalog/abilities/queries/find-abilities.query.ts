import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAbility } from '../../../entities/phb-ability.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { AbilityResponseDto } from '../dto/ability-response.dto';
import { AbilitiesMapper } from '../abilities.mapper';

@Injectable()
export class FindAbilitiesQuery {
  constructor(
    @InjectRepository(PhbAbility)
    private readonly abilitiesRepo: Repository<PhbAbility>,
    private readonly mapper: AbilitiesMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<AbilityResponseDto>> {
    const rows = await this.abilitiesRepo.find({ order: { sortOrder: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
