import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import {
  ClassResourceStateDto,
} from '@game/session/dto/core/character-state-response.dto';
import {
  resolveClassResourceMaxima,
  type ClassResourceMax,
} from '@game/session/domain/class-resources';
import { filterSpeciesResourceScheduleByChoices } from '@game/session/domain/filter-species-resources-by-option';
import { CAP6_PB_PLUS_STAGE_RESOURCE_SLUGS } from '@game/session/domain/transformation/cap6-resource-max';
import { riskDieFaces, riskDieLabel } from '@game/session/domain/risk-die';
import {
  psiEnergyDieFaces,
  psiEnergyDieLabel,
  superiorityDieFaces,
  superiorityDieLabel,
} from '@game/combat/domain/fighter';
import { loadMergedFeatureSchedules } from '@game/combat/infrastructure/feature-schedule.queries';
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
  loadThreadResourceSchedule,
} from '../../queries/class-resource-schedule.queries';
import {
  loadCharacterFeatSlugs,
  loadClassProgressionSnapshot,
  loadActiveItemSlugs,
} from '../../queries/class-resource-character.queries';
import { loadCharacterTransformation } from '../../queries/transformation-character.queries';
import { loadTransformationResourceOptionGates } from '../../queries/transformation-resource-option-gates';

export type { ClassResourceDbRow } from '../../queries/class-resource-schedule.queries';
export {
  loadClassResourceSchedule,
  loadSubclassResourceSchedule,
  loadSpeciesResourceSchedule,
  loadFeatResourceSchedule,
  loadItemResourceSchedule,
  loadHeritageResourceSchedule,
  loadThreadResourceSchedule,
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
  const featureSchedules = await loadMergedFeatureSchedules(
    dataSource,
    character.classSlug,
    character.subclassSlug,
  );
  const resources = await resolveClassResources(
    dataSource,
    character,
    featureSchedules,
  );
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
            dieFaces: superiorityDieFaces(character.level, featureSchedules),
            dieLabel: superiorityDieLabel(character.level, featureSchedules),
          }
        : isPsi
          ? {
              dieFaces: psiEnergyDieFaces(character.level, featureSchedules),
              dieLabel: psiEnergyDieLabel(character.level, featureSchedules),
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
  featureSchedules?: readonly import('@game/combat/domain/feature-schedule').FeatureScheduleBand[],
): Promise<ClassResourceMax[]> {
  const classRows = await loadClassResourceSchedule(
    dataSource,
    character.classSlug,
  );
  const subclassRows = character.subclassSlug
    ? await loadSubclassResourceSchedule(dataSource, character.subclassSlug)
    : [];
  const [speciesRowsRaw, speciesChoices, speciesGates, schedules] =
    await Promise.all([
      character.speciesSlug
        ? loadSpeciesResourceSchedule(dataSource, character.speciesSlug)
        : Promise.resolve([]),
      loadCharacterSpeciesChoices(dataSource, character.id),
      character.speciesSlug
        ? loadSpeciesResourceOptionGates(dataSource, character.speciesSlug)
        : Promise.resolve([]),
      featureSchedules != null
        ? Promise.resolve(featureSchedules)
        : loadMergedFeatureSchedules(
            dataSource,
            character.classSlug,
            character.subclassSlug,
          ),
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
  const threadRows = await loadThreadResourceSchedule(dataSource, character.id);
  const progression = await loadClassProgressionSnapshot(
    dataSource,
    character.classSlug,
    character.level,
  );
  const mods = computeAbilityModifiers(character.abilityScores);
  const proficiencyBonus = progression?.proficiencyBonus ?? 2;

  const transformation = await loadCharacterTransformation(
    dataSource,
    character.id,
  );
  let transformationMax: ClassResourceMax[] = [];
  if (transformation) {
    const transformationRowsRaw = await loadFeatResourceSchedule(dataSource, [
      transformation.slug,
    ]);
    const transformationGates = await loadTransformationResourceOptionGates(
      dataSource,
      transformation.slug,
    );
    const transformationRows = filterSpeciesResourceScheduleByChoices(
      transformationRowsRaw,
      transformationGates,
      transformation.choices,
    );
    transformationMax = resolveClassResourceMaxima({
      rows: transformationRows,
      level: transformation.stage,
      proficiencyBonus,
      abilityModifiers: mods,
      transformationStage: transformation.stage,
      proficiencyBonusPlusStageSlugs: CAP6_PB_PLUS_STAGE_RESOURCE_SLUGS,
      featureSchedules: schedules,
    });
  }

  const standardMax = resolveClassResourceMaxima({
    rows: [
      ...classRows,
      ...subclassRows,
      ...speciesRows,
      ...featRows,
      ...itemRows,
      ...heritageRows,
      ...threadRows,
    ],
    level: character.level,
    proficiencyBonus,
    abilityModifiers: mods,
    channelDivinityFromProgression: progression?.channelDivinity ?? null,
    featureSchedules: schedules,
  });

  const bySlug = new Map<string, ClassResourceMax>();
  for (const resource of standardMax) {
    bySlug.set(resource.slug, resource);
  }
  for (const resource of transformationMax) {
    bySlug.set(resource.slug, resource);
  }
  return [...bySlug.values()].sort((a, b) =>
    a.name.localeCompare(b.name, 'pt'),
  );
}
