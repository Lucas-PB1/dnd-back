import { BadRequestException } from '@nestjs/common';
import {
  assertWithinCarryingCapacity,
  encumbranceFromCatalogRows,
} from './assert-encumbrance';
import { computeEncumbrance } from './encumbrance';

describe('assert-encumbrance', () => {
  it('skips check when removing or zero quantity', () => {
    const current = computeEncumbrance([{ weightKg: 70, quantity: 1 }], 10);
    expect(() =>
      assertWithinCarryingCapacity({
        current,
        itemWeightKg: 50,
        deltaQuantity: 0,
        itemSlug: 'anvil',
      }),
    ).not.toThrow();
    expect(() =>
      assertWithinCarryingCapacity({
        current,
        itemWeightKg: 50,
        deltaQuantity: -1,
        itemSlug: 'anvil',
      }),
    ).not.toThrow();
  });

  it('allows additions within carrying capacity', () => {
    const current = computeEncumbrance([{ weightKg: 50, quantity: 1 }], 10);
    expect(() =>
      assertWithinCarryingCapacity({
        current,
        itemWeightKg: 5,
        deltaQuantity: 4,
        itemSlug: 'rope',
      }),
    ).not.toThrow();
  });

  it('throws with item slug when projected weight exceeds capacity', () => {
    const current = computeEncumbrance([{ weightKg: 70, quantity: 1 }], 10);
    expect(() =>
      assertWithinCarryingCapacity({
        current,
        itemWeightKg: 10,
        deltaQuantity: 1,
        itemSlug: 'plate-armor',
      }),
    ).toThrow(BadRequestException);
    expect(() =>
      assertWithinCarryingCapacity({
        current,
        itemWeightKg: 10,
        deltaQuantity: 1,
        itemSlug: 'plate-armor',
      }),
    ).toThrow(/plate-armor/);
  });

  it('builds encumbrance summary from catalog weight strings', () => {
    const summary = encumbranceFromCatalogRows(
      [
        { weight: '2 kg', quantity: 2 },
        { weight: '0,5 kg', quantity: 4 },
        { weight: null, quantity: 1 },
      ],
      12,
    );
    expect(summary.totalWeightKg).toBe(6);
    expect(summary.carryingCapacityKg).toBe(90);
    expect(summary.encumbered).toBe(false);
  });
});
