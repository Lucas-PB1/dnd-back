import { DataSource, Between, In, LessThanOrEqual, Like } from 'typeorm';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { sangromancyDescriptionSqlPattern } from '@game/spellcasting/domain/sangromancy/sangromancy-spells';

export async function loadSpellLevel(
  dataSource: DataSource,
  spellSlug: string,
): Promise<number | null> {
  const row = await dataSource.getRepository(VPhbSpell).findOne({
    where: { slug: spellSlug },
    select: ['level'],
  });
  return row?.level ?? null;
}

export async function spellOnClassList(
  dataSource: DataSource,
  params: {
    classSlug: string;
    spellSlug: string;
    spellLevel?: number;
  },
): Promise<boolean> {
  return dataSource.getRepository(VSpellByClass).exists({
    where: {
      classSlug: params.classSlug,
      spellSlug: params.spellSlug,
      ...(params.spellLevel !== undefined ? { spellLevel: params.spellLevel } : {}),
    },
  });
}

export async function spellOnAnyClassListUpToLevel(
  dataSource: DataSource,
  classSlugs: readonly string[],
  spellSlug: string,
  maxSpellLevel: number,
): Promise<boolean> {
  return dataSource.getRepository(VSpellByClass).exists({
    where: {
      classSlug: In([...classSlugs]),
      spellSlug,
      spellLevel: LessThanOrEqual(maxSpellLevel),
    },
  });
}

export async function sangromancySpellMatches(
  dataSource: DataSource,
  spellSlug: string,
  maxLevel: number,
): Promise<boolean> {
  return dataSource.getRepository(VPhbSpell).exists({
    where: {
      slug: spellSlug,
      level: Between(1, maxLevel),
      description: Like(sangromancyDescriptionSqlPattern()),
    },
  });
}

export async function wizardSchoolSpellMatches(
  dataSource: DataSource,
  spellSlug: string,
  maxLevel: number,
  schoolSlugs: readonly string[],
): Promise<boolean> {
  const onWizardList = await dataSource.getRepository(VSpellByClass).exists({
    where: { classSlug: 'wizard', spellSlug },
  });
  if (!onWizardList) return false;
  return dataSource.getRepository(VPhbSpell).exists({
    where: {
      slug: spellSlug,
      level: Between(1, maxLevel),
      schoolSlug: In([...schoolSlugs]),
    },
  });
}
