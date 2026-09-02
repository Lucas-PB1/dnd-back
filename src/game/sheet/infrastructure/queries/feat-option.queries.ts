import { DataSource, In } from 'typeorm';
import { ClassProficienciesQuery } from '@catalog/classes/queries/class-proficiencies.query';
import { PhbFightingStyle } from '@entities/phb-fighting-style.entity';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbSkill } from '@entities/phb-skill.entity';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';

export async function loadClassSavingThrowSlugs(
  proficiencies: ClassProficienciesQuery,
  classSlug: string,
): Promise<string[]> {
  const row = await proficiencies.forClassSlug(classSlug);
  return row.savingThrowSlugs;
}

export async function loadClassFightingStyleSlugs(
  proficiencies: ClassProficienciesQuery,
  classSlug: string,
): Promise<string[]> {
  const row = await proficiencies.forClassSlug(classSlug);
  return row.fightingStyleSlugs;
}

export async function fightingStyleExists(
  dataSource: DataSource,
  slug: string,
): Promise<boolean> {
  return dataSource.getRepository(PhbFightingStyle).exists({ where: { slug } });
}

export async function isSkillOrToolSlug(
  dataSource: DataSource,
  slug: string,
): Promise<boolean> {
  const skillRepo = dataSource.getRepository(PhbSkill);
  if (await skillRepo.exists({ where: { slug } })) return true;
  return dataSource.getRepository(PhbItem).exists({
    where: { slug, itemType: 'tool' },
  });
}

export async function featSpellMatchesRitualLevel(
  dataSource: DataSource,
  spellSlug: string,
  level: number,
): Promise<boolean> {
  return dataSource.getRepository(VPhbSpell).exists({
    where: { slug: spellSlug, level, ritual: true },
  });
}

export async function featSpellMatchesSchool(
  dataSource: DataSource,
  spellSlug: string,
  schoolSlugs: readonly string[],
  maxLevel: number | null,
): Promise<boolean> {
  const repo = dataSource.getRepository(VPhbSpell);
  if (maxLevel === null) {
    const row = await repo.findOne({
      where: { slug: spellSlug, schoolSlug: In([...schoolSlugs]) },
      select: ['level'],
    });
    return row != null && row.level >= 1;
  }
  return repo.exists({
    where: {
      slug: spellSlug,
      level: maxLevel,
      schoolSlug: In([...schoolSlugs]),
    },
  });
}

export async function featSpellMatchesExactLevel(
  dataSource: DataSource,
  spellSlug: string,
  level: number,
): Promise<boolean> {
  return dataSource.getRepository(VPhbSpell).exists({
    where: { slug: spellSlug, level },
  });
}
