import type {
  ArtifactRandomQuota,
  ArtifactRandomTableRow,
  ArtifactRandomRollResult,
  ArtifactInstanceProperties,
  CatalogSentience,
  RolledArtifactProperty,
} from './artifact-instance.types';
import type { ArtifactAbilityPenalties } from './artifact-instance.types';
import { ARTIFACT_RANDOM_SPELL_SAVE_DC } from './artifact-instance.types';

export type Rng = () => number;

export type PickSpellByLevel = (level: number, rng: Rng) => string | null;

const KIND_TO_QUOTA_KEY = {
  minor_beneficial: 'minorBeneficial',
  major_beneficial: 'majorBeneficial',
  minor_detrimental: 'minorDetrimental',
  major_detrimental: 'majorDetrimental',
} as const;

const ABILITIES = [
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
] as const;

const DAMAGE_TYPES_PT = [
  'Ácido',
  'Frio',
  'Fogo',
  'Energético',
  'Elétrico',
  'Necrótico',
  'Perfurante',
  'Veneno',
  'Psíquico',
  'Radiante',
  'Cortante',
  'Trovejante',
] as const;

const SKILLS_PT = [
  'Acrobacia',
  'Arcanismo',
  'Atletismo',
  'Enganação',
  'Furtividade',
  'História',
  'Intimidação',
  'Intuição',
  'Investigação',
  'Lidar com Animais',
  'Medicina',
  'Natureza',
  'Percepção',
  'Persuasão',
  'Prestidigitação',
  'Religião',
  'Sobrevivência',
] as const;

export function rollD100(rng: Rng): number {
  return Math.floor(rng() * 100) + 1;
}

function pickOne<T>(items: readonly T[], rng: Rng): T {
  return items[Math.floor(rng() * items.length)]!;
}

function findRowForRoll(
  rows: readonly ArtifactRandomTableRow[],
  kind: ArtifactRandomTableRow['kind'],
  roll: number,
): ArtifactRandomTableRow | null {
  return (
    rows.find(
      (row) => row.kind === kind && roll >= row.rollMin && roll <= row.rollMax,
    ) ?? null
  );
}

/**
 * Resolve escolhas “do Mestre” no momento do roll (atributo, resistência, perícia,
 * magia do círculo) e materializa efeitos aplicáveis.
 */
