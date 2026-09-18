import { divineStrikeDice, isClericClass } from './features';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('cleric-features', () => {
  const clericBands = fixtureSchedulesFor('cleric');

  it('identifies only the Cleric class', () => {
    expect(isClericClass('cleric')).toBe(true);
    expect(isClericClass('paladin')).toBe(false);
    expect(isClericClass(null)).toBe(false);
  });

  it('scales Divine Strike at levels 7 and 14', () => {
    expect(divineStrikeDice(6, clericBands)).toBeNull();
    expect(divineStrikeDice(7, clericBands)).toBe('1d8');
    expect(divineStrikeDice(14, clericBands)).toBe('2d8');
  });
});
