import type {
  ArtifactRandomQuota,
  ArtifactRandomTableRow,
  ArtifactRandomRollResult,
  ArtifactInstanceProperties,
  ArtifactAbilityPenalties,
  RolledArtifactProperty,
} from '../artifact-instance.types';
import type { Rng } from './artifact-roll-rng';
import { rollD100 } from './artifact-roll-rng';
import type { PickSpellByLevel } from './materialize-rolled-effect';
import { materializeRolledEffect } from './materialize-rolled-effect';
import {
  parseArtifactRandomQuota,
  parseCatalogSentience,
  parseInstanceProperties,
} from './parse-artifact-instance';

const KIND_TO_QUOTA_KEY = {
  minor_beneficial: 'minorBeneficial',
  major_beneficial: 'majorBeneficial',
  minor_detrimental: 'minorDetrimental',
  major_detrimental: 'majorDetrimental',
} as const;

function rollOneOfKind(
  rows: readonly ArtifactRandomTableRow[],
  kind: ArtifactRandomTableRow['kind'],
  rng: Rng,
  pickSpellByLevel?: PickSpellByLevel,
): RolledArtifactProperty {
  const roll = rollD100(rng);
  const row =
    rows.find(
      (r) => r.kind === kind && roll >= r.rollMin && roll <= r.rollMax,
    ) ?? null;
  if (!row) {
    return {
      slug: `${kind}-missing-${roll}`,
      summaryPt: `Faixa 1d100=${roll} sem entrada na tabela ${kind}`,
      roll,
      effect: {
        type: 'reminder',
        text: `Rolagem ${roll} sem propriedade cadastrada para ${kind}.`,
      },
    };
  }
  return { ...materializeRolledEffect(row, rng, pickSpellByLevel), roll };
}

function abilityPenaltiesFromRolledProps(
  artifactRandom: ArtifactRandomRollResult,
): ArtifactAbilityPenalties {
  const penalties: ArtifactAbilityPenalties = {};
  const lists = [
    artifactRandom.minorBeneficial,
    artifactRandom.majorBeneficial,
    artifactRandom.minorDetrimental,
    artifactRandom.majorDetrimental,
  ];
  for (const list of lists) {
    for (const prop of list) {
      const effect = prop.effect;
      if (
        !effect ||
        typeof effect !== 'object' ||
        Array.isArray(effect) ||
        (effect as { type?: string }).type !== 'abilityPenalty'
      ) {
        continue;
      }
      const typed = effect as { ability?: string; amount?: number };
      if (!typed.ability || typeof typed.amount !== 'number') continue;
      const key = typed.ability as keyof ArtifactAbilityPenalties;
      penalties[key] = (penalties[key] ?? 0) - Math.abs(typed.amount);
    }
  }
  return penalties;
}

export function rollArtifactRandomProperties(input: {
  quota: ArtifactRandomQuota;
  tableRows: readonly ArtifactRandomTableRow[];
  rng: Rng;
  nowIso: string;
  pickSpellByLevel?: PickSpellByLevel;
}): ArtifactRandomRollResult {
  const { quota, tableRows, rng, nowIso, pickSpellByLevel } = input;
  const result: ArtifactRandomRollResult = {
    rolledAt: nowIso,
    minorBeneficial: [],
    majorBeneficial: [],
    minorDetrimental: [],
    majorDetrimental: [],
  };

  for (const [kind, quotaKey] of Object.entries(KIND_TO_QUOTA_KEY) as [
    ArtifactRandomTableRow['kind'],
    keyof ArtifactRandomQuota,
  ][]) {
    const count = quota[quotaKey];
    for (let i = 0; i < count; i += 1) {
      result[quotaKey].push(
        rollOneOfKind(tableRows, kind, rng, pickSpellByLevel),
      );
    }
  }

  return result;
}

export function buildArtifactInstanceProperties(input: {
  catalogProperties: Record<string, unknown> | null | undefined;
  existingInstance: unknown;
  tableRows: readonly ArtifactRandomTableRow[];
  rng: Rng;
  nowIso: string;
  pickSpellByLevel?: PickSpellByLevel;
}): ArtifactInstanceProperties {
  const existing = parseInstanceProperties(input.existingInstance) ?? {};
  const next: ArtifactInstanceProperties = { ...existing };

  const quota = parseArtifactRandomQuota(input.catalogProperties);
  if (quota && !next.artifactRandom) {
    next.artifactRandom = rollArtifactRandomProperties({
      quota,
      tableRows: input.tableRows,
      rng: input.rng,
      nowIso: input.nowIso,
      pickSpellByLevel: input.pickSpellByLevel,
    });
    const penalties = abilityPenaltiesFromRolledProps(next.artifactRandom);
    if (Object.keys(penalties).length > 0) {
      next.abilityPenalties = {
        ...(next.abilityPenalties ?? {}),
        ...penalties,
      };
    }
  }

  const catalogSentience = parseCatalogSentience(input.catalogProperties);
  if (catalogSentience && !next.sentience) {
    next.sentience = { ...catalogSentience };
  }

  return next;
}
