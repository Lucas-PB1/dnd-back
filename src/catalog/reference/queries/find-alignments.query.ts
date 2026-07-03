import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAlignment } from '../../../entities/phb-alignment.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { AlignmentResponseDto } from '../dto/alignment-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindAlignmentsQuery {
  constructor(
    @InjectRepository(PhbAlignment)
    private readonly alignmentsRepo: Repository<PhbAlignment>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<AlignmentResponseDto>> {
    const rows = await this.alignmentsRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toAlignmentDto(row)), page, limit);
  }
}
