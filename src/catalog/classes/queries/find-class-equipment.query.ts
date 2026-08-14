import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassEquipment } from '@entities/views/v-phb-class-equipment.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { ClassEquipmentResponseDto } from '../dto/class-equipment-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassEquipmentQuery {
  constructor(
    @InjectRepository(VPhbClassEquipment)
    private readonly equipmentRepo: Repository<VPhbClassEquipment>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassEquipmentResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.equipmentRepo.find({
      where: { classSlug },
      order: { packageSlug: 'ASC', sortOrder: 'ASC' },
    });
    requireNonEmpty(rows, `Class '${classSlug}' has no starting equipment`);
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
