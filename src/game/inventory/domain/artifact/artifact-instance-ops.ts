import type {
  ArtifactAbilityPenalties,
  ArtifactInstanceProperties,
  ArtifactRandomBucket,
  ArtifactRandomEffect,
  RolledArtifactProperty,
} from './artifact-instance.types';
import {
  ARTIFACT_ABILITY_FLOOR,
  ARTIFACT_RANDOM_SPELL_SAVE_DC,
} from './artifact-instance.types';
import { parseInstanceProperties } from './roll-artifact-instance';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';

export function isRecord(value: unknown): value is Record<string, unknown> {
  return value != null && typeof value === 'object' && !Array.isArray(value);
}

export function listArtifactRandomBuckets(
  artifactRandom: ArtifactInstanceProperties['artifactRandom'],
): { bucket: ArtifactRandomBucket; props: RolledArtifactProperty[] }[] {
  if (!artifactRandom) return [];
  return [
    { bucket: 'minorBeneficial', props: artifactRandom.minorBeneficial ?? [] },
    { bucket: 'majorBeneficial', props: artifactRandom.majorBeneficial ?? [] },
    {
      bucket: 'minorDetrimental',
      props: artifactRandom.minorDetrimental ?? [],
    },
    {
      bucket: 'majorDetrimental',
      props: artifactRandom.majorDetrimental ?? [],
    },
  ];
}

export function getRolledPropEffect(
  prop: RolledArtifactProperty,
): ArtifactRandomEffect | null {
  const effect = prop.effect;
  if (!isRecord(effect) || typeof effect.type !== 'string') return null;
  return effect as ArtifactRandomEffect;
}

/** Soma penalidades de todas as peças (independe de sintonia). */
export function collectAbilityPenaltiesFromInventory(
  rows: readonly { instanceProperties?: unknown }[],
): ArtifactAbilityPenalties {
  const total: ArtifactAbilityPenalties = {};
  for (const row of rows) {
    const instance = parseInstanceProperties(row.instanceProperties);
    const penalties = instance?.abilityPenalties;
    if (!penalties) continue;
    for (const [key, raw] of Object.entries(penalties)) {
      if (typeof raw !== 'number' || !Number.isFinite(raw) || raw === 0) continue;
      if (
        key !== 'forca' &&
        key !== 'destreza' &&
        key !== 'constituicao' &&
        key !== 'inteligencia' &&
        key !== 'sabedoria' &&
        key !== 'carisma'
      ) {
        continue;
      }
      total[key] = (total[key] ?? 0) + raw;
    }
  }
  return total;
}

export function applyAbilityPenalties(
  scores: AbilityScores,
  penalties: ArtifactAbilityPenalties,
): AbilityScores {
  const next: AbilityScores = { ...scores };
  for (const [key, amount] of Object.entries(penalties) as [
    keyof AbilityScores,
    number | undefined,
  ][]) {
    if (!amount) continue;
    next[key] = Math.max(ARTIFACT_ABILITY_FLOOR, next[key] + amount);
  }
  return next;
}

export function clearAbilityPenaltiesFromInstance(
  instance: unknown,
): ArtifactInstanceProperties | null {
  const parsed = parseInstanceProperties(instance);
  if (!parsed?.abilityPenalties) return parsed;
  const { abilityPenalties: _removed, ...rest } = parsed;
  return rest;
}

/** Marca/recupera usos de magias roladas (1× até DL). */
export function mapArtifactSpellSpendFlags(
  instance: unknown,
  spentUntilLongRest: boolean,
): ArtifactInstanceProperties | null {
  const parsed = parseInstanceProperties(instance);
  if (!parsed?.artifactRandom) return parsed;

  const nextBuckets = { ...parsed.artifactRandom };
  for (const { bucket, props } of listArtifactRandomBuckets(nextBuckets)) {
    nextBuckets[bucket] = props.map((prop) => {
      const effect = getRolledPropEffect(prop);
      if (!effect || effect.type !== 'artifactSpell') return prop;
      return {
        ...prop,
        effect: {
          ...effect,
          spentUntilLongRest,
          spellSaveDc: effect.spellSaveDc ?? ARTIFACT_RANDOM_SPELL_SAVE_DC,
        },
      };
    });
  }

  return { ...parsed, artifactRandom: nextBuckets };
}

export function markArtifactSpellSpent(input: {
  instance: unknown;
  bucket: ArtifactRandomBucket;
  index: number;
}): ArtifactInstanceProperties {
  const parsed = parseInstanceProperties(input.instance) ?? {};
  const artifactRandom = parsed.artifactRandom;
  if (!artifactRandom) {
    throw new Error('Item has no artifactRandom props');
  }
  const list = [...(artifactRandom[input.bucket] ?? [])];
  const prop = list[input.index];
  if (!prop) {
    throw new Error(`No artifact prop at ${input.bucket}[${input.index}]`);
  }
  const effect = getRolledPropEffect(prop);
  if (!effect || effect.type !== 'artifactSpell') {
    throw new Error('Target prop is not an artifactSpell');
  }
  if (effect.spentUntilLongRest) {
    throw new Error('Artifact spell already spent until long rest');
  }
  list[input.index] = {
    ...prop,
    effect: { ...effect, spentUntilLongRest: true },
  };
  return {
    ...parsed,
    artifactRandom: { ...artifactRandom, [input.bucket]: list },
  };
}

export function readArtifactSpellProp(input: {
  instance: unknown;
  bucket: ArtifactRandomBucket;
  index: number;
}): { prop: RolledArtifactProperty; effect: Extract<ArtifactRandomEffect, { type: 'artifactSpell' }> } {
  const parsed = parseInstanceProperties(input.instance);
  const prop = parsed?.artifactRandom?.[input.bucket]?.[input.index];
  if (!prop) {
    throw new Error(`No artifact prop at ${input.bucket}[${input.index}]`);
  }
  const effect = getRolledPropEffect(prop);
  if (!effect || effect.type !== 'artifactSpell' || !effect.spellSlug) {
    throw new Error('Target prop is not a bound artifactSpell');
  }
  return { prop, effect };
}

export function findArtifactRegenOnInstance(
  instance: unknown,
): Extract<ArtifactRandomEffect, { type: 'artifactRegen' }> | null {
  const parsed = parseInstanceProperties(instance);
  for (const { props } of listArtifactRandomBuckets(parsed?.artifactRandom)) {
    for (const prop of props) {
      const effect = getRolledPropEffect(prop);
      if (effect?.type === 'artifactRegen') return effect;
    }
  }
  return null;
}
