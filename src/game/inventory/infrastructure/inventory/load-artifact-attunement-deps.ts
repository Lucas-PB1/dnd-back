import { DataSource, Repository } from 'typeorm';
import { DmgArtifactRandomProperty } from '../dmg-artifact-random-property.entity';
import type {
  ArtifactRandomEffect,
  ArtifactRandomTableRow,
} from '@game/inventory/domain/artifact/artifact-instance.types';

export async function loadArtifactRandomRows(
  artifactRandomProperties: Repository<DmgArtifactRandomProperty>,
): Promise<ArtifactRandomTableRow[]> {
  const rows = await artifactRandomProperties.find();
  return rows.map((row) => ({
    kind: row.kind,
    rollMin: row.rollMin,
    rollMax: row.rollMax,
    slug: row.slug,
    summaryPt: row.summaryPt,
    effect: row.effect as ArtifactRandomEffect,
  }));
}

export async function loadSpellPicker(
  dataSource: DataSource,
): Promise<(level: number, rng: () => number) => string | null> {
  const rows = await dataSource.query<{ slug: string; level: number }[]>(
    `SELECT slug, level FROM rpg.v_phb_spell`,
  );
  const byLevel = new Map<number, string[]>();
  for (const row of rows) {
    const level = Number(row.level);
    const list = byLevel.get(level) ?? [];
    list.push(row.slug);
    byLevel.set(level, list);
  }
  return (level, rng) => {
    const list = byLevel.get(level) ?? [];
    if (list.length === 0) return null;
    return list[Math.floor(rng() * list.length)] ?? null;
  };
}
