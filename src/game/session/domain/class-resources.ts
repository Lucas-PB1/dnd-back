/**
 * Resolve máximos e recuperação de recursos de classe (PHB 2024).
 * Cotas vêm de `phb_class_resource` + `phb_class_progression.channel_divinity`.
 * Tabelas nível→quantidade: [`resource-max-formulas.ts`](./resource-max-formulas.ts).
 */

import { resolveFormulaMax } from './resource-max-formulas';

export type ResourceMaxFormula =
  | 'fixed'
  | 'proficiency_bonus'
  | 'charisma_mod'
  | 'wisdom_mod'
  | 'constitution_mod'
  | 'intelligence_mod'
  | 'level'
  | 'level_plus_one'
  | string;

export type ClassResourceScheduleRow = {
  resourceSlug: string;
  resourceName: string;
  unlockLevel: number;
  maxFormula: ResourceMaxFormula;
  fixedMax: number | null;
  recoverOneOnShort: boolean;
  recoverAllOnShort: boolean;
  recoverAllOnLong: boolean;
};

export type ClassResourceMax = {
  slug: string;
  name: string;
  max: number;
  recoverOneOnShort: boolean;
  recoverAllOnShort: boolean;
  recoverAllOnLong: boolean;
};

export type AbilityMods = {
  forca: number;
  destreza: number;
  constituicao: number;
  inteligencia: number;
  sabedoria: number;
  carisma: number;
};

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
      slug === 'channelDivinity' &&
      input.channelDivinityFromProgression != null
    ) {
      max = input.channelDivinityFromProgression;
    }

    // Mãos Consagradas do Paladino: reserva de cura = 5 × nível (PHB).
    if (slug === 'layOnHands') {
      const LAY_ON_HANDS_HP_PER_LEVEL = 5;
      max = LAY_ON_HANDS_HP_PER_LEVEL * input.level;
    }

    if (max <= 0) continue;

    const recoverAllOnShort =
      top.recoverAllOnShort ||
      ((slug === 'bardicInspiration' || slug === 'bardic-inspiration') &&
        input.level >= 5);

    result.push({
      slug,
      name: top.resourceName,
      max,
      recoverOneOnShort: top.recoverOneOnShort,
      recoverAllOnShort,
      recoverAllOnLong: top.recoverAllOnLong,
    });
  }

  return result.sort((a, b) => a.name.localeCompare(b.name, 'pt'));
}

export function applyResourceSpend(
  used: Record<string, number>,
  slug: string,
  max: number,
  amount = 1,
): Record<string, number> {
  const current = used[slug] ?? 0;
  if (current + amount > max) {
    throw new Error(`No remaining uses of resource '${slug}'`);
  }
  return { ...used, [slug]: current + amount };
}

/** Recupera usos gastos (ex.: Gambito Terrível — 1 Dado de Risco). */
export function applyResourceRecover(
  used: Record<string, number>,
  slug: string,
  amount = 1,
): Record<string, number> {
  const current = used[slug] ?? 0;
  if (current <= 0) return { ...used };
  const next = Math.max(0, current - amount);
  if (next <= 0) {
    const { [slug]: _removed, ...rest } = used;
    return rest;
  }
  return { ...used, [slug]: next };
}

export function applyShortRestResourceRecovery(
  used: Record<string, number>,
  resources: readonly ClassResourceMax[],
): Record<string, number> {
  const next = { ...used };
  for (const resource of resources) {
    const spent = next[resource.slug] ?? 0;
    if (spent <= 0) continue;
    if (resource.recoverAllOnShort) {
      delete next[resource.slug];
      continue;
    }
    if (resource.recoverOneOnShort) {
      const remaining = spent - 1;
      if (remaining <= 0) delete next[resource.slug];
      else next[resource.slug] = remaining;
    }
  }
  return next;
}

export function applyLongRestResourceRecovery(
  used: Record<string, number>,
  resources: readonly ClassResourceMax[],
): Record<string, number> {
  const next = { ...used };
  for (const resource of resources) {
    if (resource.recoverAllOnLong) {
      delete next[resource.slug];
    }
  }
  return next;
}

export function resourcesRemaining(
  maxBySlug: Record<string, number>,
  used: Record<string, number>,
): Record<string, number> {
  const remaining: Record<string, number> = {};
  for (const [slug, max] of Object.entries(maxBySlug)) {
    remaining[slug] = Math.max(0, max - (used[slug] ?? 0));
  }
  return remaining;
}
