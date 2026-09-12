import { applyCursemarkedBracketIfTriggered } from './apply-cursemarked-bracket';
import { CURSEMARKED_BRACKET_LOCK } from '@game/session/domain/cursemarked-bracket';
import { loadActiveCursemarkedBracketBenefit } from '@game/session/infrastructure/queries/cursemarked-bracket.queries';
import { asRollDep } from './roll-damage.spec.helpers';

jest.mock(
  '@game/session/infrastructure/queries/cursemarked-bracket.queries',
  () => ({
    loadActiveCursemarkedBracketBenefit: jest.fn(),
  }),
);

const loadBracket = loadActiveCursemarkedBracketBenefit as jest.MockedFunction<
  typeof loadActiveCursemarkedBracketBenefit
>;

const tides = {
  benefitKey: 'tides-of-fate',
  maxKept: 3,
  rollKinds: ['save'] as const,
  note: 'Cursemarked — Marés do Destino: Anti-overlap.',
  rankOrder: 1,
};

const burdens = {
  benefitKey: 'burdens-shield',
  maxKept: 5,
  rollKinds: ['save', 'skill'] as const,
  note: 'Cursemarked — Escudo do Fardo: Anti-overlap.',
  rankOrder: 2,
};

const threads = {
  benefitKey: 'threads-entwined',
  maxKept: 7,
  rollKinds: ['save', 'skill', 'attack'] as const,
  note: 'Cursemarked — Fios Entrelaçados: Anti-overlap.',
  rankOrder: 3,
};

describe('applyCursemarkedBracketIfTriggered', () => {
  const character = asRollDep({ id: 'pc-1', level: 5 });
  const dataSource = asRollDep({});

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('no-ops without active bracket', async () => {
    loadBracket.mockResolvedValue(null);
    const notes: string[] = [];
    const resourceSpender = {
      getResourcesUsedEntry: jest.fn(),
      setResourcesUsedEntry: jest.fn(),
    };

    await applyCursemarkedBracketIfTriggered({
      dataSource,
      character,
      resourceSpender: asRollDep(resourceSpender),
      kind: 'save',
      kept: 2,
      notes,
    });

    expect(notes).toEqual([]);
    expect(resourceSpender.setResourcesUsedEntry).not.toHaveBeenCalled();
  });

  it('no-ops when kind or kept outside range', async () => {
    loadBracket.mockResolvedValue(tides);
    const notes: string[] = [];
    const resourceSpender = {
      getResourcesUsedEntry: jest.fn(),
      setResourcesUsedEntry: jest.fn(),
    };

    await applyCursemarkedBracketIfTriggered({
      dataSource,
      character,
      resourceSpender: asRollDep(resourceSpender),
      kind: 'attack',
      kept: 2,
      notes,
    });

    expect(notes).toEqual([]);
    expect(resourceSpender.getResourcesUsedEntry).not.toHaveBeenCalled();
  });

  it('no-ops silently when lock is set', async () => {
    loadBracket.mockResolvedValue(burdens);
    const notes: string[] = [];
    const resourceSpender = {
      getResourcesUsedEntry: jest.fn().mockResolvedValue(1),
      setResourcesUsedEntry: jest.fn(),
    };

    await applyCursemarkedBracketIfTriggered({
      dataSource,
      character,
      resourceSpender: asRollDep(resourceSpender),
      kind: 'save',
      kept: 4,
      notes,
    });

    expect(notes).toEqual([]);
    expect(resourceSpender.setResourcesUsedEntry).not.toHaveBeenCalled();
  });

  it('pushes note and sets lock on trigger', async () => {
    loadBracket.mockResolvedValue(threads);
    const notes: string[] = [];
    const resourceSpender = {
      getResourcesUsedEntry: jest.fn().mockResolvedValue(0),
      setResourcesUsedEntry: jest.fn(),
    };

    await applyCursemarkedBracketIfTriggered({
      dataSource,
      character,
      resourceSpender: asRollDep(resourceSpender),
      kind: 'attack',
      kept: 7,
      notes,
    });

    expect(notes[0]).toMatch(/Fios Entrelaçados/);
    expect(resourceSpender.setResourcesUsedEntry).toHaveBeenCalledWith(
      character,
      CURSEMARKED_BRACKET_LOCK,
      1,
    );
  });
});
