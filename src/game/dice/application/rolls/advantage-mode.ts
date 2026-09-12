import type { AdvantageMode } from '@game/dice/domain/dice';

export function forceAdvantageIfNormal(mode: AdvantageMode): AdvantageMode {
  return mode === 'normal' ? 'advantage' : mode;
}

export function upgradeTowardAdvantage(mode: AdvantageMode): AdvantageMode {
  return mode === 'disadvantage' ? 'normal' : 'advantage';
}
