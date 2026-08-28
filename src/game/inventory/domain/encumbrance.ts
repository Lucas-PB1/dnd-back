import { poundsToKg } from '@game/shared/domain/metric';

/**
 * Carga (PHB 2024 PT): capacidade = Força × 7,5 kg
 * (equivalente métrico de STR × 15 lb).
 */

export function parseItemWeightKg(weight: string | null | undefined): number {
  if (!weight?.trim()) return 0;
  const trimmed = weight.trim();
  const kgMatch = trimmed.match(/^(\d+(?:[.,]\d+)?)\s*kg$/i);
  if (kgMatch) {
    const value = Number(kgMatch[1].replace(',', '.'));
    return Number.isFinite(value) ? value : 0;
  }
  const lbMatch = trimmed.match(
    /^(\d+(?:[.,]\d+)?)\s*(?:lb\.?|lbs\.?|libras?|pounds?)$/i,
  );
  if (lbMatch) {
    const value = Number(lbMatch[1].replace(',', '.'));
    return Number.isFinite(value) ? poundsToKg(value) : 0;
  }
  return 0;
}

export function carryingCapacityKg(strengthScore: number): number {
  const score = Number.isFinite(strengthScore) ? Math.max(0, strengthScore) : 0;
  return Math.round(score * 7.5 * 100) / 100;
}

export type EncumbranceLine = {
  weightKg: number;
  quantity: number;
};

export type EncumbranceSummary = {
  totalWeightKg: number;
  carryingCapacityKg: number;
  encumbered: boolean;
};

export function computeEncumbrance(
  lines: readonly EncumbranceLine[],
  strengthScore: number,
): EncumbranceSummary {
  const raw = lines.reduce(
    (sum, line) => sum + line.weightKg * Math.max(0, line.quantity),
    0,
  );
  const totalWeightKg = Math.round(raw * 100) / 100;
  const capacity = carryingCapacityKg(strengthScore);
  return {
    totalWeightKg,
    carryingCapacityKg: capacity,
    encumbered: totalWeightKg > capacity,
  };
}

/** Peso projetado após adicionar `deltaQuantity` unidades de `itemWeightKg`. */
export function projectedTotalWeightKg(
  current: EncumbranceSummary,
  itemWeightKg: number,
  deltaQuantity: number,
): number {
  const next = current.totalWeightKg + itemWeightKg * deltaQuantity;
  return Math.round(next * 100) / 100;
}
