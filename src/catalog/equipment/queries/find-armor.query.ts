import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { ArmorResponseDto } from '../dto/armor-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

const ARMOR_CURSOR_KEYS = [
  { expr: 'armor.itemName', name: 'itemName' },
  { expr: 'armor.itemSlug', name: 'itemSlug' },
] as const;

@Injectable()
export class FindArmorQuery {
  constructor(
    @InjectRepository(VPhbArmor)
    private readonly armorRepo: Repository<VPhbArmor>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    category?: string,
  ): Promise<PaginatedResponseDto<ArmorResponseDto>> {
    const qb = this.armorRepo
      .createQueryBuilder('armor')
      .orderBy('armor.itemName', 'ASC')
      .addOrderBy('armor.itemSlug', 'ASC');

    applyIlikeSearch(qb, [
      'armor.itemName',
      'armor.itemSlug',
      'armor.categoryName',
      'armor.categorySlug',
    ], q);

    const categorySlug = category?.trim();
    if (categorySlug) {
      qb.andWhere('armor.category_slug = :categorySlug', { categorySlug });
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: ARMOR_CURSOR_KEYS,
      encodeRow: (row) => ({
        itemName: row.itemName,
        itemSlug: row.itemSlug,
      }),
    });
    return { data: rows.map((row) => this.mapper.toArmorDto(row)), meta };
  }
}
