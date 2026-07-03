import { abilityModifier } from './ability-modifier';

export interface ClassHpProfile {
  hpLevel1DieValue: number;
  hpFixedPerLevel: number;
  hpMinimumGainPerLevel?: number;
  constitutionModApplies?: boolean;
}

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

export function calculateHitPointsMax(
  level: number,
  profile: ClassHpProfile,
  constitutionScore: number,
): number {
  const minimumGain = profile.hpMinimumGainPerLevel ?? DEFAULT_MINIMUM_GAIN;
  const conMod = profile.constitutionModApplies !== false
    ? abilityModifier(constitutionScore)
    : 0;

  const level1Hp = profile.hpLevel1DieValue + conMod;
  if (level <= 1) {
    return level1Hp;
  }

  const perLevel = hpGainPerLevel(profile.hpFixedPerLevel, conMod, minimumGain);
  return level1Hp + (level - 1) * perLevel;
}
