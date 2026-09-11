import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { DuelMember } from '../../infrastructure/duel-member.entity';

export type ConditionsDeps = {
  repo: DuelRepository;
  state: CharacterStateRepository;
};

export function loadConditionsFromMembers(
  characterId: string,
  members: DuelMember[],
): string[] | null {
  const member = members.find((m) => m.characterId === characterId);
  if (member != null && member.hitPointsCurrent != null) {
    return member.conditions ?? [];
  }
  return null;
}

export async function loadConditions(
  deps: ConditionsDeps,
  characterId: string,
  members?: DuelMember[],
): Promise<string[]> {
  if (members) {
    const fromMember = loadConditionsFromMembers(characterId, members);
    if (fromMember) return fromMember;
  }
  const character = await deps.repo.findCharacterById(characterId);
  if (!character) return [];
  const state = await deps.state.buildResponse(character);
  return state.conditions ?? [];
}
