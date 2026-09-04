import {
  applyFocusedInitiativeFloor,
  FOCUSED_INITIATIVE_TRAIT_SLUG,
  focusedInitiativeTakeCount,
  hasGiantkinStoneAncestry,
  hasInitiativeProficiency,
  resolveInitiativeAdvantageContributions,
  resolveInitiativeBonus,
} from './resolve-initiative-roll';

describe('resolveInitiativeRoll', () => {
  const base = {
    dexterityModifier: 3,
    wisdomModifier: 2,
    intelligenceModifier: 1,
    proficiencyBonus: 2,
    classSlug: 'fighter',
    subclassSlug: null as string | null,
    level: 5,
    characterFeats: [] as { featSlug: string }[],
  };

  it('adds PB once for alert or focused initiative', () => {
    expect(resolveInitiativeBonus(base).total).toBe(3);
    expect(
      resolveInitiativeBonus({
        ...base,
        characterFeats: [{ featSlug: 'alert' }],
      }).total,
    ).toBe(5);
    expect(
      resolveInitiativeBonus({
        ...base,
        heritageChoices: [
          { choiceKind: 'heritage_trait_1', choiceSlug: FOCUSED_INITIATIVE_TRAIT_SLUG },
        ],
      }).total,
    ).toBe(5);
    expect(
      resolveInitiativeBonus({
        ...base,
        characterFeats: [{ featSlug: 'alert' }],
        heritageChoices: [
          { choiceKind: 'heritage_trait_1', choiceSlug: FOCUSED_INITIATIVE_TRAIT_SLUG },
        ],
      }).notes,
    ).toEqual(
      expect.arrayContaining([
        'Alerta: +PB na Iniciativa',
        'Iniciativa Concentrada: +PB na Iniciativa',
      ]),
    );
  });

  it('adds gloom stalker wisdom and trapper guild intelligence', () => {
    expect(
      resolveInitiativeBonus({
        ...base,
        classSlug: 'ranger',
        subclassSlug: 'gloom-stalker',
        level: 3,
      }).total,
    ).toBe(5);
    expect(
      resolveInitiativeBonus({
        ...base,
        subclassSlug: 'trapper-guild',
        level: 7,
      }).total,
    ).toBe(4);
  });

  it('resolves automatic advantage sources', () => {
    expect(
      resolveInitiativeAdvantageContributions(
        { ...base, classSlug: 'barbarian', level: 7 },
        {},
      ).mode,
    ).toBe('advantage');
    expect(
      resolveInitiativeAdvantageContributions(
        { ...base, subclassSlug: 'champion', level: 3 },
        {},
      ).mode,
    ).toBe('advantage');
    expect(
      resolveInitiativeAdvantageContributions(
        {
          ...base,
          speciesChoices: [
            { choiceKind: 'giantkinAncestryId', choiceSlug: 'stone' },
          ],
        },
        { stonePulse: true },
      ).mode,
    ).toBe('advantage');
  });

  it('floors low d20 when focused initiative is taken twice', () => {
    const result = applyFocusedInitiativeFloor([7], [
      { choiceKind: 'heritage_trait_1', choiceSlug: FOCUSED_INITIATIVE_TRAIT_SLUG },
      { choiceKind: 'heritage_trait_2', choiceSlug: FOCUSED_INITIATIVE_TRAIT_SLUG },
    ]);
    expect(result.kept).toEqual([10]);
    expect(result.note).toContain('Iniciativa Concentrada');
  });

  it('detects initiative proficiency helpers', () => {
    expect(hasInitiativeProficiency({ characterFeats: [{ featSlug: 'alert' }] })).toBe(
      true,
    );
    expect(
      focusedInitiativeTakeCount([
        { choiceKind: 'heritage_trait_1', choiceSlug: FOCUSED_INITIATIVE_TRAIT_SLUG },
      ]),
    ).toBe(1);
    expect(
      hasGiantkinStoneAncestry([
        { choiceKind: 'giantkinAncestryId', choiceSlug: 'stone' },
      ]),
    ).toBe(true);
  });
});
