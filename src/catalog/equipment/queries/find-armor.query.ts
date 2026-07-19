import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { ArmorResponseDto } from '../dto/armor-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

@Injectable()
export class FindArmorQuery {
  constructor(
    @InjectRepository(VPhbArmor)
    private readonly armorRepo: Repository<VPhbArmor>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    category?: string,
  ): Promise<PaginatedResponseDto<ArmorResponseDto>> {
    const qb = this.armorRepo
      .createQueryBuilder('armor')
      .orderBy('armor.itemName', 'ASC');

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

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toArmorDto(row)), meta };
  }
}
