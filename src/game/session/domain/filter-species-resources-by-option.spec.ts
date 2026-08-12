import {
  choiceKindForOptionKey,
  filterSpeciesResourceScheduleByChoices,
  isSpeciesResourceAllowedByChoices,
} from './filter-species-resources-by-option';

describe('filter-species-resources-by-option', () => {
  it('maps catalog option_key to sheet choiceKind', () => {
    expect(choiceKindForOptionKey('bearfolkLineageId')).toBe(
      'bearfolk_lineage',
    );
    expect(choiceKindForOptionKey('giantkinAncestryId')).toBe(
      'giantkin_ancestry',
    );
  });

  it('keeps ungated resources', () => {
    expect(
      isSpeciesResourceAllowedByChoices(
        'bearfolk-apex-predator',
        [
          {
            resourceSlug: 'bearfolk-apex-predator',
            requiresOptionKey: null,
            requiresOptionValue: null,
          },
        ],
        [{ choiceKind: 'bearfolk_lineage', choiceSlug: 'andari' }],
      ),
    ).toBe(true);
  });

  it('drops bear-hug for Andari and keeps for Garhamr', () => {
    const gates = [
      {
        resourceSlug: 'bearfolk-bear-hug',
        requiresOptionKey: 'bearfolkLineageId',
        requiresOptionValue: 'garhamr',
      },
    ];
    expect(
      isSpeciesResourceAllowedByChoices('bearfolk-bear-hug', gates, [
        { choiceKind: 'bearfolk_lineage', choiceSlug: 'andari' },
      ]),
    ).toBe(false);
    expect(
      isSpeciesResourceAllowedByChoices('bearfolk-bear-hug', gates, [
        { choiceKind: 'bearfolk_lineage', choiceSlug: 'garhamr' },
      ]),
    ).toBe(true);
  });

  it('keeps shared pool when any ancestry gate matches (Goliath-style)', () => {
    const gates = [
      {
        resourceSlug: 'giant-ancestry',
        requiresOptionKey: 'giantAncestryId',
        requiresOptionValue: 'cloud',
      },
      {
        resourceSlug: 'giant-ancestry',
        requiresOptionKey: 'giantAncestryId',
        requiresOptionValue: 'fire',
      },
    ];
    expect(
      isSpeciesResourceAllowedByChoices('giant-ancestry', gates, [
        { choiceKind: 'giant_ancestry', choiceSlug: 'cloud' },
      ]),
    ).toBe(true);
  });

  it('filters schedule rows', () => {
    const rows = [
      { resourceSlug: 'bearfolk-apex-predator' },
      { resourceSlug: 'bearfolk-bear-hug' },
    ];
    const gates = [
      {
        resourceSlug: 'bearfolk-apex-predator',
        requiresOptionKey: null,
        requiresOptionValue: null,
      },
      {
        resourceSlug: 'bearfolk-bear-hug',
        requiresOptionKey: 'bearfolkLineageId',
        requiresOptionValue: 'garhamr',
      },
    ];
    expect(
      filterSpeciesResourceScheduleByChoices(rows, gates, [
        { choiceKind: 'bearfolk_lineage', choiceSlug: 'andari' },
      ]).map((r) => r.resourceSlug),
    ).toEqual(['bearfolk-apex-predator']);
  });
});
