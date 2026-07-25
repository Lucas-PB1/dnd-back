import { abilityModifier } from './ability-modifier';

export interface ClassHpProfile {
  hpLevel1DieValue: number;
  hpFixedPerLevel: number;
  hpMinimumGainPerLevel?: number;
  constitutionModApplies?: boolean;
}

/** Fontes permanentes de PV máximo vindas da ficha (não de efeitos temporários). */
export type HitPointsContext = {
  speciesSlug?: string | null;
  subclassSlug?: string | null;
  featSlugs?: readonly string[];
};

type HitPointsBonusSource = {
  label: string;
  flat?: number;
  perLevel?: number;
  /** Nível de personagem a partir do qual a fonte passa a valer. */
  fromLevel?: number;
};

const SPECIES_HP_BONUS: Record<string, HitPointsBonusSource> = {
  dwarf: { label: 'Tenacidade Anã', perLevel: 1 },
};

const SUBCLASS_HP_BONUS: Record<string, HitPointsBonusSource> = {
  draconic: { label: 'Resiliência Dracônica', perLevel: 1, fromLevel: 3 },
};

const FEAT_HP_BONUS: Record<string, HitPointsBonusSource> = {
  tough: { label: 'Resistente', perLevel: 2 },
  'boon-of-fortitude': { label: 'Dádiva da Fortitude', flat: 40 },
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

function activeHitPointsBonusSources(
  context: HitPointsContext,
): HitPointsBonusSource[] {
  const featSlugs = new Set(context.featSlugs ?? []);
  const sources = [
    context.speciesSlug ? SPECIES_HP_BONUS[context.speciesSlug] : undefined,
    context.subclassSlug ? SUBCLASS_HP_BONUS[context.subclassSlug] : undefined,
    ...[...featSlugs].map((slug) => FEAT_HP_BONUS[slug]),
  ];
  return sources.filter((source): source is HitPointsBonusSource => Boolean(source));
}

/** Soma dos bônus permanentes de PV máximo (espécie, subclasse e talentos). */
export function hitPointsBonus(level: number, context: HitPointsContext = {}): number {
  return activeHitPointsBonusSources(context).reduce((total, source) => {
    if (level < (source.fromLevel ?? 1)) return total;
    return total + (source.flat ?? 0) + (source.perLevel ?? 0) * level;
  }, 0);
}

export function calculateHitPointsMax(
  level: number,
  profile: ClassHpProfile,
  constitutionScore: number,
  context: HitPointsContext = {},
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

  return base + hitPointsBonus(level, context);
}
