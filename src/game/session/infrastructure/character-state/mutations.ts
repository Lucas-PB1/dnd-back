import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import {
  findGunslingerManeuver,
  listGunslingerManeuvers,
} from '../../../combat/domain/gunslinger-maneuvers';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { abilityModifier } from '../../../sheet/domain/stats/ability-modifier';
import {
  applyResourceRecover,
  applyResourceSpend,
} from '../../domain/class-resources';
import { clampDeathSaveCount } from '../../domain/death-saves';
import { resolveManeuverEffect, rollRiskDie } from '../../domain/maneuver-resolve';
import {
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  UseClassResourceResponseDto,
  UseManeuverResponseDto,
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

export async function applyUseClassResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  resourceSlug: string;
  amount: number;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<UseClassResourceResponseDto> {
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

  const roll = resourceSlug === 'risk' ? rollRiskDie(character.level) : null;

  await stateRepo.save(state);
  return {
    state: await buildResponse(character, state),
    roll,
  };
}

export async function applyRecoverClassResource(input: {
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

  state.resourcesUsed = applyResourceRecover(
    state.resourcesUsed ?? {},
    resourceSlug,
    amount,
  );
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyUseManeuver(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  maneuverSlug: string;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<UseManeuverResponseDto> {
  const {
    character,
    state,
    maneuverSlug,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  if (character.classSlug !== 'gunslinger') {
    throw new BadRequestException('Maneuvers require the Gunslinger class');
  }

  const maneuver = findGunslingerManeuver(maneuverSlug);
  if (!maneuver) {
    throw new BadRequestException(`Unknown maneuver '${maneuverSlug}'`);
  }
  if (character.level < maneuver.fromLevel) {
    throw new BadRequestException(
      `Maneuver '${maneuverSlug}' unlocks at level ${maneuver.fromLevel}`,
    );
  }

  const resources = await resolveClassResources(dataSource, character);
  const risk = resources.find((item) => item.slug === 'risk');
  if (!risk) {
    throw new BadRequestException('Risk dice are not available yet');
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      'risk',
      risk.max,
      maneuver.riskCost,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Risk',
    );
  }

  const riskRoll = rollRiskDie(character.level);
  if (!riskRoll) {
    throw new BadRequestException('Risk die is not available at this level');
  }

  const effect = resolveManeuverEffect({
    maneuver,
    riskRoll,
    gunslingerLevel: character.level,
    dexterityModifier: abilityModifier(character.abilityScores.destreza),
  });

  if (effect.tempHpGained != null) {
    state.tempHp = Math.max(state.tempHp ?? 0, effect.tempHpGained);
  }

  await stateRepo.save(state);
  return {
    state: await buildResponse(character, state),
    maneuverSlug: effect.maneuverSlug,
    maneuverName: effect.maneuverName,
    effectKind: effect.effectKind,
    riskRoll: effect.riskRoll,
    tempHpGained: effect.tempHpGained,
    missDamage: effect.missDamage,
    acBonus: effect.acBonus,
    checkBonus: effect.checkBonus,
    note: effect.note,
  };
}

export async function applyReloadFirearm(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  itemSlug: string;
  capacity: number;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, itemSlug, capacity, stateRepo, buildResponse } =
    input;
  if (capacity < 1) {
    throw new BadRequestException(
      `Weapon '${itemSlug}' has no reload capacity`,
    );
  }
  state.firearmChambers = {
    ...(state.firearmChambers ?? {}),
    [itemSlug]: capacity,
  };
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyFireChamber(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  itemSlug: string;
  capacity: number;
  shots: number;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    itemSlug,
    capacity,
    shots,
    stateRepo,
    buildResponse,
  } = input;
  const chambers = { ...(state.firearmChambers ?? {}) };
  const current = chambers[itemSlug] ?? (capacity > 0 ? capacity : 0);
  if (current < shots) {
    throw new BadRequestException(
      `Chamber empty or insufficient shots on '${itemSlug}' (${current}/${capacity})`,
    );
  }
  chambers[itemSlug] = current - shots;
  state.firearmChambers = chambers;
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyToggleRage(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active?: boolean;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, dataSource, buildResponse } = input;
  if (character.classSlug !== 'barbarian') {
    throw new BadRequestException('Rage requires the Barbarian class');
  }

  const nextActive = input.active ?? !state.rageActive;
  if (nextActive && !state.rageActive) {
    const resources = await resolveClassResources(dataSource, character);
    const rage = resources.find((item) => item.slug === 'rage');
    if (!rage) {
      throw new BadRequestException('Rage is not available yet');
    }
    try {
      state.resourcesUsed = applyResourceSpend(
        state.resourcesUsed ?? {},
        'rage',
        rage.max,
        1,
      );
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot spend Rage',
      );
    }
    state.rageActive = true;
  } else if (!nextActive) {
    state.rageActive = false;
    state.recklessActive = false;
  }

  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyToggleReckless(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  active?: boolean;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;
  if (character.classSlug !== 'barbarian') {
    throw new BadRequestException('Reckless Attack requires the Barbarian class');
  }
  if (character.level < 2) {
    throw new BadRequestException('Reckless Attack unlocks at level 2');
  }
  state.recklessActive = input.active ?? !state.recklessActive;
  await stateRepo.save(state);
  return buildResponse(character, state);
}

/** Fúria Persistente (nv.15): recupera todos os usos de Fúria na iniciativa. */
export async function applyRecoverAllRage(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, stateRepo, buildResponse } = input;
  if (character.classSlug !== 'barbarian' || character.level < 15) {
    throw new BadRequestException(
      'Persistent Rage recovery requires Barbarian level 15+',
    );
  }
  const used = { ...(state.resourcesUsed ?? {}) };
  delete used.rage;
  state.resourcesUsed = used;
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export function listAvailableManeuvers(character: PlayerCharacter) {
  if (character.classSlug !== 'gunslinger') return [];
  return listGunslingerManeuvers({
    level: character.level,
    subclassSlug: character.subclassSlug,
  });
}
