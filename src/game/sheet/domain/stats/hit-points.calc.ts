import { abilityModifier } from './ability-modifier';

export interface ClassHpProfile {
  hpLevel1DieValue: number;
  hpFixedPerLevel: number;
  hpMinimumGainPerLevel?: number;
  constitutionModApplies?: boolean;
}

/**
 * Fonte permanente de PV máximo já resolvida do catálogo
 * (`v_phb_hp_bonus_source`). A regra de quais slugs concedem o bônus vive no
 * banco; aqui só somamos os efeitos.
 */
export type HitPointsBonusRow = {
  label: string;
  flat?: number;
  perLevel?: number;
  /** Nível de personagem a partir do qual a fonte passa a valer. */
  fromLevel?: number;
};

const DEFAULT_MINIMUM_GAIN = 1;

export function parseHitDieLabel(hitDie: string): number {
  const match = /d(\d+)/i.exec(hitDie);
  if (!match) {
    throw new Error(`Invalid hit die label: ${hitDie}`);
  }
  return Number.parseInt(match[1], 10);
}

export function hpGainPerLevel(
  hpFixedPerLevel: number,
  constitutionMod: number,
  minimumGain = DEFAULT_MINIMUM_GAIN,
): number {
  return Math.max(minimumGain, hpFixedPerLevel + constitutionMod);
}

/** Soma dos bônus permanentes de PV máximo aplicáveis no nível informado. */
export function hitPointsBonus(
  level: number,
  sources: readonly HitPointsBonusRow[] = [],
): number {
  return sources.reduce((total, source) => {
    if (level < (source.fromLevel ?? 1)) return total;
    return total + (source.flat ?? 0) + (source.perLevel ?? 0) * level;
  }, 0);
}

export function calculateHitPointsMax(
  level: number,
  profile: ClassHpProfile,
  constitutionScore: number,
  bonusSources: readonly HitPointsBonusRow[] = [],
): number {
  const minimumGain = profile.hpMinimumGainPerLevel ?? DEFAULT_MINIMUM_GAIN;
  const conMod = profile.constitutionModApplies !== false
    ? abilityModifier(constitutionScore)
    : 0;

  const level1Hp = profile.hpLevel1DieValue + conMod;
  const base =
    level <= 1
      ? level1Hp
      : level1Hp +
        (level - 1) * hpGainPerLevel(profile.hpFixedPerLevel, conMod, minimumGain);

  return base + hitPointsBonus(level, bonusSources);
}
