import type { CatalogEffect } from '@game/effects';
import { executeCatalogEffect } from '@game/effects';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyHealHitPoints } from '../primitives/apply-heal-hit-points';
import { applyTemporaryHitPoints } from '../primitives/apply-temporary-hit-points';

type ApplyFeatEconomyEffectResult = {
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
};

/** Maior mod entre INT/SAB/CAR — proxy de atributo de conjuração na mesa. */
export function spellcastingAbilityModifier(
  scores: PlayerCharacter['abilityScores'] | undefined,
): number {
  if (!scores) return 0;
  return Math.max(
    abilityModifier(scores.inteligencia ?? 10),
    abilityModifier(scores.sabedoria ?? 10),
    abilityModifier(scores.carisma ?? 10),
  );
}

/** Aplica heal / temp_hp / inspiration / note tipados no resultado da table-action. */
export async function applyFeatEconomyExecutedEffect(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  effect: CatalogEffect;
  baseNote: string;
  hitDieFaces: number;
  currentState: TableActionResponseDto['state'];
}): Promise<ApplyFeatEconomyEffectResult> {
  const needsCastingFlat =
    input.effect.numeric?.amountFormula === 'dice_2d4_plus_flat';
  const executed = executeCatalogEffect(input.effect, {
    level: input.character.level,
    hitDieFaces: input.hitDieFaces,
    ...(needsCastingFlat
      ? {
          flatOverride: spellcastingAbilityModifier(
            input.character.abilityScores,
          ),
        }
      : {}),
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
      `Cura aplicada neste PC: ${executed.amount}${executed.expression ? ` (${executed.expression})` : ''}. Aliado: ajuste PV na mesa.`,
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
  } else if (executed.kind === 'recover_resource' && executed.resourceSlug) {
    state = await input.state.recoverClassResource(
      input.character,
      executed.resourceSlug,
      executed.amount,
    );
    total = executed.amount;
    note = [
      note,
      executed.note,
      executed.note
        ? null
        : `Recuperados ${executed.amount} uso(s) de ${executed.resourceSlug}.`,
    ]
      .filter(Boolean)
      .join(' ');
  } else if (executed.kind === 'grant_inspiration') {
    state = await input.state.patch(input.character, { inspiration: true });
    note = [note, executed.note].filter(Boolean).join(' ');
  } else if (executed.kind === 'table_note' && executed.note) {
    note = `${note} ${executed.note}`;
    if (executed.amount != null) {
      total = executed.amount;
      expression = executed.expression;
      note = `${note} Valor tipado: ${executed.amount} PV/turno (ajuste na ficha a cada turno; duração na mesa).`;
    }
  }

  return { state, note, total, expression };
}
