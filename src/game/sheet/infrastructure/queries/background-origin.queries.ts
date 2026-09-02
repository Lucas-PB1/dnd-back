import { DataSource } from 'typeorm';
import { VPhbBackgroundLanguage } from '@entities/views/v-phb-background-language.entity';
import { VPhbBackgroundSkill } from '@entities/views/v-phb-background-skill.entity';

export async function loadBackgroundSkillSlugs(
  dataSource: DataSource,
  backgroundSlug: string,
): Promise<string[]> {
  const rows = await dataSource.getRepository(VPhbBackgroundSkill).find({
    where: { backgroundSlug },
    select: ['skillSlug'],
    order: { skillSlug: 'ASC' },
  });
  return rows.map((row) => row.skillSlug);
}

export async function loadBackgroundLanguageSlugs(
  dataSource: DataSource,
  backgroundSlug: string,
): Promise<string[]> {
  const rows = await dataSource.getRepository(VPhbBackgroundLanguage).find({
    where: { backgroundSlug },
    select: ['languageSlug'],
    order: { languageSlug: 'ASC' },
  });
  return rows.map((row) => row.languageSlug);
}
