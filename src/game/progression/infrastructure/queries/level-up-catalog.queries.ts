import { DataSource } from 'typeorm';
import { PhbClassFeature } from '@entities/class/phb-class-feature.entity';
import { PhbClassProgression } from '@entities/class/phb-class-progression.entity';
import { VPhbSubclassMechanics } from '@entities/views/v-phb-subclass-mechanics.entity';
import {
  loadWeaponMasteryProgression,
  resolveSubclassUnlockLevel,
} from '@game/sheet/infrastructure/queries/class-meta.queries';
import {
  loadSubclassSpellcasting,
  maxSpellLevelForCharacter,
} from '@game/sheet/infrastructure/queries/spell-progression.queries';
import type { ClassProgressionMasteryRow } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';

export type LevelUpFeatureUnlockRow = {
  name: string;
  description: string;
  level: number;
  source: 'class' | 'subclass';
  optionKey?: string | null;
};

export async function loadClassWeaponMasteryProgression(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassProgressionMasteryRow[]> {
  return loadWeaponMasteryProgression(dataSource, classSlug);
}

export async function loadAsiOrFeatLevels(
  dataSource: DataSource,
  classSlug: string,
): Promise<number[]> {
  const rows = await dataSource.getRepository(PhbClassProgression).find({
    where: { klass: { slug: classSlug }, asiOrFeat: true },
    order: { level: 'ASC' },
    select: ['level'],
  });
  return rows.map((row) => row.level);
}

export async function loadSubclassUnlockLevel(
  dataSource: DataSource,
  classSlug: string,
): Promise<number> {
  return resolveSubclassUnlockLevel(dataSource, classSlug);
}

export async function loadSubclassSpellListClassSlug(
  dataSource: DataSource,
  subclassSlug: string | null,
): Promise<string | null> {
  const info = await loadSubclassSpellcasting(dataSource, subclassSlug);
  return info?.spellListClassSlug ?? null;
}

export async function loadMaxSpellLevelForCharacter(
  dataSource: DataSource,
  classSlug: string,
  level: number,
  subclassSlug: string | null,
): Promise<number> {
  return maxSpellLevelForCharacter(dataSource, classSlug, level, subclassSlug);
}

export async function loadClassFeaturesAtLevel(
  dataSource: DataSource,
  classSlug: string,
  level: number,
): Promise<LevelUpFeatureUnlockRow[]> {
  const rows = await dataSource.getRepository(PhbClassFeature).find({
    where: { klass: { slug: classSlug }, level },
    relations: ['klass'],
    order: { name: 'ASC' },
  });
  return rows.map((row) => ({
    name: row.name,
    description: row.description,
    level: row.level,
    source: 'class' as const,
  }));
}

export async function loadSubclassFeaturesAtLevel(
  dataSource: DataSource,
  subclassSlug: string | null,
  level: number,
): Promise<LevelUpFeatureUnlockRow[]> {
  if (!subclassSlug) return [];
  const rows = await dataSource.getRepository(VPhbSubclassMechanics).find({
    where: { subclassSlug, featureLevel: level },
    order: { featureName: 'ASC' },
  });
  return rows.map((row) => ({
    name: row.featureName,
    description: row.featureDescription,
    level: row.featureLevel,
    source: 'subclass' as const,
    optionKey: row.optionKey,
  }));
}
