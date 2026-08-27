import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbVehicleTemplate } from '@entities/phb-vehicle-template.entity';
import { VPhbVehicleTemplateBundle } from '@entities/views/v-phb-vehicle-template-bundle.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import {
  VehicleTemplateResponseDto,
  VehicleTemplateSummaryResponseDto,
} from '../dto/vehicle-template-response.dto';
import { VehicleTemplateMapper } from '../vehicle-template.mapper';

const CURSOR_KEYS = [
  { expr: 'vehicle.name', name: 'name' },
  { expr: 'vehicle.slug', name: 'slug' },
] as const;

@Injectable()
export class FindVehicleTemplatesQuery {
  constructor(
    @InjectRepository(PhbVehicleTemplate)
    private readonly templates: Repository<PhbVehicleTemplate>,
    private readonly mapper: VehicleTemplateMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<
    PaginatedResponseDto<
      VehicleTemplateResponseDto | VehicleTemplateSummaryResponseDto
    >
  > {
    const qb = this.templates
      .createQueryBuilder('vehicle')
      .orderBy('vehicle.name', 'ASC')
      .addOrderBy('vehicle.slug', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'vehicle.slug',
        'vehicle.name',
        'vehicle.editionSlug',
        'vehicle.armorClass',
        'vehicle.hitPoints',
        'vehicle.crewCapacity',
      ]);
    }

    applyIlikeSearch(qb, ['vehicle.name', 'vehicle.slug'], q);

    const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
    if (slugs?.length) {
      qb.andWhere('vehicle.editionSlug IN (:...editionSlugs)', {
        editionSlugs: slugs,
      });
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: CURSOR_KEYS,
      encodeRow: (row) => ({ name: row.name, slug: row.slug }),
    });

    const data = rows.map((row) => this.mapper.toSummaryDto(row));
    return { data, meta };
  }
}

@Injectable()
export class FindVehicleTemplateBySlugQuery {
  constructor(
    @InjectRepository(VPhbVehicleTemplateBundle)
    private readonly bundles: Repository<VPhbVehicleTemplateBundle>,
    private readonly mapper: VehicleTemplateMapper,
  ) {}

  async execute(slug: string): Promise<VehicleTemplateResponseDto> {
    const row = await this.bundles.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Vehicle template '${slug}' not found`);
    }
    return this.mapper.toDto(row);
  }
}
