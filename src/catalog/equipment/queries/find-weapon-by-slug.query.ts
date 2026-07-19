import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../../entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '../../../entities/phb-weapon-property.entity';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

type WeaponPropsJson = {
  propertyIds?: string[];
  masteryId?: string;
};

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
    const row = await this.weaponsRepo.findOne({
      where: { item: { slug } },
      relations: ['item'],
    });
    if (!row) {
      throw new NotFoundException(`Weapon '${slug}' not found`);
    }

    const raw = (row.item.properties ?? {}) as WeaponPropsJson;
    const propertyIds = raw.propertyIds ?? [];
    const [properties, mastery] = await Promise.all([
      propertyIds.length
        ? this.propertyRepo.find({ where: { slug: In(propertyIds) } })
        : Promise.resolve([]),
      raw.masteryId
        ? this.masteryRepo.findOne({ where: { slug: raw.masteryId } })
        : Promise.resolve(null),
    ]);

    return this.mapper.toWeaponDto(row, properties, mastery);
  }
}
