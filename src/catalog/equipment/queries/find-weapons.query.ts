import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../../entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '../../../entities/phb-weapon-property.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

type WeaponPropsJson = {
  propertyIds?: string[];
  masteryId?: string;
};

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
    const data = await this.mapRows(rows);
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data,
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }

  private async mapRows(rows: PhbWeapon[]): Promise<WeaponResponseDto[]> {
    const propertySlugs = new Set<string>();
    const masterySlugs = new Set<string>();
    for (const row of rows) {
      const raw = (row.item.properties ?? {}) as WeaponPropsJson;
      for (const slug of raw.propertyIds ?? []) propertySlugs.add(slug);
      if (raw.masteryId) masterySlugs.add(raw.masteryId);
    }

    const [properties, masteries] = await Promise.all([
      propertySlugs.size
        ? this.propertyRepo.find({ where: { slug: In([...propertySlugs]) } })
        : Promise.resolve([]),
      masterySlugs.size
        ? this.masteryRepo.find({ where: { slug: In([...masterySlugs]) } })
        : Promise.resolve([]),
    ]);

    const masteryBySlug = new Map(masteries.map((m) => [m.slug, m]));

    return rows.map((row) => {
      const raw = (row.item.properties ?? {}) as WeaponPropsJson;
      const needed = new Set(raw.propertyIds ?? []);
      const props = properties.filter((p) => needed.has(p.slug));
      const mastery = raw.masteryId
        ? (masteryBySlug.get(raw.masteryId) ?? null)
        : null;
      return this.mapper.toWeaponDto(row, props, mastery);
    });
  }
}
