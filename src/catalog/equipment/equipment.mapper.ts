import { Injectable } from '@nestjs/common';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '../../entities/phb-weapon-property.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { WeaponResponseDto } from './dto/weapon-response.dto';
import { ArmorResponseDto } from './dto/armor-response.dto';

type WeaponPropsJson = {
  propertyIds?: string[];
  masteryId?: string;
  versatileDamage?: string;
  range?: { normal?: number; max?: number };
  [key: string]: unknown;
};

@Injectable()
export class EquipmentMapper {
  toWeaponDto(
    row: PhbWeapon,
    propertyRows: PhbWeaponProperty[] = [],
    mastery: PhbWeaponMastery | null = null,
  ): WeaponResponseDto {
    const raw = (row.item.properties ?? null) as WeaponPropsJson | null;
    const bySlug = new Map(propertyRows.map((p) => [p.slug, p]));
    const orderedIds = raw?.propertyIds ?? [];
    const propertyDetails = orderedIds
      .map((slug) => bySlug.get(slug))
      .filter((p): p is PhbWeaponProperty => !!p)
      .map((p) => ({
        slug: p.slug,
        name: p.name,
        description: p.description,
      }));

    const range =
      raw?.range && (raw.range.normal != null || raw.range.max != null)
        ? {
            normal: raw.range.normal ?? null,
            max: raw.range.max ?? null,
          }
        : null;

    return {
      slug: row.item.slug,
      name: row.item.name,
      category: row.category,
      damage: row.damage,
      damageType: row.damageType,
      versatileDamage: raw?.versatileDamage ?? null,
      cost: row.item.cost,
      weight: row.item.weight,
      range,
      propertyDetails,
      mastery: mastery
        ? {
            slug: mastery.slug,
            name: mastery.name,
            description: mastery.description,
          }
        : null,
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
      costText: row.costText,
      weight: row.weight,
    };
  }
}
