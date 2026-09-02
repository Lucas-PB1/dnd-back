import { feetToMeters } from '@game/shared/domain/metric';
import { WARLOCK_PACT_SLUGS } from '../constants';
import {
  ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY,
  ELDRITCH_INVOCATION_OPTION_KEY,
  ELDRITCH_INVOCATION_ORIGIN_FEAT_OPTION_KEY,
  isBlastInvocationSlug,
  isLessonsOfTheFirstOnesSlug,
  type BlastInvocationSlug,
} from '../features';
import type {
  ClassOptionLike,
  EldritchBlastCantripBinding,
  EldritchCantripEligibility,
  EldritchOriginFeatBinding,
} from './types';

export function readEldritchInvocationPicks(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): { slug: string; instanceIndex: number }[] {
  const picks: { slug: string; instanceIndex: number }[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== ELDRITCH_INVOCATION_OPTION_KEY) continue;
    picks.push({
      slug: option.valueId,
      instanceIndex: option.instanceIndex ?? 0,
    });
  }
  return picks.sort((a, b) => a.instanceIndex - b.instanceIndex);
}

export function readEldritchInvocationCantripBindings(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): EldritchBlastCantripBinding[] {
  const picksByIndex = new Map(
    readEldritchInvocationPicks(classOptions).map((pick) => [
      pick.instanceIndex,
      pick.slug,
    ]),
  );
  const bindings: EldritchBlastCantripBinding[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY) continue;
    const instanceIndex = option.instanceIndex ?? 0;
    const invocationSlug = picksByIndex.get(instanceIndex);
    if (!invocationSlug || !isBlastInvocationSlug(invocationSlug)) continue;
    bindings.push({
      instanceIndex,
      invocationSlug,
      cantripSlug: option.valueId,
    });
  }
  return bindings.sort((a, b) => a.instanceIndex - b.instanceIndex);
}

export function readEldritchInvocationOriginFeatBindings(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): EldritchOriginFeatBinding[] {
  const picksByIndex = new Map(
    readEldritchInvocationPicks(classOptions).map((pick) => [
      pick.instanceIndex,
      pick.slug,
    ]),
  );
  const bindings: EldritchOriginFeatBinding[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== ELDRITCH_INVOCATION_ORIGIN_FEAT_OPTION_KEY) {
      continue;
    }
    const instanceIndex = option.instanceIndex ?? 0;
    const invocationSlug = picksByIndex.get(instanceIndex);
    if (!invocationSlug || !isLessonsOfTheFirstOnesSlug(invocationSlug)) {
      continue;
    }
    const featSlug = option.valueId.trim();
    if (!featSlug) continue;
    bindings.push({ instanceIndex, featSlug });
  }
  return bindings.sort((a, b) => a.instanceIndex - b.instanceIndex);
}

export function knownPactSlugsFromPicks(
  picks: readonly { slug: string }[],
): Set<string> {
  const set = new Set<string>();
  const pactSet = new Set<string>(WARLOCK_PACT_SLUGS);
  for (const pick of picks) {
    if (pactSet.has(pick.slug)) {
      set.add(pick.slug);
    }
  }
  return set;
}

/**
 * Extrai alcance em metros a partir do texto do catálogo (ex.: "36 metros", "120 feet").
 */
export function parseSpellRangeMeters(
  rangeText: string | null | undefined,
): number | null {
  if (!rangeText) return null;
  const meters = rangeText.match(/(\d+(?:[.,]\d+)?)\s*m(?:etro)?/i);
  if (meters) {
    return Number(meters[1].replace(',', '.'));
  }
  const feet = rangeText.match(/(\d+(?:[.,]\d+)?)\s*(?:ft|feet|pés|pes)/i);
  if (feet) {
    return feetToMeters(Number(feet[1].replace(',', '.')));
  }
  return null;
}

export function inferSpellDealsDamage(input: {
  requiresAttackRoll: boolean;
  saveAbilitySlug?: string | null;
  description?: string | null;
}): boolean {
  if (input.requiresAttackRoll) return true;
  if (input.saveAbilitySlug) return true;
  const text = input.description ?? '';
  return /\d+\s*d\s*\d+/i.test(text) && /dano|damage/i.test(text);
}

export function cantripEligibleForBlastInvocation(
  invocationSlug: BlastInvocationSlug,
  cantrip: EldritchCantripEligibility,
): boolean {
  if (!cantrip.isWarlockCantrip) return false;
  if (invocationSlug === 'repelling-blast') {
    return cantrip.requiresAttackRoll;
  }
  if (invocationSlug === 'eldritch-spear') {
    return (
      cantrip.dealsDamage &&
      cantrip.rangeMeters != null &&
      cantrip.rangeMeters >= 3
    );
  }
  return cantrip.dealsDamage;
}
