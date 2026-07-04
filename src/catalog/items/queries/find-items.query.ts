import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
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

    const term = q?.trim();
    if (term) {
      qb.andWhere('(item.name ILIKE :q OR item.slug ILIKE :q)', {
        q: `%${term}%`,
      });
    }

    const type = itemType?.trim();
    if (type) {
      qb.andWhere('item.item_type = :itemType', { itemType: type });
    }

    const rows = await qb.getMany();
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
