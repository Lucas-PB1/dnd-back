import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import {
  findGunslingerManeuver,
  listGunslingerManeuvers,
} from '../../../combat/domain/gunslinger-maneuvers';
import {
  hasTacticalMind,
  hasTacticalShift,
  isFighterClass,
  secondWindHealDice,
} from '../../../combat/domain/fighter-features';
import { rollDie, rollExpression } from '../../../dice/domain/dice';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { abilityModifier } from '../../../sheet/domain/stats/ability-modifier';
import {
  applyResourceRecover,
  applyResourceSpend,
} from '../../domain/class-resources';
import { clampDeathSaveCount } from '../../domain/death-saves';
import { resolveManeuverEffect, rollRiskDie } from '../../domain/maneuver-resolve';
import {
  ActionSurgeResponseDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  SecondWindResponseDto,
  TacticalMindResponseDto,
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

export async function applySecondWind(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  characters: { save: (row: PlayerCharacter) => Promise<unknown> };
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<SecondWindResponseDto> {
  const { character, state, stateRepo, characters, dataSource, buildResponse } =
    input;
  if (!isFighterClass(character.classSlug)) {
    throw new BadRequestException('Second Wind requires the Fighter class');
  }
  if (
    character.hitPointsMax == null ||
    character.hitPointsCurrent == null
  ) {
    throw new BadRequestException('Character hit points are not set');
  }

  const resources = await resolveClassResources(dataSource, character);
  const secondWind = resources.find((item) => item.slug === 'secondWind');
  if (!secondWind) {
    throw new BadRequestException('Second Wind is not available');
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      'secondWind',
      secondWind.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Second Wind',
    );
  }

  const expression = secondWindHealDice(character.level);
  const healRoll = rollExpression(expression);
  const before = character.hitPointsCurrent;
  const after = Math.min(character.hitPointsMax, before + healRoll.total);
  const healAmount = after - before;
  character.hitPointsCurrent = after;

  await stateRepo.save(state);
  await characters.save(character);

  const notes: string[] = [];
  if (hasTacticalShift(character.level)) {
    notes.push(
      'Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO',
    );
  }

  return {
    state: await buildResponse(character, state),
    expression: healRoll.expression,
    healAmount,
    hitPointsCurrent: after,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}

export async function applyTacticalMind(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  checkTotal: number;
  dc: number;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<TacticalMindResponseDto> {
  const {
    character,
    state,
    checkTotal,
    dc,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  if (!isFighterClass(character.classSlug) || !hasTacticalMind(character.level)) {
    throw new BadRequestException(
      'Tactical Mind requires Fighter level 2+',
    );
  }

  const resources = await resolveClassResources(dataSource, character);
  const secondWind = resources.find((item) => item.slug === 'secondWind');
  if (!secondWind) {
    throw new BadRequestException('Second Wind is not available');
  }

  const remaining =
    secondWind.max - (state.resourcesUsed?.secondWind ?? 0);
  if (remaining <= 0) {
    throw new BadRequestException('No remaining uses of Second Wind');
  }

  const roll = rollDie(10);
  const newTotal = checkTotal + roll;
  const success = newTotal >= dc;

  if (success) {
    try {
      state.resourcesUsed = applyResourceSpend(
        state.resourcesUsed ?? {},
        'secondWind',
        secondWind.max,
        1,
      );
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot spend Second Wind',
      );
    }
    await stateRepo.save(state);
  }

  return {
    state: await buildResponse(character, state),
    expression: '1d10',
    roll,
    newTotal,
    success,
    resourceSpent: success,
    note: success
      ? 'Mente Tática: sucesso; uso de Recuperar Fôlego gasto'
      : 'Mente Tática: ainda falhou; uso de Recuperar Fôlego devolvido',
  };
}

export async function applyActionSurge(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<ActionSurgeResponseDto> {
  const { character, state, stateRepo, dataSource, buildResponse } = input;
  if (!isFighterClass(character.classSlug) || character.level < 2) {
    throw new BadRequestException('Action Surge requires Fighter level 2+');
  }

  const resources = await resolveClassResources(dataSource, character);
  const surge = resources.find((item) => item.slug === 'actionSurge');
  if (!surge) {
    throw new BadRequestException('Action Surge is not available');
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      'actionSurge',
      surge.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Action Surge',
    );
  }

  await stateRepo.save(state);

  const notes = [
    'Surto de Ação: execute uma ação adicional (exceto Usar Magia)',
  ];
  if (
    character.subclassSlug === 'eldritch-knight' &&
    character.level >= 15
  ) {
    notes.push(
      'Investida Mística: teleporte até 9 m antes ou depois da ação adicional',
    );
  }

  return {
    state: await buildResponse(character, state),
    note: notes.join(' · '),
  };
}

export function listAvailableManeuvers(character: PlayerCharacter) {
  if (character.classSlug !== 'gunslinger') return [];
  return listGunslingerManeuvers({
    level: character.level,
    subclassSlug: character.subclassSlug,
  });
}
