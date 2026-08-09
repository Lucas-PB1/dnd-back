import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import { ClassResourceStateDto } from '@game/session/dto';
import {
  resolveClassResourceMaxima,
  type ClassResourceMax,
  type ClassResourceScheduleRow,
} from '@game/session/domain/class-resources';
import { riskDieFaces, riskDieLabel } from '@game/session/domain/risk-die';
import {
  psiEnergyDieFaces,
  psiEnergyDieLabel,
  superiorityDieFaces,
  superiorityDieLabel,
} from '@game/combat/domain/fighter';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';

export type ClassResourceDbRow = {
  resource_slug: string;
  resource_name: string;
  unlock_level: number;
  max_formula: string;
  fixed_max: number | null;
  recover_one_on_short: boolean;
  recover_all_on_short: boolean;
  recover_all_on_long: boolean;
};

export async function buildClassResourceState(
  dataSource: DataSource,
  character: PlayerCharacter,
  state: PlayerCharacterState,
): Promise<ClassResourceStateDto[]> {
  const resources = await resolveClassResources(dataSource, character);
  const used = state.resourcesUsed ?? {};
  return resources.map((resource) => {
    const spent = used[resource.slug] ?? 0;
    const isRisk = resource.slug === 'risk';
    const isSuperiority = resource.slug === 'superiority-dice';
    const isPsi =
      resource.slug === 'psi-energy-dice' ||
      resource.slug === 'soulknife-psi-dice';
    const dieExtras = isRisk
      ? {
          dieFaces: riskDieFaces(character.level),
          dieLabel: riskDieLabel(character.level),
        }
      : isSuperiority
        ? {
            dieFaces: superiorityDieFaces(character.level),
            dieLabel: superiorityDieLabel(character.level),
          }
        : isPsi
          ? {
              dieFaces: psiEnergyDieFaces(character.level),
              dieLabel: psiEnergyDieLabel(character.level),
            }
          : {};
    return {
      slug: resource.slug,
      name: resource.name,
      max: resource.max,
      used: spent,
      remaining: Math.max(0, resource.max - spent),
      ...dieExtras,
    };
  });
}

export async function resolveClassResources(
  dataSource: DataSource,
  character: PlayerCharacter,
): Promise<ClassResourceMax[]> {
  const classRows = await loadClassResourceSchedule(
    dataSource,
    character.classSlug,
  );
  const subclassRows = character.subclassSlug
    ? await loadSubclassResourceSchedule(dataSource, character.subclassSlug)
    : [];
  const speciesRows = await loadSpeciesResourceSchedule(
    dataSource,
    character.speciesSlug,
  );
  const featSlugs = await loadCharacterFeatSlugs(dataSource, character.id);
  const featRows =
    featSlugs.length > 0
      ? await loadFeatResourceSchedule(dataSource, featSlugs)
      : [];
  const itemSlugs = await loadActiveItemSlugs(dataSource, character.id);
  const itemRows =
    itemSlugs.length > 0
      ? await loadItemResourceSchedule(dataSource, itemSlugs)
      : [];
  const progression = await loadClassProgressionSnapshot(
    dataSource,
    character.classSlug,
    character.level,
  );
  const mods = computeAbilityModifiers(character.abilityScores);

  return resolveClassResourceMaxima({
    rows: [
      ...classRows,
      ...subclassRows,
      ...speciesRows,
      ...featRows,
      ...itemRows,
    ],
    level: character.level,
    proficiencyBonus: progression?.proficiencyBonus ?? 2,
    abilityModifiers: mods,
    channelDivinityFromProgression: progression?.channelDivinity ?? null,
  });
}

export async function loadCharacterFeatSlugs(
  dataSource: DataSource,
  characterId: string,
): Promise<string[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<{ feat_slug: string }[]>(
    `SELECT DISTINCT feat_slug
     FROM rpg.player_character_feat
     WHERE character_id = $1
     ORDER BY feat_slug`,
    [characterId],
  );
  return rows.map((row) => row.feat_slug);
}

export async function loadClassProgressionSnapshot(
  dataSource: DataSource,
  classSlug: string,
  level: number,
): Promise<{
  proficiencyBonus: number;
  channelDivinity: number | null;
} | null> {
  const rows = await dataSource.query<
    { proficiency_bonus: number; channel_divinity: number | null }[]
  >(
    `SELECT proficiency_bonus, channel_divinity
     FROM rpg.v_phb_class_progression
     WHERE class_slug = $1 AND level = $2
     LIMIT 1`,
    [classSlug, level],
  );
  const row = rows[0];
  if (!row) return null;
  return {
    proficiencyBonus: row.proficiency_bonus,
    channelDivinity: row.channel_divinity,
  };
}

