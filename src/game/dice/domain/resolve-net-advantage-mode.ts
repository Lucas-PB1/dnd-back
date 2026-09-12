import type { AdvantageMode } from './dice';

export type AdvantageContribution = 'advantage' | 'disadvantage';

export function resolveNetAdvantageMode(
  contributions: readonly AdvantageContribution[],
): AdvantageMode {
  let hasAdvantage = false;
  let hasDisadvantage = false;
  for (const contribution of contributions) {
    if (contribution === 'advantage') hasAdvantage = true;
    else hasDisadvantage = true;
  }
  if (hasAdvantage && hasDisadvantage) return 'normal';
  if (hasAdvantage) return 'advantage';
  if (hasDisadvantage) return 'disadvantage';
  return 'normal';
}

export function advantageModeFromManual(
  manual: AdvantageMode | undefined,
): AdvantageContribution[] {
  if (manual === 'advantage') return ['advantage'];
  if (manual === 'disadvantage') return ['disadvantage'];
  return [];
}
