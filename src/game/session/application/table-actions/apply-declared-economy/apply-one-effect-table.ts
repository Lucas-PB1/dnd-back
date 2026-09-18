import type { EffectExecution } from '@game/effects';
import type { ApplyCtx } from './types';
import type { ApplyOneEffectResult } from './apply-one-effect.types';
import { applySheetConditions } from '../primitives/apply-sheet-conditions';

async function expandTableNote(
  template: string,
  values: {
    total?: number;
    expression?: string;
    saveDc?: number;
    proficiencyBonus?: number;
    usePsiDie?: boolean;
  },
): Promise<string> {
  let out = template
    .replace(/\{total\}/g, values.total != null ? String(values.total) : '—')
    .replace(
      /\{expression\}/g,
      values.expression != null ? String(values.expression) : '—',
    )
    .replace(
      /\{saveDc\}/g,
      values.saveDc != null ? String(values.saveDc) : '—',
    );
  if (out.includes('{proficiencyBonus}')) {
    const pb = values.proficiencyBonus ?? 2;
    out = out.replace(/\{proficiencyBonus\}/g, String(pb));
  }
  if (out.includes('{psiSpend}')) {
    out = out.replace(
      /\{psiSpend\}/g,
      values.usePsiDie ? 'Dado psi gasto.' : 'Uso gratuito gasto.',
    );
  }
  return out;
}

export async function applyTableEffect(
  ctx: ApplyCtx,
  executed: EffectExecution,
): Promise<Partial<ApplyOneEffectResult>> {
  const { deps, character, options, state, note, saveDc } = ctx;
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
    const pb = deps.getProficiencyBonus
      ? await deps.getProficiencyBonus(character.level)
      : undefined;
    if (executed.note?.trim()) {
      nextNote = await expandTableNote(executed.note, {
        total: executed.amount,
        expression: executed.expression,
        saveDc,
        proficiencyBonus: pb,
        usePsiDie: options.usePsiDie,
      });
    }
    if (executed.applyBestialAspect) {
      nextState = await deps.state.martial.setBestialAspectLevel(
        character,
        executed.amount,
      );
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
    nextNote = await expandTableNote(`${note} ${executed.note}`, {
      total,
      expression,
      saveDc,
    });
    return { state: nextState, note: nextNote, total, expression };
  }

  if (executed.kind === 'grant_inspiration') {
    nextState = await deps.state.patch(character, { inspiration: true });
    if (executed.note) nextNote = `${note} ${executed.note}`;
    return { state: nextState, note: nextNote };
  }

  if (
    (executed.kind === 'apply_condition' ||
      executed.kind === 'clear_condition') &&
    executed.conditionSlug
  ) {
    nextState = await applySheetConditions(deps.state, character, state, {
      add: executed.kind === 'apply_condition' ? [executed.conditionSlug] : [],
      remove:
        executed.kind === 'clear_condition' ? [executed.conditionSlug] : [],
    });
    nextNote =
      executed.note?.trim() ||
      (executed.kind === 'apply_condition'
        ? `Condição na ficha: ${executed.conditionSlug}.`
        : `Condição encerrada na ficha: ${executed.conditionSlug}.`);
    return { state: nextState, note: nextNote };
  }

  return {};
}
