import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

@Injectable()
export class FindWeaponsQuery {
  constructor(
    @InjectRepository(PhbWeapon)
    private readonly weaponsRepo: Repository<PhbWeapon>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
  ): Promise<PaginatedResponseDto<WeaponResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.weaponsRepo
      .createQueryBuilder('weapon')
      .innerJoinAndSelect('weapon.item', 'item')
      .orderBy('item.name', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(item.name ILIKE :q OR item.slug ILIKE :q OR weapon.category::text ILIKE :q OR COALESCE(weapon.damageType, \'\') ILIKE :q OR COALESCE(weapon.damage, \'\') ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toWeaponDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
