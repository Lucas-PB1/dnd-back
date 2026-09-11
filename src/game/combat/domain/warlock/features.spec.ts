import {
  healingLightDiceMax,
  isWarlockClass,
  magicalCunningSlotRecoveryCount,
  warlockInvocationLimit,
  warlockPactSlotCount,
  warlockPactSlotLevel,
} from './features';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('warlock-features', () => {
  const warlockBands = fixtureSchedulesFor('warlock');

  it('identifies warlock class correctly', () => {
    expect(isWarlockClass('warlock')).toBe(true);
    expect(isWarlockClass('sorcerer')).toBe(false);
  });

  it('computes pact slot level by warlock level', () => {
    expect(warlockPactSlotLevel(1, warlockBands)).toBe(1);
    expect(warlockPactSlotLevel(3, warlockBands)).toBe(2);
    expect(warlockPactSlotLevel(5, warlockBands)).toBe(3);
    expect(warlockPactSlotLevel(7, warlockBands)).toBe(4);
    expect(warlockPactSlotLevel(9, warlockBands)).toBe(5);
    expect(warlockPactSlotLevel(20, warlockBands)).toBe(5);
  });

  it('computes pact slot count by warlock level', () => {
    expect(warlockPactSlotCount(1, warlockBands)).toBe(1);
    expect(warlockPactSlotCount(2, warlockBands)).toBe(2);
    expect(warlockPactSlotCount(10, warlockBands)).toBe(2);
    expect(warlockPactSlotCount(11, warlockBands)).toBe(3);
    expect(warlockPactSlotCount(17, warlockBands)).toBe(4);
  });

  it('computes magical cunning recovery count', () => {
    expect(magicalCunningSlotRecoveryCount(2, warlockBands)).toBe(1);
    expect(magicalCunningSlotRecoveryCount(5, warlockBands)).toBe(1);
    expect(magicalCunningSlotRecoveryCount(11, warlockBands)).toBe(2);
    expect(magicalCunningSlotRecoveryCount(17, warlockBands)).toBe(2);
    expect(magicalCunningSlotRecoveryCount(20, warlockBands)).toBe(4);
  });

  it('computes warlock invocation limit by level', () => {
    expect(warlockInvocationLimit(1, warlockBands)).toBe(1);
    expect(warlockInvocationLimit(2, warlockBands)).toBe(3);
    expect(warlockInvocationLimit(5, warlockBands)).toBe(5);
    expect(warlockInvocationLimit(7, warlockBands)).toBe(6);
    expect(warlockInvocationLimit(9, warlockBands)).toBe(7);
    expect(warlockInvocationLimit(12, warlockBands)).toBe(8);
    expect(warlockInvocationLimit(15, warlockBands)).toBe(9);
    expect(warlockInvocationLimit(18, warlockBands)).toBe(10);
  });

  it('computes celestial healing light dice max pool', () => {
    expect(healingLightDiceMax(3)).toBe(4);
    expect(healingLightDiceMax(10)).toBe(11);
  });
});
