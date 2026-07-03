import { Injectable } from '@nestjs/common';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { WeaponResponseDto } from './dto/weapon-response.dto';
import { ArmorResponseDto } from './dto/armor-response.dto';

@Injectable()
export class EquipmentMapper {
  toWeaponDto(row: PhbWeapon): WeaponResponseDto {
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

  toArmorDto(row: VPhbArmor): ArmorResponseDto {
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
