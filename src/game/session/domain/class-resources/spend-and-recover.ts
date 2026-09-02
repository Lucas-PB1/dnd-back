import { rollExpression, type Rng } from '@game/dice/domain/dice';
import type {
  ClassResourceMax,
  LongRestResourceRecoveryResult,
} from './types';

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
  rng: Rng = Math.random,
): LongRestResourceRecoveryResult {
  let next = { ...used };
  const notes: string[] = [];
  for (const resource of resources) {
    const spent = next[resource.slug] ?? 0;
    if (resource.recoverOnLongDice) {
      if (spent <= 0) continue;
      const rolled = rollExpression(resource.recoverOnLongDice, rng).total;
      const recovered = Math.min(Math.max(0, rolled), spent);
      next = applyResourceRecover(next, resource.slug, recovered);
      notes.push(
        `${resource.name}: recuperou ${recovered} (${resource.recoverOnLongDice}).`,
      );
      continue;
    }
    if (resource.recoverAllOnLong) {
      delete next[resource.slug];
    }
  }
  return { used: next, notes };
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