export function materializeRolledEffect(
  row: ArtifactRandomTableRow,
  rng: Rng,
  pickSpellByLevel?: PickSpellByLevel,
): RolledArtifactProperty {
  const baseEffect = row.effect ?? { type: 'reminder', text: row.summaryPt };
  let summaryPt = row.summaryPt;
  let effect: RolledArtifactProperty['effect'] = { ...baseEffect };

  if (
    typeof baseEffect === 'object' &&
    baseEffect !== null &&
    'type' in baseEffect
  ) {
    if (baseEffect.type === 'permanentEffects') {
      const pe = {
        ...(baseEffect.permanentEffects as Record<string, unknown>),
      };
      if (pe.abilityBonusChoice === true) {
        const ability = pickOne(ABILITIES, rng);
        delete pe.abilityBonusChoice;
        pe.abilityBonuses = { [ability]: 2 };
        pe.abilityScoreMax = 24;
        summaryPt = `${summaryPt} (${ability} +2, máx. 24)`;
      }
      effect = { type: 'permanentEffects', permanentEffects: pe };
    } else if (baseEffect.type === 'artifactSpell') {
      const spellLevel = Number(
        (baseEffect as { spellLevel?: number }).spellLevel ?? 0,
      );
      const spellSlug = pickSpellByLevel?.(spellLevel, rng) ?? null;
      const levelLabel =
        spellLevel === 0 ? 'truque' : `${spellLevel}º círculo`;
      summaryPt = spellSlug
        ? `Conjura ${spellSlug} (${levelLabel}) · CD ${ARTIFACT_RANDOM_SPELL_SAVE_DC} · 1×/DL`
        : `Conjura magia de ${levelLabel} (nenhuma no catálogo)`;
      effect = {
        type: 'artifactSpell',
        spellLevel,
        spellSlug: spellSlug ?? undefined,
        spentUntilLongRest: false,
        spellSaveDc: ARTIFACT_RANDOM_SPELL_SAVE_DC,
      };
    } else if (baseEffect.type === 'artifactRegen') {
      const dice =
        typeof (baseEffect as { dice?: string }).dice === 'string'
          ? (baseEffect as { dice: string }).dice
          : '1d6';
      summaryPt = `Regeneração ${dice} PV no início do turno (botão na ficha)`;
      effect = { type: 'artifactRegen', dice };
    } else if (baseEffect.type === 'abilityPenalty') {
      const amount = Math.abs(
        Number((baseEffect as { amount?: number }).amount ?? 2) || 2,
      );
      const ability = pickOne(ABILITIES, rng);
      summaryPt = `${ability} −${amount} (até Restauração Maior)`;
      effect = { type: 'abilityPenalty', amount, ability };
    } else if (baseEffect.type === 'reminder') {
      let text =
        typeof baseEffect.text === 'string' ? baseEffect.text : row.summaryPt;
      if (row.slug === 'skill-proficiency') {
        const skill = pickOne(SKILLS_PT, rng);
        text = `Proficiência em ${skill} (escolha do Mestre materializada no roll).`;
        summaryPt = `Proficiência em ${skill}`;
      } else if (row.slug === 'damage-resistance') {
        const damageType = pickOne(DAMAGE_TYPES_PT, rng);
        text = `Resistência a dano ${damageType} (escolha do Mestre materializada no roll).`;
        summaryPt = `Resistência a ${damageType}`;
      }
      effect = { type: 'reminder', text };
    }
  }

  return {
    slug: row.slug,
    summaryPt,
    roll: 0,
    effect,
  };
}

function rollOneOfKind(
  rows: readonly ArtifactRandomTableRow[],
  kind: ArtifactRandomTableRow['kind'],
  rng: Rng,
  pickSpellByLevel?: PickSpellByLevel,
): RolledArtifactProperty {
  const roll = rollD100(rng);
  const row = findRowForRoll(rows, kind, roll);
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
  const materialized = materializeRolledEffect(row, rng, pickSpellByLevel);
  return { ...materialized, roll };
}

export function parseArtifactRandomQuota(
  properties: Record<string, unknown> | null | undefined,
): ArtifactRandomQuota | null {
  const raw = properties?.artifactRandomQuota;
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null;
  const source = raw as Record<string, unknown>;
  const quota: ArtifactRandomQuota = {
    minorBeneficial: Number(source.minorBeneficial ?? 0) || 0,
    majorBeneficial: Number(source.majorBeneficial ?? 0) || 0,
    minorDetrimental: Number(source.minorDetrimental ?? 0) || 0,
    majorDetrimental: Number(source.majorDetrimental ?? 0) || 0,
  };
  if (
    quota.minorBeneficial +
      quota.majorBeneficial +
      quota.minorDetrimental +
      quota.majorDetrimental ===
    0
  ) {
    return null;
  }
  return quota;
}

export function parseCatalogSentience(
  properties: Record<string, unknown> | null | undefined,
): CatalogSentience | null {
  const raw = properties?.sentience;
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null;
  return raw as CatalogSentience;
}

export function parseInstanceProperties(
  value: unknown,
): ArtifactInstanceProperties | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return null;
  return value as ArtifactInstanceProperties;
}

export function needsArtifactInstanceRoll(
  catalogProperties: Record<string, unknown> | null | undefined,
  instanceProperties: unknown,
): boolean {
  const quota = parseArtifactRandomQuota(catalogProperties);
  const catalogSentience = parseCatalogSentience(catalogProperties);
  if (!quota && !catalogSentience) return false;
  const instance = parseInstanceProperties(instanceProperties) ?? {};
  if (quota && !instance.artifactRandom) return true;
  if (catalogSentience && !instance.sentience) return true;
  return false;
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
