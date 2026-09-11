import { DataSource } from 'typeorm';
import { PhbClassRef } from '@entities/phb-class-ref.entity';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import {
  isClassExpertiseOptionKey,
  type ClassExpertiseSlot,
} from '@game/sheet/domain/validation/class-options/class-expertise-slots';

export type ClassFeatureDefRow = { optionKey: string; unlockLevel: number };

async function loadClassId(
  dataSource: DataSource,
  classSlug: string,
): Promise<string | null> {
  const row = await dataSource.getRepository(PhbClassRef).findOne({
    where: { slug: classSlug },
    select: ['id'],
  });
  return row?.id ?? null;
}

export async function loadClassOptionDefs(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassFeatureDefRow[]> {
  const classId = await loadClassId(dataSource, classSlug);
  if (!classId) return [];
  const rows = await dataSource.getRepository(PhbOptionDef).find({
    where: { scope: 'class', ownerId: classId },
    select: ['optionKey', 'unlockLevel'],
    order: { unlockLevel: 'ASC', optionKey: 'ASC' },
  });
  return rows
    .filter((row) => !isClassExpertiseOptionKey(row.optionKey))
    .map((row) => ({
      optionKey: row.optionKey,
      unlockLevel: row.unlockLevel ?? 1,
    }));
}

/** Slots de Especialização (`expertiseSkill*`) da classe. */
export async function loadClassExpertiseSlots(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassExpertiseSlot[]> {
  const classId = await loadClassId(dataSource, classSlug);
  if (!classId) return [];
  const rows = await dataSource.getRepository(PhbOptionDef).find({
    where: { scope: 'class', ownerId: classId },
    select: ['optionKey', 'unlockLevel'],
    order: { unlockLevel: 'ASC', optionKey: 'ASC' },
  });
  return rows
    .filter((row) => isClassExpertiseOptionKey(row.optionKey))
    .map((row) => ({
      optionKey: row.optionKey,
      unlockLevel: row.unlockLevel ?? 1,
    }));
}

/**
 * Whitelist de perícias para expertise (ex.: erudição do Mago).
 * null = qualquer perícia já proficiente.
 */
export async function loadExpertiseSkillWhitelist(
  dataSource: DataSource,
  classSlug: string,
): Promise<string[] | null> {
  const classId = await loadClassId(dataSource, classSlug);
  if (!classId) return null;
  const rows = await dataSource
    .getRepository(PhbOptionValue)
    .createQueryBuilder('v')
    .select('DISTINCT v.value_id', 'valueId')
    .where('v.scope = :scope', { scope: 'class' })
    .andWhere('v.owner_id = :ownerId', { ownerId: classId })
    .andWhere('v.option_key ~ :pattern', { pattern: '^expertiseSkill[0-9]+$' })
    .orderBy('v.value_id', 'ASC')
    .getRawMany<{ valueId: string }>();
  if (rows.length === 0) return null;
  return rows.map((row) => row.valueId);
}

export async function classOptionValueExists(
  dataSource: DataSource,
  classSlug: string,
  optionKey: string,
  valueId: string,
): Promise<boolean> {
  const classId = await loadClassId(dataSource, classSlug);
  if (!classId) return false;
  return dataSource.getRepository(PhbOptionValue).exists({
    where: {
      scope: 'class',
      ownerId: classId,
      optionKey,
      valueId,
    },
  });
}

export async function loadSubclassOptionKeysAtLevel(
  dataSource: DataSource,
  subclassId: string,
  level: number,
): Promise<string[]> {
  const rows = await dataSource
    .getRepository(PhbOptionDef)
    .createQueryBuilder('def')
    .select('DISTINCT def.option_key', 'optionKey')
    .where('def.scope = :scope', { scope: 'subclass' })
    .andWhere('def.owner_id = :ownerId', { ownerId: subclassId })
    .andWhere('COALESCE(def.unlock_level, 1) <= :level', { level })
    .orderBy('def.option_key', 'ASC')
    .getRawMany<{ optionKey: string }>();
  return rows.map((row) => row.optionKey);
}

export type SubclassOptionSlotRow = {
  optionKey: string;
  label: string;
  unlockLevel: number;
};

/** Opções de subclasse que desbloqueiam exatamente neste nível. */
export async function loadSubclassOptionSlotsNewAtLevel(
  dataSource: DataSource,
  subclassId: string,
  level: number,
): Promise<SubclassOptionSlotRow[]> {
  const rows = await dataSource.getRepository(PhbOptionDef).find({
    where: { scope: 'subclass', ownerId: subclassId, unlockLevel: level },
    select: ['optionKey', 'label', 'unlockLevel'],
    order: { sortOrder: 'ASC', optionKey: 'ASC' },
  });
  return rows.map((row) => ({
    optionKey: row.optionKey,
    label: row.label?.trim() || row.optionKey,
    unlockLevel: row.unlockLevel ?? level,
  }));
}

export async function subclassOptionValueType(
  dataSource: DataSource,
  subclassId: string,
  optionKey: string,
): Promise<string | null> {
  const row = await dataSource.getRepository(PhbOptionDef).findOne({
    where: { scope: 'subclass', ownerId: subclassId, optionKey },
    select: ['valueType'],
  });
  return row?.valueType ?? null;
}

export type WeaponMasteryPieceRow = {
  slug: string;
  name: string;
  category: string;
  damage: string | null;
  damageType: string | null;
  properties: Record<string, unknown> | null;
  masterySlug: string | null;
};

export async function loadWeaponMasteryPiece(
  dataSource: DataSource,
  weaponSlug: string,
): Promise<WeaponMasteryPieceRow | null> {
  const item = await dataSource.getRepository(PhbItem).findOne({
    where: { slug: weaponSlug },
    select: ['id', 'slug', 'name', 'properties'],
  });
  if (!item) return null;

  const weapon = await dataSource.getRepository(PhbWeapon).findOne({
    where: { itemId: item.id },
    select: ['category', 'damage', 'damageType', 'masteryId'],
  });
  if (!weapon) return null;

  let masterySlug: string | null = null;
  if (weapon.masteryId) {
    const mastery = await dataSource.getRepository(PhbWeaponMastery).findOne({
      where: { id: weapon.masteryId },
      select: ['slug'],
    });
    masterySlug = mastery?.slug ?? null;
  }

  return {
    slug: item.slug,
    name: item.name,
    category: weapon.category,
    damage: weapon.damage,
    damageType: weapon.damageType,
    properties: item.properties,
    masterySlug,
  };
}
