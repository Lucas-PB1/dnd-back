import type { DataSource } from 'typeorm';
import { PhbDamageType } from '@entities/reference/phb-damage-type.entity';

export async function loadDamageTypeLabels(
  dataSource: DataSource,
): Promise<ReadonlyMap<string, string>> {
  const rows = await dataSource.getRepository(PhbDamageType).find({
    order: { sortOrder: 'ASC' },
  });
  return new Map(rows.map((row) => [row.slug, row.labelPt]));
}
