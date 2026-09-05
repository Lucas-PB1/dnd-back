import type { CatalogEffect } from '@game/effects';
import { executeCatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyHealHitPoints } from './apply-heal-hit-points';
import { applyTemporaryHitPoints } from './apply-temporary-hit-points';

type ApplyFeatEconomyEffectResult = {
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
};

/** Aplica heal / temp_hp / inspiration / note tipados no resultado da table-action. */
export async function applyFeatEconomyExecutedEffect(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  effect: CatalogEffect;
  baseNote: string;
  hitDieFaces: number;
  currentState: TableActionResponseDto['state'];
}): Promise<ApplyFeatEconomyEffectResult> {
  const executed = executeCatalogEffect(input.effect, {
    level: input.character.level,
    hitDieFaces: input.hitDieFaces,
  });
  let note = input.baseNote;
  let state = input.currentState;
  let total: number | undefined;
  let expression: string | undefined;

  if (executed.kind === 'heal') {
    const healed = await applyHealHitPoints(
      input.state,
      input.character,
      executed.amount,
    );
    state = healed.state;
    total = executed.amount;
    expression = executed.expression;
    note = [
      note,
      executed.note,
      `Cura aplicada: ${executed.amount}${executed.expression ? ` (${executed.expression})` : ''}.`,
    ]
      .filter(Boolean)
      .join(' ');
  } else if (executed.kind === 'temp_hp') {
    state = await applyTemporaryHitPoints(
      input.state,
      input.character,
      executed.amount,
    );
    total = executed.amount;
    expression = executed.expression;
    note = [note, executed.note, `PV temporários aplicados: ${executed.amount}.`]
      .filter(Boolean)
      .join(' ');
  } else if (executed.kind === 'grant_inspiration') {
    state = await input.state.patch(input.character, { inspiration: true });
    note = [note, executed.note].filter(Boolean).join(' ');
  } else if (executed.kind === 'table_note' && executed.note) {
    note = `${note} ${executed.note}`;
  }

  return { state, note, total, expression };
}
