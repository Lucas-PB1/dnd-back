import { resolveAttackVsArmorClass } from './attack-vs-armor-class';

describe('resolveAttackVsArmorClass', () => {
  it('misses on a natural 1 even if the total beats AC', () => {
    expect(
      resolveAttackVsArmorClass({
        attackTotal: 21,
        targetAc: 10,
        naturalD20: 1,
      }),
    ).toEqual({ hit: false, critical: false });
  });

  it('crits and hits on a natural 20 even if the total is below AC', () => {
    expect(
      resolveAttackVsArmorClass({
        attackTotal: 12,
        targetAc: 18,
        naturalD20: 20,
      }),
    ).toEqual({ hit: true, critical: true });
  });

  it('hits when the total meets AC', () => {
    expect(
      resolveAttackVsArmorClass({
        attackTotal: 15,
        targetAc: 15,
        naturalD20: 10,
      }),
    ).toEqual({ hit: true, critical: false });
  });

  it('misses when the total is below AC', () => {
    expect(
      resolveAttackVsArmorClass({
        attackTotal: 14,
        targetAc: 15,
        naturalD20: 9,
      }),
    ).toEqual({ hit: false, critical: false });
  });

  it('uses a custom crit threshold', () => {
    expect(
      resolveAttackVsArmorClass({
        attackTotal: 8,
        targetAc: 20,
        naturalD20: 19,
        critThreshold: 19,
      }),
    ).toEqual({ hit: true, critical: true });
  });
});
