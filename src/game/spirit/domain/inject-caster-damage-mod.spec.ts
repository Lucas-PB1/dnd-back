import { injectCasterDamageMod } from './inject-caster-damage-mod';

describe('injectCasterDamageMod (PVE-7b)', () => {
  it('replaces +0 with casting ability mod', () => {
    expect(injectCasterDamageMod('1d8+0', 4)).toBe('1d8+4');
  });

  it('uses 0 when mod is null', () => {
    expect(injectCasterDamageMod('1d8+0', null)).toBe('1d8+0');
  });

  it('leaves expressions without +0 marker unchanged', () => {
    expect(injectCasterDamageMod('3d10', 5)).toBe('3d10');
    expect(injectCasterDamageMod('1d8+4', 3)).toBe('1d8+4');
  });
});