export async function loadClassResourceSchedule(
  dataSource: DataSource,
  classSlug: string,
): Promise<ClassResourceScheduleRow[]> {
  const rows = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT
       rd.slug AS resource_slug,
       rd.name AS resource_name,
       cr.unlock_level,
       cr.max_formula::text AS max_formula,
       cr.fixed_max,
       cr.recover_one_on_short,
       cr.recover_all_on_short,
       cr.recover_all_on_long
     FROM rpg.phb_resource_grant cr
     JOIN rpg.phb_class c ON c.id = cr.owner_id AND cr.owner_kind = 'class'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = cr.resource_id
     WHERE c.slug = $1
     ORDER BY rd.slug, cr.unlock_level`,
    [classSlug],
  );

  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
  }));
}

export async function loadSubclassResourceSchedule(
  dataSource: DataSource,
  subclassSlug: string,
): Promise<ClassResourceScheduleRow[]> {
  const rows = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT
       rd.slug AS resource_slug,
       rd.name AS resource_name,
       sr.unlock_level,
       sr.max_formula::text AS max_formula,
       sr.fixed_max,
       sr.recover_one_on_short,
       sr.recover_all_on_short,
       sr.recover_all_on_long
     FROM rpg.phb_resource_grant sr
     JOIN rpg.phb_subclass s ON s.id = sr.owner_id AND sr.owner_kind = 'subclass'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = sr.resource_id
     WHERE s.slug = $1
     ORDER BY rd.slug, sr.unlock_level`,
    [subclassSlug],
  );

  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
  }));
}

export async function loadSpeciesResourceSchedule(
  dataSource: DataSource,
  speciesSlug: string,
): Promise<ClassResourceScheduleRow[]> {
  const rows = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT
       rd.slug AS resource_slug,
       rd.name AS resource_name,
       gr.unlock_level,
       gr.max_formula::text AS max_formula,
       gr.fixed_max,
       gr.recover_one_on_short,
       gr.recover_all_on_short,
       gr.recover_all_on_long
     FROM rpg.phb_resource_grant gr
     JOIN rpg.phb_species sp
       ON sp.id = gr.owner_id AND gr.owner_kind = 'species'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     WHERE sp.slug = $1
     ORDER BY rd.slug, gr.unlock_level`,
    [speciesSlug],
  );

  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
  }));
}

export async function loadFeatResourceSchedule(
  dataSource: DataSource,
  featSlugs: readonly string[],
): Promise<ClassResourceScheduleRow[]> {
  if (featSlugs.length === 0) return [];
  const rows = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT
       rd.slug AS resource_slug,
       rd.name AS resource_name,
       gr.unlock_level,
       gr.max_formula::text AS max_formula,
       gr.fixed_max,
       gr.recover_one_on_short,
       gr.recover_all_on_short,
       gr.recover_all_on_long
     FROM rpg.phb_resource_grant gr
     JOIN rpg.phb_feat f
       ON f.id = gr.owner_id AND gr.owner_kind = 'feat'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     WHERE f.slug = ANY($1::text[])
     ORDER BY rd.slug, gr.unlock_level`,
    [featSlugs],
  );

  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
  }));
}

/** Itens equipados (+ sintonizados se exigir) e charms anexados a armas equipadas. */
export async function loadActiveItemSlugs(
  dataSource: DataSource,
  characterId: string,
): Promise<string[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<{ item_slug: string }[]>(
    `SELECT DISTINCT item_slug FROM (
       SELECT pci.item_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item i ON i.slug = pci.item_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND (
           COALESCE((i.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attuned = true
         )
       UNION ALL
       SELECT pci.attached_charm_slug AS item_slug
       FROM rpg.player_character_item pci
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.attached_charm_slug IS NOT NULL
     ) active
     ORDER BY item_slug`,
    [characterId],
  );
  return rows.map((row) => row.item_slug);
}

export async function loadItemResourceSchedule(
  dataSource: DataSource,
  itemSlugs: readonly string[],
): Promise<ClassResourceScheduleRow[]> {
  if (itemSlugs.length === 0) return [];
  const rows = await dataSource.query<ClassResourceDbRow[]>(
    `SELECT
       rd.slug AS resource_slug,
       rd.name AS resource_name,
       gr.unlock_level,
       gr.max_formula::text AS max_formula,
       gr.fixed_max,
       gr.recover_one_on_short,
       gr.recover_all_on_short,
       gr.recover_all_on_long
     FROM rpg.phb_resource_grant gr
     JOIN rpg.phb_item i
       ON i.id = gr.owner_id AND gr.owner_kind = 'item'::rpg.resource_owner_kind
     JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
     WHERE i.slug = ANY($1::text[])
     ORDER BY rd.slug, gr.unlock_level`,
    [itemSlugs],
  );

  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
  }));
}
