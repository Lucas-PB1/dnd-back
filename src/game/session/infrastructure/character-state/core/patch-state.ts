import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { clampDeathSaveCount } from '@game/session/domain/death-saves';
import {
  CharacterStateResponseDto,
  PatchCharacterStateDto,
} from '@game/session/dto';
import { PhbCondition } from '@game/session/infrastructure/phb-condition.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { assertValidConditions } from './conditions';
import type { BuildResponse } from './mutation-types';

export async function applyPatchState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: PatchCharacterStateDto;
  stateRepo: Repository<PlayerCharacterState>;
  conditions: Repository<PhbCondition>;
  catalogLookup: CatalogLookupService;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    dto,
    stateRepo,
    conditions,
    catalogLookup,
    buildResponse,
  } = input;

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

  if (dto.deathSaveSuccesses !== undefined) {
    state.deathSaveSuccesses = clampDeathSaveCount(dto.deathSaveSuccesses);
  }
  if (dto.deathSaveFailures !== undefined) {
    state.deathSaveFailures = clampDeathSaveCount(dto.deathSaveFailures);
  }
  if (dto.inspiration !== undefined) {
    state.inspiration = dto.inspiration;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}
