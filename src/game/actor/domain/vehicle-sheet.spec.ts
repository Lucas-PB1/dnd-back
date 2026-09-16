import {
  clampVehicleMetric,
  formatVehicleMetricsNote,
  isVehicleSheetAction,
} from './vehicle-sheet';

describe('vehicle-sheet', () => {
  it('reconhece ações de ficha', () => {
    expect(isVehicleSheetAction('set-metrics')).toBe(true);
    expect(isVehicleSheetAction('ram')).toBe(false);
  });

  it('limita métrica à capacidade quando ela existe', () => {
    expect(clampVehicleMetric(90, 80)).toBe(80);
    expect(clampVehicleMetric(-2, 10)).toBe(0);
    expect(clampVehicleMetric(12, null)).toBe(12);
  });

  it('formata nota de métricas', () => {
    expect(
      formatVehicleMetricsNote({
        crewCurrent: 2,
        crewCapacity: 10,
        passengerCurrent: 0,
        passengerCapacity: null,
        cargoCurrentLb: 500,
        cargoCapacityLb: 2000,
      }),
    ).toBe('Métricas: 2/10 tripulação; 0 passageiros; 500/2000 lb carga.');
  });
});
