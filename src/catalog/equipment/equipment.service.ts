import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { WeaponResponseDto } from './dto/weapon-response.dto';
import { ArmorResponseDto } from './dto/armor-response.dto';

@Injectable()
export class EquipmentService {
  constructor(
    @InjectRepository(PhbWeapon)
    private readonly weaponsRepo: Repository<PhbWeapon>,
    @InjectRepository(VPhbArmor)
    private readonly armorRepo: Repository<VPhbArmor>,
  ) {}

  async findAllWeapons(page = 1, limit = 20): Promise<PaginatedResponseDto<WeaponResponseDto>> {
    const rows = await this.weaponsRepo.find({
      relations: ['item'],
      order: { item: { name: 'ASC' } },
    });
    return paginate(rows.map((row) => this.toWeaponDto(row)), page, limit);
  }

  async findWeaponBySlug(slug: string): Promise<WeaponResponseDto> {
    const row = await this.weaponsRepo.findOne({
      where: { item: { slug } },
      relations: ['item'],
    });
    if (!row) {
      throw new NotFoundException(`Weapon '${slug}' not found`);
    }
    return this.toWeaponDto(row);
  }

  async findAllArmor(page = 1, limit = 20): Promise<PaginatedResponseDto<ArmorResponseDto>> {
    const rows = await this.armorRepo.find({ order: { itemName: 'ASC' } });
    return paginate(rows.map((row) => this.toArmorDto(row)), page, limit);
  }

  async findArmorBySlug(slug: string): Promise<ArmorResponseDto> {
    const row = await this.armorRepo.findOne({ where: { itemSlug: slug } });
    if (!row) {
      throw new NotFoundException(`Armor '${slug}' not found`);
    }
    return this.toArmorDto(row);
  }

  private toWeaponDto(row: PhbWeapon): WeaponResponseDto {
    return {
      slug: row.item.slug,
      name: row.item.name,
      category: row.category,
      damage: row.damage,
      damageType: row.damageType,
      cost: row.item.cost,
      weight: row.item.weight,
      properties: row.item.properties,
    };
  }

  private toArmorDto(row: VPhbArmor): ArmorResponseDto {
    return {
      slug: row.itemSlug,
      name: row.itemName,
      categorySlug: row.categorySlug,
      categoryName: row.categoryName,
      donDoff: row.donDoff,
      acBase: row.acBase,
      acFormula: row.acFormula,
      strengthReq: row.strengthReq,
      stealthDisadvantage: row.stealthDisadvantage,
    };
  }
}
