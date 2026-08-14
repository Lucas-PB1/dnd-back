import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundToolOption } from '@entities/views/v-phb-background-tool-option.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
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
    cursor?: string,
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
      order: { itemName: 'ASC', itemSlug: 'ASC' },
    });

    requireNonEmpty(
      rows,
      `Background '${backgroundSlug}' has no tool options configured`,
    );
    return paginateByKeys(
      rows.map((row) => this.mapper.toToolDto(row)),
      {
        cursor,
        limit,
        keyNames: ['itemName', 'itemSlug'],
        encodeRow: (row) => ({
          itemName: row.itemName,
          itemSlug: row.itemSlug,
        }),
      },
    );
  }
}
