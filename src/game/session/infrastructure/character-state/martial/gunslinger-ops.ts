import {
  CharacterStateResponseDto,
  UseManeuverResponseDto,
} from '@game/session/dto/character-state.dto';
import { reloadAllFirearms, loadReloadCapacity } from './firearm-ops';
import type { MartialSessionDeps, PlayerCharacter } from './martial-deps';
import {
  applyFireChamber,
  applyReloadFirearm,
  applyUseManeuver,
  listAvailableManeuvers,
} from '../mutations';

export async function useManeuverOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  maneuverSlug: string,
): Promise<UseManeuverResponseDto> {
  const catalog = await deps.loadMechanicalCatalog();
  const state = await deps.findOrCreate(character.id, character.level);
  const result = await applyUseManeuver({
    character,
    state,
    maneuverSlug,
    maneuvers: catalog.gunslingerManeuvers,
    stateRepo: deps.stateRepo,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
  if (result.effectKind === 'reload_move') {
    await reloadAllFirearms({
      stateRepo: deps.stateRepo,
      dataSource: deps.dataSource,
      findOrCreate: () => deps.findOrCreate(character.id, character.level),
    });
    result.state = await deps.buildResponse(
      character,
      await deps.findOrCreate(character.id, character.level),
    );
  }
  return result;
}

export async function listManeuversOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
) {
  const catalog = await deps.loadMechanicalCatalog();
  return listAvailableManeuvers(character, catalog.gunslingerManeuvers);
}

export async function reloadFirearmOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  itemSlug: string,
): Promise<CharacterStateResponseDto> {
  const capacity = await loadReloadCapacity(deps.dataSource, itemSlug);
  const state = await deps.findOrCreate(character.id, character.level);
  return applyReloadFirearm({
    character,
    state,
    itemSlug,
    capacity,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}

export async function fireChamberOp(
  deps: MartialSessionDeps,
  character: PlayerCharacter,
  itemSlug: string,
  shots = 1,
): Promise<CharacterStateResponseDto> {
  const capacity = await loadReloadCapacity(deps.dataSource, itemSlug);
  const state = await deps.findOrCreate(character.id, character.level);
  return applyFireChamber({
    character,
    state,
    itemSlug,
    capacity,
    shots,
    stateRepo: deps.stateRepo,
    buildResponse: deps.buildResponse,
  });
}
