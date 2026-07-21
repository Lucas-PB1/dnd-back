import { applyFeatAbilityIncreases } from './feat-ability-boost';

describe('applyFeatAbilityIncreases', () => {
  const base = {
    forca: 10,
    destreza: 10,
    constituicao: 10,
    inteligencia: 14,
    sabedoria: 12,
    carisma: 8,
  };

  it('adds +1 from abilityIncrease feat options', () => {
    const result = applyFeatAbilityIncreases(base, [
      {
        featSlug: 'elemental-adept',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'inteligencia',
      },
    ]);
    expect(result.inteligencia).toBe(15);
    expect(result.forca).toBe(10);
  });

  it('caps non-epic abilityIncrease at 20', () => {
    const high = { ...base, carisma: 20 };
    const result = applyFeatAbilityIncreases(high, [
      {
        featSlug: 'elemental-adept',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'carisma',
      },
    ]);
    expect(result.carisma).toBe(20);
  });

  it('caps epic boon abilityIncrease at 30', () => {
    const high = { ...base, carisma: 29 };
    const epicBoons = new Set(['boon-of-fortitude']);
    const result = applyFeatAbilityIncreases(
      high,
      [
        {
          featSlug: 'boon-of-fortitude',
          instanceIndex: 0,
          optionKey: 'abilityIncrease',
          valueId: 'carisma',
        },
      ],
      { epicBoonFeatSlugs: epicBoons },
    );
    expect(result.carisma).toBe(30);
  });

  it('does not exceed 30 for epic boon abilityIncrease', () => {
    const high = { ...base, carisma: 30 };
    const epicBoons = new Set(['boon-of-fortitude']);
    const result = applyFeatAbilityIncreases(
      high,
      [
        {
          featSlug: 'boon-of-fortitude',
          instanceIndex: 0,
          optionKey: 'abilityIncrease',
          valueId: 'carisma',
        },
      ],
      { epicBoonFeatSlugs: epicBoons },
    );
    expect(result.carisma).toBe(30);
  });

  it('applies +2 from ability-score-improvement', () => {
    const result = applyFeatAbilityIncreases(base, [
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: 0,
        optionKey: 'distributionMode',
        valueId: 'plus2',
      },
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: 0,
        optionKey: 'primaryAbility',
        valueId: 'forca',
      },
    ]);
    expect(result.forca).toBe(12);
  });

  it('applies +1/+1 from ability-score-improvement', () => {
    const result = applyFeatAbilityIncreases(base, [
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: 0,
        optionKey: 'distributionMode',
        valueId: 'plus1plus1',
      },
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: 0,
        optionKey: 'primaryAbility',
        valueId: 'forca',
      },
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: 0,
        optionKey: 'secondaryAbility',
        valueId: 'destreza',
      },
    ]);
    expect(result.forca).toBe(11);
    expect(result.destreza).toBe(11);
  });
});
