import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { FeatResponseDto } from '../dto/feat-response.dto';
import { FeatsMapper } from '../feats.mapper';

@Injectable()
export class FindFeatsQuery {
  constructor(
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    private readonly mapper: FeatsMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<FeatResponseDto>> {
    const rows = await this.featsRepo.find({ order: { featName: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
