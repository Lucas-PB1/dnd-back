import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '../../../entities/views/v-phb-background.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { BackgroundResponseDto } from '../dto/background-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundsQuery {
  constructor(
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<BackgroundResponseDto>> {
    const rows = await this.backgroundsRepo.find({ order: { backgroundName: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
