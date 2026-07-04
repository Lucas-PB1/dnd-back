import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
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
    const row = await this.itemsRepo.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Item '${slug}' not found`);
    }
    return this.mapper.toDto(row);
  }
}
