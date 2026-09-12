import { DataSource } from 'typeorm';
import type { ClassResourceScheduleRow } from '@game/session/domain/class-resources';
import {
  mapResourceScheduleRow,
  type ClassResourceDbRow,
} from './resource-schedule.shared';

export async function loadFeatResourceSchedule(
  dataSource: DataSource,
  featSlugs: readonly string[],
): Promise<ClassResourceScheduleRow[]> {
  if (featSlugs.length === 0) return [];
  const fromEffects = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT rd.slug AS resource_slug,
            rd.name AS resource_name,
            e.unlock_level,
            er.max_formula::text AS max_formula,
            er.fixed_max,
            er.recover_one_on_short,
            er.recover_all_on_short,
            er.recover_all_on_long,
            er.recover_on_long_dice
     FROM rpg.phb_effect e
     JOIN rpg.phb_feat f ON f.id = e.owner_id AND e.owner_kind = 'feat'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     WHERE e.kind = 'grant_resource'
       AND f.slug = ANY($1::text[])
     ORDER BY rd.slug, e.unlock_level`,
    [featSlugs],
  );
  return fromEffects.map(mapResourceScheduleRow);
}
