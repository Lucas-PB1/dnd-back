import { AbilityScores } from '../../../shared/infrastructure/player-character.entity';
import { abilityModifier } from './ability-modifier';

/**
 * Aumento de atributo concedido por capacidade de classe em um nível fixo
 * (resolvido de `v_phb_class_ability_boost`). Diferente do ASI/talentos, pode
 * elevar o atributo acima de 20 até `scoreMax`. A regra de qual classe/nível
 * concede o bônus vive no banco; aqui só aplicamos os efeitos.
 */
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

/**
 * Aplica os aumentos de classe sobre os atributos base, respeitando o teto
 * próprio de cada fonte e o nível do personagem. Nunca reduz um atributo já
 * acima do teto (ex.: edição manual), só eleva.
 */
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

/**
 * Delta de PV máximo decorrente do aumento de Constituição por classe.
 * Cada ponto de modificador de Constituição soma 1 PV por nível.
 */
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
