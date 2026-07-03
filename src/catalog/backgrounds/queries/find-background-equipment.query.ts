import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundEquipment } from '../../../entities/views/v-phb-background-equipment.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
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
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundEquipmentResponseDto>> {
    await this.catalogLookup.findBackgroundOrFail(backgroundSlug);

    const rows = await this.equipmentRepo.find({
      where: { backgroundSlug },
      order: { packageSlug: 'ASC', sortOrder: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Background '${backgroundSlug}' has no starting equipment`);
    }
    return paginate(rows.map((row) => this.mapper.toEquipmentDto(row)), page, limit);
  }
}
