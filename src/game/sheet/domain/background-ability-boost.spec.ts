import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import {
  applyBackgroundAbilityBoosts,
  assertBackgroundBoostSlugsAllowed,
} from './background-ability-boost';

describe('background-ability-boost', () => {
  const base: AbilityScores = {
    forca: 15,
    destreza: 14,
    constituicao: 13,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
  };

  it('applies +2 and +1 to different abilities', () => {
    const result = applyBackgroundAbilityBoosts(base, {
      plus2Slug: 'sabedoria',
      plus1Slug: 'carisma',
    });
    expect(result.sabedoria).toBe(14);
    expect(result.carisma).toBe(9);
    expect(result.forca).toBe(15);
  });

  it('caps scores at 20', () => {
    const high = { ...base, sabedoria: 19, carisma: 19 };
    const result = applyBackgroundAbilityBoosts(high, {
      plus2Slug: 'sabedoria',
      plus1Slug: 'carisma',
    });
    expect(result.sabedoria).toBe(20);
    expect(result.carisma).toBe(20);
  });

  it('rejects same ability for +2 and +1', () => {
    expect(() =>
      applyBackgroundAbilityBoosts(base, {
        plus2Slug: 'sabedoria',
        plus1Slug: 'sabedoria',
      }),
    ).toThrow();
  });

  it('validates allowed slugs from background', () => {
    expect(() =>
      assertBackgroundBoostSlugsAllowed(['sabedoria', 'carisma'], {
        plus2Slug: 'forca',
        plus1Slug: 'carisma',
      }),
    ).toThrow();
  });
});
