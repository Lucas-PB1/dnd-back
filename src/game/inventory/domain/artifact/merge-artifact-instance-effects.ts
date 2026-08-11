import type { ArtifactInstanceProperties } from './artifact-instance.types';
import { parseInstanceProperties } from './roll-artifact-instance';

type PermanentEffectsBag = Record<string, unknown>;

function isRecord(value: unknown): value is Record<string, unknown> {
  return value != null && typeof value === 'object' && !Array.isArray(value);
}

function mergeAbilityMaps(
  left: Record<string, number>,
  right: Record<string, unknown>,
): Record<string, number> {
  const result = { ...left };
  for (const [key, raw] of Object.entries(right)) {
    if (typeof raw !== 'number' || !Number.isFinite(raw)) continue;
    result[key] = (result[key] ?? 0) + raw;
  }
  return result;
}

function mergePermanentEffects(
  left: PermanentEffectsBag,
  right: PermanentEffectsBag,
): PermanentEffectsBag {
  const next: PermanentEffectsBag = { ...left };
  for (const [key, value] of Object.entries(right)) {
    if (key === 'abilityBonuses' || key === 'savingThrowBonuses') {
      const current = isRecord(next[key])
        ? (next[key] as Record<string, number>)
        : {};
      const incoming = isRecord(value) ? value : {};
      next[key] = mergeAbilityMaps(current, incoming);
      continue;
    }
    if (typeof value === 'number' && Number.isFinite(value)) {
      const prev = typeof next[key] === 'number' ? (next[key] as number) : 0;
      next[key] = prev + value;
      continue;
    }
    if (key === 'abilityScoreMax' && typeof value === 'number') {
      const prev =
        typeof next.abilityScoreMax === 'number'
          ? (next.abilityScoreMax as number)
          : 20;
      next.abilityScoreMax = Math.max(prev, value);
      continue;
    }
    next[key] = value;
  }
  return next;
}

function collectRolledPermanentEffects(
  instance: ArtifactInstanceProperties | null,
): PermanentEffectsBag | null {
  const buckets = instance?.artifactRandom;
  if (!buckets) return null;

  let merged: PermanentEffectsBag | null = null;
  const lists = [
    buckets.minorBeneficial,
    buckets.majorBeneficial,
    buckets.minorDetrimental,
    buckets.majorDetrimental,
  ];
  for (const list of lists) {
    for (const prop of list ?? []) {
      const effect = prop.effect;
      if (!isRecord(effect) || effect.type !== 'permanentEffects') continue;
      const pe = effect.permanentEffects;
      if (!isRecord(pe)) continue;
      merged = merged ? mergePermanentEffects(merged, pe) : { ...pe };
    }
  }
  return merged;
}

/**
 * Mescla PE das props de artefato roladas nas properties do catálogo
 * para o resolve de efeitos permanentes ativos.
 */
export function mergeArtifactInstanceIntoCatalogProperties(
  catalogProperties: Record<string, unknown> | null | undefined,
  instanceProperties: unknown,
): Record<string, unknown> | null {
  const base = isRecord(catalogProperties) ? { ...catalogProperties } : {};
  const rolledPe = collectRolledPermanentEffects(
    parseInstanceProperties(instanceProperties),
  );
  if (!rolledPe) {
    return Object.keys(base).length > 0 ? base : (catalogProperties ?? null);
  }

  const existingPe = isRecord(base.permanentEffects)
    ? (base.permanentEffects as PermanentEffectsBag)
    : {};
  base.permanentEffects = mergePermanentEffects(existingPe, rolledPe);
  return base;
}
