import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../../shared/infrastructure/character.repository';
import { computeAbilityModifiers } from '../../../sheet/domain/stats/character-derived-stats';
import { RestResponseDto } from '../../dto/character-state.dto';
import {
  restoreHitDiceOnLongRest,
  spendHitDice,
} from '../../domain/hit-dice-rest';
import {
  applyLongRestResourceRecovery,
  applyShortRestResourceRecovery,
} from '../../domain/class-resources';
import { resetDeathSaves } from '../../domain/death-saves';
import { PlayerCharacterState } from '../player-character-state.entity';
import { resolveClassResources } from './class-resources';
import { clampHitDiceToLevel } from './hit-dice';

type BuildResponse = (
  character: PlayerCharacter,
  stateRow?: PlayerCharacterState,
) => Promise<RestResponseDto['state']>;

export async function applyLongRestState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  characters: CharacterRepository;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<RestResponseDto> {
  const { character, state, stateRepo, characters, dataSource, buildResponse } =
    input;
  const resources = await resolveClassResources(dataSource, character);
  state.spellSlotsUsed = {};
  state.grantedSpellUses = {};
  state.highElfCantripSwapAvailable = true;
  state.resourcesUsed = applyLongRestResourceRecovery(
    state.resourcesUsed ?? {},
    resources,
  );
  state.concentratingOn = null;
  state.conditions = [];
  state.tempHp = 0;
  state.rageActive = false;
  state.recklessActive = false;
  state.hitDiceCurrent = restoreHitDiceOnLongRest(
    state.hitDiceCurrent,
    character.level,
  );
  const deathSaves = resetDeathSaves();
  state.deathSaveSuccesses = deathSaves.deathSaveSuccesses;
  state.deathSaveFailures = deathSaves.deathSaveFailures;
  await stateRepo.save(state);

  if (character.hitPointsMax !== null) {
    character.hitPointsCurrent = character.hitPointsMax;
    await characters.save(character);
  }

  return {
    type: 'long',
    state: await buildResponse(character, state),
  };
}

export async function applyShortRestState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  hitDiceSpent: number;
  stateRepo: Repository<PlayerCharacterState>;
  characters: CharacterRepository;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<RestResponseDto> {
  const {
    character,
    state,
    hitDiceSpent,
    stateRepo,
    characters,
    catalogLookup,
    dataSource,
    buildResponse,
  } = input;

  await clampHitDiceToLevel(stateRepo, state, character.level);

  const resources = await resolveClassResources(dataSource, character);
  state.resourcesUsed = applyShortRestResourceRecovery(
    state.resourcesUsed ?? {},
    resources,
  );

  if (hitDiceSpent === 0) {
    await stateRepo.save(state);
    return {
      type: 'short',
      state: await buildResponse(character, state),
      hitDiceSpent: 0,
      hitDiceRolls: [],
      hitPointsHealed: 0,
    };
  }

  if (character.hitPointsMax === null || character.hitPointsCurrent === null) {
    throw new BadRequestException('Character hit points are not set');
  }

  const phbClass = await catalogLookup.findClassOrFail(character.classSlug);
  const mods = computeAbilityModifiers(character.abilityScores);

  let spendResult;
  try {
    spendResult = spendHitDice({
      hitDiceCurrent: state.hitDiceCurrent,
      hitDiceMax: character.level,
      hitDiceSpent,
      hitDieLabel: phbClass.hitDie,
      constitutionModifier: mods.constituicao,
      hitPointsCurrent: character.hitPointsCurrent,
      hitPointsMax: character.hitPointsMax,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid hit dice spend',
    );
  }

  state.hitDiceCurrent = spendResult.hitDiceRemaining;
  character.hitPointsCurrent = spendResult.hitPointsCurrent;
  await stateRepo.save(state);
  await characters.save(character);

  return {
    type: 'short',
    state: await buildResponse(character, state),
    hitDiceSpent: spendResult.hitDiceSpent,
    hitDiceRolls: spendResult.rolls,
    hitPointsHealed: spendResult.hitPointsHealed,
  };
}
