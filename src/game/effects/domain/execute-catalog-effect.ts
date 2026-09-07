import type { Rng } from '@game/dice/domain/dice';
import type { CatalogEffect, EffectKind } from './catalog-effect';
import { resolveEffectAmount } from './resolve-effect-amount';

export type EffectExecution =
  | {
      kind: 'temp_hp' | 'heal';
      amount: number;
      note: string | null;
      expression?: string;
      faces?: number;
    }
  | {
      kind: 'spend_resource';
      resourceSlug: string;
      amount: number;
      note: string | null;
    }
  | {
      kind: 'table_note';
      note: string;
      /** Valor tipado para declare (ex.: PV/turno), sem apply na ficha. */
      amount?: number;
      expression?: string;
    }
  | {
      kind: 'grant_inspiration';
      note: string | null;
    }
  | {
      kind: 'unsupported';
      effectKind: EffectKind;
    };

const EXECUTABLE_KINDS = new Set<EffectKind>([
  'temp_hp',
  'heal',
  'spend_resource',
  'grant_inspiration',
]);

function tableNoteFromEffect(
  effect: CatalogEffect,
  context: {
    level: number;
    rng?: Rng;
    hitDieFaces?: number;
    flatOverride?: number;
  },
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
  });
  return {
    kind: 'table_note',
    note,
    amount: resolved.amount,
    expression: resolved.expression,
  };
}

export function executeCatalogEffect(
  effect: CatalogEffect,
  context: {
    level: number;
    rng?: Rng;
    hitDieFaces?: number;
    /** Sobrescreve `numeric.flat` (ex.: mod de conjuração). */
    flatOverride?: number;
  },
): EffectExecution {
  if (!EXECUTABLE_KINDS.has(effect.kind)) {
    return tableNoteFromEffect(effect, context);
  }

  if (effect.kind === 'grant_inspiration') {
    return {
      kind: 'grant_inspiration',
      note:
        effect.note?.note?.trim() ||
        effect.label ||
        'Inspiração concedida (declare aliados na mesa).',
    };
  }

  const flat =
    context.flatOverride !== undefined
      ? context.flatOverride
      : (effect.numeric?.flat ?? null);

  if (effect.kind === 'spend_resource') {
    const amount = effect.numeric
      ? resolveEffectAmount({
          amountFormula: effect.numeric.amountFormula,
          flat,
          level: context.level,
          rng: context.rng,
          hitDieFaces: context.hitDieFaces,
        }).amount
      : 1;
    return {
      kind: 'spend_resource',
      resourceSlug: effect.resourceSlug ?? '',
      amount: Math.max(1, amount),
      note: effect.note?.note ?? null,
    };
  }

  
  if (!effect.numeric) {
    return { kind: 'unsupported', effectKind: effect.kind };
  }
  const resolved = resolveEffectAmount({
    amountFormula: effect.numeric.amountFormula,
    flat,
    level: context.level,
    rng: context.rng,
    hitDieFaces: context.hitDieFaces,
  });
  return {
    kind: effect.kind as 'temp_hp' | 'heal',
    amount: resolved.amount,
    note: effect.note?.note ?? null,
    expression: resolved.expression,
    faces: resolved.faces,
  };
}
