import { applyCurrentHitPoints } from './apply-current-hit-points';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const UNCONSCIOUS = 'unconscious';

export async function applySurviveAtZero(
  stateRepo: CharacterStateRepository,
  character: PlayerCharacter,
  hitPoints: number,
): Promise<CharacterStateResponseDto> {
  const afterHp = await applyCurrentHitPoints(stateRepo, character, hitPoints);
  const conditions = (afterHp.conditions ?? []).filter(
    (slug) => slug !== UNCONSCIOUS,
  );
  return stateRepo.patch(character, {
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    conditions,
  });
}
