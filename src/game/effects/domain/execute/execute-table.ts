import { rollDamageParts } from '@game/dice/domain/dice';
import type { CatalogEffect } from '../catalog-effect';
import { resolveEffectAmount } from '../resolve-effect-amount';
import type { EffectExecution, ExecuteCatalogEffectContext } from './types';

export function executeTableEffect(
  effect: CatalogEffect,
  context: ExecuteCatalogEffectContext,
): EffectExecution {
  const flat =
    context.flatOverride !== undefined
      ? context.flatOverride
      : (effect.numeric?.flat ?? null);

  if (effect.kind === 'feature_dc') {
    const resolved = effect.numeric
      ? resolveEffectAmount({
          amountFormula: effect.numeric.amountFormula,
          flat,
          level: context.level,
          rageBonus: context.rageBonus,
          rageActive: context.rageActive,
        })
      : { amount: 8 };
    return {
      kind: 'feature_dc',
      saveDc: resolved.amount,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'table_roll') {
    if (effect.numeric?.amountFormula === 'schedule_die_plus_flat') {
      const resolved = resolveEffectAmount({
        amountFormula: 'schedule_die_plus_flat',
        flat,
        level: context.level,
        rng: context.rng,
        scheduleDieFaces: context.scheduleDieFaces,
      });
      return {
        kind: 'table_roll',
        amount: resolved.amount,
        expression: resolved.expression ?? `1d${context.scheduleDieFaces ?? 6}`,
        note: effect.note?.note ?? null,
      };
    }
    if (effect.numeric?.amountFormula === 'rage_bonus_d6') {
      const resolved = resolveEffectAmount({
        amountFormula: 'rage_bonus_d6',
        flat: null,
        level: context.level,
        rng: context.rng,
        rageBonus: context.rageBonus,
      });
      return {
        kind: 'table_roll',
        amount: resolved.amount,
        expression: resolved.expression ?? `${context.rageBonus ?? 2}d6`,
        note: effect.note?.note ?? null,
      };
    }
    if (effect.numeric?.amountFormula === 'portent_d20_count') {
      const resolved = resolveEffectAmount({
        amountFormula: 'portent_d20_count',
        flat: null,
        level: context.level,
        rng: context.rng,
      });
      return {
        kind: 'table_roll',
        amount: resolved.amount,
        expression: resolved.expression ?? String(resolved.amount),
        note: effect.note?.note ?? null,
      };
    }
    if (effect.numeric?.amountFormula === 'rage_bonus') {
      const resolved = resolveEffectAmount({
        amountFormula: 'rage_bonus',
        flat: null,
        level: context.level,
        rageBonus: context.rageBonus,
      });
      return {
        kind: 'table_roll',
        amount: resolved.amount,
        expression: String(resolved.amount),
        note: effect.note?.note ?? null,
      };
    }
    if (
      effect.numeric?.amountFormula === 'dice_2d_schedule' ||
      effect.numeric?.amountFormula === 'dice_3d_schedule'
    ) {
      const resolved = resolveEffectAmount({
        amountFormula: effect.numeric.amountFormula,
        flat: null,
        level: context.level,
        rng: context.rng,
        scheduleDieFaces: context.scheduleDieFaces,
      });
      return {
        kind: 'table_roll',
        amount: resolved.amount,
        expression: resolved.expression ?? String(resolved.amount),
        note: effect.note?.note ?? null,
      };
    }
    if (effect.numeric && !effect.dice) {
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
        kind: 'table_roll',
        amount: resolved.amount,
        expression: resolved.expression ?? String(resolved.amount),
        note: effect.note?.note ?? null,
      };
    }
    const die = effect.dice?.die ?? '1d6';
    let bonus = 0;
    if (effect.numeric?.amountFormula === 'ability_mod') {
      bonus = flat ?? 0;
    } else if (effect.numeric?.amountFormula === 'half_level_if_rage') {
      bonus = resolveEffectAmount({
        amountFormula: 'half_level_if_rage',
        flat: null,
        level: context.level,
        rageActive: context.rageActive,
      }).amount;
    } else if (effect.numeric) {
      bonus = resolveEffectAmount({
        amountFormula: effect.numeric.amountFormula,
        flat,
        level: context.level,
        rng: context.rng,
        rageBonus: context.rageBonus,
        rageActive: context.rageActive,
      }).amount;
    }
    const rolled = rollDamageParts(die, bonus, { rng: context.rng });
    return {
      kind: 'table_roll',
      amount: rolled.total,
      expression: rolled.expression,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.dice?.die) {
    const rolled = rollDamageParts(effect.dice.die, flat ?? 0, {
      rng: context.rng,
    });
    return {
      kind: effect.kind as 'temp_hp' | 'heal',
      amount: rolled.total,
      note: effect.note?.note ?? null,
      expression: rolled.expression,
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
    scheduleDieFaces: context.scheduleDieFaces,
    rageBonus: context.rageBonus,
    rageActive: context.rageActive,
  });
  return {
    kind: effect.kind as 'temp_hp' | 'heal',
    amount: resolved.amount,
    note: effect.note?.note ?? null,
    expression: resolved.expression,
    faces: resolved.faces,
  };
}
