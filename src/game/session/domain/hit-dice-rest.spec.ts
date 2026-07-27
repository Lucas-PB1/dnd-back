import {
  grantHitDiceOnLevelUp,
  restoreHitDiceOnLongRest,
  spendHitDice,
} from './hit-dice-rest';

describe('hit-dice-rest', () => {
  it('spends hit dice and heals with CON mod (min 0 per die)', () => {
    const result = spendHitDice({
      hitDiceCurrent: 3,
      hitDiceMax: 5,
      hitDiceSpent: 2,
      hitDieLabel: 'D10',
      constitutionModifier: 2,
      hitPointsCurrent: 10,
      hitPointsMax: 40,
      rng: () => 0, // faces = 1
    });
    expect(result.rolls).toEqual([1, 1]);
    expect(result.rawHealed).toBe(6);
    expect(result.hitPointsHealed).toBe(6);
    expect(result.hitPointsCurrent).toBe(16);
    expect(result.hitDiceRemaining).toBe(1);
  });

  it('clamps healing to hit points max', () => {
    const result = spendHitDice({
      hitDiceCurrent: 1,
      hitDiceMax: 1,
      hitDiceSpent: 1,
      hitDieLabel: 'd8',
      constitutionModifier: 5,
      hitPointsCurrent: 18,
      hitPointsMax: 20,
      rng: () => 0.99,
    });
    expect(result.hitPointsHealed).toBe(2);
    expect(result.hitPointsCurrent).toBe(20);
  });

  it('restores half hit dice on long rest (min 1)', () => {
    expect(restoreHitDiceOnLongRest(0, 5)).toBe(2);
    expect(restoreHitDiceOnLongRest(1, 1)).toBe(1);
    expect(restoreHitDiceOnLongRest(4, 5)).toBe(5);
  });

  it('grants hit dice on level up', () => {
    expect(grantHitDiceOnLevelUp(3, 3, 4)).toBe(4);
    expect(grantHitDiceOnLevelUp(0, 3, 4)).toBe(1);
  });
});
