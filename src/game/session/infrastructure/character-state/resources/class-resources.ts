import { DataSource } from 'typeorm';
import { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import { computeAbilityModifiers } from '../../../../sheet/domain/stats/character-derived-stats';
import { ClassResourceStateDto } from '../../../dto/character-state.dto';
import {
  resolveClassResourceMaxima,
  type ClassResourceMax,
  type ClassResourceScheduleRow,
} from '../../../domain/class-resources';
import { riskDieFaces, riskDieLabel } from '../../../domain/risk-die';
import {
  psiEnergyDieFaces,
  psiEnergyDieLabel,
  superiorityDieFaces,
  superiorityDieLabel,
} from '../../../../combat/domain/fighter-features';
import { PlayerCharacterState } from '../../player-character-state.entity';

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
  const progression = await loadClassProgressionSnapshot(
    dataSource,
    character.classSlug,
    character.level,
  );
  const mods = computeAbilityModifiers(character.abilityScores);

  return resolveClassResourceMaxima({
    rows: [...classRows, ...subclassRows],
    level: character.level,
    proficiencyBonus: progression?.proficiencyBonus ?? 2,
    abilityModifiers: mods,
    channelDivinityFromProgression: progression?.channelDivinity ?? null,
  });
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
     FROM rpg.phb_class_resource cr
     JOIN rpg.phb_class c ON c.id = cr.class_id
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
     FROM rpg.phb_subclass_resource sr
     JOIN rpg.phb_subclass s ON s.id = sr.subclass_id
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
