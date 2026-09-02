import { applyCurrentHitPoints } from '@game/session/application/core/apply-current-hit-points';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const DOOM_DELAYED_RESOURCE = 'doom-delayed';
const UNCONSCIOUS = 'unconscious';

/**
 * Efeitos colaterais ao gastar recurso de Character Thread (spend-resource).
 * Fatebound Ruína Adiada → estável a 0 PV (3 sucessos de morte).
 */
export async function applyThreadResourceSpendSideEffects(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
}): Promise<{ state: CharacterStateResponseDto; note: string | null }> {
  const { state, character, resourceSlug, currentState } = input;

  if (resourceSlug !== DOOM_DELAYED_RESOURCE) {
    return { state: currentState, note: null };
  }

  const afterHp = await applyCurrentHitPoints(state, character, 0);
  const conditions = afterHp.conditions.includes(UNCONSCIOUS)
    ? afterHp.conditions
    : [...afterHp.conditions, UNCONSCIOUS];

  const next = await state.patch(character, {
    deathSaveSuccesses: 3,
    deathSaveFailures: 0,
    conditions,
  });

  return {
    state: next,
    note: 'Ruína Adiada: estável a 0 PV (1/DL).',
  };
}
