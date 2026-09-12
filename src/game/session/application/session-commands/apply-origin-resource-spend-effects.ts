import type { Rng } from '@game/dice/domain/dice';
import { executeCatalogEffect } from '@game/effects';
import type { CatalogEffect } from '@game/effects';
import { filterEffectsByResourceSpend } from '@game/effects';
import { applyHealHitPoints } from '../table-actions/primitives/apply-heal-hit-points';
import { applyTemporaryHitPoints } from '../table-actions/primitives/apply-temporary-hit-points';
import type { ResourceDieRollDto } from '@game/session/dto/core/session-commands.dto';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type OriginResourceSpendResult = {
  state: CharacterStateResponseDto;
  note: string | null;
  roll?: ResourceDieRollDto | null;
};

export async function applyOriginResourceSpendEffects(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
  rng?: Rng;
  effects?: readonly CatalogEffect[];
}): Promise<OriginResourceSpendResult> {
  const { state, character, resourceSlug, currentState, rng } = input;
  const fromCatalog = filterEffectsByResourceSpend(
    input.effects ?? [],
    resourceSlug,
  ).find((effect) => effect.kind === 'temp_hp' || effect.kind === 'heal');

  if (!fromCatalog) {
    return { state: currentState, note: null };
  }

  const executed = executeCatalogEffect(fromCatalog, {
    level: character.level,
    rng,
  });
  if (executed.kind !== 'temp_hp' && executed.kind !== 'heal') {
    return { state: currentState, note: null };
  }

  const note =
    executed.note ??
    `${fromCatalog.label ?? resourceSlug}: ${executed.amount}`;
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
  const healed = await applyHealHitPoints(
    state,
    character,
    executed.amount,
  );
  return { state: healed.state, note, roll };
}
