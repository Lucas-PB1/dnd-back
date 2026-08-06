import { CharacterStateResponseDto } from '../../../dto/character-state.dto';
import type { MartialSessionDeps, PlayerCharacter } from './martial-deps';
import {
  applyRecoverAllRage,
  applySetBestialAspectLevel,
  applySetPersonaMasks,
  applyToggleRage,
  applyToggleReckless,
} from '../mutations';

export async function toggleRageOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  active?: boolean,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyToggleRage({
    character,
    state,
    active,
    stateRepo: deps.stateRepo,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function toggleRecklessOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  active?: boolean,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyToggleReckless({
    character,
    state,
    active,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}

export async function recoverAllRageOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyRecoverAllRage({
    character,
    state,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}

export async function setPersonaMasksOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  masks: string[],
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applySetPersonaMasks({
    character,
    state,
    masks,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}

export async function setBestialAspectLevelOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  level: number,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applySetBestialAspectLevel({
    character,
    state,
    level,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}
