import type { CatalogEffect } from '../catalog-effect';
import { resolveEffectAmount } from '../resolve-effect-amount';
import type { EffectExecution, ExecuteCatalogEffectContext } from './types';

export function tableNoteFromEffect(
  effect: CatalogEffect,
  context: ExecuteCatalogEffectContext,
): EffectExecution {
  const note = effect.note?.note?.trim() || effect.label || 'Declare na mesa.';
  if (!effect.numeric) {
    return { kind: 'table_note', note };
  }
  const flat =
    context.flatOverride !== undefined
      ? context.flatOverride
      : (effect.numeric.flat ?? null);
  const resolved = resolveEffectAmount({
    amountFormula: effect.numeric.amountFormula,
    flat,
    level: context.level,
    rng: context.rng,
    hitDieFaces: context.hitDieFaces,
    scheduleDieFaces: context.scheduleDieFaces,
    rageBonus: context.rageBonus,
    rageActive: context.rageActive,
  });
  return {
    kind: 'table_note',
    note,
    amount: resolved.amount,
    expression: resolved.expression,
  };
}
