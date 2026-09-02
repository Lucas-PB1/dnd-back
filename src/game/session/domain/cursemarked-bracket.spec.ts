import {
  cursemarkedBracketNote,
  cursemarkedBracketTriggers,
  pickHighestCursemarkedBracket,
} from './cursemarked-bracket';

describe('cursemarked-bracket', () => {
  it('picks highest bracket benefit', () => {
    expect(pickHighestCursemarkedBracket([])).toBeNull();
    expect(pickHighestCursemarkedBracket(['tides-of-fate'])).toBe(
      'tides-of-fate',
    );
    expect(
      pickHighestCursemarkedBracket(['tides-of-fate', 'threads-entwined']),
    ).toBe('threads-entwined');
    expect(
      pickHighestCursemarkedBracket(['two-edged-gift', 'burdens-shield']),
    ).toBe('two-edged-gift');
  });

  it('triggers by kind and kept range', () => {
    expect(
      cursemarkedBracketTriggers({
        benefit: 'tides-of-fate',
        kind: 'save',
        kept: 3,
      }),
    ).toBe(true);
    expect(
      cursemarkedBracketTriggers({
        benefit: 'tides-of-fate',
        kind: 'attack',
        kept: 2,
      }),
    ).toBe(false);
    expect(
      cursemarkedBracketTriggers({
        benefit: 'burdens-shield',
        kind: 'skill',
        kept: 5,
      }),
    ).toBe(true);
    expect(
      cursemarkedBracketTriggers({
        benefit: 'burdens-shield',
        kind: 'skill',
        kept: 6,
      }),
    ).toBe(false);
    expect(
      cursemarkedBracketTriggers({
        benefit: 'two-edged-gift',
        kind: 'attack',
        kept: 9,
      }),
    ).toBe(true);
  });

  it('returns PT notes', () => {
    expect(cursemarkedBracketNote('tides-of-fate')).toMatch(/Marés do Destino/);
    expect(cursemarkedBracketNote('two-edged-gift')).toMatch(/Anti-overlap/);
  });
});
