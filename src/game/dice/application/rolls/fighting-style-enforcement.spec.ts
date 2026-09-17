import { rollDamageParts } from '@game/dice/domain/dice';

/**
 * Enforcement PVE-5c: GWF floor no path de dano (faces 1–2 → 3).
 * TWF continua coberto em weapon-attack.spec (light_bonus + ability).
 * Charger: gate em executeRollDamage (feat + melee).
 */
describe('fighting-style damage floors (PVE-5c)', () => {
  it('GWF treats 1 and 2 as 3 on damage dice', () => {
    const rng = (() => {
      const queue = [0, 0.1]; // → faces 1, 2 on d12
      let i = 0;
      return () => queue[i++ % queue.length]!;
    })();
    const result = rollDamageParts('2d12', 0, {
      treatOnesAndTwosAsThree: true,
      rng,
    });
    expect(result.dice[0]?.kept).toEqual([3, 3]);
    expect(result.total).toBe(6);
  });

  it('without GWF, ones stay ones (Elemental floor is separate)', () => {
    const result = rollDamageParts('1d8', 0, {
      treatOnesAndTwosAsThree: false,
      treatOnesAsTwos: false,
      rng: () => 0,
    });
    expect(result.dice[0]?.kept).toEqual([1]);
  });
});
