import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  ActionSurgeResponseDto,
  CharacterStateResponseDto,
  SecondWindResponseDto,
  TacticalMindResponseDto,
  UseManeuverResponseDto,
} from '@game/session/dto';
import type { MartialSessionDeps } from './martial-deps';
import {
  fireChamberOp,
  listManeuversOp,
  recoverAllRageOp,
  reloadFirearmOp,
  setBestialAspectLevelOp,
  setPersonaMasksOp,
  toggleRageOp,
  toggleRecklessOp,
  useActionSurgeOp,
  useManeuverOp,
  useSecondWindOp,
  useTacticalMindOp,
} from './index';

/** Agrupa ops marciais; deps via factory (buildResponse do repository). */
export class MartialSessionFacade {
  constructor(private readonly getDeps: () => MartialSessionDeps) {}

  useManeuver(
    character: PlayerCharacter,
    maneuverSlug: string,
  ): Promise<UseManeuverResponseDto> {
    return useManeuverOp(this.getDeps(), character, maneuverSlug);
  }

  listManeuvers(character: PlayerCharacter) {
    return listManeuversOp(this.getDeps(), character);
  }

  reloadFirearm(
    character: PlayerCharacter,
    itemSlug: string,
  ): Promise<CharacterStateResponseDto> {
    return reloadFirearmOp(this.getDeps(), character, itemSlug);
  }

  fireChamber(
    character: PlayerCharacter,
    itemSlug: string,
    shots = 1,
  ): Promise<CharacterStateResponseDto> {
    return fireChamberOp(this.getDeps(), character, itemSlug, shots);
  }

  toggleRage(
    character: PlayerCharacter,
    active?: boolean,
    spendResource = true,
  ): Promise<CharacterStateResponseDto> {
    return toggleRageOp(this.getDeps(), character, active, spendResource);
  }

  toggleReckless(
    character: PlayerCharacter,
    active?: boolean,
  ): Promise<CharacterStateResponseDto> {
    return toggleRecklessOp(this.getDeps(), character, active);
  }

  setPersonaMasks(
    character: PlayerCharacter,
    masks: string[],
  ): Promise<CharacterStateResponseDto> {
    return setPersonaMasksOp(this.getDeps(), character, masks);
  }

  setBestialAspectLevel(
    character: PlayerCharacter,
    level: number,
  ): Promise<CharacterStateResponseDto> {
    return setBestialAspectLevelOp(this.getDeps(), character, level);
  }

  recoverAllRage(
    character: PlayerCharacter,
  ): Promise<CharacterStateResponseDto> {
    return recoverAllRageOp(this.getDeps(), character);
  }

  useSecondWind(
    character: PlayerCharacter,
  ): Promise<SecondWindResponseDto> {
    return useSecondWindOp(this.getDeps(), character);
  }

  useTacticalMind(
    character: PlayerCharacter,
    checkTotal?: number,
    dc?: number,
  ): Promise<TacticalMindResponseDto> {
    return useTacticalMindOp(this.getDeps(), character, checkTotal, dc);
  }

  useActionSurge(
    character: PlayerCharacter,
  ): Promise<ActionSurgeResponseDto> {
    return useActionSurgeOp(this.getDeps(), character);
  }
}
