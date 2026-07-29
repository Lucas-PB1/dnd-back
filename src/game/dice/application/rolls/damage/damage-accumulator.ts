import { rollDamageParts } from '../../../domain/dice';

export type DamageAccumulator = {
  total: number;
  expression: string;
  rolls: number[];
  notes: string[];
};

export function createDamageAccumulator(
  total: number,
  expression: string,
  rolls: number[],
): DamageAccumulator {
  return {
    total,
    expression,
    rolls: [...rolls],
    notes: [],
  };
}

export function addDamagePart(
  acc: DamageAccumulator,
  dice: string,
  options?: { critical?: boolean; treatOnesAndTwosAsThree?: boolean },
): void {
  const part = rollDamageParts(dice, 0, options);
  acc.total += part.total;
  acc.expression = `${acc.expression}+${part.expression}`;
  acc.rolls.push(...(part.dice[0]?.rolls ?? []));
}

export function addFlatDamage(
  acc: DamageAccumulator,
  amount: number,
  note?: string,
): void {
  acc.total += amount;
  acc.expression = `${acc.expression}+${amount}`;
  if (note) {
    acc.notes.push(note);
  }
}

export function multiplyDamageTotal(
  acc: DamageAccumulator,
  factor: number,
  note: string,
): void {
  acc.total *= factor;
  acc.expression = `${factor}×(${acc.expression})`;
  acc.notes.push(note);
}
