import { DataSource, In, LessThanOrEqual } from 'typeorm';
import { PhbEldritchInvocation } from '@entities/phb-eldritch-invocation.entity';
import { VPhbFeat } from '@entities/views/v-phb-feat.entity';
import type { EldritchInvocationCatalogRow } from '@game/combat/domain/warlock';

export async function loadEldritchInvocationCatalog(
  dataSource: DataSource,
): Promise<EldritchInvocationCatalogRow[]> {
  const rows = await dataSource.getRepository(PhbEldritchInvocation).find({
    order: { sortOrder: 'ASC', slug: 'ASC' },
  });
  return rows.map((row) => ({
    slug: row.slug,
    name: row.name,
    minLevel: row.minLevel,
    requiresPactSlug: row.requiresPactSlug,
    requiresInvocationSlug: row.requiresInvocationSlug,
    repeatable: row.repeatable,
  }));
}

export async function loadOriginFeatSlugs(
  dataSource: DataSource,
  slugs: readonly string[],
): Promise<Set<string>> {
  if (slugs.length === 0) return new Set();
  const rows = await dataSource.getRepository(VPhbFeat).find({
    where: { featSlug: In([...slugs]), categorySlug: 'origin' },
    select: ['featSlug'],
  });
  return new Set(rows.map((row) => row.featSlug));
}
