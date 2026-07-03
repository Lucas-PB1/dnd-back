import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { WeaponResponseDto } from '../dto/weapon-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

@Injectable()
export class FindWeaponsQuery {
  constructor(
    @InjectRepository(PhbWeapon)
    private readonly weaponsRepo: Repository<PhbWeapon>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<WeaponResponseDto>> {
    const rows = await this.weaponsRepo.find({
      relations: ['item'],
      order: { item: { name: 'ASC' } },
    });
    return paginate(rows.map((row) => this.mapper.toWeaponDto(row)), page, limit);
  }
}
