export const VEHICLE_SHEET_ACTIONS = [
  'board',
  'dismount',
  'set-metrics',
  'helm',
] as const;

export type VehicleSheetAction = (typeof VEHICLE_SHEET_ACTIONS)[number];

export function isVehicleSheetAction(
  value: string,
): value is VehicleSheetAction {
  return (VEHICLE_SHEET_ACTIONS as readonly string[]).includes(value);
}

/** Capacidade nula = sem teto (só ≥ 0). */
export function clampVehicleMetric(
  value: number,
  capacity: number | null | undefined,
): number {
  const n = Math.max(0, Math.floor(value));
  if (capacity == null) return n;
  return Math.min(capacity, n);
}

export function formatVehicleMetricsNote(input: {
  crewCurrent: number;
  crewCapacity: number | null;
  passengerCurrent: number;
  passengerCapacity: number | null;
  cargoCurrentLb: number;
  cargoCapacityLb: number | null;
}): string {
  const crew =
    input.crewCapacity == null
      ? `${input.crewCurrent} tripulação`
      : `${input.crewCurrent}/${input.crewCapacity} tripulação`;
  const passengers =
    input.passengerCapacity == null
      ? `${input.passengerCurrent} passageiros`
      : `${input.passengerCurrent}/${input.passengerCapacity} passageiros`;
  const cargo =
    input.cargoCapacityLb == null
      ? `${input.cargoCurrentLb} lb carga`
      : `${input.cargoCurrentLb}/${input.cargoCapacityLb} lb carga`;
  return `Métricas: ${crew}; ${passengers}; ${cargo}.`;
}
