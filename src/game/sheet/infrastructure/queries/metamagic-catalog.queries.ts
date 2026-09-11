import { DataSource } from 'typeorm';
import { PhbMetamagic } from '@entities/class/phb-metamagic.entity';
import type { MetamagicCatalogRow } from '@game/combat/domain/sorcerer';

export async function loadMetamagicCatalog(
  dataSource: DataSource,
): Promise<MetamagicCatalogRow[]> {
  const rows = await dataSource.getRepository(PhbMetamagic).find({
    order: { sortOrder: 'ASC', slug: 'ASC' },
  });
  return rows.map((row) => ({
    slug: row.slug,
    name: row.name,
    description: row.description,
    cost: Number(row.cost),
    stacksWithOther: row.stacksWithOther,
  }));
}
