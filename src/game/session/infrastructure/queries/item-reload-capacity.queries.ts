import { DataSource } from 'typeorm';
import { PhbItem } from '@entities/equipment/phb-item.entity';

export function parseItemReloadCapacity(
  properties: Record<string, unknown> | null | undefined,
): number {
  const reload = properties?.reload;
  return typeof reload === 'number' && Number.isFinite(reload) ? reload : 0;
}

export async function loadItemReloadCapacity(
  dataSource: DataSource,
  itemSlug: string,
): Promise<number> {
  if (!itemSlug) return 0;
  const row = await dataSource.getRepository(PhbItem).findOne({
    where: { slug: itemSlug },
    select: ['properties'],
  });
  return parseItemReloadCapacity(row?.properties ?? null);
}
