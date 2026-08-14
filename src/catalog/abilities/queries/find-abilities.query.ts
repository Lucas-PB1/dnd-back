import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAbility } from '@entities/phb-ability.entity';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { AbilityResponseDto } from '../dto/ability-response.dto';
import { AbilitiesMapper } from '../abilities.mapper';

@Injectable()
export class FindAbilitiesQuery {
  constructor(
    @InjectRepository(PhbAbility)
    private readonly abilitiesRepo: Repository<PhbAbility>,
    private readonly mapper: AbilitiesMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<AbilityResponseDto>> {
    const rows = await this.abilitiesRepo.find({
      order: { sortOrder: 'ASC', slug: 'ASC' },
    });
    return paginateByKeys(
      rows.map((row) => this.mapper.toDto(row)),
      {
        cursor,
        limit,
        keyNames: ['sortOrder', 'slug'],
        encodeRow: (row) => ({ sortOrder: row.sortOrder, slug: row.slug }),
      },
    );
  }
}
