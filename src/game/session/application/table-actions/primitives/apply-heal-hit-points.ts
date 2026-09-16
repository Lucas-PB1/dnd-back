import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

type VitalBondShare = {
  shareVitalBondHeal?: (
    characterId: string,
    amount: number,
  ) => Promise<void>;
};

export async function applyHealHitPoints(
  stateRepo: CharacterStateRepository,
  character: PlayerCharacter,
  amount: number,
): Promise<{ state: CharacterStateResponseDto; healed: number }> {
  if (
    amount <= 0 ||
    character.hitPointsCurrent == null ||
    character.hitPointsMax == null
  ) {
    return { state: await stateRepo.buildResponse(character), healed: 0 };
  }

  const before = character.hitPointsCurrent;
  const after = Math.min(character.hitPointsMax, before + amount);
  const healed = after - before;
  const state = await stateRepo.applyCurrentHitPoints(character, after);
  if (healed > 0) {
    const share = (stateRepo as CharacterStateRepository & VitalBondShare)
      .shareVitalBondHeal;
    if (share) {
      await share.call(stateRepo, character.id, healed);
    }
  }
  return { state, healed };
}
