import { DataSource } from 'typeorm';
import type { SpeciesResourceOptionGate } from '@game/session/domain/filter-species-resources-by-option';


export async function loadTransformationResourceOptionGates(
  dataSource: DataSource,
  transformationSlug: string,
): Promise<SpeciesResourceOptionGate[]> {
  if (!transformationSlug) return [];
  const rows = await dataSource.query<
    {
      resource_slug: string;
      requires_option_key: string | null;
      requires_option_value: string | null;
    }[]
  >(
    `SELECT e.resource_slug,
            e.requires_option_key,
            e.requires_option_value
     FROM rpg.phb_class_economy_action e
     JOIN rpg.phb_feat f ON f.id = e.feat_id
     WHERE f.slug = $1
       AND e.resource_slug IS NOT NULL`,
    [transformationSlug],
  );
  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    requiresOptionKey: row.requires_option_key,
    requiresOptionValue: row.requires_option_value,
  }));
}
