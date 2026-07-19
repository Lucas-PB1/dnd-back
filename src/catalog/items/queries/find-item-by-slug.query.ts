import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { requireFound } from '../../../common/require-found';
import { PhbItem } from '../../../entities/phb-item.entity';
import { ItemResponseDto } from '../dto/item-response.dto';
import { ItemsMapper } from '../items.mapper';

@Injectable()
export class FindItemBySlugQuery {
  constructor(
    @InjectRepository(PhbItem)
    private readonly itemsRepo: Repository<PhbItem>,
    private readonly mapper: ItemsMapper,
  ) {}

  async execute(slug: string): Promise<ItemResponseDto> {
    const row = requireFound(
      await this.itemsRepo.findOne({ where: { slug } }),
      `Item '${slug}' not found`,
    );
    return this.mapper.toDto(row);
  }
}
