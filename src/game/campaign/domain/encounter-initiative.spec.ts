import {
  advanceEncounterTurn,
  compareInitiativeOrder,
  hitPointsPercent,
  sortCombatantsByInitiative,
} from './encounter-initiative';

describe('encounter-initiative', () => {
  it('sorts by total desc then modifier then name', () => {
    const sorted = sortCombatantsByInitiative([
      {
        combatantId: '1',
        displayName: 'Bob',
        initiativeTotal: 15,
        initiativeModifier: 2,
        isActive: true,
      },
      {
        combatantId: '2',
        displayName: 'Ana',
        initiativeTotal: 15,
        initiativeModifier: 3,
        isActive: true,
      },
      {
        combatantId: '3',
        displayName: 'Cid',
        initiativeTotal: 18,
        initiativeModifier: 1,
        isActive: true,
      },
      {
        combatantId: '4',
        displayName: 'Dan',
        initiativeTotal: null,
        initiativeModifier: null,
        isActive: true,
      },
    ]);
    expect(sorted.map((row) => row.displayName)).toEqual([
      'Cid',
      'Ana',
      'Bob',
      'Dan',
    ]);
  });

  it('puts inactive after active', () => {
    expect(
      compareInitiativeOrder(
        {
          combatantId: 'a',
          displayName: 'X',
          initiativeTotal: 20,
          initiativeModifier: 5,
          isActive: false,
        },
        {
          combatantId: 'b',
          displayName: 'Y',
          initiativeTotal: 1,
          initiativeModifier: 0,
          isActive: true,
        },
      ),
    ).toBe(1);
  });

  it('advances turn and round', () => {
    expect(
      advanceEncounterTurn({
        currentTurnIndex: 0,
        round: 1,
        activeCount: 2,
      }),
    ).toEqual({ currentTurnIndex: 1, round: 1 });
    expect(
      advanceEncounterTurn({
        currentTurnIndex: 1,
        round: 1,
        activeCount: 2,
      }),
    ).toEqual({ currentTurnIndex: 0, round: 2 });
  });

  it('computes hit points percent', () => {
    expect(hitPointsPercent(25, 50)).toBe(50);
    expect(hitPointsPercent(0, 40)).toBe(0);
    expect(hitPointsPercent(null, 40)).toBeNull();
  });
});
