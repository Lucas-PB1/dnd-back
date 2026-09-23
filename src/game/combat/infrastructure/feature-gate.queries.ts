import type { DataSource } from 'typeorm';
import { PhbFeatureGate } from '@entities/class/phb-feature-gate.entity';
import { PhbClassRef } from '@entities/class/phb-class-ref.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';

export async function loadSubclassFeatureGates(
  dataSource: DataSource,
  subclassSlug: string | null | undefined,
): Promise<ReadonlyMap<string, number>> {
  if (!subclassSlug) return new Map();
  const rows = await dataSource
    .getRepository(PhbFeatureGate)
    .createQueryBuilder('g')
    .innerJoin(PhbSubclassRef, 's', 's.id = g.subclass_id')
    .where('g.owner_kind = :ownerKind', { ownerKind: 'subclass' })
    .andWhere('s.slug = :subclassSlug', { subclassSlug })
    .getMany();
  return new Map(rows.map((row) => [row.gateKey, row.unlockLevel]));
}

export async function loadClassFeatureGates(
  dataSource: DataSource,
  classSlug: string | null | undefined,
): Promise<ReadonlyMap<string, number>> {
  if (!classSlug) return new Map();
  const rows = await dataSource
    .getRepository(PhbFeatureGate)
    .createQueryBuilder('g')
    .innerJoin(PhbClassRef, 'c', 'c.id = g.class_id')
    .where('g.owner_kind = :ownerKind', { ownerKind: 'class' })
    .andWhere('c.slug = :classSlug', { classSlug })
    .getMany();
  return new Map(rows.map((row) => [row.gateKey, row.unlockLevel]));
}

export function gateUnlock(
  gates: ReadonlyMap<string, number>,
  gateKey: string,
): number | null {
  return gates.get(gateKey) ?? null;
}
