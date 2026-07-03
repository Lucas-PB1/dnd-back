import {
  assignScoresToAbilities,
  generateAbilityScores,
  POINT_BUY_BUDGET,
  roll4d6DropLowest,
  standardArrayScores,
} from './ability-generation';

describe('ability-generation', () => {
  it('standard array returns PHB values', () => {
    expect(standardArrayScores()).toEqual([15, 14, 13, 12, 10, 8]);
    const scores = generateAbilityScores('standard-array');
    expect(scores.forca).toBe(15);
    expect(scores.carisma).toBe(8);
  });

  it('roll4d6DropLowest is between 3 and 18', () => {
    for (let i = 0; i < 50; i++) {
      const v = roll4d6DropLowest();
      expect(v).toBeGreaterThanOrEqual(3);
      expect(v).toBeLessThanOrEqual(18);
    }
  });

  it('roll uses deterministic rng', () => {
    let n = 0;
    const rng = () => {
      n = (n + 0.17) % 1;
      return n;
    };
    const scores = generateAbilityScores('roll', { rng });
    expect(Object.values(scores)).toHaveLength(6);
  });

  it('point-buy validates budget', () => {
    expect(() =>
      generateAbilityScores('point-buy', {
        abilityScores: {
          forca: 15,
          destreza: 15,
          constituicao: 15,
          inteligencia: 15,
          sabedoria: 15,
          carisma: 15,
        },
      }),
    ).toThrow();

    const valid = generateAbilityScores('point-buy', {
      abilityScores: {
        forca: 15,
        destreza: 14,
        constituicao: 13,
        inteligencia: 12,
        sabedoria: 10,
        carisma: 8,
      },
    });
    expect(valid.forca).toBe(15);
  });

  it('assignScoresToAbilities respects custom order', () => {
    const scores = assignScoresToAbilities([8, 10, 12, 13, 14, 15], [
      'carisma',
      'sabedoria',
      'inteligencia',
      'constituicao',
      'destreza',
      'forca',
    ]);
    expect(scores.carisma).toBe(8);
    expect(scores.forca).toBe(15);
  });
});
