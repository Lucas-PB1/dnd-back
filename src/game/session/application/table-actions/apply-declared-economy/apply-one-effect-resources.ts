import { BadRequestException } from '@nestjs/common';
import { applyHealHitPoints } from '../primitives/apply-heal-hit-points';
import { applyTemporaryHitPoints } from '../primitives/apply-temporary-hit-points';
import type { EffectExecution } from '@game/effects';
import type { ApplyCtx } from './types';
import type { ApplyOneEffectResult } from './apply-one-effect.types';

export async function applyResourceEffect(
  ctx: ApplyCtx,
  executed: EffectExecution,
): Promise<Partial<ApplyOneEffectResult>> {
  const { deps, character, actionSlug, effect, options, state, note } = ctx;
  let { total, expression, resourceSpent } = ctx;
  let nextState = state;
  let nextNote = note;

  if (
    effect.kind === 'heal' &&
    (executed.kind === 'heal' || options.amount != null)
  ) {
    const healAmount =
      options.amount ?? (executed.kind === 'heal' ? executed.amount : 0);
    const healed = await applyHealHitPoints(deps.state, character, healAmount);
    nextState = healed.state;
    total = healAmount;
    expression =
      options.amount != null
        ? String(healAmount)
        : executed.kind === 'heal'
          ? executed.expression
          : String(healAmount);
    const healNote =
      executed.kind === 'heal' ? executed.note : effect.note?.note ?? null;
    const effectNote = healNote
      ?.replace(/\{total\}/g, String(healAmount))
      .replace(/\{expression\}/g, expression ?? String(healAmount));
    nextNote = [note, effectNote, `Cura: ${expression ?? healAmount} → +${healed.healed} PV.`]
      .filter(Boolean)
      .join(' ');
    return { state: nextState, note: nextNote, total, expression, resourceSpent };
  }

  if (executed.kind === 'survive_at_zero') {
    nextState = await deps.state.patch(character, {
      deathSaveSuccesses: 0,
      deathSaveFailures: 0,
    });
    total = executed.amount;
    nextNote =
      executed.note?.trim() ||
      `Sentinela Imortal: defina seus PV atuais em ${executed.amount} (1 + 3 × nível, teto = PV máximos) e limpe salvaguardas contra morte.`;
    nextNote = nextNote.replace(/\{total\}/g, String(executed.amount));
    return { state: nextState, note: nextNote, total, resourceSpent };
  }

  if (executed.kind === 'temp_hp') {
    nextState = await applyTemporaryHitPoints(
      deps.state,
      character,
      executed.amount,
    );
    total = executed.amount;
    expression = executed.expression;
    nextNote = [note, executed.note?.trim(), `PV temporários aplicados: ${executed.amount}.`]
      .filter(Boolean)
      .join(' ');
    return { state: nextState, note: nextNote, total, expression, resourceSpent };
  }

  if (executed.kind === 'recover_resource' && executed.resourceSlug) {
    nextState = await deps.state.recoverClassResource(
      character,
      executed.resourceSlug,
      executed.amount,
    );
    total = executed.amount;
    nextNote = executed.note?.trim()
      ? `${note} ${executed.note.trim()}`
      : `${note} Recuperados ${executed.amount} uso(s) de ${executed.resourceSlug}.`;
    return { state: nextState, note: nextNote, total, resourceSpent };
  }

  if (executed.kind === 'recover_resource_to_max' && executed.resourceSlug) {
    if (executed.resourceSlug === 'rage') {
      nextState = await deps.state.martial.recoverAllRage(character);
    } else {
      const pool = state.classResources?.find(
        (r) => r.slug === executed.resourceSlug,
      );
      const missing = pool ? Math.max(0, pool.max - pool.remaining) : 0;
      if (missing > 0) {
        nextState = await deps.state.recoverClassResource(
          character,
          executed.resourceSlug,
          missing,
        );
      } else {
        nextState = await deps.state.buildResponse(character);
      }
    }
    nextNote =
      executed.note?.trim() ||
      `Recuperou todos os usos de ${executed.resourceSlug}.`;
    return { state: nextState, note: nextNote, resourceSpent };
  }

  if (
    executed.kind === 'spend_resource' &&
    executed.resourceSlug &&
    executed.amount > 0
  ) {
    nextState = (
      await deps.state.useClassResource(
        character,
        executed.resourceSlug,
        executed.amount,
      )
    ).state;
    resourceSpent = true;
    return { state: nextState, resourceSpent };
  }

  if (executed.kind === 'heal_from_dice_pool') {
    if (!executed.resourceSlug) {
      throw new BadRequestException('heal_from_dice_pool exige resource_slug');
    }
    nextState = (
      await deps.state.useClassResource(
        character,
        executed.resourceSlug,
        executed.diceCount,
      )
    ).state;
    resourceSpent = true;
    total = executed.amount;
    expression = executed.expression;
    nextNote =
      executed.note?.trim() ||
      `Campeão dos Deuses: Ação Bônus — recupere ${executed.amount} PV (${executed.expression}). Aplique na ficha.`;
    nextNote = nextNote
      .replace(/\{total\}/g, String(executed.amount))
      .replace(/\{expression\}/g, executed.expression);
    if (executed.resourceSlug === 'healing-light') {
      const healed = await applyHealHitPoints(
        deps.state,
        character,
        executed.amount,
      );
      nextState = healed.state;
      nextNote = `${nextNote} (+${healed.healed} na ficha — ajuste se for aliado).`;
    }
    return {
      state: nextState,
      note: nextNote,
      total,
      expression,
      resourceSpent,
    };
  }

  if (executed.kind === 'recover_spell_slot') {
    for (let i = 0; i < executed.count; i += 1) {
      await deps.state.recoverSpellSlotLevel(character, executed.slotLevel);
    }
    nextState = await deps.state.buildResponse(character);
    total = executed.count;
    nextNote =
      executed.note?.trim()?.replace(/\{total\}/g, String(executed.count)) ??
      `${note} Recuperou ${executed.count} slot(s) de ${executed.slotLevel}º círculo.`;
    return { state: nextState, note: nextNote, total, resourceSpent };
  }

  return {};
}
