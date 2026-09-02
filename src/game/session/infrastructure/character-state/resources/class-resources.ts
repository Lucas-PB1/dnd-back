import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import { ClassResourceStateDto } from '@game/session/dto';
import {
  resolveClassResourceMaxima,
  type ClassResourceMax,
} from '@game/session/domain/class-resources';
import { filterSpeciesResourceScheduleByChoices } from '@game/session/domain/filter-species-resources-by-option';
import { riskDieFaces, riskDieLabel } from '@game/session/domain/risk-die';
import {
  psiEnergyDieFaces,
  psiEnergyDieLabel,
  superiorityDieFaces,
  superiorityDieLabel,
} from '@game/combat/domain/fighter';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import {
  loadCharacterSpeciesChoices,
  loadSpeciesResourceOptionGates,
} from './species-resource-option-gates';
import {
  loadClassResourceSchedule,
  loadSubclassResourceSchedule,
  loadSpeciesResourceSchedule,
  loadFeatResourceSchedule,
  loadItemResourceSchedule,
  loadHeritageResourceSchedule,
} from '../../queries/class-resource-schedule.queries';
import {
  loadCharacterFeatSlugs,
  loadClassProgressionSnapshot,
  loadActiveItemSlugs,
} from '../../queries/class-resource-character.queries';

export type { ClassResourceDbRow } from '../../queries/class-resource-schedule.queries';
export {
  loadClassResourceSchedule,
  loadSubclassResourceSchedule,
  loadSpeciesResourceSchedule,
  loadFeatResourceSchedule,
  loadItemResourceSchedule,
  loadHeritageResourceSchedule,
} from '../../queries/class-resource-schedule.queries';
export {
  loadCharacterFeatSlugs,
  loadClassProgressionSnapshot,
  loadActiveItemSlugs,
} from '../../queries/class-resource-character.queries';

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
  const [speciesRowsRaw, speciesChoices, speciesGates] = await Promise.all([
    character.speciesSlug
      ? loadSpeciesResourceSchedule(dataSource, character.speciesSlug)
      : Promise.resolve([]),
    loadCharacterSpeciesChoices(dataSource, character.id),
    character.speciesSlug
      ? loadSpeciesResourceOptionGates(dataSource, character.speciesSlug)
      : Promise.resolve([]),
  ]);
  const speciesRows = filterSpeciesResourceScheduleByChoices(
    speciesRowsRaw,
    speciesGates,
    speciesChoices,
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
  const heritageRows = await loadHeritageResourceSchedule(
    dataSource,
    character.id,
  );
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
      ...heritageRows,
    ],
    level: character.level,
    proficiencyBonus: progression?.proficiencyBonus ?? 2,
    abilityModifiers: mods,
    channelDivinityFromProgression: progression?.channelDivinity ?? null,
  });
}
