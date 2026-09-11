import { rollDamageParts } from '@game/dice/domain/dice';
import type { CatalogEffect } from '../catalog-effect';
import { resolveEffectAmount } from '../resolve-effect-amount';
import type { EffectExecution, ExecuteCatalogEffectContext } from './types';

export function executeResourceEffect(
  effect: CatalogEffect,
  context: ExecuteCatalogEffectContext,
): EffectExecution | null {
  if (effect.kind === 'survive_at_zero') {
    const amount = 1 + 3 * context.level;
    return {
      kind: 'survive_at_zero',
      amount,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'recover_spell_slot') {
    const slotLevel =
      effect.spell?.spellLevel ??
      (effect.spell?.optionKey === 'pact_slot_level'
        ? (context.pactSlotLevel ?? 1)
        : 1);
    const count = effect.numeric
      ? resolveEffectAmount({
          amountFormula: effect.numeric.amountFormula,
          flat: effect.numeric.flat,
          level: context.level,
          pactSlotsRecoveryCount: context.pactSlotsRecoveryCount,
        }).amount
      : 1;
    return {
      kind: 'recover_spell_slot',
      slotLevel,
      count: Math.max(1, count),
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

  return null;
}
