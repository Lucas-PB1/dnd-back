import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { clampDeathSaveCount } from '@game/session/domain/death-saves';
import {
  isMesaCircumstanceTag,
  normalizeMesaCircumstances,
} from '@game/session/domain/mesa-circumstances';
import {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import {
  PatchCharacterStateDto,
} from '@game/session/dto/core/session-commands.dto';
import { PhbCondition } from '@game/session/infrastructure/phb-condition.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { despawnSpiritsOnConcentrationChange } from '@game/spirit/application/despawn-spell-spirits';
import { assertValidConditions } from './conditions';
import type { BuildResponse } from './mutation-types';

export async function applyPatchState(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: PatchCharacterStateDto;
  stateRepo: Repository<PlayerCharacterState>;
  conditions: Repository<PhbCondition>;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    dto,
    stateRepo,
    conditions,
    catalogLookup,
    dataSource,
    buildResponse,
  } = input;

  if (dto.conditions !== undefined) {
    await assertValidConditions(conditions, dto.conditions);
    state.conditions = dto.conditions;
  } else if (
    dto.addConditions !== undefined ||
    dto.removeConditions !== undefined
  ) {
    const add = dto.addConditions ?? [];
    const remove = dto.removeConditions ?? [];
    await assertValidConditions(conditions, [...add, ...remove]);
    const drop = new Set(remove);
    const next = state.conditions.filter((slug) => !drop.has(slug));
    for (const slug of add) {
      if (slug && !next.includes(slug)) next.push(slug);
    }
    state.conditions = next;
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
    const previousConcentration = state.concentratingOn;
    await despawnSpiritsOnConcentrationChange(
      dataSource,
      character.id,
      previousConcentration,
      dto.concentratingOn,
    );
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
  if (dto.mesaCircumstances !== undefined) {
    const invalid = dto.mesaCircumstances.filter(
      (tag) => !isMesaCircumstanceTag(tag.trim()),
    );
    if (invalid.length > 0) {
      throw new BadRequestException(
        `Circunstância de mesa inválida: ${invalid.join(', ')}`,
      );
    }
    state.mesaCircumstances = normalizeMesaCircumstances(dto.mesaCircumstances);
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}
