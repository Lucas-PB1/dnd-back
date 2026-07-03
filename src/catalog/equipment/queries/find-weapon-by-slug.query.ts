import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

@Injectable()
export class FindWeaponBySlugQuery {
  constructor(
    @InjectRepository(PhbWeapon)
    private readonly weaponsRepo: Repository<PhbWeapon>,
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
    return this.mapper.toWeaponDto(row);
  }
}
