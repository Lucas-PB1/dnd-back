import type { Rng } from '@game/dice/domain/dice';
import { executeCatalogEffect } from '@game/effects';
import type { CatalogEffect } from '@game/effects';
import { filterEffectsByResourceSpend } from '@game/effects';
import { applyHealHitPoints } from '../table-actions/primitives/apply-heal-hit-points';
import { applySurviveAtZero } from '../table-actions/primitives/apply-survive-at-zero';
import { applyTemporaryHitPoints } from '../table-actions/primitives/apply-temporary-hit-points';
import type { ResourceDieRollDto } from '@game/session/dto/core/session-commands.dto';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { DataSource } from 'typeorm';

const SHEET_SPEND_KINDS = new Set(['temp_hp', 'heal', 'survive_at_zero']);

export type OriginResourceSpendResult = {
  state: CharacterStateResponseDto;
  note: string | null;
  roll?: ResourceDieRollDto | null;
};

export async function loadHeritageTraitTakesForResource(
  dataSource: DataSource,
  characterId: string,
  resourceSlug: string,
): Promise<number | null> {
  const rows = await dataSource.query<{ takes: number | null }[]>(
    `SELECT CASE
              WHEN rd.heritage_trait_id IS NULL THEN NULL
              ELSE (
                SELECT COUNT(*)::int
                FROM rpg.player_character_heritage_trait pct
                WHERE pct.character_id = $1::uuid
                  AND pct.trait_id = rd.heritage_trait_id
              )
            END AS takes
     FROM rpg.phb_resource_definition rd
     WHERE rd.slug = $2
     LIMIT 1`,
    [characterId, resourceSlug],
  );
  return rows[0]?.takes ?? null;
}

export function pickOriginSheetSpendEffect(
  effects: readonly CatalogEffect[],
  resourceSlug: string,
  traitTakes: number | null,
): CatalogEffect | undefined {
  const candidates = filterEffectsByResourceSpend(effects, resourceSlug)
    .filter((effect) => SHEET_SPEND_KINDS.has(effect.kind))
    .filter(
      (effect) => traitTakes == null || effect.minTraitTakes <= traitTakes,
    )
    .sort((left, right) => right.minTraitTakes - left.minTraitTakes);
  return candidates[0];
}

export async function applyOriginResourceSpendEffects(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
  rng?: Rng;
  effects?: readonly CatalogEffect[];
  traitTakes?: number | null;
}): Promise<OriginResourceSpendResult> {
  const { state, character, resourceSlug, currentState, rng } = input;
  const fromCatalog = pickOriginSheetSpendEffect(
    input.effects ?? [],
    resourceSlug,
    input.traitTakes ?? null,
  );

  if (!fromCatalog) {
    return { state: currentState, note: null };
  }

  const executed = executeCatalogEffect(fromCatalog, {
    level: character.level,
    rng,
  });
  if (
    executed.kind !== 'temp_hp' &&
    executed.kind !== 'heal' &&
    executed.kind !== 'survive_at_zero'
  ) {
    return { state: currentState, note: null };
  }

  const note = (
    executed.note ??
    `${fromCatalog.label ?? resourceSlug}: ${executed.amount}`
  )
    .replace(/\{total\}/g, String(executed.amount))
    .replace(
      /\{expression\}/g,
      executed.expression ?? String(executed.amount),
    );
  const roll =
    executed.expression != null
      ? {
          resourceSlug,
          faces: executed.faces ?? 0,
          value: executed.amount,
          expression: executed.expression,
        }
      : null;
  if (executed.kind === 'temp_hp') {
    const next = await applyTemporaryHitPoints(
      state,
      character,
      executed.amount,
    );
    return { state: next, note, roll };
  }
  if (executed.kind === 'survive_at_zero') {
    const next = await applySurviveAtZero(state, character, executed.amount);
    return { state: next, note, roll };
  }
  const healed = await applyHealHitPoints(
    state,
    character,
    executed.amount,
  );
  return { state: healed.state, note, roll };
}
