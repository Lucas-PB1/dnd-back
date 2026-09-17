import {
  concentrationSaveDc,
  resolveConcentrationCheck,
} from './resolve-concentration-check';

jest.mock('@game/dice/domain/dice', () => ({
  rollD20Check: jest.fn((bonus: number) => ({
    total: 12 + bonus,
    d20: { kept: [12], rolls: [12] },
  })),
}));

describe('concentrationSaveDc', () => {
  it('is at least 10', () => {
    expect(concentrationSaveDc(5)).toBe(10);
    expect(concentrationSaveDc(0)).toBe(10);
  });

  it('uses half damage when higher than 10', () => {
    expect(concentrationSaveDc(22)).toBe(11);
    expect(concentrationSaveDc(30)).toBe(15);
  });
});

describe('resolveConcentrationCheck', () => {
  it('skips when not concentrating', () => {
    const r = resolveConcentrationCheck({
      damageTaken: 20,
      constitutionModifier: 2,
      concentratingOn: null,
    });
    expect(r.attempted).toBe(false);
    expect(r.broken).toBe(false);
  });

  it('maintains concentration when save meets DC', () => {
    // total 12+2=14 vs DC max(10, 10)=10
    const r = resolveConcentrationCheck({
      damageTaken: 20,
      constitutionModifier: 2,
      concentratingOn: 'bencao',
    });
    expect(r.attempted).toBe(true);
    expect(r.broken).toBe(false);
    expect(r.dc).toBe(10);
    expect(r.total).toBe(14);
  });

  it('breaks concentration when save fails', () => {
    // total 12+0=12 vs DC 15
    const r = resolveConcentrationCheck({
      damageTaken: 30,
      constitutionModifier: 0,
      concentratingOn: 'escuridao',
    });
    expect(r.attempted).toBe(true);
    expect(r.broken).toBe(true);
    expect(r.dc).toBe(15);
    expect(r.spellSlug).toBe('escuridao');
  });
});
