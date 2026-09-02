import { DataSource } from 'typeorm';
import { PhbClassRef } from '@entities/phb-class-ref.entity';
import { VPhbClass } from '@entities/views/v-phb-class.entity';
import { PhbClassProgression } from '@entities/phb-class-progression.entity';
import type { ClassProgressionMasteryRow } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';

export async function resolveSubclassUnlockLevel(
  dataSource: DataSource,
  classSlug: string,
): Promise<number> {
  const row = await dataSource.getRepository(PhbClassRef).findOne({
    where: { slug: classSlug },
    select: ['subclassUnlockLevel'],
  });
  return row?.subclassUnlockLevel ?? 3;
}

export async function loadWeaponMasteryProgression(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassProgressionMasteryRow[]> {
  const rows = await dataSource.getRepository(PhbClassProgression).find({
    where: { klass: { slug: classSlug } },
    order: { level: 'ASC' },
  });
  return rows.map((row) => ({
    level: row.level,
    weaponMastery: row.weaponMastery,
  }));
}

export async function loadWeaponMasteryEligibility(
  dataSource: DataSource,
  classSlug: string,
): Promise<string | null> {
  const row = await dataSource.getRepository(VPhbClass).findOne({
    where: { classSlug },
    select: ['weaponMasteryEligibility'],
  });
  return row?.weaponMasteryEligibility ?? null;
}
