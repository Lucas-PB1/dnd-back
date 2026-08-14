import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '@entities/phb-weapon-property.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';
import {
  loadWeaponMasteryBySlug,
  loadWeaponPropertyRows,
  weaponPropsOf,
} from '../weapon-props';

const WEAPON_CURSOR_KEYS = [
  { expr: 'item.name', name: 'name' },
  { expr: 'item.slug', name: 'slug' },
] as const;

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
    cursor?: string,
    limit = 20,
    q?: string,
    category?: string,
  ): Promise<PaginatedResponseDto<WeaponResponseDto>> {
    const qb = this.weaponsRepo
      .createQueryBuilder('weapon')
      .innerJoinAndSelect('weapon.item', 'item')
      .orderBy('item.name', 'ASC')
      .addOrderBy('item.slug', 'ASC');

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

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: WEAPON_CURSOR_KEYS,
      encodeRow: (row) => ({
        name: row.item.name,
        slug: row.item.slug,
      }),
    });
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
