import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  applyIlikeSearch,
  DEFAULT_PHB_EDITION_SLUG,
  PaginatedResponseDto,
  paginateQb,
} from '@common/dto/pagination.dto';
import { PhbItem } from '@entities/phb-item.entity';
import { ItemResponseDto } from '../dto/item-response.dto';
import { ItemSummaryResponseDto } from '../dto/item-summary-response.dto';
import { ItemsMapper } from '../items.mapper';

export type FindItemsFilters = {
  itemType?: string;
  magic?: boolean;
  rarity?: string;
  editionSlugs?: string[];
  fields?: 'summary';
  hasCost?: boolean;
  kind?: string;
  consumable?: boolean;
};

@Injectable()
export class FindItemsQuery {
  constructor(
    @InjectRepository(PhbItem)
    private readonly itemsRepo: Repository<PhbItem>,
    private readonly mapper: ItemsMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    filters: FindItemsFilters = {},
  ): Promise<PaginatedResponseDto<ItemResponseDto | ItemSummaryResponseDto>> {
    const qb = this.itemsRepo
      .createQueryBuilder('item')
      .orderBy('item.name', 'ASC');

    if (filters.fields === 'summary') {
      qb.select([
        'item.slug',
        'item.name',
        'item.itemType',
        'item.cost',
        'item.weight',
        'item.properties',
      ]);
    }

    applyIlikeSearch(qb, ['item.name', 'item.slug'], q);

    const types = filters.itemType
      ?.split(',')
      .map((value) => value.trim())
      .filter(Boolean);
    if (types?.length === 1) {
      qb.andWhere('item.itemType = :itemType', { itemType: types[0] });
    } else if (types && types.length > 1) {
      qb.andWhere('item.itemType IN (:...types)', { types });
    }

    if (filters.magic === true) {
      qb.andWhere(`(item.properties->>'magic') = 'true'`);
    } else if (filters.magic === false) {
      qb.andWhere(
        `(item.properties->>'magic' IS NULL OR (item.properties->>'magic') <> 'true')`,
      );
    }

    const rarity = filters.rarity?.trim();
    if (rarity) {
      qb.andWhere(`(item.properties->>'rarity') = :rarity`, { rarity });
    }

    if (filters.hasCost === true) {
      qb.andWhere(
        `item.cost IS NOT NULL
         AND NULLIF(TRIM(item.cost->>'text'), '') IS NOT NULL
         AND LOWER(TRIM(item.cost->>'text')) <> 'varia'`,
      );
    } else if (filters.hasCost === false) {
      qb.andWhere(
        `item.cost IS NULL
         OR NULLIF(TRIM(item.cost->>'text'), '') IS NULL
         OR LOWER(TRIM(item.cost->>'text')) = 'varia'`,
      );
    }

    const kinds = filters.kind
      ?.split(',')
      .map((value) => value.trim())
      .filter(Boolean);
    if (kinds?.length === 1) {
      qb.andWhere(`(item.properties->>'kind') = :kind`, { kind: kinds[0] });
    } else if (kinds && kinds.length > 1) {
      qb.andWhere(`(item.properties->>'kind') IN (:...kinds)`, { kinds });
    }

    if (filters.consumable === true) {
      qb.andWhere(`(item.properties->>'consumable') = 'true'`);
    } else if (filters.consumable === false) {
      qb.andWhere(
        `(item.properties->>'consumable' IS NULL OR (item.properties->>'consumable') <> 'true')`,
      );
    }

    const editionSlugs = filters.editionSlugs
      ?.map((slug) => slug.trim())
      .filter(Boolean);
    if (editionSlugs?.length) {
      qb.andWhere(
        `COALESCE(item.properties->>'editionSlug', :defaultEdition) IN (:...editionSlugs)`,
        {
          defaultEdition: DEFAULT_PHB_EDITION_SLUG,
          editionSlugs,
        },
      );
    }

    const { rows, meta } = await paginateQb(qb, page, limit);
    const data =
      filters.fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
