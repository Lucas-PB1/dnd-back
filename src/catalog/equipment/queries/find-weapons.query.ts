import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../../entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '../../../entities/phb-weapon-property.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';
import {
  loadWeaponMasteryBySlug,
  loadWeaponPropertyRows,
  weaponPropsOf,
} from '../weapon-props';

@Injectable()
export class FindWeaponsQuery {
  constructor(
    @InjectRepository(PhbWeapon)
    private readonly weaponsRepo: Repository<PhbWeapon>,
    @InjectRepository(PhbWeaponProperty)
    private readonly propertyRepo: Repository<PhbWeaponProperty>,
    @InjectRepository(PhbWeaponMastery)
    private readonly masteryRepo: Repository<PhbWeaponMastery>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    category?: string,
  ): Promise<PaginatedResponseDto<WeaponResponseDto>> {
    const qb = this.weaponsRepo
      .createQueryBuilder('weapon')
      .innerJoinAndSelect('weapon.item', 'item')
      .orderBy('item.name', 'ASC');

    applyIlikeSearch(qb, [
      'item.name',
      'item.slug',
      'weapon.category::text',
      "COALESCE(weapon.damageType, '')",
      "COALESCE(weapon.damage, '')",
    ], q);

    const categoryValue = category?.trim();
    if (categoryValue) {
      qb.andWhere('weapon.category = :category', { category: categoryValue });
    }

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: await this.mapRows(rows), meta };
  }

  private async mapRows(rows: PhbWeapon[]): Promise<WeaponResponseDto[]> {
    const [properties, masteryBySlug] = await Promise.all([
      loadWeaponPropertyRows(rows, this.propertyRepo),
      loadWeaponMasteryBySlug(rows, this.masteryRepo),
    ]);

    return rows.map((row) => {
      const raw = weaponPropsOf(row);
      const needed = new Set(raw.propertyIds ?? []);
      const props = properties.filter((p) => needed.has(p.slug));
      const mastery = raw.masteryId
        ? (masteryBySlug.get(raw.masteryId) ?? null)
        : null;
      return this.mapper.toWeaponDto(row, props, mastery);
    });
  }
}
