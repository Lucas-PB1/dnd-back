import type { DataSource } from 'typeorm';
import type { FeatureScheduleBand } from '../domain/feature-schedule';

type ScheduleSqlRow = {
  owner_slug: string;
  owner_kind: 'class' | 'subclass';
  feature_key: string;
  unlock_level: number;
  value_num: string | number;
};

/** Carrega todos os schedules (classe + subclasse) para o catálogo mecânico. */
export async function loadAllFeatureSchedules(
  dataSource: DataSource,
): Promise<{
  byClassSlug: ReadonlyMap<string, readonly FeatureScheduleBand[]>;
  bySubclassSlug: ReadonlyMap<string, readonly FeatureScheduleBand[]>;
}> {
  const raw: ScheduleSqlRow[] = await dataSource.query(
    `
    SELECT owner_slug, owner_kind, feature_key, unlock_level, value_num FROM (
      SELECT c.slug AS owner_slug, s.owner_kind, s.feature_key, s.unlock_level, s.value_num
      FROM rpg.phb_class_feature_schedule s
      JOIN rpg.phb_class c ON c.id = s.class_id
      WHERE s.owner_kind = 'class'
      UNION ALL
      SELECT sc.slug AS owner_slug, s.owner_kind, s.feature_key, s.unlock_level, s.value_num
      FROM rpg.phb_class_feature_schedule s
      JOIN rpg.phb_subclass sc ON sc.id = s.subclass_id
      WHERE s.owner_kind = 'subclass'
    ) q
    ORDER BY owner_slug, feature_key, unlock_level
    `,
  );

  const byClassSlug = new Map<string, FeatureScheduleBand[]>();
  const bySubclassSlug = new Map<string, FeatureScheduleBand[]>();

  for (const row of raw) {
    const band: FeatureScheduleBand = {
      featureKey: row.feature_key,
      unlockLevel: Number(row.unlock_level),
      valueNum: Number(row.value_num),
    };
    const target =
      row.owner_kind === 'class' ? byClassSlug : bySubclassSlug;
    const list = target.get(row.owner_slug);
    if (list) list.push(band);
    else target.set(row.owner_slug, [band]);
  }

  return { byClassSlug, bySubclassSlug };
}

function mapBandRows(
  raw: Omit<ScheduleSqlRow, 'owner_slug' | 'owner_kind'>[],
): FeatureScheduleBand[] {
  return raw.map((row) => ({
    featureKey: row.feature_key,
    unlockLevel: Number(row.unlock_level),
    valueNum: Number(row.value_num),
  }));
}

/** Schedules de uma classe (ficha / aggregate). */
export async function loadClassFeatureSchedules(
  dataSource: DataSource,
  classSlug: string | null | undefined,
): Promise<readonly FeatureScheduleBand[]> {
  if (!classSlug) return [];
  const raw: Omit<ScheduleSqlRow, 'owner_slug' | 'owner_kind'>[] =
    await dataSource.query(
      `
      SELECT s.feature_key, s.unlock_level, s.value_num
      FROM rpg.phb_class_feature_schedule s
      JOIN rpg.phb_class c ON c.id = s.class_id
      WHERE s.owner_kind = 'class' AND c.slug = $1
      ORDER BY s.feature_key, s.unlock_level
      `,
      [classSlug],
    );
  return mapBandRows(raw);
}

/** Schedules de uma subclasse. */
export async function loadSubclassFeatureSchedules(
  dataSource: DataSource,
  subclassSlug: string | null | undefined,
): Promise<readonly FeatureScheduleBand[]> {
  if (!subclassSlug) return [];
  const raw: Omit<ScheduleSqlRow, 'owner_slug' | 'owner_kind'>[] =
    await dataSource.query(
      `
      SELECT s.feature_key, s.unlock_level, s.value_num
      FROM rpg.phb_class_feature_schedule s
      JOIN rpg.phb_subclass sc ON sc.id = s.subclass_id
      WHERE s.owner_kind = 'subclass' AND sc.slug = $1
      ORDER BY s.feature_key, s.unlock_level
      `,
      [subclassSlug],
    );
  return mapBandRows(raw);
}

/** Classe + subclasse mesclados (ficha / aggregate). */
export async function loadMergedFeatureSchedules(
  dataSource: DataSource,
  classSlug: string | null | undefined,
  subclassSlug: string | null | undefined,
): Promise<readonly FeatureScheduleBand[]> {
  const [classBands, subclassBands] = await Promise.all([
    loadClassFeatureSchedules(dataSource, classSlug),
    loadSubclassFeatureSchedules(dataSource, subclassSlug),
  ]);
  return [...classBands, ...subclassBands];
}
