/**
 * Tabela PHB 2024 PT (apresentação SI).
 * Persistência pode continuar imperial (`speed_ft`, `reach_ft`, `*_lb`).
 *
 * 1 pé = 30 cm · 1 libra = 500 g · 1 milha = 1,5 km
 */

export const METERS_PER_FOOT = 0.3;
export const KG_PER_POUND = 0.5;

export function roundMetric(value: number): number {
  return Math.round(value * 100) / 100;
}

export function feetToMeters(feet: number): number {
  return roundMetric(feet * METERS_PER_FOOT);
}

export function poundsToKg(pounds: number): number {
  return roundMetric(pounds * KG_PER_POUND);
}
