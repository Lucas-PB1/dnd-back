import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { PhbItem } from '../../../entities/phb-item.entity';
import { ItemResponseDto } from '../dto/item-response.dto';
import { ItemsMapper } from '../items.mapper';

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
    itemType?: string,
  ): Promise<PaginatedResponseDto<ItemResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.itemsRepo
      .createQueryBuilder('item')
      .orderBy('item.name', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere('(item.name ILIKE :q OR item.slug ILIKE :q)', {
        q: `%${term}%`,
      });
    }

    const types = itemType
      ?.split(',')
      .map((value) => value.trim())
      .filter(Boolean);
    if (types?.length === 1) {
      qb.andWhere('item.itemType = :itemType', { itemType: types[0] });
    } else if (types && types.length > 1) {
      qb.andWhere('item.itemType IN (:...types)', { types });
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
