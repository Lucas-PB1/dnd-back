import type { EffectExecution } from '@game/effects';
import type { ApplyCtx } from './types';
import type { ApplyOneEffectResult } from './apply-one-effect.types';

export async function applyTableEffect(
  ctx: ApplyCtx,
  executed: EffectExecution,
): Promise<Partial<ApplyOneEffectResult>> {
  const { deps, character, actionSlug, options, state, note, saveDc } = ctx;
  let { total, expression, roll } = ctx;
  let nextState = state;
  let nextNote = note;
  let nextSaveDc = saveDc;

  if (executed.kind === 'feature_dc') {
    nextSaveDc = executed.saveDc;
    if (executed.note?.trim()) nextNote = `${note} ${executed.note.trim()}`;
    else nextNote = `${note} CD ${executed.saveDc}.`;
    return { state: nextState, note: nextNote, saveDc: nextSaveDc };
  }

  if (executed.kind === 'table_roll') {
    total = executed.amount;
    expression = executed.expression;
    roll = executed.amount;
    if (executed.note?.trim()) {
      nextNote = executed.note
        .replace(/\{total\}/g, String(executed.amount))
        .replace(/\{expression\}/g, executed.expression)
        .replace(/\{saveDc\}/g, saveDc != null ? String(saveDc) : '—');
    }
    if (actionSlug === 'feral-howl') {
      nextState = await deps.state.martial.setBestialAspectLevel(
        character,
        executed.amount,
      );
      nextNote = `Uivo Feral: 1d4 = ${executed.amount}. Aspecto Bestial definido em ${executed.amount}.`;
    }
    if (actionSlug === 'psychic-teleport') {
      total = executed.amount * 3;
      nextNote = `Teleporte Psíquico: teleporte-se até ${total} m para um espaço visível e desocupado.`;
    }
    if (actionSlug === 'psychic-whispers' && deps.getProficiencyBonus) {
      const pb = await deps.getProficiencyBonus(character.level);
      nextNote = `Sussurros Psíquicos: conecte até ${pb} criaturas por ${executed.amount} hora(s). ${options.usePsiDie ? 'Dado psi gasto.' : 'Uso gratuito gasto.'}`;
    }
    return {
      state: nextState,
      note: nextNote,
      total,
      expression,
      roll,
      saveDc: nextSaveDc,
    };
  }

  if (executed.kind === 'start_concentration' && executed.spellSlug) {
    nextState = await deps.state.patch(character, {
      concentratingOn: executed.spellSlug,
    });
    if (executed.note?.trim()) {
      nextNote = executed.note.trim();
    }
    return { state: nextState, note: nextNote };
  }

  if (executed.kind === 'table_note' && executed.note) {
    if (executed.amount != null) {
      total = executed.amount;
      expression = executed.expression;
    }
    nextNote = `${note} ${executed.note}`
      .replace(/\{total\}/g, total != null ? String(total) : '—')
      .replace(/\{expression\}/g, expression != null ? String(expression) : '—')
      .replace(/\{saveDc\}/g, saveDc != null ? String(saveDc) : '—');
    return { state: nextState, note: nextNote, total, expression };
  }

  if (executed.kind === 'grant_inspiration') {
    nextState = await deps.state.patch(character, { inspiration: true });
    if (executed.note) nextNote = `${note} ${executed.note}`;
    return { state: nextState, note: nextNote };
  }

  return {};
}
