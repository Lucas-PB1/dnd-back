import {
  classSpellcastingMode,
  countSpellsByType,
  findSpellQuotaViolation,
  wizardSpellbookLimitAtLevel,
} from './spell-quota';

describe('spell-quota', () => {
  const catalog = [
    { slug: 'luz', level: 0 },
    { slug: 'alarme', level: 1 },
    { slug: 'escudo', level: 1 },
    { slug: 'bola-de-fogo', level: 3 },
  ];

  it('classifies casting modes', () => {
    expect(classSpellcastingMode('wizard')).toBe('wizard');
    expect(classSpellcastingMode('cleric')).toBe('prepared');
    expect(classSpellcastingMode('bard')).toBe('known');
  });

  it('counts prepared/known excluding always_prepared and non-catalog', () => {
    expect(
      countSpellsByType(
        [
          { spellSlug: 'luz', listType: 'known' },
          { spellSlug: 'alarme', listType: 'prepared' },
          { spellSlug: 'escudo', listType: 'known' },
          { spellSlug: 'marca-divina', listType: 'always_prepared' },
          { spellSlug: 'feat-only', listType: 'known' },
        ],
        catalog,
      ),
    ).toEqual({
      cantrips: 1,
      leveledKnown: 2,
      leveledPrepared: 1,
    });
  });

  it('computes wizard spellbook limit', () => {
    expect(wizardSpellbookLimitAtLevel(1, 4)).toBe(6);
    expect(wizardSpellbookLimitAtLevel(5, 9)).toBe(14);
  });

  it('flags prepared quota overflow', () => {
    expect(
      findSpellQuotaViolation({
        classSlug: 'cleric',
        level: 1,
        characterSpells: [
          { spellSlug: 'alarme', listType: 'prepared' },
          { spellSlug: 'escudo', listType: 'prepared' },
        ],
        catalog,
        cantripsMax: 3,
        preparedOrKnownMax: 1,
      }),
    ).toEqual({ kind: 'prepared', count: 2, max: 1 });
  });

  it('flags wizard spellbook overflow', () => {
    const spells = Array.from({ length: 7 }, (_, i) => ({
      spellSlug: `w${i}`,
      listType: 'known' as const,
    }));
    const catalogExtra = Array.from({ length: 7 }, (_, i) => ({
      slug: `w${i}`,
      level: 1,
    }));
    expect(
      findSpellQuotaViolation({
        classSlug: 'wizard',
        level: 1,
        characterSpells: spells,
        catalog: catalogExtra,
        cantripsMax: 3,
        preparedOrKnownMax: 1,
      }),
    ).toEqual({ kind: 'spellbook', count: 7, max: 6 });
  });
});
