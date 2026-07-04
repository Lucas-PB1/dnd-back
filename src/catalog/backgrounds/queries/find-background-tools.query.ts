import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundToolOption } from '../../../entities/views/v-phb-background-tool-option.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { BackgroundToolResponseDto } from '../dto/background-tool-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundToolsQuery {
  constructor(
    @InjectRepository(VPhbBackgroundToolOption)
    private readonly toolsRepo: Repository<VPhbBackgroundToolOption>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(
    backgroundSlug: string,
    page = 1,
    limit = 50,
  ): Promise<PaginatedResponseDto<BackgroundToolResponseDto>> {
    const background = await this.catalogLookup.findBackgroundOrFail(backgroundSlug);

    if (background.toolProficiencyKind !== 'choice') {
      throw new NotFoundException(
        `Background '${backgroundSlug}' has no tool choices`,
      );
    }

    const rows = await this.toolsRepo.find({
      where: { backgroundSlug },
      order: { itemName: 'ASC' },
    });

    if (rows.length === 0) {
      throw new NotFoundException(
        `Background '${backgroundSlug}' has no tool options configured`,
      );
    }

    return paginate(rows.map((row) => this.mapper.toToolDto(row)), page, limit);
  }
}
