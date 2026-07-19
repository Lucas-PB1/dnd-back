import { In, Repository } from 'typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '../../entities/phb-weapon-property.entity';

export type WeaponPropsJson = {
  propertyIds?: string[];
  masteryId?: string;
  versatileDamage?: string;
  range?: { normal?: number; max?: number };
  [key: string]: unknown;
};

export function weaponPropsOf(row: PhbWeapon): WeaponPropsJson {
  return (row.item.properties ?? {}) as WeaponPropsJson;
}

export async function loadWeaponPropertyRows(
  rows: PhbWeapon[],
  propertyRepo: Repository<PhbWeaponProperty>,
): Promise<PhbWeaponProperty[]> {
  const slugs = new Set<string>();
  for (const row of rows) {
    for (const slug of weaponPropsOf(row).propertyIds ?? []) slugs.add(slug);
  }
  if (slugs.size === 0) return [];
  return propertyRepo.find({ where: { slug: In([...slugs]) } });
}

export async function loadWeaponMasteryBySlug(
  rows: PhbWeapon[],
  masteryRepo: Repository<PhbWeaponMastery>,
): Promise<Map<string, PhbWeaponMastery>> {
  const slugs = new Set<string>();
  for (const row of rows) {
    const id = weaponPropsOf(row).masteryId;
    if (id) slugs.add(id);
  }
  if (slugs.size === 0) return new Map();
  const masteries = await masteryRepo.find({ where: { slug: In([...slugs]) } });
  return new Map(masteries.map((m) => [m.slug, m]));
}
