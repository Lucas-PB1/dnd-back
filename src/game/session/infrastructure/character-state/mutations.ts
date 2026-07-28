import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '../../domain/class-resources';
import {
  CharacterStateResponseDto,
  PatchCharacterStateDto,
} from '../../dto/character-state.dto';
import { PhbCondition } from '../phb-condition.entity';
import { PlayerCharacterState } from '../player-character-state.entity';
import { resolveClassResources } from './class-resources';
import { assertValidConditions } from './conditions';

type BuildResponse = (
  character: PlayerCharacter,
  stateRow?: PlayerCharacterState,
) => Promise<CharacterStateResponseDto>;

export async function applyPatchState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: PatchCharacterStateDto;
  stateRepo: Repository<PlayerCharacterState>;
  conditions: Repository<PhbCondition>;
  catalogLookup: CatalogLookupService;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, dto, stateRepo, conditions, catalogLookup, buildResponse } =
    input;

  if (dto.conditions !== undefined) {
    await assertValidConditions(conditions, dto.conditions);
    state.conditions = dto.conditions;
  }

  if (dto.tempHp !== undefined) {
    state.tempHp = dto.tempHp;
  }

  if (dto.concentratingOn !== undefined) {
    if (dto.concentratingOn !== null) {
      const spell = await catalogLookup.assertSpellInCatalog(dto.concentratingOn);
      if (!spell.concentration) {
        throw new BadRequestException(
          `Spell '${dto.concentratingOn}' is not a concentration spell`,
        );
      }
    }
    state.concentratingOn = dto.concentratingOn;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyUseClassResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  resourceSlug: string;
  amount: number;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    resourceSlug,
    amount,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `Resource '${resourceSlug}' is not available for this character`,
    );
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      resourceSlug,
      resource.max,
      amount,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend resource',
    );
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}
