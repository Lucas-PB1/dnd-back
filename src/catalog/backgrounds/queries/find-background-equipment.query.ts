import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundEquipment } from '@entities/views/v-phb-background-equipment.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { BackgroundEquipmentResponseDto } from '../dto/background-equipment-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundEquipmentQuery {
  constructor(
    @InjectRepository(VPhbBackgroundEquipment)
    private readonly equipmentRepo: Repository<VPhbBackgroundEquipment>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(
    backgroundSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundEquipmentResponseDto>> {
    await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const rows = await this.equipmentRepo.find({
      where: { backgroundSlug },
      order: { packageSlug: 'ASC', sortOrder: 'ASC' },
    });
    requireNonEmpty(
      rows,
      `Background '${backgroundSlug}' has no starting equipment`,
    );
    return paginateByKeys(
      rows.map((row) => this.mapper.toEquipmentDto(row)),
      {
        cursor,
        limit,
        keyNames: ['packageSlug', 'sortOrder'],
        encodeRow: (row) => ({
          packageSlug: row.packageSlug,
          sortOrder: row.sortOrder,
        }),
      },
    );
  }
}
