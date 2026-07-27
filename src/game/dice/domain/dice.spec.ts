import {
  parseDiceExpression,
  rollD20Check,
  rollDamageParts,
  rollDie,
  rollDice,
  rollExpression,
} from './dice';

describe('dice domain', () => {
  const fixed = (() => {
    const queue = [0.99, 0.0, 0.49, 0.74];
    let i = 0;
    return () => queue[i++ % queue.length];
  })();

  it('rollDie uses 1..sides', () => {
    expect(rollDie(6, () => 0)).toBe(1);
    expect(rollDie(6, () => 0.999)).toBe(6);
  });

  it('rollDice returns N faces', () => {
    expect(rollDice(3, 6, () => 0)).toEqual([1, 1, 1]);
  });

  it('parseDiceExpression reads NdM±K', () => {
    expect(parseDiceExpression('2d6+3')).toEqual({
      count: 2,
      sides: 6,
      modifier: 3,
    });
    expect(parseDiceExpression('1d8')).toEqual({
      count: 1,
      sides: 8,
      modifier: 0,
    });
  });

  it('rollExpression sums dice and modifier', () => {
    const result = rollExpression('2d6+1', () => 0);
    expect(result.total).toBe(3);
    expect(result.dice[0].rolls).toEqual([1, 1]);
  });

  it('rollD20Check applies advantage', () => {
    const result = rollD20Check(3, 'advantage', fixed);
    expect(result.d20.rolls).toHaveLength(2);
    expect(result.d20.kept[0]).toBe(Math.max(...result.d20.rolls));
    expect(result.total).toBe(result.d20.kept[0] + 3);
  });

  it('rollD20Check applies disadvantage', () => {
    const result = rollD20Check(0, 'disadvantage', fixed);
    expect(result.d20.kept[0]).toBe(Math.min(...result.d20.rolls));
  });

  it('rollDamageParts doubles dice on critical, not modifier', () => {
    const normal = rollDamageParts('1d8', 3, { rng: () => 0 });
    expect(normal.expression).toBe('1d8+3');
    expect(normal.total).toBe(4);

    const crit = rollDamageParts('1d8', 3, { critical: true, rng: () => 0 });
    expect(crit.expression).toBe('2d8+3');
    expect(crit.total).toBe(5);
    expect(crit.critical).toBe(true);
  });
});
