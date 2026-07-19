import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
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
    const qb = this.itemsRepo
      .createQueryBuilder('item')
      .orderBy('item.name', 'ASC');

    applyIlikeSearch(qb, ['item.name', 'item.slug'], q);

    const types = itemType
      ?.split(',')
      .map((value) => value.trim())
      .filter(Boolean);
    if (types?.length === 1) {
      qb.andWhere('item.itemType = :itemType', { itemType: types[0] });
    } else if (types && types.length > 1) {
      qb.andWhere('item.itemType IN (:...types)', { types });
    }

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
