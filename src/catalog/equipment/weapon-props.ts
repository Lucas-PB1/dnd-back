import { In, Repository } from 'typeorm';
import { PhbWeapon } from '@entities/equipment/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/equipment/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '@entities/equipment/phb-weapon-property.entity';

export type WeaponPropsJson = {
  propertyIds?: string[];
  masteryId?: string;
  secondaryMasteryId?: string;
  versatileDamage?: string;
  range?: { normal?: number; max?: number };

  reload?: number;
  [key: string]: unknown;
};

export function weaponPropsOf(row: PhbWeapon): WeaponPropsJson {
  return (row.item.properties ?? {}) as WeaponPropsJson;
}

/** Prefer coluna tipada; fallback jsonb legado. */
export function resolveWeaponMasterySlug(row: PhbWeapon): string | null {
  return row.mastery?.slug ?? weaponPropsOf(row).masteryId ?? null;
}

export function resolveWeaponSecondaryMasterySlug(
  row: PhbWeapon,
): string | null {
  return (
    row.secondaryMastery?.slug ??
    weaponPropsOf(row).secondaryMasteryId ??
    null
  );
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
    const primary = resolveWeaponMasterySlug(row);
    const secondary = resolveWeaponSecondaryMasterySlug(row);
    if (primary) slugs.add(primary);
    if (secondary) slugs.add(secondary);
  }
  if (slugs.size === 0) return new Map();
  const masteries = await masteryRepo.find({ where: { slug: In([...slugs]) } });
  return new Map(masteries.map((m) => [m.slug, m]));
}
