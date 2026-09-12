

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
