import { resolveParryReduction } from './resolve-parry-reduction';

describe('resolveParryReduction', () => {
  it('adds max(STR, DEX) to the superiority die', () => {
    const r = resolveParryReduction({
      dieFaces: 8,
      dieRoll: 5,
      strengthMod: 3,
      dexterityMod: 4,
    });
    expect(r.reduction).toBe(9);
    expect(r.expression).toBe('1d8+4');
  });

  it('floors at zero when mods are negative', () => {
    const r = resolveParryReduction({
      dieFaces: 8,
      dieRoll: 1,
      strengthMod: -2,
      dexterityMod: -1,
    });
    expect(r.reduction).toBe(0);
  });
});
