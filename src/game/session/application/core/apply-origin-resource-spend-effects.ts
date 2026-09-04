import type { Rng } from '@game/dice/domain/dice';
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
 * Efeitos ao gastar recurso de espécie, herança ou thread com PV temp./cura calculável.
 */
export async function applyOriginResourceSpendEffects(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
  rng?: Rng;
}): Promise<OriginResourceSpendResult> {
  const { state, character, resourceSlug, currentState, rng } = input;
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
