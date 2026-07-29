import {
  applyClassAbilityBoosts,
  classHitPointsBonus,
  type ClassAbilityBoostRow,
} from './class-ability-boost';
import type { AbilityScores } from '../../../shared/infrastructure/player-character.entity';

describe('class-ability-boost', () => {
  const base: AbilityScores = {
    forca: 20,
    destreza: 14,
    constituicao: 20,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
  };

  const primalChampion: ClassAbilityBoostRow[] = [
    { ability: 'forca', label: 'Campeão Primitivo', bonus: 4, scoreMax: 25, fromLevel: 20 },
    {
      ability: 'constituicao',
      label: 'Campeão Primitivo',
      bonus: 4,
      scoreMax: 25,
      fromLevel: 20,
    },
  ];

  it('applies the boost at the required level respecting the higher cap', () => {
    const result = applyClassAbilityBoosts(base, 20, primalChampion);
    expect(result.scores.forca).toBe(24);
    expect(result.scores.constituicao).toBe(24);
    expect(result.labels).toEqual(['Campeão Primitivo']);
  });

  it('does not apply below the required level', () => {
    const result = applyClassAbilityBoosts(base, 19, primalChampion);
    expect(result.scores).toEqual(base);
    expect(result.labels).toEqual([]);
  });

  it('caps at scoreMax without lowering a higher manual score', () => {
    const boosted = applyClassAbilityBoosts(
      { ...base, forca: 24 },
      20,
      primalChampion,
    );
    expect(boosted.scores.forca).toBe(25);

    const manualHigh = applyClassAbilityBoosts(
      { ...base, forca: 28 },
      20,
      primalChampion,
    );
    expect(manualHigh.scores.forca).toBe(28);
  });

  it('computes the HP delta from a constitution increase', () => {
    expect(classHitPointsBonus(20, 24, 20)).toBe(40);
    expect(classHitPointsBonus(20, 20, 20)).toBe(0);
    expect(classHitPointsBonus(22, 24, 20)).toBe(20);
  });
});
