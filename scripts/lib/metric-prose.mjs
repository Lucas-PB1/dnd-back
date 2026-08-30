/**
 * Conversão imperial → SI em prosa (espelha dnd-front/src/shared/lib/metric.ts).
 */

export const METERS_PER_FOOT = 0.3;
export const KG_PER_POUND = 0.5;
export const KM_PER_MILE = 1.5;

export function roundMetric(value) {
  return Math.round(value * 100) / 100;
}

export function formatMetricNumber(value) {
  const rounded = roundMetric(value);
  if (Number.isInteger(rounded)) return String(rounded);
  return String(rounded).replace('.', ',');
}

export function feetToMeters(feet) {
  return roundMetric(feet * METERS_PER_FOOT);
}

export function poundsToKg(pounds) {
  return roundMetric(pounds * KG_PER_POUND);
}

export function mphToKmh(mph) {
  return roundMetric(mph * KM_PER_MILE);
}

export function milesToKm(miles) {
  return roundMetric(miles * KM_PER_MILE);
}

export function formatMetersFromFeet(feet) {
  return `${formatMetricNumber(feetToMeters(feet))} m`;
}

export function formatKgFromPounds(pounds) {
  return `${formatMetricNumber(poundsToKg(pounds))} kg`;
}

function parseLooseNumber(raw) {
  return Number(raw.replace(',', '.'));
}

/** Converte medidas imperiais em prosa para SI. */
export function toMetricProse(text) {
  if (!text) return text;

  return text
    .replace(
      /(\d+(?:[.,]\d+)?)\s*\/\s*(\d+(?:[.,]\d+)?)\s*(?:pés|pes|feet|ft\.|ft)(?!\w)/gi,
      (_match, min, max) =>
        `${formatMetricNumber(feetToMeters(parseLooseNumber(min)))}/${formatMetersFromFeet(parseLooseNumber(max))}`,
    )
    .replace(
      /(\d+(?:[.,]\d+)?)\s*(?:pés|pes|feet|ft\.|ft|-foot|-feet)(?!\w)/gi,
      (_match, raw) => formatMetersFromFeet(parseLooseNumber(raw)),
    )
    .replace(
      /(\d+(?:[.,]\d+)?)\s*mph\b/gi,
      (_match, raw) => `${formatMetricNumber(mphToKmh(parseLooseNumber(raw)))} km/h`,
    )
    .replace(
      /(\d+(?:[.,]\d+)?)\s*(?:milhas?|miles?)\b/gi,
      (_match, raw) => `${formatMetricNumber(milesToKm(parseLooseNumber(raw)))} km`,
    )
    .replace(
      /(\d+(?:[.,]\d+)?)\s*(?:libras?|pounds?|lbs\.|lb\.|lbs|lb)(?!\w)/gi,
      (_match, raw) => formatKgFromPounds(parseLooseNumber(raw)),
    )
    .replace(/\bGP\b/g, 'PO');
}
