/**
 * Resolve máximos de recursos de classe (PHB 2024).
 * Cotas vêm de `phb_resource_grant` + `phb_class_progression.channel_divinity`.
 * Tabelas nível→quantidade: [`resource-max-formulas.ts`](../resource-max-formulas.ts).
 */

import { resolveFormulaMax } from '../resource-max-formulas';
import {
  BARDIC_INSPIRATION_KEBAB_SLUG,
  BARDIC_INSPIRATION_SLUG,
  CHANNEL_DIVINITY_SLUG,
  LAY_ON_HANDS_SLUG,
} from '../resource-slugs';
import type {
  AbilityMods,
  ClassResourceMax,
  ClassResourceScheduleRow,
} from './types';

/** Maior cota desbloqueada ≤ nível atual por slug. */
export function resolveClassResourceMaxima(input: {
  rows: readonly ClassResourceScheduleRow[];
  level: number;
  proficiencyBonus: number;
  abilityModifiers: AbilityMods;
  /** Sobrescreve max de channelDivinity (coluna de progressão). */
  channelDivinityFromProgression?: number | null;
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
    );

    if (
      slug === CHANNEL_DIVINITY_SLUG &&
      input.channelDivinityFromProgression != null
    ) {
      max = input.channelDivinityFromProgression;
    }

    // Mãos Consagradas do Paladino: reserva de cura = 5 × nível (PHB).
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
