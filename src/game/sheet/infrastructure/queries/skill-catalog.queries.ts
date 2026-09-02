import { DataSource } from 'typeorm';
import { PhbSkill } from '@entities/phb-skill.entity';
import { VPhbClassSkillChoice } from '@entities/views/v-phb-class-skill-choice.entity';

export async function skillExists(
  dataSource: DataSource,
  slug: string,
): Promise<boolean> {
  return dataSource.getRepository(PhbSkill).exists({ where: { slug } });
}

export async function loadClassSkillChoiceSlugs(
  dataSource: DataSource,
  classSlug: string,
): Promise<string[]> {
  const rows = await dataSource.getRepository(VPhbClassSkillChoice).find({
    where: { classSlug },
    select: ['skillSlug'],
  });
  return rows.map((row) => row.skillSlug);
}
