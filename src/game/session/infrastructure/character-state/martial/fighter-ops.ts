import {
  ActionSurgeResponseDto,
  SecondWindResponseDto,
  TacticalMindResponseDto,
} from '@game/session/dto';
import type { MartialSessionDeps, PlayerCharacter } from './martial-deps';
import {
  applyActionSurge,
  applySecondWind,
  applyTacticalMind,
} from '..';

export async function useSecondWindOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
): Promise<SecondWindResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applySecondWind({
    character,
    state,
    stateRepo: deps.stateRepo,
    characters: deps.characters,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function useTacticalMindOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  checkTotal?: number,
  dc?: number,
): Promise<TacticalMindResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyTacticalMind({
    character,
    state,
    checkTotal,
    dc,
    stateRepo: deps.stateRepo,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function useActionSurgeOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
): Promise<ActionSurgeResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyActionSurge({
    character,
    state,
    stateRepo: deps.stateRepo,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}
