import { turnCheckIntoNaturalTwenty } from './stroke-of-luck';

describe('turnCheckIntoNaturalTwenty', () => {
  it('replaces the kept d20 with 20 without rerolling the original check', () => {
    const result = turnCheckIntoNaturalTwenty({
      expression: '1d20+5',
      total: 9,
      modifier: 5,
      mode: 'normal',
      d20: {
        count: 1,
        sides: 20,
        rolls: [4],
        kept: [4],
      },
    });

    expect(result.total).toBe(25);
    expect(result.d20.rolls).toEqual([4, 20]);
    expect(result.d20.kept).toEqual([20]);
    expect(result.expression).toContain('Golpe de Sorte');
  });
});
