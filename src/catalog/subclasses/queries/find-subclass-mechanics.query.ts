import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclassMechanics } from '@entities/views/v-phb-subclass-mechanics.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { SubclassMechanicResponseDto } from '../dto/subclass-mechanic-response.dto';
import { SubclassesMapper } from '../subclasses.mapper';

@Injectable()
export class FindSubclassMechanicsQuery {
  constructor(
    @InjectRepository(VPhbSubclassMechanics)
    private readonly mechanicsRepo: Repository<VPhbSubclassMechanics>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SubclassesMapper,
  ) {}

  async execute(
    subclassSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassMechanicResponseDto>> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);
    const rows = await this.mechanicsRepo.find({
      where: { subclassSlug },
      order: { featureLevel: 'ASC', featureName: 'ASC' },
    });
    requireNonEmpty(rows, `Subclass '${subclassSlug}' has no mechanics data`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toMechanicDto(row)),
      {
        cursor,
        limit,
        keyNames: ['featureLevel', 'featureName'],
        encodeRow: (row) => ({
          featureLevel: row.featureLevel,
          featureName: row.featureName,
        }),
      },
    );
  }
}
