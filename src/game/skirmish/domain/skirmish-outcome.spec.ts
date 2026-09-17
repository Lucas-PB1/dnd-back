import {
  skirmishForfeitPatch,
  skirmishWinnerFromHitPoints,
} from './skirmish-outcome';

describe('skirmishWinnerFromHitPoints', () => {
  it('keeps the fight going while both sides have HP', () => {
    expect(skirmishWinnerFromHitPoints(12, 7)).toBeNull();
  });

  it('awards the PC when the creature is at 0 HP', () => {
    expect(skirmishWinnerFromHitPoints(4, 0)).toBe('pc');
  });

  it('awards the creature when the PC is at 0 HP', () => {
    expect(skirmishWinnerFromHitPoints(0, 9)).toBe('actor');
  });
});

describe('skirmishForfeitPatch', () => {
  it('ends the fight without a winner', () => {
    expect(skirmishForfeitPatch()).toEqual({
      status: 'finished',
      endReason: 'forfeit',
      winnerKind: null,
    });
  });
});
