import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export async function applySheetConditions(
  stateRepo: CharacterStateRepository,
  character: PlayerCharacter,
  current: CharacterStateResponseDto,
  input: { add?: readonly string[]; remove?: readonly string[] },
): Promise<CharacterStateResponseDto> {
  const remove = new Set(input.remove ?? []);
  const next = (current.conditions ?? []).filter((slug) => !remove.has(slug));
  for (const slug of input.add ?? []) {
    if (slug && !next.includes(slug)) next.push(slug);
  }
  return stateRepo.patch(character, { conditions: next });
}
