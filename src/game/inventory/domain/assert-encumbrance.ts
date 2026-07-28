import { BadRequestException } from '@nestjs/common';
import {
  computeEncumbrance,
  parseItemWeightKg,
  projectedTotalWeightKg,
  type EncumbranceSummary,
} from './encumbrance';

export function assertWithinCarryingCapacity(input: {
  current: EncumbranceSummary;
  itemWeightKg: number;
  deltaQuantity: number;
  itemSlug: string;
}): void {
  if (input.deltaQuantity <= 0) return;
  const projected = projectedTotalWeightKg(
    input.current,
    input.itemWeightKg,
    input.deltaQuantity,
  );
  if (projected <= input.current.carryingCapacityKg) return;
  throw new BadRequestException(
    `Carga excedida ao adicionar '${input.itemSlug}': ` +
      `${projected} kg > capacidade ${input.current.carryingCapacityKg} kg (Força × 7,5).`,
  );
}

export function encumbranceFromCatalogRows(
  rows: readonly { weight: string | null; quantity: number }[],
  strengthScore: number,
): EncumbranceSummary {
  return computeEncumbrance(
    rows.map((row) => ({
      weightKg: parseItemWeightKg(row.weight),
      quantity: row.quantity,
    })),
    strengthScore,
  );
}
