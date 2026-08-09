import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  applyBackgroundAbilityBoosts,
  assertBackgroundBoostSlugsAllowed,
  BACKGROUND_BOOST_MODE_PLUS1X3,
  BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
  resolveBackgroundAbilityBoostInput,
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
      mode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
      plus2Slug: 'sabedoria',
      plus1Slug: 'carisma',
    });
    expect(result.sabedoria).toBe(14);
    expect(result.carisma).toBe(9);
    expect(result.forca).toBe(15);
  });

  it('applies +1 to three different abilities', () => {
    const result = applyBackgroundAbilityBoosts(base, {
      mode: BACKGROUND_BOOST_MODE_PLUS1X3,
      plus1Slugs: ['sabedoria', 'carisma', 'inteligencia'],
    });
    expect(result.sabedoria).toBe(13);
    expect(result.carisma).toBe(9);
    expect(result.inteligencia).toBe(11);
    expect(result.forca).toBe(15);
  });

  it('caps scores at 20', () => {
    const high = { ...base, sabedoria: 19, carisma: 19 };
    const result = applyBackgroundAbilityBoosts(high, {
      mode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
      plus2Slug: 'sabedoria',
      plus1Slug: 'carisma',
    });
    expect(result.sabedoria).toBe(20);
    expect(result.carisma).toBe(20);
  });

  it('rejects same ability for +2 and +1', () => {
    expect(() =>
      applyBackgroundAbilityBoosts(base, {
        mode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
        plus2Slug: 'sabedoria',
        plus1Slug: 'sabedoria',
      }),
    ).toThrow();
  });

  it('rejects duplicate +1×3 targets', () => {
    expect(() =>
      applyBackgroundAbilityBoosts(base, {
        mode: BACKGROUND_BOOST_MODE_PLUS1X3,
        plus1Slugs: ['sabedoria', 'carisma', 'sabedoria'],
      }),
    ).toThrow();
  });

  it('validates allowed slugs from background', () => {
    expect(() =>
      assertBackgroundBoostSlugsAllowed(['sabedoria', 'carisma'], {
        mode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
        plus2Slug: 'forca',
        plus1Slug: 'carisma',
      }),
    ).toThrow();

    expect(() =>
      assertBackgroundBoostSlugsAllowed(
        ['sabedoria', 'carisma', 'inteligencia'],
        {
          mode: BACKGROUND_BOOST_MODE_PLUS1X3,
          plus1Slugs: ['sabedoria', 'carisma', 'forca'],
        },
      ),
    ).toThrow();
  });

  it('resolves payload to domain input', () => {
    expect(
      resolveBackgroundAbilityBoostInput({
        mode: 'plus1x3',
        plus1Slugs: ['sabedoria', 'carisma', 'inteligencia'],
      }),
    ).toEqual({
      mode: BACKGROUND_BOOST_MODE_PLUS1X3,
      plus1Slugs: ['sabedoria', 'carisma', 'inteligencia'],
    });
  });
});
