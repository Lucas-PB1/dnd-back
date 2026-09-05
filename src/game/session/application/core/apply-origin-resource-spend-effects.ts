import type { Rng } from '@game/dice/domain/dice';
import { executeCatalogEffect } from '@game/effects';
import type { CatalogEffect } from '@game/effects';
import { filterEffectsByResourceSpend } from '@game/effects';
import { applyHealHitPoints } from '@game/session/application/core/apply-heal-hit-points';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import { resolveOriginResourceGrant } from '@game/session/domain/origin-resource-grants';
import type { ResourceDieRollDto } from '@game/session/dto/core/session-commands.dto';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type OriginResourceSpendResult = {
  state: CharacterStateResponseDto;
  note: string | null;
  roll?: ResourceDieRollDto | null;
};

/**
 * Efeitos ao gastar recurso: preferência `phb_effect` (on_resource_spend);
 * fallback heurística TS legada.
 */
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

  if (fromCatalog) {
    const executed = executeCatalogEffect(fromCatalog, {
      level: character.level,
      rng,
    });
    if (executed.kind === 'temp_hp' || executed.kind === 'heal') {
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
  }

  const grant = resolveOriginResourceGrant(resourceSlug, character, rng);
  if (!grant) {
    return { state: currentState, note: null };
  }

  if (grant.kind === 'temp_hp') {
    const next = await applyTemporaryHitPoints(state, character, grant.amount);
    return {
      state: next,
      note: grant.note,
      roll: grant.roll ?? null,
    };
  }

  const healed = await applyHealHitPoints(state, character, grant.amount);
  return {
    state: healed.state,
    note: grant.note,
    roll: grant.roll,
  };
}
