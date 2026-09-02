import { DataSource } from 'typeorm';
import type { ClassResourceScheduleRow } from '@game/session/domain/class-resources';
import {
  CURSEMARKED_BRACKET_BENEFITS,
  CURSEMARKED_GREATER_SACRIFICE,
} from '@game/session/domain/cursemarked-bracket';

export type ClassResourceDbRow = {
  resource_slug: string;
  resource_name: string;
  unlock_level: number;
  max_formula: string;
  fixed_max: number | null;
  recover_one_on_short: boolean;
  recover_all_on_short: boolean;
  recover_all_on_long: boolean;
  recover_on_long_dice: string | null;
};

function mapResourceScheduleRow(
  row: ClassResourceDbRow,
): ClassResourceScheduleRow {
  return {
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
    recoverOnLongDice: row.recover_on_long_dice ?? null,
  };
}

function resourceScheduleSelect(grantAlias: string): string {
  return `
       rd.slug AS resource_slug,
       rd.name AS resource_name,
       ${grantAlias}.unlock_level,
       ${grantAlias}.max_formula::text AS max_formula,
       ${grantAlias}.fixed_max,
       ${grantAlias}.recover_one_on_short,
       ${grantAlias}.recover_all_on_short,
       ${grantAlias}.recover_all_on_long,
       ${grantAlias}.recover_on_long_dice`;
}

async function queryResourceSchedule(
  dataSource: DataSource,
  grantAlias: string,
  body: string,
  params: unknown[],
): Promise<ClassResourceScheduleRow[]> {
  const rows = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT ${resourceScheduleSelect(grantAlias)}
     FROM rpg.phb_resource_grant ${grantAlias}
     ${body}
     ORDER BY rd.slug, ${grantAlias}.unlock_level`,
    params,
  );
  return rows.map(mapResourceScheduleRow);
}

export async function loadClassResourceSchedule(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassResourceScheduleRow[]> {
  return queryResourceSchedule(
    dataSource,
    'cr',
    `JOIN rpg.phb_class c ON c.id = cr.owner_id AND cr.owner_kind = 'class'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = cr.resource_id
     WHERE c.slug = $1`,
    [classSlug],
  );
}

export async function loadSubclassResourceSchedule(
  dataSource: DataSource,
  subclassSlug: string,
): Promise<ClassResourceScheduleRow[]> {
  return queryResourceSchedule(
    dataSource,
    'sr',
    `JOIN rpg.phb_subclass s ON s.id = sr.owner_id AND sr.owner_kind = 'subclass'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = sr.resource_id
     WHERE s.slug = $1`,
    [subclassSlug],
  );
}

export async function loadSpeciesResourceSchedule(
  dataSource: DataSource,
  speciesSlug: string,
): Promise<ClassResourceScheduleRow[]> {
  return queryResourceSchedule(
    dataSource,
    'gr',
    `JOIN rpg.phb_species sp
       ON sp.id = gr.owner_id AND gr.owner_kind = 'species'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     WHERE sp.slug = $1`,
    [speciesSlug],
  );
}

export async function loadFeatResourceSchedule(
  dataSource: DataSource,
  featSlugs: readonly string[],
): Promise<ClassResourceScheduleRow[]> {
  if (featSlugs.length === 0) return [];
  return queryResourceSchedule(
    dataSource,
    'gr',
    `JOIN rpg.phb_feat f
       ON f.id = gr.owner_id AND gr.owner_kind = 'feat'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     WHERE f.slug = ANY($1::text[])`,
    [featSlugs],
  );
}

export async function loadItemResourceSchedule(
  dataSource: DataSource,
  itemSlugs: readonly string[],
): Promise<ClassResourceScheduleRow[]> {
  if (itemSlugs.length === 0) return [];
  return queryResourceSchedule(
    dataSource,
    'gr',
    `JOIN rpg.phb_item i
       ON i.id = gr.owner_id AND gr.owner_kind = 'item'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     WHERE i.slug = ANY($1::text[])`,
    [itemSlugs],
  );
}

/** Recursos de traços de herança GH — exige takes >= min_trait_takes do grant. */
export async function loadHeritageResourceSchedule(
  dataSource: DataSource,
  characterId: string,
): Promise<ClassResourceScheduleRow[]> {
  if (!characterId) return [];
  return queryResourceSchedule(
    dataSource,
    'gr',
    `JOIN rpg.phb_heritage_trait ht
       ON ht.id = gr.owner_id
      AND gr.owner_kind = 'heritage'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     JOIN (
       SELECT trait_id, COUNT(*)::int AS take_count
       FROM rpg.player_character_heritage_trait
       WHERE character_id = $1::uuid
       GROUP BY trait_id
     ) picks ON picks.trait_id = ht.id
     WHERE picks.take_count >= COALESCE(gr.min_trait_takes, 1)`,
    [characterId],
  );
}

/** Recursos de Character Thread — só milestones alcançados no thread ativo. */
export async function loadThreadResourceSchedule(
  dataSource: DataSource,
  characterId: string,
): Promise<ClassResourceScheduleRow[]> {
  if (!characterId) return [];
  return queryResourceSchedule(
    dataSource,
    'gr',
    `JOIN rpg.phb_character_thread t
       ON t.id = gr.owner_id
      AND gr.owner_kind = 'character_thread'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     JOIN rpg.player_character_thread pct
       ON pct.character_id = $1::uuid
      AND pct.status = 'active'
      AND pct.thread_slug = t.slug
     JOIN rpg.player_character_thread_milestone m
       ON m.character_thread_id = pct.id
     WHERE m.benefit_key = rd.slug
        OR (
          rd.slug = $2
          AND m.benefit_key = ANY($3::text[])
        )`,
    [characterId, CURSEMARKED_GREATER_SACRIFICE, [...CURSEMARKED_BRACKET_BENEFITS]],
  );
}
