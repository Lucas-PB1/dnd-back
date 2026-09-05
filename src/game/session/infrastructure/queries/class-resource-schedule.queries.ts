import { DataSource } from 'typeorm';
import type { ClassResourceScheduleRow } from '@game/session/domain/class-resources';
import {
  CURSEMARKED_BRACKET_BENEFITS,
  CURSEMARKED_GREATER_SACRIFICE,
} from '@game/session/domain/cursemarked-bracket';
import {
  mapResourceScheduleRow,
  type ClassResourceDbRow,
} from './resource-schedule.shared';

export type { ClassResourceDbRow } from './resource-schedule.shared';
export { loadFeatResourceSchedule } from './feat-resource-schedule.queries';

export async function loadClassResourceSchedule(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassResourceScheduleRow[]> {
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
     JOIN rpg.phb_class c ON c.id = e.owner_id AND e.owner_kind = 'class'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     WHERE e.kind = 'grant_resource'
       AND c.slug = $1
     ORDER BY rd.slug, e.unlock_level`,
    [classSlug],
  );
  return fromEffects.map(mapResourceScheduleRow);
}

export async function loadSubclassResourceSchedule(
  dataSource: DataSource,
  subclassSlug: string,
): Promise<ClassResourceScheduleRow[]> {
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
     JOIN rpg.phb_subclass s ON s.id = e.owner_id AND e.owner_kind = 'subclass'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     WHERE e.kind = 'grant_resource'
       AND s.slug = $1
     ORDER BY rd.slug, e.unlock_level`,
    [subclassSlug],
  );
  return fromEffects.map(mapResourceScheduleRow);
}

export async function loadSpeciesResourceSchedule(
  dataSource: DataSource,
  speciesSlug: string,
): Promise<ClassResourceScheduleRow[]> {
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
     JOIN rpg.phb_species sp ON sp.id = e.owner_id AND e.owner_kind = 'species'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     WHERE e.kind = 'grant_resource'
       AND sp.slug = $1
     ORDER BY rd.slug, e.unlock_level`,
    [speciesSlug],
  );
  return fromEffects.map(mapResourceScheduleRow);
}

export async function loadItemResourceSchedule(
  dataSource: DataSource,
  itemSlugs: readonly string[],
): Promise<ClassResourceScheduleRow[]> {
  if (itemSlugs.length === 0) return [];
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
     JOIN rpg.phb_item i ON i.id = e.owner_id AND e.owner_kind = 'item'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     WHERE e.kind = 'grant_resource'
       AND i.slug = ANY($1::text[])
     ORDER BY rd.slug, e.unlock_level`,
    [itemSlugs],
  );
  return fromEffects.map(mapResourceScheduleRow);
}

/** Recursos de traços de herança GH — takes >= min_trait_takes do efeito. */
export async function loadHeritageResourceSchedule(
  dataSource: DataSource,
  characterId: string,
): Promise<ClassResourceScheduleRow[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<ClassResourceDbRow[]>(
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
     JOIN rpg.phb_heritage_trait ht
       ON ht.id = e.owner_id AND e.owner_kind = 'heritage'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     JOIN (
       SELECT trait_id, COUNT(*)::int AS take_count
       FROM rpg.player_character_heritage_trait
       WHERE character_id = $1::uuid
       GROUP BY trait_id
     ) picks ON picks.trait_id = ht.id
     WHERE e.kind = 'grant_resource'
       AND picks.take_count >= COALESCE(e.min_trait_takes, 1)
     ORDER BY rd.slug, e.unlock_level`,
    [characterId],
  );
  return rows.map(mapResourceScheduleRow);
}

/** Recursos de Character Thread — só milestones alcançados no thread ativo. */
export async function loadThreadResourceSchedule(
  dataSource: DataSource,
  characterId: string,
): Promise<ClassResourceScheduleRow[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<ClassResourceDbRow[]>(
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
     JOIN rpg.phb_character_thread t
       ON t.id = e.owner_id AND e.owner_kind = 'character_thread'
     JOIN rpg.phb_effect_resource er ON er.effect_id = e.id
     JOIN rpg.phb_resource_definition rd ON rd.id = er.resource_id
     JOIN rpg.player_character_thread pct
       ON pct.character_id = $1::uuid
      AND pct.status = 'active'
      AND pct.thread_slug = t.slug
     JOIN rpg.player_character_thread_milestone m
       ON m.character_thread_id = pct.id
     WHERE e.kind = 'grant_resource'
       AND (
         m.benefit_key = rd.slug
         OR (
           rd.slug = $2
           AND m.benefit_key = ANY($3::text[])
         )
       )
     ORDER BY rd.slug, e.unlock_level`,
    [characterId, CURSEMARKED_GREATER_SACRIFICE, [...CURSEMARKED_BRACKET_BENEFITS]],
  );
  return rows.map(mapResourceScheduleRow);
}
