import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassEquipment } from '../../../entities/views/v-phb-class-equipment.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '../../../common/dto/pagination.dto';
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
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassEquipmentResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.equipmentRepo.find({
      where: { classSlug },
      order: { packageSlug: 'ASC', sortOrder: 'ASC' },
    });
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toEquipmentDto(row),
      page,
      limit,
      `Class '${classSlug}' has no starting equipment`,
    );
  }
}
