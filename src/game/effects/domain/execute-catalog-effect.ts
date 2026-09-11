import type { Rng } from '@game/dice/domain/dice';
import { rollDamageParts } from '@game/dice/domain/dice';
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
      kind: 'spend_resource' | 'recover_resource';
      resourceSlug: string;
      amount: number;
      note: string | null;
    }
  | {
      kind: 'recover_resource_to_max';
      resourceSlug: string;
      note: string | null;
    }
  | {
      kind: 'toggle_combat_flag';
      flag: 'rage' | 'reckless';
      spendOnEnter: boolean;
      forceEnter: boolean;
      note: string | null;
    }
  | {
      kind: 'sync_companion';
      restoreHp: boolean;
      note: string | null;
    }
  | {
      kind: 'companion_command';
      note: string | null;
    }
  | {
      kind: 'table_roll';
      amount: number;
      expression: string;
      note: string | null;
    }
  | {
      kind: 'feature_dc';
      saveDc: number;
      note: string | null;
    }
  | {
      kind: 'heal_from_dice_pool';
      resourceSlug: string;
      diceCount: number;
      die: string;
      amount: number;
      expression: string;
      note: string | null;
    }
  | {
      kind: 'table_note';
      note: string;
      amount?: number;
      expression?: string;
    }
  | {
      kind: 'grant_inspiration';
      note: string | null;
    }
  | {
      kind: 'check_boost';
      resourceSlug: string;
      note: string | null;
    }
  | {
      kind: 'catalog_maneuver';
      note: string | null;
    }
  | {
      kind: 'strike_self_cost';
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
  'recover_resource',
  'recover_resource_to_max',
  'toggle_combat_flag',
  'sync_companion',
  'companion_command',
  'table_roll',
  'feature_dc',
  'heal_from_dice_pool',
  'grant_inspiration',
  'check_boost',
  'catalog_maneuver',
  'strike_self_cost',
]);

export type ExecuteCatalogEffectContext = {
  level: number;
  rng?: Rng;
  hitDieFaces?: number;
  scheduleDieFaces?: number;
  flatOverride?: number;
  rageBonus?: number;
  rageActive?: boolean;
  /** Contagem de dados (Campeão dos Deuses). */
  diceCount?: number;
};

function tableNoteFromEffect(
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

export function executeCatalogEffect(
  effect: CatalogEffect,
  context: ExecuteCatalogEffectContext,
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

  if (effect.kind === 'check_boost') {
    return {
      kind: 'check_boost',
      resourceSlug: effect.resourceSlug ?? '',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'catalog_maneuver') {
    return {
      kind: 'catalog_maneuver',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'strike_self_cost') {
    return {
      kind: 'strike_self_cost',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'toggle_combat_flag') {
    const flag = effect.combatFlag?.flag ?? 'rage';
    return {
      kind: 'toggle_combat_flag',
      flag,
      spendOnEnter: effect.combatFlag?.spendOnEnter ?? true,
      forceEnter: effect.combatFlag?.forceEnter ?? false,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'sync_companion') {
    return {
      kind: 'sync_companion',
      restoreHp: effect.companion?.restoreHp ?? false,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'companion_command') {
    return {
      kind: 'companion_command',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'recover_resource_to_max') {
    return {
      kind: 'recover_resource_to_max',
      resourceSlug: effect.resourceSlug ?? '',
      note: effect.note?.note ?? null,
    };
  }

  const flat =
    context.flatOverride !== undefined
      ? context.flatOverride
      : (effect.numeric?.flat ?? null);

  if (effect.kind === 'spend_resource' || effect.kind === 'recover_resource') {
    const amount = effect.numeric
      ? resolveEffectAmount({
          amountFormula: effect.numeric.amountFormula,
          flat,
          level: context.level,
          rng: context.rng,
          hitDieFaces: context.hitDieFaces,
          rageBonus: context.rageBonus,
          rageActive: context.rageActive,
        }).amount
      : 1;
    return {
      kind: effect.kind,
      resourceSlug: effect.resourceSlug ?? '',
      amount: Math.max(1, amount),
      note: effect.note?.note ?? null,
    };
  }

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

  if (effect.kind === 'heal_from_dice_pool') {
    const die = effect.dice?.die ?? '1d12';
    const facesMatch = /^(\d*)d(\d+)$/.exec(die);
    const faces = facesMatch ? Number(facesMatch[2]) : 12;
    const count = Math.max(
      1,
      context.diceCount ??
        (effect.numeric
          ? resolveEffectAmount({
              amountFormula: effect.numeric.amountFormula,
              flat,
              level: context.level,
            }).amount
          : 1),
    );
    const rolled = rollDamageParts(`${count}d${faces}`, 0, {
      rng: context.rng,
    });
    return {
      kind: 'heal_from_dice_pool',
      resourceSlug: effect.resourceSlug ?? '',
      diceCount: count,
      die: `${count}d${faces}`,
      amount: rolled.total,
      expression: rolled.expression,
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
    // Fórmula já resolve o total (dados inclusos) — sem phb_effect_dice.
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
