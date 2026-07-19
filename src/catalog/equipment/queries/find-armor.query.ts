import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
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
  ): Promise<PaginatedResponseDto<ArmorResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.armorRepo
      .createQueryBuilder('armor')
      .orderBy('armor.itemName', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(armor.itemName ILIKE :q OR armor.itemSlug ILIKE :q OR armor.categoryName ILIKE :q OR armor.categorySlug ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    const total = await qb.getCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);
    const currentPage = Math.min(safePage, totalPages);

    const rows = await qb
      .skip((currentPage - 1) * safeLimit)
      .take(safeLimit)
      .getMany();

    return {
      data: rows.map((row) => this.mapper.toArmorDto(row)),
      meta: {
        page: currentPage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
