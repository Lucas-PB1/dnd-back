import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { requireFound } from '@common/require-found';
import { PhbWeapon } from '@entities/equipment/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/equipment/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '@entities/equipment/phb-weapon-property.entity';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';
import {
  loadWeaponMasteryBySlug,
  loadWeaponPropertyRows,
  resolveWeaponMasterySlug,
  resolveWeaponSecondaryMasterySlug,
} from '../weapon-props';

@Injectable()
export class FindWeaponBySlugQuery {
  constructor(
    @InjectRepository(PhbWeapon)
    private readonly weaponsRepo: Repository<PhbWeapon>,
    @InjectRepository(PhbWeaponProperty)
    private readonly propertyRepo: Repository<PhbWeaponProperty>,
    @InjectRepository(PhbWeaponMastery)
    private readonly masteryRepo: Repository<PhbWeaponMastery>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(slug: string): Promise<WeaponResponseDto> {
    const row = requireFound(
      await this.weaponsRepo.findOne({
        where: { item: { slug } },
        relations: ['item', 'mastery', 'secondaryMastery'],
      }),
      `Weapon '${slug}' not found`,
    );

    const [properties, masteryBySlug] = await Promise.all([
      loadWeaponPropertyRows([row], this.propertyRepo),
      loadWeaponMasteryBySlug([row], this.masteryRepo),
    ]);
    const masterySlug = resolveWeaponMasterySlug(row);
    const secondarySlug = resolveWeaponSecondaryMasterySlug(row);
    const mastery = masterySlug
      ? (masteryBySlug.get(masterySlug) ?? null)
      : null;
    const secondaryMastery = secondarySlug
      ? (masteryBySlug.get(secondarySlug) ?? null)
      : null;

    return this.mapper.toWeaponDto(row, properties, mastery, secondaryMastery);
  }
}
