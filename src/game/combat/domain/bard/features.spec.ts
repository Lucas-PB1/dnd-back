import {
  bardicInspirationDie,
  bardicInspirationMaxUses,
  bardicInspirationRestRecovery,
  isBardClass,
} from './features';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('bard-features', () => {
  const bardBands = fixtureSchedulesFor('bard');

  it('identifies bard class correctly', () => {
    expect(isBardClass('bard')).toBe(true);
    expect(isBardClass('fighter')).toBe(false);
    expect(isBardClass(null)).toBe(false);
  });

  it('computes correct bardic inspiration die per level', () => {
    expect(bardicInspirationDie(1, bardBands)).toBe('d6');
    expect(bardicInspirationDie(4, bardBands)).toBe('d6');
    expect(bardicInspirationDie(5, bardBands)).toBe('d8');
    expect(bardicInspirationDie(9, bardBands)).toBe('d8');
    expect(bardicInspirationDie(10, bardBands)).toBe('d10');
    expect(bardicInspirationDie(14, bardBands)).toBe('d10');
    expect(bardicInspirationDie(15, bardBands)).toBe('d12');
    expect(bardicInspirationDie(20, bardBands)).toBe('d12');
  });

  it('computes max inspiration uses based on charisma score (min 1)', () => {
    expect(bardicInspirationMaxUses(16)).toBe(3);
    expect(bardicInspirationMaxUses(20)).toBe(5);
    expect(bardicInspirationMaxUses(8)).toBe(1);
  });

  it('computes rest recovery rule (short vs long rest)', () => {
    expect(bardicInspirationRestRecovery(1)).toBe('long');
    expect(bardicInspirationRestRecovery(4)).toBe('long');
    expect(bardicInspirationRestRecovery(5)).toBe('short');
    expect(bardicInspirationRestRecovery(10)).toBe('short');
  });
});
