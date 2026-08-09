import type { AdvantageMode } from '@game/dice/domain/dice';

/** Só promove para vantagem se o modo atual ainda for normal. */
export function forceAdvantageIfNormal(mode: AdvantageMode): AdvantageMode {
  return mode === 'normal' ? 'advantage' : mode;
}

/** Cancela desvantagem → normal; senão concede vantagem. */
export function upgradeTowardAdvantage(mode: AdvantageMode): AdvantageMode {
  return mode === 'disadvantage' ? 'normal' : 'advantage';
}
