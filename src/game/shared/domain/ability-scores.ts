export interface AbilityScores {
  forca: number;
  destreza: number;
  constituicao: number;
  inteligencia: number;
  sabedoria: number;
  carisma: number;
}

export const DEFAULT_ABILITY_SCORES: AbilityScores = {
  forca: 10,
  destreza: 10,
  constituicao: 10,
  inteligencia: 10,
  sabedoria: 10,
  carisma: 10,
};

export type AbilityModifiers = AbilityScores;

export function abilityModifier(score: number): number {
  return Math.floor((score - 10) / 2);
}

export function computeAbilityModifiers(scores: AbilityScores): AbilityModifiers {
  return {
    forca: abilityModifier(scores.forca),
    destreza: abilityModifier(scores.destreza),
    constituicao: abilityModifier(scores.constituicao),
    inteligencia: abilityModifier(scores.inteligencia),
    sabedoria: abilityModifier(scores.sabedoria),
    carisma: abilityModifier(scores.carisma),
  };
}
