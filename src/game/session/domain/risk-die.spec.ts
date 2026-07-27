import { riskDieFaces, riskDieLabel } from './risk-die';

describe('riskDie', () => {
  it('returns null before level 2', () => {
    expect(riskDieFaces(1)).toBeNull();
    expect(riskDieLabel(1)).toBeNull();
  });

  it('follows Valda die schedule', () => {
    expect(riskDieFaces(2)).toBe(8);
    expect(riskDieFaces(9)).toBe(8);
    expect(riskDieFaces(10)).toBe(10);
    expect(riskDieFaces(17)).toBe(10);
    expect(riskDieFaces(18)).toBe(12);
    expect(riskDieFaces(20)).toBe(12);
    expect(riskDieLabel(5)).toBe('d8');
    expect(riskDieLabel(12)).toBe('d10');
    expect(riskDieLabel(20)).toBe('d12');
  });
});
