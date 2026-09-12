import { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from './ability-modifier';

export type ClassAbilityBoostRow = {
  ability: keyof AbilityScores;
  label: string;
  bonus: number;
  scoreMax: number;
  fromLevel: number;
};

export type AppliedClassAbilityBoosts = {
  scores: AbilityScores;
  labels: string[];
};

export function applyClassAbilityBoosts(
  scores: AbilityScores,
  level: number,
  rows: readonly ClassAbilityBoostRow[],
): AppliedClassAbilityBoosts {
  const next: AbilityScores = { ...scores };
  const labels = new Set<string>();

  for (const row of rows) {
    if (level < row.fromLevel) continue;
    const current = next[row.ability];
    const boosted = Math.min(row.scoreMax, current + row.bonus);
    if (boosted > current) {
      next[row.ability] = boosted;
      labels.add(row.label);
    }
  }

  return { scores: next, labels: [...labels] };
}

export function classHitPointsBonus(
  baseConstitution: number,
  boostedConstitution: number,
  level: number,
): number {
  const modDelta =
    abilityModifier(boostedConstitution) - abilityModifier(baseConstitution);
  if (modDelta <= 0) return 0;
  return modDelta * level;
}
