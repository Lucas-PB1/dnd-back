import {
  carryingCapacityKg,
  computeEncumbrance,
  parseItemWeightKg,
  projectedTotalWeightKg,
} from './encumbrance';
import { assertWithinCarryingCapacity } from './assert-encumbrance';

describe('encumbrance', () => {
  it('parses PT weight strings', () => {
    expect(parseItemWeightKg('0,5 kg')).toBe(0.5);
    expect(parseItemWeightKg('2 kg')).toBe(2);
    expect(parseItemWeightKg('5 lb.')).toBe(2.5);
    expect(parseItemWeightKg('100 libras')).toBe(50);
    expect(parseItemWeightKg(null)).toBe(0);
    expect(parseItemWeightKg('unknown')).toBe(0);
  });

  it('computes capacity as strength × 7.5', () => {
    expect(carryingCapacityKg(10)).toBe(75);
    expect(carryingCapacityKg(8)).toBe(60);
  });

  it('flags encumbered when over capacity', () => {
    const summary = computeEncumbrance(
      [
        { weightKg: 40, quantity: 1 },
        { weightKg: 20, quantity: 2 },
      ],
      10,
    );
    expect(summary.totalWeightKg).toBe(80);
    expect(summary.carryingCapacityKg).toBe(75);
    expect(summary.encumbered).toBe(true);
  });

  it('projects added weight', () => {
    const current = computeEncumbrance([{ weightKg: 70, quantity: 1 }], 10);
    expect(projectedTotalWeightKg(current, 10, 1)).toBe(80);
  });

  it('assertWithinCarryingCapacity throws when over', () => {
    const current = computeEncumbrance([{ weightKg: 70, quantity: 1 }], 10);
    expect(() =>
      assertWithinCarryingCapacity({
        current,
        itemWeightKg: 10,
        deltaQuantity: 1,
        itemSlug: 'plate',
      }),
    ).toThrow(/Carga excedida/);
  });
});
