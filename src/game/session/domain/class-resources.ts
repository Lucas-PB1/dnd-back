/**
 * Resolve máximos e recuperação de recursos de classe (PHB 2024).
 * Cotas vêm de `phb_class_resource` + `phb_class_progression.channel_divinity`.
 */

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

function abilityModFromFormula(
  formula: ResourceMaxFormula,
  mods: AbilityMods,
): number | null {
  if (formula === 'charisma_mod') return mods.carisma;
  if (formula === 'wisdom_mod') return mods.sabedoria;
  if (formula === 'constitution_mod') return mods.constituicao;
  if (formula === 'intelligence_mod') return mods.inteligencia;
  return null;
}

function resolveFormulaMax(
  row: ClassResourceScheduleRow,
  level: number,
  proficiencyBonus: number,
  mods: AbilityMods,
): number {
  if (row.maxFormula === 'fixed') return row.fixedMax ?? 0;
  if (row.maxFormula === 'level') return level;
  if (row.maxFormula === 'level_plus_one') return level + 1;
  if (row.maxFormula === 'proficiency_bonus') return proficiencyBonus;
  if (row.maxFormula === 'zealot_healing_dice_count') {
    if (level >= 17) return 7;
    if (level >= 12) return 6;
    if (level >= 6) return 5;
    if (level >= 3) return 4;
    return 0;
  }
  if (row.maxFormula === 'superiority_dice_count') {
    if (level >= 15) return 6;
    if (level >= 7) return 5;
    if (level >= 3) return 4;
    return 0;
  }
  if (row.maxFormula === 'psi_energy_dice_count') {
    if (level >= 17) return 12;
    if (level >= 13) return 10;
    if (level >= 11) return 8;
    if (level >= 9) return 8;
    if (level >= 5) return 6;
    if (level >= 3) return 4;
    return 0;
  }
  const ability = abilityModFromFormula(row.maxFormula, mods);
  if (ability != null) return Math.max(1, ability);
  return row.fixedMax ?? 0;
}

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

    if (max <= 0) continue;

    result.push({
      slug,
      name: top.resourceName,
      max,
      recoverOneOnShort: top.recoverOneOnShort,
      recoverAllOnShort: top.recoverAllOnShort,
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
