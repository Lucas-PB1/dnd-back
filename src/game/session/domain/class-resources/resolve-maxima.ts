

import { resolveFormulaMax } from '../resource-max-formulas';
import {
  BARDIC_INSPIRATION_KEBAB_SLUG,
  BARDIC_INSPIRATION_SLUG,
  CHANNEL_DIVINITY_SLUG,
  LAY_ON_HANDS_SLUG,
} from '../resource-slugs';
import type { FeatureScheduleBand } from '@game/combat/domain/feature-schedule';
import type {
  AbilityMods,
  ClassResourceMax,
  ClassResourceScheduleRow,
} from './types';

export function resolveClassResourceMaxima(input: {
  rows: readonly ClassResourceScheduleRow[];
  level: number;
  proficiencyBonus: number;
  abilityModifiers: AbilityMods;
  channelDivinityFromProgression?: number | null;
  transformationStage?: number;
  featureSchedules: readonly FeatureScheduleBand[];
}): ClassResourceMax[] {
  const bySlug = new Map<string, ClassResourceScheduleRow[]>();
  for (const row of input.rows) {
    if (row.unlockLevel > input.level) continue;
    const list = bySlug.get(row.resourceSlug) ?? [];
    list.push(row);
    bySlug.set(row.resourceSlug, list);
  }

  const result: ClassResourceMax[] = [];
  for (const [slug, list] of bySlug) {
    list.sort((a, b) => b.unlockLevel - a.unlockLevel);
    const top = list[0];
    if (!top) continue;

    let max = resolveFormulaMax(
      top,
      input.level,
      input.proficiencyBonus,
      input.abilityModifiers,
      input.featureSchedules,
      input.transformationStage ?? 0,
    );

    if (
      slug === CHANNEL_DIVINITY_SLUG &&
      input.channelDivinityFromProgression != null
    ) {
      max = input.channelDivinityFromProgression;
    }

    if (slug === LAY_ON_HANDS_SLUG) {
      const LAY_ON_HANDS_HP_PER_LEVEL = 5;
      max = LAY_ON_HANDS_HP_PER_LEVEL * input.level;
    }

    if (max <= 0) continue;

    const recoverAllOnShort =
      top.recoverAllOnShort ||
      ((slug === BARDIC_INSPIRATION_SLUG ||
        slug === BARDIC_INSPIRATION_KEBAB_SLUG) &&
        input.level >= 5);

    result.push({
      slug,
      name: top.resourceName,
      max,
      recoverOneOnShort: top.recoverOneOnShort,
      recoverAllOnShort,
      recoverAllOnLong: top.recoverAllOnLong,
      recoverOnLongDice: top.recoverOnLongDice ?? null,
    });
  }

  return result.sort((a, b) => a.name.localeCompare(b.name, 'pt'));
}
