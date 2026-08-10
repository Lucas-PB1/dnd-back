import {
  assertCharacterMayAttune,
  characterMatchesAttunementRestriction,
  parseAttunementRestriction,
} from './attunement-restriction';

describe('parseAttunementRestriction', () => {
  it('treats plain attunement as unrestricted', () => {
    expect(
      parseAttunementRestriction({
        requiresAttunement: true,
        attunement: 'Requer Sintonização',
      }),
    ).toEqual({ kind: 'unrestricted' });
  });

  it('parses single class', () => {
    expect(
      parseAttunementRestriction({
        attunement: 'Requer Sintonização por um Bruxo',
      }),
    ).toEqual({
      kind: 'restricted',
      classSlugs: ['warlock'],
      speciesSlugs: [],
      allowAnySpellcaster: false,
      clause: 'Bruxo',
    });
  });

  it('parses class list with ou', () => {
    const result = parseAttunementRestriction({
      attunement:
        'Requer Sintonização por um Bardo, Clérigo ou Druida',
    });
    expect(result.kind).toBe('restricted');
    if (result.kind !== 'restricted') return;
    expect(result.classSlugs.sort()).toEqual(['bard', 'cleric', 'druid']);
  });

  it('parses Conjurador', () => {
    expect(
      parseAttunementRestriction({
        attunement: 'Requer Sintonização por um Conjurador',
      }),
    ).toMatchObject({
      kind: 'restricted',
      allowAnySpellcaster: true,
      classSlugs: [],
    });
  });

  it('aliases Ranger to patrulheiro slug', () => {
    const result = parseAttunementRestriction({
      attunement: 'Requer Sintonização por um Druida ou Ranger',
    });
    expect(result.kind).toBe('restricted');
    if (result.kind !== 'restricted') return;
    expect(result.classSlugs.sort()).toEqual(['druid', 'ranger']);
  });

  it('allows narrative creature choice', () => {
    expect(
      parseAttunementRestriction({
        attunement:
          'Requer Sintonização por uma Criatura da Escolha da Arma',
      }),
    ).toEqual({ kind: 'unrestricted' });
  });
});

describe('characterMatchesAttunementRestriction', () => {
  it('allows matching class', () => {
    expect(
      characterMatchesAttunementRestriction({
        classSlug: 'wizard',
        speciesSlug: null,
        restriction: {
          kind: 'restricted',
          classSlugs: ['warlock', 'wizard'],
          speciesSlugs: [],
          allowAnySpellcaster: false,
          clause: 'Bruxo ou Mago',
        },
      }),
    ).toBe(true);
  });

  it('allows spellcaster for Conjurador', () => {
    expect(
      characterMatchesAttunementRestriction({
        classSlug: 'paladin',
        speciesSlug: null,
        restriction: {
          kind: 'restricted',
          classSlugs: [],
          speciesSlugs: [],
          allowAnySpellcaster: true,
          clause: 'Conjurador',
        },
      }),
    ).toBe(true);
  });

  it('rejects fighter for Conjurador', () => {
    expect(
      characterMatchesAttunementRestriction({
        classSlug: 'fighter',
        speciesSlug: null,
        restriction: {
          kind: 'restricted',
          classSlugs: [],
          speciesSlugs: [],
          allowAnySpellcaster: true,
          clause: 'Conjurador',
        },
      }),
    ).toBe(false);
  });
});

describe('assertCharacterMayAttune', () => {
  it('throws for wrong class', () => {
    expect(() =>
      assertCharacterMayAttune({
        itemLabel: 'cajado-da-cura',
        classSlug: 'fighter',
        speciesSlug: null,
        properties: {
          attunement: 'Requer Sintonização por um Bardo, Clérigo ou Druida',
        },
      }),
    ).toThrow(/cajado-da-cura/);
  });
});
