import { DataSource } from 'typeorm';
import {
  loadWeaponMasteryProgression,
  resolveSubclassUnlockLevel,
} from '@game/sheet/infrastructure/queries/class-meta.queries';
import {
  loadSubclassSpellcasting,
  maxSpellLevelForCharacter,
} from '@game/sheet/infrastructure/queries/spell-progression.queries';
import type { ClassProgressionMasteryRow } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';

export async function loadClassWeaponMasteryProgression(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassProgressionMasteryRow[]> {
  return loadWeaponMasteryProgression(dataSource, classSlug);
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
