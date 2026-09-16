import { applyCurrentHitPoints } from '../table-actions/primitives/apply-current-hit-points';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const UNCONSCIOUS = 'unconscious';
const CHARMED = 'charmed';

const TENACITY_CONDITIONS = new Set([
  'frightened',
  'incapacitated',
  'paralyzed',
  'stunned',
]);

export async function applyDoomDelayedSheet(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<CharacterStateResponseDto> {
  const afterHp = await applyCurrentHitPoints(state, character, 0);
  const conditions = afterHp.conditions.includes(UNCONSCIOUS)
    ? afterHp.conditions
    : [...afterHp.conditions, UNCONSCIOUS];

  return state.patch(character, {
    deathSaveSuccesses: 3,
    deathSaveFailures: 0,
    conditions,
  });
}

export async function applyLastActOfFateSheet(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<CharacterStateResponseDto> {
  await applyCurrentHitPoints(state, character, 1);
  return state.patch(character, {
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    conditions: [],
  });
}

export async function applyTenacitySheet(
  state: CharacterStateRepository,
  character: PlayerCharacter,
  currentState: CharacterStateResponseDto,
): Promise<CharacterStateResponseDto> {
  const conditions = currentState.conditions.filter(
    (slug) => !TENACITY_CONDITIONS.has(slug),
  );
  return state.patch(character, { conditions });
}

export async function applyExtremeLoyaltySheet(
  state: CharacterStateRepository,
  character: PlayerCharacter,
  currentState: CharacterStateResponseDto,
): Promise<CharacterStateResponseDto> {
  const hp = currentState.hitPointsCurrent ?? character.hitPointsCurrent ?? 0;
  const afterHp = await applyCurrentHitPoints(
    state,
    character,
    Math.max(0, hp - character.level),
  );
  const conditions = afterHp.conditions.filter((slug) => slug !== CHARMED);
  return state.patch(character, { conditions });
}

export async function applyUndyingLoyaltySheet(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<CharacterStateResponseDto> {
  const afterHp = await applyCurrentHitPoints(state, character, character.level);
  const conditions = afterHp.conditions.filter((slug) => slug !== UNCONSCIOUS);
  return state.patch(character, { conditions });
}
