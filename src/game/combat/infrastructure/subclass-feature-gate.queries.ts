import type { DataSource } from 'typeorm';
import { PhbSubclass } from '../../../entities/phb-subclass.entity';
import { PhbSubclassFeatureGate } from '../../../entities/phb-subclass-feature-gate.entity';

export async function loadSubclassFeatureGates(
  dataSource: DataSource,
  subclassSlug: string | null | undefined,
): Promise<ReadonlyMap<string, number>> {
  if (!subclassSlug) return new Map();
  const rows = await dataSource
    .getRepository(PhbSubclassFeatureGate)
    .createQueryBuilder('g')
    .innerJoin(PhbSubclass, 's', 's.id = g.subclass_id')
    .where('s.slug = :subclassSlug', { subclassSlug })
    .getMany();
  return new Map(rows.map((row) => [row.gateKey, row.unlockLevel]));
}

export function gateUnlock(
  gates: ReadonlyMap<string, number>,
  gateKey: string,
): number | null {
  return gates.get(gateKey) ?? null;
}
