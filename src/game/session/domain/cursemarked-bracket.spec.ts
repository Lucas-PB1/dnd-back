import {
  cursemarkedBracketNote,
  cursemarkedBracketTriggers,
  pickHighestCursemarkedBracket,
  type CursemarkedBracketRule,
} from './cursemarked-bracket';

const RULES: readonly CursemarkedBracketRule[] = [
  {
    benefitKey: 'tides-of-fate',
    maxKept: 3,
    rollKinds: ['save'],
    note: 'Cursemarked — Marés do Destino: Anti-overlap.',
    rankOrder: 1,
  },
  {
    benefitKey: 'burdens-shield',
    maxKept: 5,
    rollKinds: ['save', 'skill'],
    note: 'Cursemarked — Escudo do Fardo: Anti-overlap.',
    rankOrder: 2,
  },
  {
    benefitKey: 'threads-entwined',
    maxKept: 7,
    rollKinds: ['save', 'skill', 'attack'],
    note: 'Cursemarked — Fios Entrelaçados: Anti-overlap.',
    rankOrder: 3,
  },
  {
    benefitKey: 'two-edged-gift',
    maxKept: 9,
    rollKinds: ['save', 'skill', 'attack'],
    note: 'Cursemarked — Dádiva de Dois Gumes: Anti-overlap.',
    rankOrder: 4,
  },
];

describe('cursemarked-bracket', () => {
  it('picks highest bracket benefit', () => {
    expect(pickHighestCursemarkedBracket([], RULES)).toBeNull();
    expect(
      pickHighestCursemarkedBracket(['tides-of-fate'], RULES)?.benefitKey,
    ).toBe('tides-of-fate');
    expect(
      pickHighestCursemarkedBracket(
        ['tides-of-fate', 'threads-entwined'],
        RULES,
      )?.benefitKey,
    ).toBe('threads-entwined');
    expect(
      pickHighestCursemarkedBracket(
        ['two-edged-gift', 'burdens-shield'],
        RULES,
      )?.benefitKey,
    ).toBe('two-edged-gift');
  });

  it('triggers by kind and kept range', () => {
    const tides = RULES[0]!;
    const burdens = RULES[1]!;
    const twoEdged = RULES[3]!;
    expect(
      cursemarkedBracketTriggers({ rule: tides, kind: 'save', kept: 3 }),
    ).toBe(true);
    expect(
      cursemarkedBracketTriggers({ rule: tides, kind: 'attack', kept: 2 }),
    ).toBe(false);
    expect(
      cursemarkedBracketTriggers({ rule: burdens, kind: 'skill', kept: 5 }),
    ).toBe(true);
    expect(
      cursemarkedBracketTriggers({ rule: burdens, kind: 'skill', kept: 6 }),
    ).toBe(false);
    expect(
      cursemarkedBracketTriggers({ rule: twoEdged, kind: 'attack', kept: 9 }),
    ).toBe(true);
  });

  it('returns PT notes', () => {
    expect(cursemarkedBracketNote(RULES[0]!)).toMatch(/Marés do Destino/);
    expect(cursemarkedBracketNote(RULES[3]!)).toMatch(/Anti-overlap/);
  });
});
