import { DataSource } from 'typeorm';
import { sangromancyDescriptionSqlPattern } from './sangromancy-spells';

export type SangromancySpellLevel = {
  slug: string;
  level: number;
};

export async function loadSangromancySpellSlugsAmong(
  dataSource: DataSource,
  spellSlugs: readonly string[],
): Promise<Set<string>> {
  if (spellSlugs.length === 0) return new Set();
  const rows = await dataSource.query<{ slug: string }[]>(
    `SELECT slug
     FROM rpg.phb_spell
     WHERE slug = ANY($1::text[])
       AND description LIKE $2`,
    [spellSlugs, sangromancyDescriptionSqlPattern()],
  );
  return new Set(rows.map((row) => row.slug));
}

export async function loadSangromancySpellLevelsUpTo(
  dataSource: DataSource,
  maxLevel: number,
): Promise<SangromancySpellLevel[]> {
  const rows = await dataSource.query<{ slug: string; level: number }[]>(
    `SELECT slug, level
     FROM rpg.phb_spell
     WHERE description LIKE $1
       AND level BETWEEN 1 AND $2
     ORDER BY level ASC, slug ASC`,
    [sangromancyDescriptionSqlPattern(), maxLevel],
  );
  return rows.map((row) => ({
    slug: row.slug,
    level: Number(row.level),
  }));
}
