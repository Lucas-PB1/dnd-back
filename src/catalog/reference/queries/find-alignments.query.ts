import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAlignment } from '@entities/phb-alignment.entity';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { AlignmentResponseDto } from '../dto/alignment-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindAlignmentsQuery {
  constructor(
    @InjectRepository(PhbAlignment)
    private readonly alignmentsRepo: Repository<PhbAlignment>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<AlignmentResponseDto>> {
    const rows = await this.alignmentsRepo.find({
      order: { name: 'ASC', slug: 'ASC' },
    });
    return paginateByKeys(
      rows.map((row) => this.mapper.toAlignmentDto(row)),
      {
        cursor,
        limit,
        keyNames: ['name', 'slug'],
        encodeRow: (row) => ({ name: row.name, slug: row.slug }),
      },
    );
  }
}
